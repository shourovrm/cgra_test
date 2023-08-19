"""
==========================================================================
VectorCGRAKingMeshRTL_test.py
==========================================================================
Test cases for CGRAs with different configurations.

Put this file in VectorCGRA/cgra/test/ folder then test, or use 
appropriate directory structure to load the libraries



Author : Cheng Tan
  Date : April 1, 2023

"""

from pymtl3 import *
from pymtl3.stdlib.test import TestSinkCL
from pymtl3.stdlib.test.test_srcs import TestSrcRTL

from ...lib.opt_type import *
from ...lib.messages import *

from ...fu.flexible.FlexibleFuRTL import FlexibleFuRTL
from ...fu.single.AdderRTL import AdderRTL
from ...fu.single.MemUnitRTL import MemUnitRTL
from ...fu.single.MulRTL import MulRTL
from ...fu.single.SelRTL import SelRTL
from ...fu.single.ShifterRTL import ShifterRTL
from ...fu.single.LogicRTL import LogicRTL
from ...fu.single.PhiRTL import PhiRTL
from ...fu.single.CompRTL import CompRTL
from ...fu.single.BranchRTL import BranchRTL
from ...fu.vector.VectorMulComboRTL import VectorMulComboRTL
from ...fu.vector.VectorAdderComboRTL import VectorAdderComboRTL

from ..CGRAKingMeshRTL import CGRAKingMeshRTL

from pymtl3.passes import TracingConfigs
from pymtl3.passes.backends.verilog import *
from pymtl3.passes.backends.verilog import VerilatorImportConfigs
from pymtl3.passes.backends.verilog import TranslationImportPass

# -------------------------------------------------------------------------
# Test harness
# -------------------------------------------------------------------------


class TestHarness(Component):
    def construct(
        s,
        DUT,
        FunctionUnit,
        FuList,
        DataType,
        PredicateType,
        CtrlType,
        width,
        height,
        ctrl_mem_size,
        data_mem_size,
        src_opt,
        ctrl_waddr,
    ):
        s.num_tiles = width * height
        AddrType = mk_bits(clog2(ctrl_mem_size))

        s.src_opt = [TestSrcRTL(CtrlType, src_opt[i]) for i in range(s.num_tiles)]
        s.ctrl_waddr = [TestSrcRTL(AddrType, ctrl_waddr[i]) for i in range(s.num_tiles)]

        s.dut = DUT(
            DataType,
            PredicateType,
            CtrlType,
            width,
            height,
            ctrl_mem_size,
            data_mem_size,
            len(src_opt[0]),
            FunctionUnit,
            FuList,
        )

        for i in range(s.num_tiles):
            connect(s.src_opt[i].send, s.dut.recv_wopt[i])
            connect(s.ctrl_waddr[i].send, s.dut.recv_waddr[i])

    def done(s):
        done = True
        for i in range(s.num_tiles):
            if not s.src_opt[i].done():
                done = False
                break
        return done

    def line_trace(s):
        return s.dut.line_trace()


# def run_sim( test_harness, max_cycles=100 ):
#   test_harness.elaborate()
#   # print("Elaboration complete.")

#   test_harness.dut.verilog_translate_import = True
#   # try:
#   test_harness.dut.config_verilog_import = VerilatorImportConfigs(vl_Wno_list=['UNSIGNED', 'UNOPTFLAT', 'WIDTH', 'WIDTHCONCAT', 'ALWCOMBORDER'],
#                                                                   vl_trace_filename="test",
#                                                                   vl_trace=True)

#   test_harness = TranslationImportPass()(test_harness)

#   test_harness.apply( SimulationPass() )

#   test_harness.sim_reset()


#   # Run simulation
#   ncycles = 0
#   print()

#   print( "{}:{}".format( ncycles, test_harness.line_trace() ))
#   while not test_harness.done() and ncycles < max_cycles:
#     try:
#       test_harness.tick()
#       ncycles += 1

#       print( "{}:{}".format( ncycles, test_harness.line_trace() ))
#     except Exception as e:
#       print(f"Error during tick {ncycles}: {e}")
#       break


#   # Check timeout
#   # assert ncycles < max_cycles
#   if ncycles >= max_cycles:
#     # print("Error: Simulation reached max cycles without completing.")
#     assert False

#   for _ in range(6):
#     # try:
#     test_harness.tick()
#     # except Exception as e:
#     #   print(f"Error during post-simulation tick: {e}")


def run_sim(test_harness, max_cycles=10):
    test_harness.elaborate()
    test_harness.dut.verilog_translate_import = True
    test_harness.dut.config_verilog_import = VerilatorImportConfigs(
        vl_Wno_list=["UNSIGNED", "UNOPTFLAT", "WIDTH", "WIDTHCONCAT", "ALWCOMBORDER"],
        vl_trace_filename="test",
        vl_trace=True,
    )
    test_harness = TranslationImportPass()(test_harness)
    test_harness.apply(SimulationPass())
    test_harness.sim_reset()

    # Run simulation
    ncycles = 0
    print()
    print("{}:{}".format(ncycles, test_harness.line_trace()))
    while not test_harness.done() and ncycles < max_cycles:
        test_harness.tick()
        ncycles += 1
        print("{}:{}".format(ncycles, test_harness.line_trace()))

    # Check timeout
    assert ncycles < max_cycles

    test_harness.tick()
    test_harness.tick()
    test_harness.tick()


# def run_sim( test_harness, max_cycles=100 ):
#   # test_harness.elaborate()
#   # test_harness.apply( SimulationPass() )
#   # test_harness.sim_reset()


#     test_harness.elaborate()
#   # print("Elaboration complete.")

#   test_harness.dut.verilog_translate_import = True
#   # try:
#   test_harness.dut.config_verilog_import = VerilatorImportConfigs(vl_Wno_list=['UNSIGNED', 'UNOPTFLAT', 'WIDTH', 'WIDTHCONCAT', 'ALWCOMBORDER'],
#                                                                   vl_trace_filename="test",
#                                                                   vl_trace=True)

#   test_harness = TranslationImportPass()(test_harness)

#   test_harness.apply( SimulationPass() )

#   test_harness.sim_reset()

#   # Run simulation
#   ncycles = 0
#   print()
#   print( "{}:{}".format( ncycles, test_harness.line_trace() ))
#   # while not test_harness.done() and ncycles < max_cycles:
#   #   test_harness.tick()
#   #   ncycles += 1
#   #   print( "{}:{}".format( ncycles, test_harness.line_trace() ))

#   while not test_harness.done() and ncycles < max_cycles:
#   try:
#     test_harness.tick()
#     ncycles += 1

#     print( "{}:{}".format( ncycles, test_harness.line_trace() ))
#   except Exception as e:
#     print(f"Error during tick {ncycles}: {e}")
#     break

# # Check timeout
# # assert ncycles < max_cycles
# if ncycles >= max_cycles:
#   print("Error: Simulation reached max cycles without completing.")
#   assert False

# for _ in range(6):
#   try:
#     test_harness.tick()
#   except Exception as e:
#     print(f"Error during post-simulation tick: {e}")


# # Check timeout
# assert ncycles < max_cycles

# test_harness.tick()
# test_harness.tick()
# test_harness.tick()


def test_homo_4x4():
    num_tile_inports = 8
    num_tile_outports = 8
    num_xbar_inports = 10
    num_xbar_outports = 12
    ctrl_mem_size = 6
    width = 4
    height = 4
    RouteType = mk_bits(clog2(num_xbar_inports + 1))
    AddrType = mk_bits(clog2(ctrl_mem_size))
    num_tiles = width * height
    data_mem_size = 8
    num_fu_in = 4
    DUT = CGRAKingMeshRTL
    FunctionUnit = FlexibleFuRTL
    # FuList        = [MemUnitRTL, AdderRTL]
    FuList = [
        AdderRTL,
        MulRTL,
        LogicRTL,
        ShifterRTL,
        PhiRTL,
        CompRTL,
        BranchRTL,
        MemUnitRTL,
        SelRTL,
        VectorMulComboRTL,
        VectorAdderComboRTL,
    ]
    DataType = mk_data(64, 1)
    PredicateType = mk_predicate(1, 1)
    CtrlType = mk_ctrl(num_fu_in, num_xbar_inports, num_xbar_outports)
    FuInType = mk_bits(clog2(num_fu_in + 1))
    pickRegister = [FuInType(x + 1) for x in range(num_fu_in)]
    src_opt = [
        [
            CtrlType(
                OPT_INC,
                b1(0),
                pickRegister,
                [
                    RouteType(4),
                    RouteType(3),
                    RouteType(2),
                    RouteType(1),
                    RouteType(0),
                    RouteType(0),
                    RouteType(0),
                    RouteType(0),
                    RouteType(5),
                    RouteType(5),
                    RouteType(5),
                    RouteType(5),
                ],
            ),
            CtrlType(
                OPT_INC,
                b1(0),
                pickRegister,
                [
                    RouteType(4),
                    RouteType(3),
                    RouteType(2),
                    RouteType(1),
                    RouteType(0),
                    RouteType(0),
                    RouteType(0),
                    RouteType(0),
                    RouteType(5),
                    RouteType(5),
                    RouteType(5),
                    RouteType(5),
                ],
            ),
            CtrlType(
                OPT_ADD,
                b1(0),
                pickRegister,
                [
                    RouteType(4),
                    RouteType(3),
                    RouteType(2),
                    RouteType(1),
                    RouteType(0),
                    RouteType(0),
                    RouteType(0),
                    RouteType(0),
                    RouteType(5),
                    RouteType(5),
                    RouteType(5),
                    RouteType(5),
                ],
            ),
            CtrlType(
                OPT_STR,
                b1(0),
                pickRegister,
                [
                    RouteType(4),
                    RouteType(3),
                    RouteType(2),
                    RouteType(1),
                    RouteType(0),
                    RouteType(0),
                    RouteType(0),
                    RouteType(0),
                    RouteType(5),
                    RouteType(5),
                    RouteType(5),
                    RouteType(5),
                ],
            ),
            CtrlType(
                OPT_ADD,
                b1(0),
                pickRegister,
                [
                    RouteType(4),
                    RouteType(3),
                    RouteType(2),
                    RouteType(1),
                    RouteType(0),
                    RouteType(0),
                    RouteType(0),
                    RouteType(0),
                    RouteType(5),
                    RouteType(5),
                    RouteType(5),
                    RouteType(5),
                ],
            ),
            CtrlType(
                OPT_ADD,
                b1(0),
                pickRegister,
                [
                    RouteType(4),
                    RouteType(3),
                    RouteType(2),
                    RouteType(1),
                    RouteType(0),
                    RouteType(0),
                    RouteType(0),
                    RouteType(0),
                    RouteType(5),
                    RouteType(5),
                    RouteType(5),
                    RouteType(5),
                ],
            ),
        ]
        for _ in range(num_tiles)
    ]
    ctrl_waddr = [
        [AddrType(0), AddrType(1), AddrType(2), AddrType(3), AddrType(4), AddrType(5)]
        for _ in range(num_tiles)
    ]
    th = TestHarness(
        DUT,
        FunctionUnit,
        FuList,
        DataType,
        PredicateType,
        CtrlType,
        width,
        height,
        ctrl_mem_size,
        data_mem_size,
        src_opt,
        ctrl_waddr,
    )
    run_sim(th)
