// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Tracing implementation internals
#include "verilated_vcd_c.h"
#include "VCGRATemplateRTL__cbb34633479d3fdc__Syms.h"


void VCGRATemplateRTL__cbb34633479d3fdc::traceChgSub1(void* userp, VerilatedVcd* tracep) {
    VCGRATemplateRTL__cbb34633479d3fdc__Syms* __restrict vlSymsp = static_cast<VCGRATemplateRTL__cbb34633479d3fdc__Syms*>(userp);
    VCGRATemplateRTL__cbb34633479d3fdc* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    vluint32_t* const oldp = tracep->oldp(vlSymsp->__Vm_baseCode + 10803);
    if (false && oldp) {}  // Prevent unused
    // Body
    {
        tracep->chgBit(oldp+0,(vlTOPp->CGRATemplateRTL___05Fcbb34633479d3fdc__DOT__tile___05F0__DOT__element__DOT__fu___05F10__DOT__first));
        tracep->chgCData(oldp+1,(vlTOPp->CGRATemplateRTL___05Fcbb34633479d3fdc__DOT__tile___05F1__DOT__channel___05Fcount[0]),2);
        tracep->chgCData(oldp+2,(vlTOPp->CGRATemplateRTL___05Fcbb34633479d3fdc__DOT__tile___05F1__DOT__channel___05Fcount[1]),2);
        tracep->chgCData(oldp+3,(vlTOPp->CGRATemplateRTL___05Fcbb34633479d3fdc__DOT__tile___05F1__DOT__channel___05Fcount[2]),2);
        tracep->chgCData(oldp+4,(vlTOPp->CGRATemplateRTL___05Fcbb34633479d3fdc__DOT__tile___05F1__DOT__channel___05Fcount[3]),2);
        tracep->chgCData(oldp+5,(vlTOPp->CGRATemplateRTL___05Fcbb34633479d3fdc__DOT__tile___05F1__DOT__channel___05Fcount[4]),2);
        tracep->chgCData(oldp+6,(vlTOPp->CGRATemplateRTL___05Fcbb34633479d3fdc__DOT__tile___05F1__DOT__channel___05Fcount[5]),2);
        tracep->chgCData(oldp+7,(vlTOPp->CGRATemplateRTL___05Fcbb34633479d3fdc__DOT__tile___05F1__DOT__channel___05Fcount[6]),2);
        tracep->chgCData(oldp+8,(vlTOPp->CGRATemplateRTL___05Fcbb34633479d3fdc__DOT__tile___05F1__DOT__channel___05Fcount[7]),2);
        tracep->chgCData(oldp+9,(vlTOPp->CGRATemplateRTL___05Fcbb34633479d3fdc__DOT__tile___05F1__DOT__channel___05Fcount[8]),2);
        tracep->chgCData(oldp+10,(vlTOPp->CGRATemplateRTL___05Fcbb34633479d3fdc__DOT__tile___05F1__DOT__channel___05Fcount[9]),2);
        tracep->chgCData(oldp+11,(vlTOPp->CGRATemplateRTL___05Fcbb34633479d3fdc__DOT__tile___05F1__DOT__channel___05Fcount[10]),2);
        tracep->chgCData(oldp+12,(vlTOPp->CGRATemplateRTL___05Fcbb34633479d3fdc__DOT__tile___05F1__DOT__channel___05Fcount[11]),2);
        tracep->chgBit(oldp+13,(((~ ((4U == (IData)(vlTOPp->CGRATemplateRTL___05Fcbb34633479d3fdc__DOT__tile___05F1__DOT__ctrl_mem__DOT__times)) 
                                     | (0U == (0x3fU 
                                               & (IData)(
                                                         (vlTOPp->CGRATemplateRTL___05Fcbb34633479d3fdc__DOT__tile___05F1__DOT__ctrl_mem__DOT__reg_file___05Frdata
                                                          [0U] 
                                                          >> 0x35U)))))) 
                                 & ((IData)(vlTOPp->CGRATemplateRTL___05Fcbb34633479d3fdc__DOT__tile___05F1__DOT__element___05Frecv_opt___05Frdy) 
                                    & (IData)(vlTOPp->CGRATemplateRTL___05Fcbb34633479d3fdc__DOT__tile___05F1__DOT__crossbar___05Frecv_opt___05Frdy)))));
        tracep->chgBit(oldp+14,(vlTOPp->CGRATemplateRTL___05Fcbb34633479d3fdc__DOT__tile___05F1__DOT__element__DOT__fu___05F10__DOT__first));
        tracep->chgCData(oldp+15,(vlTOPp->CGRATemplateRTL___05Fcbb34633479d3fdc__DOT__tile___05F2__DOT__channel___05Fcount[0]),2);
        tracep->chgCData(oldp+16,(vlTOPp->CGRATemplateRTL___05Fcbb34633479d3fdc__DOT__tile___05F2__DOT__channel___05Fcount[1]),2);
        tracep->chgCData(oldp+17,(vlTOPp->CGRATemplateRTL___05Fcbb34633479d3fdc__DOT__tile___05F2__DOT__channel___05Fcount[2]),2);
        tracep->chgCData(oldp+18,(vlTOPp->CGRATemplateRTL___05Fcbb34633479d3fdc__DOT__tile___05F2__DOT__channel___05Fcount[3]),2);
        tracep->chgCData(oldp+19,(vlTOPp->CGRATemplateRTL___05Fcbb34633479d3fdc__DOT__tile___05F2__DOT__channel___05Fcount[4]),2);
        tracep->chgCData(oldp+20,(vlTOPp->CGRATemplateRTL___05Fcbb34633479d3fdc__DOT__tile___05F2__DOT__channel___05Fcount[5]),2);
        tracep->chgCData(oldp+21,(vlTOPp->CGRATemplateRTL___05Fcbb34633479d3fdc__DOT__tile___05F2__DOT__channel___05Fcount[6]),2);
        tracep->chgCData(oldp+22,(vlTOPp->CGRATemplateRTL___05Fcbb34633479d3fdc__DOT__tile___05F2__DOT__channel___05Fcount[7]),2);
        tracep->chgCData(oldp+23,(vlTOPp->CGRATemplateRTL___05Fcbb34633479d3fdc__DOT__tile___05F2__DOT__channel___05Fcount[8]),2);
        tracep->chgCData(oldp+24,(vlTOPp->CGRATemplateRTL___05Fcbb34633479d3fdc__DOT__tile___05F2__DOT__channel___05Fcount[9]),2);
        tracep->chgCData(oldp+25,(vlTOPp->CGRATemplateRTL___05Fcbb34633479d3fdc__DOT__tile___05F2__DOT__channel___05Fcount[10]),2);
        tracep->chgCData(oldp+26,(vlTOPp->CGRATemplateRTL___05Fcbb34633479d3fdc__DOT__tile___05F2__DOT__channel___05Fcount[11]),2);
        tracep->chgBit(oldp+27,(((~ ((4U == (IData)(vlTOPp->CGRATemplateRTL___05Fcbb34633479d3fdc__DOT__tile___05F2__DOT__ctrl_mem__DOT__times)) 
                                     | (0U == (0x3fU 
                                               & (IData)(
                                                         (vlTOPp->CGRATemplateRTL___05Fcbb34633479d3fdc__DOT__tile___05F2__DOT__ctrl_mem__DOT__reg_file___05Frdata
                                                          [0U] 
                                                          >> 0x35U)))))) 
                                 & ((IData)(vlTOPp->CGRATemplateRTL___05Fcbb34633479d3fdc__DOT__tile___05F2__DOT__element___05Frecv_opt___05Frdy) 
                                    & (IData)(vlTOPp->CGRATemplateRTL___05Fcbb34633479d3fdc__DOT__tile___05F2__DOT__crossbar___05Frecv_opt___05Frdy)))));
        tracep->chgBit(oldp+28,(vlTOPp->CGRATemplateRTL___05Fcbb34633479d3fdc__DOT__tile___05F2__DOT__element__DOT__fu___05F10__DOT__first));
        tracep->chgCData(oldp+29,(vlTOPp->CGRATemplateRTL___05Fcbb34633479d3fdc__DOT__tile___05F3__DOT__channel___05Fcount[0]),2);
        tracep->chgCData(oldp+30,(vlTOPp->CGRATemplateRTL___05Fcbb34633479d3fdc__DOT__tile___05F3__DOT__channel___05Fcount[1]),2);
        tracep->chgCData(oldp+31,(vlTOPp->CGRATemplateRTL___05Fcbb34633479d3fdc__DOT__tile___05F3__DOT__channel___05Fcount[2]),2);
        tracep->chgCData(oldp+32,(vlTOPp->CGRATemplateRTL___05Fcbb34633479d3fdc__DOT__tile___05F3__DOT__channel___05Fcount[3]),2);
        tracep->chgCData(oldp+33,(vlTOPp->CGRATemplateRTL___05Fcbb34633479d3fdc__DOT__tile___05F3__DOT__channel___05Fcount[4]),2);
        tracep->chgCData(oldp+34,(vlTOPp->CGRATemplateRTL___05Fcbb34633479d3fdc__DOT__tile___05F3__DOT__channel___05Fcount[5]),2);
        tracep->chgCData(oldp+35,(vlTOPp->CGRATemplateRTL___05Fcbb34633479d3fdc__DOT__tile___05F3__DOT__channel___05Fcount[6]),2);
        tracep->chgCData(oldp+36,(vlTOPp->CGRATemplateRTL___05Fcbb34633479d3fdc__DOT__tile___05F3__DOT__channel___05Fcount[7]),2);
        tracep->chgCData(oldp+37,(vlTOPp->CGRATemplateRTL___05Fcbb34633479d3fdc__DOT__tile___05F3__DOT__channel___05Fcount[8]),2);
        tracep->chgCData(oldp+38,(vlTOPp->CGRATemplateRTL___05Fcbb34633479d3fdc__DOT__tile___05F3__DOT__channel___05Fcount[9]),2);
        tracep->chgCData(oldp+39,(vlTOPp->CGRATemplateRTL___05Fcbb34633479d3fdc__DOT__tile___05F3__DOT__channel___05Fcount[10]),2);
        tracep->chgCData(oldp+40,(vlTOPp->CGRATemplateRTL___05Fcbb34633479d3fdc__DOT__tile___05F3__DOT__channel___05Fcount[11]),2);
        tracep->chgBit(oldp+41,(((~ ((4U == (IData)(vlTOPp->CGRATemplateRTL___05Fcbb34633479d3fdc__DOT__tile___05F3__DOT__ctrl_mem__DOT__times)) 
                                     | (0U == (0x3fU 
                                               & (IData)(
                                                         (vlTOPp->CGRATemplateRTL___05Fcbb34633479d3fdc__DOT__tile___05F3__DOT__ctrl_mem__DOT__reg_file___05Frdata
                                                          [0U] 
                                                          >> 0x35U)))))) 
                                 & ((IData)(vlTOPp->CGRATemplateRTL___05Fcbb34633479d3fdc__DOT__tile___05F3__DOT__element___05Frecv_opt___05Frdy) 
                                    & (IData)(vlTOPp->CGRATemplateRTL___05Fcbb34633479d3fdc__DOT__tile___05F3__DOT__crossbar___05Frecv_opt___05Frdy)))));
        tracep->chgBit(oldp+42,(vlTOPp->CGRATemplateRTL___05Fcbb34633479d3fdc__DOT__tile___05F3__DOT__element__DOT__fu___05F10__DOT__first));
    }
}

void VCGRATemplateRTL__cbb34633479d3fdc::traceCleanup(void* userp, VerilatedVcd* /*unused*/) {
    VCGRATemplateRTL__cbb34633479d3fdc__Syms* __restrict vlSymsp = static_cast<VCGRATemplateRTL__cbb34633479d3fdc__Syms*>(userp);
    VCGRATemplateRTL__cbb34633479d3fdc* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    {
        vlSymsp->__Vm_activity = false;
        vlTOPp->__Vm_traceActivity[0U] = 0U;
        vlTOPp->__Vm_traceActivity[1U] = 0U;
        vlTOPp->__Vm_traceActivity[2U] = 0U;
        vlTOPp->__Vm_traceActivity[3U] = 0U;
        vlTOPp->__Vm_traceActivity[4U] = 0U;
        vlTOPp->__Vm_traceActivity[5U] = 0U;
        vlTOPp->__Vm_traceActivity[6U] = 0U;
        vlTOPp->__Vm_traceActivity[7U] = 0U;
        vlTOPp->__Vm_traceActivity[8U] = 0U;
        vlTOPp->__Vm_traceActivity[9U] = 0U;
        vlTOPp->__Vm_traceActivity[0xaU] = 0U;
        vlTOPp->__Vm_traceActivity[0xbU] = 0U;
        vlTOPp->__Vm_traceActivity[0xcU] = 0U;
        vlTOPp->__Vm_traceActivity[0xdU] = 0U;
        vlTOPp->__Vm_traceActivity[0xeU] = 0U;
        vlTOPp->__Vm_traceActivity[0xfU] = 0U;
        vlTOPp->__Vm_traceActivity[0x10U] = 0U;
        vlTOPp->__Vm_traceActivity[0x11U] = 0U;
        vlTOPp->__Vm_traceActivity[0x12U] = 0U;
        vlTOPp->__Vm_traceActivity[0x13U] = 0U;
        vlTOPp->__Vm_traceActivity[0x14U] = 0U;
        vlTOPp->__Vm_traceActivity[0x15U] = 0U;
        vlTOPp->__Vm_traceActivity[0x16U] = 0U;
        vlTOPp->__Vm_traceActivity[0x17U] = 0U;
        vlTOPp->__Vm_traceActivity[0x18U] = 0U;
        vlTOPp->__Vm_traceActivity[0x19U] = 0U;
        vlTOPp->__Vm_traceActivity[0x1aU] = 0U;
        vlTOPp->__Vm_traceActivity[0x1bU] = 0U;
        vlTOPp->__Vm_traceActivity[0x1cU] = 0U;
        vlTOPp->__Vm_traceActivity[0x1dU] = 0U;
        vlTOPp->__Vm_traceActivity[0x1eU] = 0U;
        vlTOPp->__Vm_traceActivity[0x1fU] = 0U;
        vlTOPp->__Vm_traceActivity[0x20U] = 0U;
        vlTOPp->__Vm_traceActivity[0x21U] = 0U;
        vlTOPp->__Vm_traceActivity[0x22U] = 0U;
        vlTOPp->__Vm_traceActivity[0x23U] = 0U;
        vlTOPp->__Vm_traceActivity[0x24U] = 0U;
        vlTOPp->__Vm_traceActivity[0x25U] = 0U;
        vlTOPp->__Vm_traceActivity[0x26U] = 0U;
        vlTOPp->__Vm_traceActivity[0x27U] = 0U;
        vlTOPp->__Vm_traceActivity[0x28U] = 0U;
        vlTOPp->__Vm_traceActivity[0x29U] = 0U;
        vlTOPp->__Vm_traceActivity[0x2aU] = 0U;
        vlTOPp->__Vm_traceActivity[0x2bU] = 0U;
        vlTOPp->__Vm_traceActivity[0x2cU] = 0U;
        vlTOPp->__Vm_traceActivity[0x2dU] = 0U;
        vlTOPp->__Vm_traceActivity[0x2eU] = 0U;
        vlTOPp->__Vm_traceActivity[0x2fU] = 0U;
        vlTOPp->__Vm_traceActivity[0x30U] = 0U;
        vlTOPp->__Vm_traceActivity[0x31U] = 0U;
        vlTOPp->__Vm_traceActivity[0x32U] = 0U;
        vlTOPp->__Vm_traceActivity[0x33U] = 0U;
        vlTOPp->__Vm_traceActivity[0x34U] = 0U;
        vlTOPp->__Vm_traceActivity[0x35U] = 0U;
        vlTOPp->__Vm_traceActivity[0x36U] = 0U;
        vlTOPp->__Vm_traceActivity[0x37U] = 0U;
        vlTOPp->__Vm_traceActivity[0x38U] = 0U;
        vlTOPp->__Vm_traceActivity[0x39U] = 0U;
        vlTOPp->__Vm_traceActivity[0x3aU] = 0U;
        vlTOPp->__Vm_traceActivity[0x3bU] = 0U;
        vlTOPp->__Vm_traceActivity[0x3cU] = 0U;
        vlTOPp->__Vm_traceActivity[0x3dU] = 0U;
        vlTOPp->__Vm_traceActivity[0x3eU] = 0U;
        vlTOPp->__Vm_traceActivity[0x3fU] = 0U;
        vlTOPp->__Vm_traceActivity[0x40U] = 0U;
        vlTOPp->__Vm_traceActivity[0x41U] = 0U;
        vlTOPp->__Vm_traceActivity[0x42U] = 0U;
    }
}
