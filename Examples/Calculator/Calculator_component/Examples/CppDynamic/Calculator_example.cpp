/*++

Copyright (C) 2019 Calculator developers

All rights reserved.

This file has been generated by the Automatic Component Toolkit (ACT) version 1.6.0.

Abstract: This is an autogenerated C++ application that demonstrates the
 usage of the Dynamic C++ bindings of Calculator library

Interface version: 1.0.0

*/

#include <iostream>
#include "calculator_dynamic.hpp"


int main()
{
	try
	{
		std::string libpath = (""); // TODO: put the location of the Calculator-library file here.
		auto wrapper = Calculator::CWrapper::loadLibrary(libpath + "/calculator."); // TODO: add correct suffix of the library
		Calculator_uint32 nMajor, nMinor, nMicro;
		wrapper->GetVersion(nMajor, nMinor, nMicro);
		std::cout << "Calculator.Version = " << nMajor << "." << nMinor << "." << nMicro;
		std::cout << std::endl;

 		auto calculator = wrapper->CreateCalculator();
		{
			auto v1 = wrapper->CreateVariable(2);
			calculator->EnlistVariable(v1.get());

			auto v2 = wrapper->CreateVariable(3);
			calculator->EnlistVariable(v2.get());
			
			// The application releases ownership of v1 and v2,
			// the calculator, however, still holds these instances.
		}

		std::cout << "   sum = " << calculator->Add()->GetValue() << std::endl;
		{
			auto v1Again = calculator->GetEnlistedVariable(0);
			std::cout << "Changing the value of the first summand" << std::endl;
			v1Again->SetValue(10);
			std::cout << "newSum = " << calculator->Add()->GetValue() << std::endl;
		}

	}
	catch (std::exception &e)
	{
		std::cout << e.what() << std::endl;
		return 1;
	}
	return 0;
}

