/*++

Copyright (C) 2019 ACT Developers


This file has been generated by the Automatic Component Toolkit (ACT) version 1.6.0.

Abstract: This is an autogenerated C++-Header file in order to allow an easy
 use of Optional Class Library

Interface version: 1.0.0

*/

#ifndef __OPTCLASS_DYNAMICHEADER_CPPTYPES
#define __OPTCLASS_DYNAMICHEADER_CPPTYPES

#include "optclass_types.hpp"



/*************************************************************************************************************************
 Class definition for Base
**************************************************************************************************************************/

/*************************************************************************************************************************
 Global functions
**************************************************************************************************************************/

/**
* Acquire shared ownership of an Instance
*
* @param[in] pInstance - Instance Handle
* @return error code or 0 (success)
*/
typedef OptClassResult (*POptClassAcquireInstancePtr) (OptClass_Base pInstance);

/**
* Releases shared ownership of an Instance
*
* @param[in] pInstance - Instance Handle
* @return error code or 0 (success)
*/
typedef OptClassResult (*POptClassReleaseInstancePtr) (OptClass_Base pInstance);

/**
* retrieves the binary version of this library.
*
* @param[out] pMajor - returns the major version of this library
* @param[out] pMinor - returns the minor version of this library
* @param[out] pMicro - returns the micro version of this library
* @return error code or 0 (success)
*/
typedef OptClassResult (*POptClassGetVersionPtr) (OptClass_uint32 * pMajor, OptClass_uint32 * pMinor, OptClass_uint32 * pMicro);

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
typedef OptClassResult (*POptClassGetLastErrorPtr) (OptClass_Base pInstance, const OptClass_uint32 nErrorMessageBufferSize, OptClass_uint32* pErrorMessageNeededChars, char * pErrorMessageBuffer, bool * pHasError);

/**
* Handles Library Journaling
*
* @param[in] pFileName - Journal FileName
* @return error code or 0 (success)
*/
typedef OptClassResult (*POptClassSetJournalPtr) (const char * pFileName);

/**
* Creates an instance of Base class with a given identifier (but does not return it)
*
* @param[in] pIdentifier - Identifier of the new instance
* @return error code or 0 (success)
*/
typedef OptClassResult (*POptClassCreateInstanceWithNamePtr) (const char * pIdentifier);

/**
* Finds a Base class instance by Identifier
*
* @param[in] pIdentifier - Identifier of the tnstance to query
* @param[out] pInstance - Base class instance
* @return error code or 0 (success)
*/
typedef OptClassResult (*POptClassFindInstanceAPtr) (const char * pIdentifier, OptClass_Base * pInstance);

/**
* Finds a Base class instance by Identifier
*
* @param[in] pIdentifier - Identifier of the tnstance to query
* @param[out] pInstance - Base class instance
* @return error code or 0 (success)
*/
typedef OptClassResult (*POptClassFindInstanceBPtr) (const char * pIdentifier, OptClass_Base * pInstance);

/**
* Uses a Base class instance
*
* @param[in] pInstance - Base class instance
* @param[out] pIsUsed - Was the Instance used?
* @return error code or 0 (success)
*/
typedef OptClassResult (*POptClassUseInstanceMaybePtr) (OptClass_Base pInstance, bool * pIsUsed);

/*************************************************************************************************************************
 Function Table Structure
**************************************************************************************************************************/

typedef struct {
	void * m_LibraryHandle;
	POptClassAcquireInstancePtr m_AcquireInstance;
	POptClassReleaseInstancePtr m_ReleaseInstance;
	POptClassGetVersionPtr m_GetVersion;
	POptClassGetLastErrorPtr m_GetLastError;
	POptClassSetJournalPtr m_SetJournal;
	POptClassCreateInstanceWithNamePtr m_CreateInstanceWithName;
	POptClassFindInstanceAPtr m_FindInstanceA;
	POptClassFindInstanceBPtr m_FindInstanceB;
	POptClassUseInstanceMaybePtr m_UseInstanceMaybe;
} sOptClassDynamicWrapperTable;

#endif // __OPTCLASS_DYNAMICHEADER_CPPTYPES

