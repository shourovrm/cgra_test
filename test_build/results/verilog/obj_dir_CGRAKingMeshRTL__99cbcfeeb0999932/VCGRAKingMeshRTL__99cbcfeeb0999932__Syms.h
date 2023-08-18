// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Symbol table internal header
//
// Internal details; most calling programs do not need this header,
// unless using verilator public meta comments.

#ifndef _VCGRAKINGMESHRTL__99CBCFEEB0999932__SYMS_H_
#define _VCGRAKINGMESHRTL__99CBCFEEB0999932__SYMS_H_  // guard

#include "verilated.h"

// INCLUDE MODULE CLASSES
#include "VCGRAKingMeshRTL__99cbcfeeb0999932.h"
#include "VCGRAKingMeshRTL__99cbcfeeb0999932___024unit.h"

// SYMS CLASS
class VCGRAKingMeshRTL__99cbcfeeb0999932__Syms : public VerilatedSyms {
  public:
    
    // LOCAL STATE
    const char* __Vm_namep;
    bool __Vm_activity;  ///< Used by trace routines to determine change occurred
    uint32_t __Vm_baseCode;  ///< Used by trace routines when tracing multiple models
    bool __Vm_didInit;
    
    // SUBCELL STATE
    VCGRAKingMeshRTL__99cbcfeeb0999932* TOPp;
    
    // CREATORS
    VCGRAKingMeshRTL__99cbcfeeb0999932__Syms(VCGRAKingMeshRTL__99cbcfeeb0999932* topp, const char* namep);
    ~VCGRAKingMeshRTL__99cbcfeeb0999932__Syms() {}
    
    // METHODS
    inline const char* name() { return __Vm_namep; }
    
} VL_ATTR_ALIGNED(VL_CACHE_LINE_BYTES);

#endif  // guard
