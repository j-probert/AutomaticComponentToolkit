/*++

Copyright (C) 2018 Automatic Component Toolkit Developers

All rights reserved.

Abstract: This is an autogenerated C++ implementation file in order to allow easy
development of Prime Numbers Interface. It needs to be generated only once.
Interface version: 1.0.0

*/

#include "libprimes.h"
#include "libprimes_interfaces.hpp"
#include "libprimes_interfaceexception.hpp"

#include "libprimes_factorizationcalculator.hpp"
#include "libprimes_sievecalculator.hpp"

using namespace LibPrimes;

ILibPrimesFactorizationCalculator * CLibPrimesWrapper::CreateFactorizationCalculator ()
{
	return new CLibPrimesFactorizationCalculator();
}

ILibPrimesSieveCalculator * CLibPrimesWrapper::CreateSieveCalculator()
{
	return new CLibPrimesSieveCalculator();
}

void CLibPrimesWrapper::ReleaseInstance (ILibPrimesBaseClass* pInstance)
{
	delete pInstance;
}

void CLibPrimesWrapper::GetLibraryVersion (unsigned int & nMajor, unsigned int & nMinor, unsigned int & nMicro)
{
	nMajor = LIBPRIMES_VERSION_MAJOR;
	nMinor = LIBPRIMES_VERSION_MINOR;
	nMicro = LIBPRIMES_VERSION_MICRO;
}

void CLibPrimesWrapper::SetJournal (const std::string & sFileName)
{
	throw ELibPrimesInterfaceException (LIBPRIMES_ERROR_NOTIMPLEMENTED);
}


