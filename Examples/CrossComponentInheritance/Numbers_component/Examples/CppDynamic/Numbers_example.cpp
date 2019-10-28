/*++

Copyright (C) 2019 Numbers developers

All rights reserved.

This file has been generated by the Automatic Component Toolkit (ACT) version 1.7.0-develop.

Abstract: This is an autogenerated C++ application that demonstrates the
 usage of the Dynamic C++ bindings of Numbers library

Interface version: 1.0.0

*/

#include <iostream>
#include "numbers_dynamic.hpp"


int main()
{
	try
	{
		std::string libpath = ("D:/PUBLIC/AutomaticComponentToolkit_work/Examples/CrossComponentInheritance/Numbers_component/Implementations/Cpp/build/Debug"); // TODO: put the location of the Numbers-library file here.
		auto wrapper = Numbers::Binding::CWrapper::loadLibrary(libpath + "/numbers.dll"); // TODO: add correct suffix of the library
		Numbers_uint32 nMajor, nMinor, nMicro;
		wrapper->GetVersion(nMajor, nMinor, nMicro);
		std::cout << "Numbers.Version = " << nMajor << "." << nMinor << "." << nMicro;
		std::cout << std::endl;

		auto pVar = wrapper->CreateVariable(1.0);
		std::cout << pVar->GetValue() << std::endl;
		pVar->SetValue(10.0);
		std::cout << pVar->GetValue() << std::endl;

		auto pVarImpl= wrapper->CreateVariableImpl(2.0);
		std::cout << pVarImpl->GetValue() << std::endl;
		pVarImpl->SetValue(20.0);
		std::cout << pVarImpl->GetValue() << std::endl;
	}
	catch (std::exception &e)
	{
		std::cout << e.what() << std::endl;
		return 1;
	}
	return 0;
}

