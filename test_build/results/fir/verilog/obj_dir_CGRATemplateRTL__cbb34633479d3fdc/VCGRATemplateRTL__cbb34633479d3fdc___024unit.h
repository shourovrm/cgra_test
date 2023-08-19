// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design internal header
// See VCGRATemplateRTL__cbb34633479d3fdc.h for the primary calling header

#ifndef _VCGRATEMPLATERTL__CBB34633479D3FDC___024UNIT_H_
#define _VCGRATEMPLATERTL__CBB34633479D3FDC___024UNIT_H_  // guard

#include "verilated.h"

//==========

class VCGRATemplateRTL__cbb34633479d3fdc__Syms;
class VCGRATemplateRTL__cbb34633479d3fdc_VerilatedVcd;


//----------

VL_MODULE(VCGRATemplateRTL__cbb34633479d3fdc___024unit) {
  public:
    
    // INTERNAL VARIABLES
  private:
    VCGRATemplateRTL__cbb34633479d3fdc__Syms* __VlSymsp;  // Symbol table
  public:
    
    // CONSTRUCTORS
  private:
    VL_UNCOPYABLE(VCGRATemplateRTL__cbb34633479d3fdc___024unit);  ///< Copying not allowed
  public:
    VCGRATemplateRTL__cbb34633479d3fdc___024unit(const char* name = "TOP");
    ~VCGRATemplateRTL__cbb34633479d3fdc___024unit();
    
    // INTERNAL METHODS
    void __Vconfigure(VCGRATemplateRTL__cbb34633479d3fdc__Syms* symsp, bool first);
  private:
    void _ctor_var_reset() VL_ATTR_COLD;
    static void traceInit(void* userp, VerilatedVcd* tracep, uint32_t code) VL_ATTR_COLD;
} VL_ATTR_ALIGNED(VL_CACHE_LINE_BYTES);

//----------


#endif  // guard
