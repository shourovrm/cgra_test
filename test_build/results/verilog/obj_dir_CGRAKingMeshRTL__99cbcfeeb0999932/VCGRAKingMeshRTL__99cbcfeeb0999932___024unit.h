// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design internal header
// See VCGRAKingMeshRTL__99cbcfeeb0999932.h for the primary calling header

#ifndef _VCGRAKINGMESHRTL__99CBCFEEB0999932___024UNIT_H_
#define _VCGRAKINGMESHRTL__99CBCFEEB0999932___024UNIT_H_  // guard

#include "verilated.h"

//==========

class VCGRAKingMeshRTL__99cbcfeeb0999932__Syms;
class VCGRAKingMeshRTL__99cbcfeeb0999932_VerilatedVcd;


//----------

VL_MODULE(VCGRAKingMeshRTL__99cbcfeeb0999932___024unit) {
  public:
    
    // INTERNAL VARIABLES
  private:
    VCGRAKingMeshRTL__99cbcfeeb0999932__Syms* __VlSymsp;  // Symbol table
  public:
    
    // CONSTRUCTORS
  private:
    VL_UNCOPYABLE(VCGRAKingMeshRTL__99cbcfeeb0999932___024unit);  ///< Copying not allowed
  public:
    VCGRAKingMeshRTL__99cbcfeeb0999932___024unit(const char* name = "TOP");
    ~VCGRAKingMeshRTL__99cbcfeeb0999932___024unit();
    
    // INTERNAL METHODS
    void __Vconfigure(VCGRAKingMeshRTL__99cbcfeeb0999932__Syms* symsp, bool first);
  private:
    void _ctor_var_reset() VL_ATTR_COLD;
    static void traceInit(void* userp, VerilatedVcd* tracep, uint32_t code) VL_ATTR_COLD;
} VL_ATTR_ALIGNED(VL_CACHE_LINE_BYTES);

//----------


#endif  // guard
