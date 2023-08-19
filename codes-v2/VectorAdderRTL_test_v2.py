"""
==========================================================================
VAdderRTL_test.py
==========================================================================
Test cases for vector adder.

Author : Cheng Tan
  Date : March 13, 2022

"""

from pymtl3                       import *
from pymtl3.stdlib.test           import TestSinkCL
from pymtl3.stdlib.test.test_srcs import TestSrcRTL

from ..VectorAdderRTL             import VectorAdderRTL
from ....mem.const.ConstQueueRTL  import ConstQueueRTL
from ....lib.opt_type             import *
from ....lib.messages             import *

from pymtl3.passes import TracingConfigs
from pymtl3.passes.backends.verilog import *
from pymtl3.passes.backends.verilog import TranslationImportPass


import os

os.chdir("/home/rms/repos/RecoNTT-CGRA/test_build/results/verilog/")
os.system("rm -rf /home/rms/repos/RecoNTT-CGRA/test_build/results/verilog/*")

#-------------------------------------------------------------------------
# Test harness
#-------------------------------------------------------------------------

class TestHarness( Component ):

  def construct( s, FunctionUnit, bandwidth, ConfigType,
                 num_inports, num_outports, data_mem_size,
                 src0_msgs, src1_msgs, src_const,
                 ctrl_msgs, sink_msgs ):

    InDataType  = mk_bits( bandwidth )
    OutDataType = mk_bits( bandwidth+1 )
    s.src_in0   = TestSrcRTL( InDataType,  src0_msgs )
    s.src_in1   = TestSrcRTL( InDataType,  src1_msgs )
    s.src_opt   = TestSrcRTL( ConfigType,  ctrl_msgs )
    s.sink_out  = TestSinkCL( OutDataType, sink_msgs )

    s.const_queue = ConstQueueRTL( InDataType, src_const )
    s.dut = FunctionUnit( bandwidth, ConfigType,
                          num_inports, num_outports,
                          data_mem_size )

    for i in range( num_inports ):
      s.dut.recv_in_count[i] //= 1

    s.src_in0.send.rdy //= s.dut.recv_in[0].rdy
    s.src_in0.send.en  //= s.dut.recv_in[0].en
    s.src_in0.send.msg //= s.dut.recv_in[0].msg[0:bandwidth]

    s.src_in1.send.rdy //= s.dut.recv_in[1].rdy
    s.src_in1.send.en  //= s.dut.recv_in[1].en
    s.src_in1.send.msg //= s.dut.recv_in[1].msg[0:bandwidth]

    s.const_queue.send_const.rdy //= s.dut.recv_const.rdy
    s.const_queue.send_const.en  //= s.dut.recv_const.en
    s.const_queue.send_const.msg //= s.dut.recv_const.msg[0:bandwidth]

    # connect( s.src_in0.send,       s.dut.recv_in[0]         )
    # connect( s.src_in1.send,       s.dut.recv_in[1]         )
    # connect( s.dut.recv_const,     s.const_queue.send_const )
    connect( s.src_opt.send,       s.dut.recv_opt           )
    connect( s.dut.send_out[0],    s.sink_out.recv          )

  def done( s ):
    return s.src_in0.done() and s.src_in1.done() and\
           s.src_opt.done() and s.sink_out.done()

  def line_trace( s ):
    return s.dut.line_trace()

def run_sim( test_harness, max_cycles=100 ):
  test_harness.elaborate()
  test_harness.dut.verilog_translate_import = True
  test_harness.dut.config_verilog_import = VerilatorImportConfigs(vl_Wno_list=['UNSIGNED', 'UNOPTFLAT', 'WIDTH', 'WIDTHCONCAT', 'ALWCOMBORDER'],
                                                                  vl_trace_filename="rms.vcd",
                                                                  vl_trace=True)
  test_harness = TranslationImportPass()(test_harness)
  
  
  test_harness.apply( SimulationPass() )
  test_harness.sim_reset()

  # Run simulation
  ncycles = 0
  print()
  print( "{}:{}".format( ncycles, test_harness.line_trace() ))
  while ncycles < max_cycles:
  # while not test_harness.done() and ncycles < max_cycles:
    test_harness.tick()
    ncycles += 1
    print( "{}:{}".format( ncycles, test_harness.line_trace() ))

  # Check timeout
  # assert ncycles < max_cycles

  # test_harness.tick()
  # test_harness.tick()
  # test_harness.tick()

def test_vadder():
  FU            = VectorAdderRTL
  bandwidth     = 8
  InDataType    = mk_bits( bandwidth )
  OutDataType   = mk_bits( bandwidth+1 )
  PredicateType = mk_predicate( 1, 1 )
  ConfigType    = mk_ctrl()
  data_mem_size = 8
  num_inports   = 2
  num_outports  = 1
  FuInType      = mk_bits( clog2( num_inports + 1 ) )
  pickRegister  = [ FuInType( x+1 ) for x in range( num_inports ) ]
  src_in0       = [ InDataType(1),  InDataType(7),  InDataType(4) ]
  src_in1       = [ InDataType(2),  InDataType(3),  InDataType(1) ]
  src_const     = [ InDataType(5),  InDataType(0),  InDataType(7) ]
  sink_out      = [ OutDataType(6), OutDataType(4), OutDataType(11) ]
  src_opt       = [ ConfigType( OPT_ADD_CONST, b1( 1 ), pickRegister ),
                    ConfigType( OPT_SUB,       b1( 1 ), pickRegister ),
                    ConfigType( OPT_ADD_CONST, b1( 1 ), pickRegister ) ]
  th = TestHarness( FU, bandwidth, ConfigType,
                    num_inports, num_outports, data_mem_size,
                    src_in0, src_in1, src_const, src_opt,
                    sink_out )
  run_sim( th, max_cycles=100 )

