/*++

Copyright (C) 2018 Autodesk Inc. (Original Author)

All rights reserved.

Redistribution and use in source and binary forms, with or without modification,
are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this
list of conditions and the following disclaimer.
2. Redistributions in binary form must reproduce the above copyright notice,
this list of conditions and the following disclaimer in the documentation
and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR
ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

--*/

//////////////////////////////////////////////////////////////////////////////////////////////////////
// buildlayer.go
// functions to generate C-layer of a library's API (can be used in bindings or implementation)
//////////////////////////////////////////////////////////////////////////////////////////////////////

package main

import (
	"fmt"
	"path"
	"os"
	"io"
	"strings"
	"log"
)

// BuildBindingC builds C-bindings of a library's API in form of automatically C functions
func BuildBindingC(component ComponentDefinition, outputFolderBindingC string) error {
	CTypesHeaderName := path.Join(outputFolderBindingC, component.BaseName + "_types.h");
	log.Printf("Creating \"%s\"", CTypesHeaderName)
	err := CreateCTypesHeader (component, CTypesHeaderName);
	if (err != nil) {
		return err;
	}

	CHeaderName := path.Join(outputFolderBindingC, component.BaseName + ".h");
	log.Printf("Creating \"%s\"", CTypesHeaderName)
	err = CreateCHeader (component, CHeaderName);
	if (err != nil) {
		return err;
	}

	return nil;
}

// CreateCTypesHeader creates a C header file for the types in component's API
func CreateCTypesHeader (component ComponentDefinition, CTypesHeaderName string) (error) {
	hTypesFile, err := os.Create(CTypesHeaderName);
	if (err != nil) {
		return err;
	}
	WriteLicenseHeader (hTypesFile, component,
		fmt.Sprintf ("This is an autogenerated plain C Header file with basic types in\norder to allow an easy use of %s", component.LibraryName),
		true);

	err = buildCTypesHeader (component, hTypesFile, component.NameSpace);
	return err;
}

func buildCTypesHeader (component ComponentDefinition, w io.Writer, NameSpace string) (error) {
	fmt.Fprintf (w, "#ifndef __%s_TYPES_HEADER\n", strings.ToUpper (NameSpace));
	fmt.Fprintf (w, "#define __%s_TYPES_HEADER\n", strings.ToUpper (NameSpace));
	fmt.Fprintf (w, "\n");

	fmt.Fprintf (w, "/*************************************************************************************************************************\n");
	fmt.Fprintf (w, " General type definitions\n");
	fmt.Fprintf (w, "**************************************************************************************************************************/\n");

	fmt.Fprintf (w, "\n");
	fmt.Fprintf (w, "typedef int %sResult;\n", NameSpace);
	fmt.Fprintf (w, "typedef void * %sHandle;\n", NameSpace);
	
	fmt.Fprintf (w, "\n");
	fmt.Fprintf (w, "/*************************************************************************************************************************\n");
	fmt.Fprintf (w, " Version for %s\n", NameSpace);
	fmt.Fprintf (w, "**************************************************************************************************************************/\n");
	fmt.Fprintf (w, "\n");
	fmt.Fprintf (w, "#define %s_VERSION_MAJOR %d\n", strings.ToUpper (NameSpace), majorVersion(component.Version));
	fmt.Fprintf (w, "#define %s_VERSION_MINOR %d\n", strings.ToUpper (NameSpace), minorVersion(component.Version));
	fmt.Fprintf (w, "#define %s_VERSION_MICRO %d\n", strings.ToUpper (NameSpace), microVersion(component.Version));

	fmt.Fprintf (w, "\n");

	fmt.Fprintf (w, "/*************************************************************************************************************************\n");
	fmt.Fprintf (w, " Error constants for %s\n", NameSpace);
	fmt.Fprintf (w, "**************************************************************************************************************************/\n");
	fmt.Fprintf (w, "\n");
	fmt.Fprintf (w, "#define %s_SUCCESS 0\n", strings.ToUpper (NameSpace));
	
	
	for i := 0; i < len(component.Errors.Errors); i++ {
		errorcode := component.Errors.Errors[i];
		fmt.Fprintf (w, "#define %s_ERROR_%s %d\n", strings.ToUpper (NameSpace), errorcode.Name, errorcode.Code);
	}

	fmt.Fprintf (w, "\n");
	
	fmt.Fprintf (w, "/*************************************************************************************************************************\n");
	fmt.Fprintf (w, " Declaration of handle classes \n");
	fmt.Fprintf (w, "**************************************************************************************************************************/\n");
	fmt.Fprintf (w, "\n");
	
	fmt.Fprintf (w, "typedef %sHandle %s_BaseClass;\n", NameSpace, NameSpace);	
	
	for i := 0; i < len(component.Classes); i++ {
		class := component.Classes[i];				
		fmt.Fprintf (w, "typedef %sHandle %s_%s;\n", NameSpace, NameSpace, class.ClassName);	
	}
	fmt.Fprintf (w, "\n");
	
	if (len(component.Enums) > 0) {
		fmt.Fprintf (w, "/*************************************************************************************************************************\n");
		fmt.Fprintf (w, " Declaration of enums\n");
		fmt.Fprintf (w, "**************************************************************************************************************************/\n");
		fmt.Fprintf (w, "\n");

		for i := 0; i < len(component.Enums); i++ {
			enum := component.Enums[i];
			fmt.Fprintf (w, "enum e%s%s {\n", NameSpace, enum.Name);
			
			for j := 0; j < len(enum.Options); j++ {			
			
				comma := "";
				if (j < len(enum.Options) - 1) {
					comma = ",";
				}
			
				option := enum.Options[j];
				fmt.Fprintf (w, "    e%s%s = %d%s\n", enum.Name, option.Name, option.Value, comma);
			}
			
			fmt.Fprintf (w, "};\n");
			fmt.Fprintf (w, "\n");
		}
		

		fmt.Fprintf (w, "/*************************************************************************************************************************\n");
		fmt.Fprintf (w, " Declaration of enum members for 4 byte struct alignment\n");
		fmt.Fprintf (w, "**************************************************************************************************************************/\n");
		fmt.Fprintf (w, "\n");

		for i := 0; i < len(component.Enums); i++ {
			enum := component.Enums[i];
			fmt.Fprintf (w, "typedef union {\n");
			fmt.Fprintf (w, "  e%s%s m_enum;\n", NameSpace, enum.Name);				
			fmt.Fprintf (w, "  int m_code;\n");				
			fmt.Fprintf (w, "} structEnum%s%s;\n", NameSpace, enum.Name);
			fmt.Fprintf (w, "\n");
		}
	}
		
	if len(component.Structs) > 0 {

		fmt.Fprintf (w, "/*************************************************************************************************************************\n");
		fmt.Fprintf (w, " Declaration of structs\n");
		fmt.Fprintf (w, "**************************************************************************************************************************/\n");
		fmt.Fprintf (w, "\n");
			
		fmt.Fprintf (w, "#pragma pack (1)\n");
		fmt.Fprintf (w, "\n");

		for i := 0; i < len(component.Structs); i++ {
			structinfo := component.Structs[i];
			fmt.Fprintf (w, "typedef struct {\n");
			
			for j := 0; j < len(structinfo.Members); j++ {			

			member := structinfo.Members[j];
			
				arraysuffix := "";
				if (member.Rows > 0) {
					if (member.Columns > 0) {
						arraysuffix = fmt.Sprintf ("[%d][%d]", member.Columns, member.Rows)
					} else {
						arraysuffix = fmt.Sprintf ("[%d]",member.Rows)
					}
				}
			
				switch (member.Type) {
					case "uint8":
						fmt.Fprintf (w, "    unsigned char m_%s%s;\n", member.Name, arraysuffix);
					case "uint16":
						fmt.Fprintf (w, "    unsigned short m_%s%s;\n", member.Name, arraysuffix);
					case "uint32":
						fmt.Fprintf (w, "    unsigned int m_%s%s;\n", member.Name, arraysuffix);
					case "uint64":				
						fmt.Fprintf (w, "    unsigned long long m_%s%s;\n", member.Name, arraysuffix);
					case "int8":
						fmt.Fprintf (w, "    char m_%s%s;\n", member.Name, arraysuffix);
					case "int16":
						fmt.Fprintf (w, "    short m_%s%s;\n", member.Name, arraysuffix);
					case "int32":
						fmt.Fprintf (w, "    int m_%s%s;\n", member.Name, arraysuffix);
					case "int64":				
						fmt.Fprintf (w, "    long long m_%s%s;\n", member.Name, arraysuffix);
					case "bool":				
						fmt.Fprintf (w, "    bool m_%s%s;\n", member.Name, arraysuffix);
					case "single":
						fmt.Fprintf (w, "    float m_%s%s;\n", member.Name, arraysuffix);
					case "double":
						fmt.Fprintf (w, "    double m_%s%s;\n", member.Name, arraysuffix);
					case "string":
						return fmt.Errorf ("it is not possible for struct s%s%s to contain a string value", NameSpace, structinfo.Name);
					case "handle":
						return fmt.Errorf ("it is not possible for struct s%s%s to contain a handle value", NameSpace, structinfo.Name);
					case "enum":
						fmt.Fprintf (w, "    structEnum%s%s m_%s%s;\n", NameSpace, member.Class, member.Name, arraysuffix);
				}
				
				
			}
			
			fmt.Fprintf (w, "} s%s%s;\n", NameSpace, structinfo.Name);
			fmt.Fprintf (w, "\n");
		}
		
		fmt.Fprintf (w, "#pragma pack ()\n");
		fmt.Fprintf (w, "\n");

	}

	if len(component.Functions) > 0 {
		fmt.Fprintf (w, "/*************************************************************************************************************************\n");
		fmt.Fprintf (w, " Declaration of function pointers \n");
		fmt.Fprintf (w, "**************************************************************************************************************************/\n");
		fmt.Fprintf (w, "\n");
		for i := 0; i < len(component.Functions); i++ {
			functiontype := component.Functions[i]
			returnType := "void"
			parameters := ""
			for j := 0; j < len(functiontype.Params); j++ {
				param := functiontype.Params[j]
				cParamTypeName, err := getCParameterTypeName(param.ParamType, NameSpace, param.ParamClass);
				if (err != nil) {
					return err;
				}
				if (parameters != "") {
					parameters = parameters + ", "
				}
				if (param.ParamPass == "in") {
					parameters = parameters + cParamTypeName
				} else {
					parameters = parameters + cParamTypeName + "*"
				}
			}
			fmt.Fprintf (w, "typedef %s(*%s%s)(%s);\n", returnType, NameSpace, functiontype.FunctionName, parameters);
		}
		fmt.Fprintf (w, "\n");
	}
	
	
	fmt.Fprintf (w, "#endif // __%s_TYPES_HEADER\n", strings.ToUpper (NameSpace));

	return nil;
}

// CreateCHeader creates a C header file for the component's API
func CreateCHeader (component ComponentDefinition, CHeaderName string) (error) {
	hfile, err := os.Create(CHeaderName);
	if (err != nil) {
		return err;
	}
	WriteLicenseHeader (hfile, component,
		fmt.Sprintf ("This is an autogenerated plain C Header file in order to allow an easy\n use of %s", component.LibraryName),
		true);
	err = buildCHeader (component, hfile, component.NameSpace, component.BaseName);
	return err;
}

func buildCHeader (component ComponentDefinition, w io.Writer, NameSpace string, BaseName string) (error) {
	fmt.Fprintf (w, "#ifndef __%s_HEADER\n", strings.ToUpper (NameSpace));
	fmt.Fprintf (w, "#define __%s_HEADER\n", strings.ToUpper (NameSpace));
	fmt.Fprintf (w, "\n");
	fmt.Fprintf (w, "#ifdef __%s_DLL\n", strings.ToUpper (NameSpace));
	fmt.Fprintf (w, "#define %s_DECLSPEC __declspec (dllexport)\n", strings.ToUpper (NameSpace));
	fmt.Fprintf (w, "#else // __%s_DLL\n", strings.ToUpper (NameSpace));
	fmt.Fprintf (w, "#define %s_DECLSPEC\n", strings.ToUpper (NameSpace));
	fmt.Fprintf (w, "#endif // __%s_DLL\n", strings.ToUpper (NameSpace));
	fmt.Fprintf (w, "\n");

	fmt.Fprintf (w, "#include \"%s_types.h\"\n", BaseName);
	fmt.Fprintf (w, "\n");

	fmt.Fprintf (w, "extern \"C\" {\n");

	for i := 0; i < len(component.Classes); i++ {
		class := component.Classes[i];		

		fmt.Fprintf (w, "\n");
		fmt.Fprintf (w, "/*************************************************************************************************************************\n");
		fmt.Fprintf (w, " Class definition for %s\n", class.ClassName);
		fmt.Fprintf (w, "**************************************************************************************************************************/\n");

		for j := 0; j < len(class.Methods); j++ {
			method := class.Methods[j];
			WriteCMethod (method, w, NameSpace, class.ClassName, false, false);			
		}
	}

	
	fmt.Fprintf (w, "\n");
	fmt.Fprintf (w, "/*************************************************************************************************************************\n");
	fmt.Fprintf (w, " Global functions\n");
	fmt.Fprintf (w, "**************************************************************************************************************************/\n");
	
	global := component.Global;
	for j := 0; j < len(global.Methods); j++ {
		method := global.Methods[j];
		err := WriteCMethod (method, w, NameSpace, "Wrapper", true, false);
		if (err != nil) {
			return err;
		}
	}
	
	fmt.Fprintf (w, "\n");
	fmt.Fprintf (w, "}\n");
	fmt.Fprintf (w, "\n");
	fmt.Fprintf (w, "#endif // __%s_HEADER\n", strings.ToUpper (NameSpace));
	fmt.Fprintf (w, "\n");
	
	return nil;
}


// GetCExportName How do we name the exports in the plain C DLL
func GetCExportName (NameSpace string, ClassName string, method ComponentDefinitionMethod, isGlobal bool) (string) {
	CMethodName := "";
	if isGlobal {
		CMethodName = fmt.Sprintf("%s_%s%s", strings.ToLower(NameSpace), strings.ToLower(method.MethodName), method.DLLSuffix)
	} else {
		CMethodName = fmt.Sprintf("%s_%s_%s%s", strings.ToLower(NameSpace), strings.ToLower(ClassName), strings.ToLower(method.MethodName), method.DLLSuffix)
	}
	
	return CMethodName;
}


// WriteCMethod writes a method as a C funtion
func WriteCMethod (method ComponentDefinitionMethod, w io.Writer, NameSpace string, ClassName string, isGlobal bool, writeCallbacks bool) (error) {

	CMethodName := "";
	CCallbackName := "";
	parameters := "";
	if (isGlobal) {
		CMethodName = fmt.Sprintf ("%s_%s%s", strings.ToLower (NameSpace), strings.ToLower (method.MethodName), method.DLLSuffix);
		CCallbackName = fmt.Sprintf ("P%s%sPtr", NameSpace, method.MethodName);
	} else {
		CMethodName = fmt.Sprintf ("%s_%s_%s%s", strings.ToLower (NameSpace), strings.ToLower (ClassName), strings.ToLower (method.MethodName), method.DLLSuffix);
		CCallbackName = fmt.Sprintf ("P%s%s_%sPtr", NameSpace, ClassName, method.MethodName);
		parameters = fmt.Sprintf ("%s_%s p%s", NameSpace, ClassName, ClassName);
	}

	fmt.Fprintf (w, "\n");
	fmt.Fprintf (w, "/**\n");
	fmt.Fprintf (w, "* %s\n", method.MethodDescription);
	fmt.Fprintf (w, "*\n");
	if (!isGlobal) {
		fmt.Fprintf (w, "* @param[in] p%s - %s instance.\n", ClassName, ClassName);
	}
	

	for k := 0; k < len(method.Params); k++ {
		param := method.Params [k];
		
		cParams, err := generateCParameter(param, ClassName, method.MethodName, NameSpace);
		if (err != nil) {
			return err;
		}

		for _, cParam := range cParams {
			fmt.Fprintf (w, cParam.ParamComment);
			if (parameters != "") {
				parameters = parameters + ", ";
			}
			parameters = parameters + cParam.ParamType + " " + cParam.ParamName;
		}

	}
	
	fmt.Fprintf (w, "* @return error code or 0 (success)\n");
	fmt.Fprintf (w, "*/\n");
			
	if (writeCallbacks) {
		fmt.Fprintf (w, "typedef %sResult (*%s) (%s);\n", NameSpace, CCallbackName, parameters);
	} else {
		fmt.Fprintf (w, "%s_DECLSPEC %sResult %s (%s);\n", strings.ToUpper(NameSpace), NameSpace, CMethodName, parameters);
	}
	
	return nil;
}


func getCParameterTypeName(ParamTypeName string, NameSpace string, ParamClass string)(string, error) {
	cParamTypeName := "";
	switch (ParamTypeName) {
		case "uint8":
			cParamTypeName = "unsigned char";

		case "uint16":
			cParamTypeName = "unsigned short";

		case "uint32":
			cParamTypeName = "unsigned int";
			
		case "uint64":
			cParamTypeName = "unsigned long long";
		
		case "int8":
			cParamTypeName = "char";

		case "int16":
			cParamTypeName = "short";

		case "int32":
			cParamTypeName = "int";
			
		case "int64":
			cParamTypeName = "long long";

		case "bool":
			cParamTypeName = "bool";
			
		case "single":
			cParamTypeName = "float";

		case "double":
			cParamTypeName = "double";
			
		case "string":
			cParamTypeName = "char *";

		case "enum":
			cParamTypeName = fmt.Sprintf ("e%s%s", NameSpace, ParamClass);

		case "struct":
			cParamTypeName = fmt.Sprintf ("s%s%s *", NameSpace, ParamClass);

		case "basicarray":
			basicTypeName, err := getCParameterTypeName(ParamClass, NameSpace, "");
			if (err != nil) {
				return "", err;
			}
			cParamTypeName = fmt.Sprintf ("%s *", basicTypeName);

		case "structarray":
			cParamTypeName = fmt.Sprintf ("s%s%s *", NameSpace, ParamClass)
			
		case "handle":
			cParamTypeName = fmt.Sprintf ("%s_%s", NameSpace, ParamClass)

		case "functiontype":
			cParamTypeName = fmt.Sprintf ("%s%s", NameSpace, ParamClass)
		
		default:
			return "", fmt.Errorf ("invalid parameter type \"%s\" for C-parameter", ParamTypeName);
	}
	
	return cParamTypeName, nil;
}

// CParameter is a handy representation of a function parameter in C
type CParameter struct {
	ParamType string
	ParamName string
	ParamComment string
}


func generateCParameter(param ComponentDefinitionParam, className string, methodName string, NameSpace string) ([]CParameter, error) {
	cParams := make([]CParameter,1)
	cParamTypeName, err := getCParameterTypeName(param.ParamType, NameSpace, param.ParamClass);
	if (err != nil) {
		return nil, err;
	}

	switch (param.ParamPass) {
	case "in":
		switch (param.ParamType) {
			case "uint8", "uint16", "uint32", "uint64", "int8", "int16", "int32", "int64":
				cParams[0].ParamType = cParamTypeName;
				cParams[0].ParamName = "n" + param.ParamName;
				cParams[0].ParamComment = fmt.Sprintf("* @param[in] %s - %s\n", cParams[0].ParamName, param.ParamDescription);

			case "bool":
				cParams[0].ParamType = cParamTypeName;
				cParams[0].ParamName = "b" + param.ParamName;
				cParams[0].ParamComment = fmt.Sprintf("* @param[in] %s - %s\n", cParams[0].ParamName, param.ParamDescription);
				
			case "single":
				cParams[0].ParamType = cParamTypeName;
				cParams[0].ParamName = "f" + param.ParamName;
				cParams[0].ParamComment = fmt.Sprintf("* @param[in] %s - %s\n", cParams[0].ParamName, param.ParamDescription);

			case "double":
				cParams[0].ParamType = cParamTypeName;
				cParams[0].ParamName = "d" + param.ParamName;
				cParams[0].ParamComment = fmt.Sprintf("* @param[in] %s - %s\n", cParams[0].ParamName, param.ParamDescription);
				
			case "string":
				cParams[0].ParamType = "const " + cParamTypeName;
				cParams[0].ParamName = "p" + param.ParamName;
				cParams[0].ParamComment = fmt.Sprintf("* @param[in] %s - %s\n", cParams[0].ParamName, param.ParamDescription);

			case "enum":
				cParams[0].ParamType = cParamTypeName;
				cParams[0].ParamName = "e" + param.ParamName;
				cParams[0].ParamComment = fmt.Sprintf("* @param[in] %s - %s\n", cParams[0].ParamName, param.ParamDescription);

			case "struct":
				cParams[0].ParamType = "const " + cParamTypeName;
				cParams[0].ParamName = "p" + param.ParamName;
				cParams[0].ParamComment = fmt.Sprintf("* @param[in] %s - %s\n", cParams[0].ParamName, param.ParamDescription);

			case "basicarray", "structarray":
				cParams = make([]CParameter,2)
				cParams[0].ParamType = "const unsigned int";
				cParams[0].ParamName = "n" + param.ParamName + "BufferSize";
				cParams[0].ParamComment = fmt.Sprintf("* @param[in] %s - Number of elements in buffer\n", cParams[0].ParamName);

				cParams[1].ParamType = "const " + cParamTypeName;
				cParams[1].ParamName = "p" + param.ParamName + "Buffer";
				cParams[1].ParamComment = fmt.Sprintf("* @param[in] %s - %s buffer of %s\n", cParams[1].ParamName, param.ParamClass, param.ParamDescription);

			case "handle":
				cParams[0].ParamType = cParamTypeName;
				cParams[0].ParamName = "p" + param.ParamName;
				cParams[0].ParamComment = fmt.Sprintf("* @param[in] %s - %s\n", cParams[0].ParamName, param.ParamDescription);

			case "functiontype":
				cParams[0].ParamType = cParamTypeName;
				cParams[0].ParamName = "p" + param.ParamName;
				cParams[0].ParamComment = fmt.Sprintf("* @param[in] %s - %s\n", cParams[0].ParamName, param.ParamDescription);

			default:
				return nil, fmt.Errorf ("invalid method parameter type \"%s\" for %s.%s (%s)", param.ParamType, className, methodName, param.ParamName);
		}
	
	case "out", "return":
	
		switch (param.ParamType) {
		
			case "uint8", "uint16", "uint32", "uint64",  "int8", "int16", "int32", "int64", "bool", "single", "double", "enum":
				cParams[0].ParamType = cParamTypeName + " *";
				cParams[0].ParamName = "p" + param.ParamName;
				cParams[0].ParamComment = fmt.Sprintf("* @param[out] %s - %s\n", cParams[0].ParamName, param.ParamDescription);

			case "struct":
				cParams[0].ParamType = cParamTypeName;
				cParams[0].ParamName = "p" + param.ParamName;
				cParams[0].ParamComment = fmt.Sprintf("* @param[out] %s - %s\n", cParams[0].ParamName, param.ParamDescription);
				
			case "basicarray", "structarray":
				cParams = make([]CParameter,3)
				cParams[0].ParamType = "const unsigned int";
				cParams[0].ParamName = "n" + param.ParamName + "BufferSize";
				cParams[0].ParamComment = fmt.Sprintf("* @param[in] %s - Number of elements in buffer\n", cParams[0].ParamName);

				cParams[1].ParamType = "unsigned int *";
				cParams[1].ParamName = "p" + param.ParamName + "NeededCount";
				cParams[1].ParamComment = fmt.Sprintf("* @param[out] %s - will be filled with the count of the written elements, or needed buffer size.\n", cParams[1].ParamName);

				cParams[2].ParamType = cParamTypeName;
				cParams[2].ParamName = "p" + param.ParamName + "Buffer";
				cParams[2].ParamComment = fmt.Sprintf("* @param[out] %s - %s buffer of %s\n", cParams[2].ParamName, param.ParamClass, param.ParamDescription);

			case "string":
				cParams = make([]CParameter,3)
				cParams[0].ParamType = "const unsigned int";
				cParams[0].ParamName = "n" + param.ParamName + "BufferSize";
				cParams[0].ParamComment = fmt.Sprintf("* @param[in] %s - size of the buffer (including trailing 0)\n", cParams[0].ParamName);

				cParams[1].ParamType = "unsigned int *";
				cParams[1].ParamName = "p" + param.ParamName + "NeededChars";
				cParams[1].ParamComment = fmt.Sprintf("* @param[out] %s - will be filled with the count of the written bytes, or needed buffer size.\n", cParams[1].ParamName);

				cParams[2].ParamType = cParamTypeName;
				cParams[2].ParamName = "p" + param.ParamName + "Buffer";
				cParams[2].ParamComment = fmt.Sprintf("* @param[out] %s - %s buffer of %s, may be NULL\n", cParams[2].ParamName, param.ParamClass, param.ParamDescription);

			case "handle":
				cParams[0].ParamType = cParamTypeName + " *";
				cParams[0].ParamName = "p" + param.ParamName;
				cParams[0].ParamComment = fmt.Sprintf("* @param[out] %s - %s\n", cParams[0].ParamName, param.ParamDescription);
	
			default:
				return nil, fmt.Errorf ("invalid method parameter type \"%s\" for %s.%s (%s)", param.ParamType, className, methodName, param.ParamName);
		}
		
	default:
		return nil, fmt.Errorf ("invalid method parameter passing \"%s\" for %s.%s (%s)", param.ParamPass, className, methodName, param.ParamName);
	}

	return cParams, nil;
}

// GenerateCParameters generates an array of cParameters for a method
func GenerateCParameters(method ComponentDefinitionMethod, className string, NameSpace string) ([]CParameter, error) {
	parameters := []CParameter{};
	for k := 0; k < len(method.Params); k++ {
		param := method.Params [k];
		
		cParam, err := generateCParameter(param, className, method.MethodName, NameSpace);
		if err != nil {
			return nil, err;
		}
		parameters = append(parameters, cParam...);
	}

	return parameters, nil;
}