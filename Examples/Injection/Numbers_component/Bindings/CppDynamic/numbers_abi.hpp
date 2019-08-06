/*++

Copyright (C) 2019 Numbers developers

All rights reserved.

This file has been generated by the Automatic Component Toolkit (ACT) version 1.6.0.

Abstract: This is an autogenerated C++-Header file in order to allow an easy
 use of Numbers library

Interface version: 1.0.0

*/

#ifndef __NUMBERS_HEADER_CPP
#define __NUMBERS_HEADER_CPP

#ifdef __NUMBERS_EXPORTS
#ifdef _WIN32
#define NUMBERS_DECLSPEC __declspec (dllexport)
#else // _WIN32
#define NUMBERS_DECLSPEC __attribute__((visibility("default")))
#endif // _WIN32
#else // __NUMBERS_EXPORTS
#define NUMBERS_DECLSPEC
#endif // __NUMBERS_EXPORTS

#include "numbers_types.hpp"


extern "C" {

/*************************************************************************************************************************
 Class definition for Base
**************************************************************************************************************************/

/*************************************************************************************************************************
 Class definition for Variable
**************************************************************************************************************************/

/**
* Returns the current value of this Variable
*
* @param[in] pVariable - Variable instance.
* @param[out] pValue - The current value of this Variable
* @return error code or 0 (success)
*/
NUMBERS_DECLSPEC NumbersResult numbers_variable_getvalue(Numbers_Variable pVariable, Numbers_double * pValue);

/**
* Set the numerical value of this Variable
*
* @param[in] pVariable - Variable instance.
* @param[in] dValue - The new value of this Variable
* @return error code or 0 (success)
*/
NUMBERS_DECLSPEC NumbersResult numbers_variable_setvalue(Numbers_Variable pVariable, Numbers_double dValue);

/*************************************************************************************************************************
 Global functions
**************************************************************************************************************************/

/**
* Creates a new Variable instance
*
* @param[in] dInitialValue - Initial value of the new Variable
* @param[out] pInstance - New Variable instance
* @return error code or 0 (success)
*/
NUMBERS_DECLSPEC NumbersResult numbers_createvariable(Numbers_double dInitialValue, Numbers_Variable * pInstance);

/**
* retrieves the binary version of this library.
*
* @param[out] pMajor - returns the major version of this library
* @param[out] pMinor - returns the minor version of this library
* @param[out] pMicro - returns the micro version of this library
* @return error code or 0 (success)
*/
NUMBERS_DECLSPEC NumbersResult numbers_getversion(Numbers_uint32 * pMajor, Numbers_uint32 * pMinor, Numbers_uint32 * pMicro);

/**
* Returns the last error recorded on this object
*
* @param[in] pInstance - Instance Handle
* @param[in] nErrorMessageBufferSize - size of the buffer (including trailing 0)
* @param[out] pErrorMessageNeededChars - will be filled with the count of the written bytes, or needed buffer size.
* @param[out] pErrorMessageBuffer -  buffer of Message of the last error, may be NULL
* @param[out] pHasError - Is there a last error to query
* @return error code or 0 (success)
*/
NUMBERS_DECLSPEC NumbersResult numbers_getlasterror(Numbers_Base pInstance, const Numbers_uint32 nErrorMessageBufferSize, Numbers_uint32* pErrorMessageNeededChars, char * pErrorMessageBuffer, bool * pHasError);

/**
* Releases shared ownership of an Instance
*
* @param[in] pInstance - Instance Handle
* @return error code or 0 (success)
*/
NUMBERS_DECLSPEC NumbersResult numbers_releaseinstance(Numbers_Base pInstance);

/**
* Acquires shared ownership of an Instance
*
* @param[in] pInstance - Instance Handle
* @return error code or 0 (success)
*/
NUMBERS_DECLSPEC NumbersResult numbers_acquireinstance(Numbers_Base pInstance);

/**
* Returns the address of the SymbolLookupMethod
*
* @param[out] pSymbolLookupMethod - Address of the SymbolAddressMethod
* @return error code or 0 (success)
*/
NUMBERS_DECLSPEC NumbersResult numbers_getsymbollookupmethod(Numbers_pvoid * pSymbolLookupMethod);

}

#endif // __NUMBERS_HEADER_CPP

