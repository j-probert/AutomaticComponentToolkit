{$IFDEF FPC}{$MODE DELPHI}{$ENDIF}
(*++

Copyright (C) 2019 Calculator developers

All rights reserved.

This file has been generated by the Automatic Component Toolkit (ACT) version 1.6.0-develop.

Abstract: This is an autogenerated Pascal Header file in order to allow an easy
 use of Calculator library

Interface version: 1.0.0

*)

unit Unit_Calculator;

interface

uses
  {$IFDEF WINDOWS}
    Windows,
  {$ELSE}
    dynlibs,
  {$ENDIF}
  Types,
  Classes,
  SysUtils;

(*************************************************************************************************************************
 Version definition for Calculator
**************************************************************************************************************************)

const
  CALCULATOR_VERSION_MAJOR = 1;
  CALCULATOR_VERSION_MINOR = 0;
  CALCULATOR_VERSION_MICRO = 0;
  CALCULATOR_VERSION_PRERELEASEINFO = '';
  CALCULATOR_VERSION_BUILDINFO = '';


(*************************************************************************************************************************
 General type definitions
**************************************************************************************************************************)

type
  TCalculatorResult = Cardinal;
  TCalculatorHandle = Pointer;

  PCalculatorResult = ^TCalculatorResult;
  PCalculatorHandle = ^TCalculatorHandle;

(*************************************************************************************************************************
 Error Constants for Calculator
**************************************************************************************************************************)

const
  CALCULATOR_SUCCESS = 0;
  CALCULATOR_ERROR_NOTIMPLEMENTED = 1;
  CALCULATOR_ERROR_INVALIDPARAM = 2;
  CALCULATOR_ERROR_INVALIDCAST = 3;
  CALCULATOR_ERROR_BUFFERTOOSMALL = 4;
  CALCULATOR_ERROR_GENERICEXCEPTION = 5;
  CALCULATOR_ERROR_COULDNOTLOADLIBRARY = 6;
  CALCULATOR_ERROR_COULDNOTFINDLIBRARYEXPORT = 7;
  CALCULATOR_ERROR_INCOMPATIBLEBINARYVERSION = 8;


(*************************************************************************************************************************
 Declaration of handle classes 
**************************************************************************************************************************)

type
  TCalculatorWrapper = class;
  TCalculatorBase = class;
  TCalculatorVariable = class;
  TCalculatorCalculator = class;


(*************************************************************************************************************************
 Function type definitions for Base
**************************************************************************************************************************)


(*************************************************************************************************************************
 Function type definitions for Variable
**************************************************************************************************************************)

  (**
  * Returns the current value of this Variable
  *
  * @param[in] pVariable - Variable instance.
  * @param[out] pValue - The current value of this Variable
  * @return error code or 0 (success)
  *)
  TCalculatorVariable_GetValueFunc = function (pVariable: TCalculatorHandle; out pValue: Double): TCalculatorResult; cdecl;
  
  (**
  * Set the numerical value of this Variable
  *
  * @param[in] pVariable - Variable instance.
  * @param[in] dValue - The new value of this Variable
  * @return error code or 0 (success)
  *)
  TCalculatorVariable_SetValueFunc = function (pVariable: TCalculatorHandle; const dValue: Double): TCalculatorResult; cdecl;
  

(*************************************************************************************************************************
 Function type definitions for Calculator
**************************************************************************************************************************)

  (**
  * Adds a Variable to the list of Variables this calculator works on
  *
  * @param[in] pCalculator - Calculator instance.
  * @param[in] pVariable - The new variable in this calculator
  * @return error code or 0 (success)
  *)
  TCalculatorCalculator_EnlistVariableFunc = function (pCalculator: TCalculatorHandle; const pVariable: TCalculatorHandle): TCalculatorResult; cdecl;
  
  (**
  * Returns an instance of a enlisted variable
  *
  * @param[in] pCalculator - Calculator instance.
  * @param[in] nIndex - The index of the variable to query
  * @param[out] pVariable - The Index-th variable in this calculator
  * @return error code or 0 (success)
  *)
  TCalculatorCalculator_GetEnlistedVariableFunc = function (pCalculator: TCalculatorHandle; const nIndex: Cardinal; out pVariable: TCalculatorHandle): TCalculatorResult; cdecl;
  
  (**
  * Clears all variables in enlisted in this calculator
  *
  * @param[in] pCalculator - Calculator instance.
  * @return error code or 0 (success)
  *)
  TCalculatorCalculator_ClearVariablesFunc = function (pCalculator: TCalculatorHandle): TCalculatorResult; cdecl;
  
  (**
  * Multiplies all enlisted variables
  *
  * @param[in] pCalculator - Calculator instance.
  * @param[out] pInstance - Variable that holds the product of all enlisted Variables
  * @return error code or 0 (success)
  *)
  TCalculatorCalculator_MultiplyFunc = function (pCalculator: TCalculatorHandle; out pInstance: TCalculatorHandle): TCalculatorResult; cdecl;
  
  (**
  * Sums all enlisted variables
  *
  * @param[in] pCalculator - Calculator instance.
  * @param[out] pInstance - Variable that holds the sum of all enlisted Variables
  * @return error code or 0 (success)
  *)
  TCalculatorCalculator_AddFunc = function (pCalculator: TCalculatorHandle; out pInstance: TCalculatorHandle): TCalculatorResult; cdecl;
  
(*************************************************************************************************************************
 Global function definitions 
**************************************************************************************************************************)

  (**
  * retrieves the binary version of this library.
  *
  * @param[out] pMajor - returns the major version of this library
  * @param[out] pMinor - returns the minor version of this library
  * @param[out] pMicro - returns the micro version of this library
  * @return error code or 0 (success)
  *)
  TCalculatorGetVersionFunc = function (out pMajor: Cardinal; out pMinor: Cardinal; out pMicro: Cardinal): TCalculatorResult; cdecl;
  
  (**
  * Returns the last error recorded on this object
  *
  * @param[in] pInstance - Instance Handle
  * @param[in] nErrorMessageBufferSize - size of the buffer (including trailing 0)
  * @param[out] pErrorMessageNeededChars - will be filled with the count of the written bytes, or needed buffer size.
  * @param[out] pErrorMessageBuffer -  buffer of Message of the last error, may be NULL
  * @param[out] pHasError - Is there a last error to query
  * @return error code or 0 (success)
  *)
  TCalculatorGetLastErrorFunc = function (const pInstance: TCalculatorHandle; const nErrorMessageBufferSize: Cardinal; out pErrorMessageNeededChars: Cardinal; pErrorMessageBuffer: PAnsiChar; out pHasError: Byte): TCalculatorResult; cdecl;
  
  (**
  * Releases the memory of an Instance
  *
  * @param[in] pInstance - Instance Handle
  * @return error code or 0 (success)
  *)
  TCalculatorReleaseInstanceFunc = function (const pInstance: TCalculatorHandle): TCalculatorResult; cdecl;
  
  (**
  * Creates a new Variable instance
  *
  * @param[in] dInitialValue - Initial value of the new Variable
  * @param[out] pInstance - New Variable instance
  * @return error code or 0 (success)
  *)
  TCalculatorCreateVariableFunc = function (const dInitialValue: Double; out pInstance: TCalculatorHandle): TCalculatorResult; cdecl;
  
  (**
  * Creates a new Calculator instance
  *
  * @param[out] pInstance - New Calculator instance
  * @return error code or 0 (success)
  *)
  TCalculatorCreateCalculatorFunc = function (out pInstance: TCalculatorHandle): TCalculatorResult; cdecl;
  
(*************************************************************************************************************************
 Exception definition
**************************************************************************************************************************)

  ECalculatorException = class (Exception)
  private
    FErrorCode: TCalculatorResult;
    FCustomMessage: String;
  public
    property ErrorCode: TCalculatorResult read FErrorCode;
    property CustomMessage: String read FCustomMessage;
    constructor Create (AErrorCode: TCalculatorResult; AMessage: String);
    constructor CreateCustomMessage (AErrorCode: TCalculatorResult; AMessage: String);
  end;


(*************************************************************************************************************************
 Class definition for Base
**************************************************************************************************************************)

 TCalculatorBase = class (TObject)
  private
    FWrapper: TCalculatorWrapper;
    FHandle: TCalculatorHandle;
  public
    constructor Create (AWrapper: TCalculatorWrapper; AHandle: TCalculatorHandle);
    destructor Destroy; override;
  end;


(*************************************************************************************************************************
 Class definition for Variable
**************************************************************************************************************************)

  TCalculatorVariable = class (TCalculatorBase)
  public
    constructor Create (AWrapper: TCalculatorWrapper; AHandle: TCalculatorHandle);
    destructor Destroy; override;
    function GetValue(): Double;
    procedure SetValue(const AValue: Double);
  end;


(*************************************************************************************************************************
 Class definition for Calculator
**************************************************************************************************************************)

  TCalculatorCalculator = class (TCalculatorBase)
  public
    constructor Create (AWrapper: TCalculatorWrapper; AHandle: TCalculatorHandle);
    destructor Destroy; override;
    procedure EnlistVariable(const AVariable: TCalculatorVariable);
    function GetEnlistedVariable(const AIndex: Cardinal): TCalculatorVariable;
    procedure ClearVariables();
    function Multiply(): TCalculatorVariable;
    function Add(): TCalculatorVariable;
  end;

(*************************************************************************************************************************
 Wrapper definition
**************************************************************************************************************************)

  TCalculatorWrapper = class (TObject)
  private
    FModule: HMODULE;
    FCalculatorVariable_GetValueFunc: TCalculatorVariable_GetValueFunc;
    FCalculatorVariable_SetValueFunc: TCalculatorVariable_SetValueFunc;
    FCalculatorCalculator_EnlistVariableFunc: TCalculatorCalculator_EnlistVariableFunc;
    FCalculatorCalculator_GetEnlistedVariableFunc: TCalculatorCalculator_GetEnlistedVariableFunc;
    FCalculatorCalculator_ClearVariablesFunc: TCalculatorCalculator_ClearVariablesFunc;
    FCalculatorCalculator_MultiplyFunc: TCalculatorCalculator_MultiplyFunc;
    FCalculatorCalculator_AddFunc: TCalculatorCalculator_AddFunc;
    FCalculatorGetVersionFunc: TCalculatorGetVersionFunc;
    FCalculatorGetLastErrorFunc: TCalculatorGetLastErrorFunc;
    FCalculatorReleaseInstanceFunc: TCalculatorReleaseInstanceFunc;
    FCalculatorCreateVariableFunc: TCalculatorCreateVariableFunc;
    FCalculatorCreateCalculatorFunc: TCalculatorCreateCalculatorFunc;

    {$IFDEF MSWINDOWS}
    function LoadFunction (AFunctionName: AnsiString; FailIfNotExistent: Boolean = True): FARPROC;
    {$ELSE}
    function LoadFunction (AFunctionName: AnsiString; FailIfNotExistent: Boolean = True): Pointer;
    {$ENDIF MSWINDOWS}

    procedure checkBinaryVersion();

  protected
    property CalculatorVariable_GetValueFunc: TCalculatorVariable_GetValueFunc read FCalculatorVariable_GetValueFunc;
    property CalculatorVariable_SetValueFunc: TCalculatorVariable_SetValueFunc read FCalculatorVariable_SetValueFunc;
    property CalculatorCalculator_EnlistVariableFunc: TCalculatorCalculator_EnlistVariableFunc read FCalculatorCalculator_EnlistVariableFunc;
    property CalculatorCalculator_GetEnlistedVariableFunc: TCalculatorCalculator_GetEnlistedVariableFunc read FCalculatorCalculator_GetEnlistedVariableFunc;
    property CalculatorCalculator_ClearVariablesFunc: TCalculatorCalculator_ClearVariablesFunc read FCalculatorCalculator_ClearVariablesFunc;
    property CalculatorCalculator_MultiplyFunc: TCalculatorCalculator_MultiplyFunc read FCalculatorCalculator_MultiplyFunc;
    property CalculatorCalculator_AddFunc: TCalculatorCalculator_AddFunc read FCalculatorCalculator_AddFunc;
    property CalculatorGetVersionFunc: TCalculatorGetVersionFunc read FCalculatorGetVersionFunc;
    property CalculatorGetLastErrorFunc: TCalculatorGetLastErrorFunc read FCalculatorGetLastErrorFunc;
    property CalculatorReleaseInstanceFunc: TCalculatorReleaseInstanceFunc read FCalculatorReleaseInstanceFunc;
    property CalculatorCreateVariableFunc: TCalculatorCreateVariableFunc read FCalculatorCreateVariableFunc;
    property CalculatorCreateCalculatorFunc: TCalculatorCreateCalculatorFunc read FCalculatorCreateCalculatorFunc;
    procedure CheckError (AInstance: TCalculatorBase; AErrorCode: TCalculatorResult);
  public
    constructor Create (ADLLName: String);
    destructor Destroy; override;
    procedure GetVersion(out AMajor: Cardinal; out AMinor: Cardinal; out AMicro: Cardinal);
    function GetLastError(const AInstance: TCalculatorBase; out AErrorMessage: String): Boolean;
    procedure ReleaseInstance(const AInstance: TCalculatorBase);
    function CreateVariable(const AInitialValue: Double): TCalculatorVariable;
    function CreateCalculator(): TCalculatorCalculator;
  end;


implementation


(*************************************************************************************************************************
 Exception implementation
**************************************************************************************************************************)

  constructor ECalculatorException.Create (AErrorCode: TCalculatorResult; AMessage: String);
  var
    ADescription: String;
  begin
    FErrorCode := AErrorCode;
    case FErrorCode of
      CALCULATOR_ERROR_NOTIMPLEMENTED: ADescription := 'functionality not implemented';
      CALCULATOR_ERROR_INVALIDPARAM: ADescription := 'an invalid parameter was passed';
      CALCULATOR_ERROR_INVALIDCAST: ADescription := 'a type cast failed';
      CALCULATOR_ERROR_BUFFERTOOSMALL: ADescription := 'a provided buffer is too small';
      CALCULATOR_ERROR_GENERICEXCEPTION: ADescription := 'a generic exception occurred';
      CALCULATOR_ERROR_COULDNOTLOADLIBRARY: ADescription := 'the library could not be loaded';
      CALCULATOR_ERROR_COULDNOTFINDLIBRARYEXPORT: ADescription := 'a required exported symbol could not be found in the library';
      CALCULATOR_ERROR_INCOMPATIBLEBINARYVERSION: ADescription := 'the version of the binary interface does not match the bindings interface';
      else
        ADescription := 'unknown';
    end;

    inherited Create (Format ('Calculator library Error - %s (#%d, %s)', [ ADescription, AErrorCode, AMessage ]));
  end;

  constructor ECalculatorException.CreateCustomMessage (AErrorCode: TCalculatorResult; AMessage: String);
  begin
    FCustomMessage := AMessage;
    FErrorCode := AErrorCode;
    inherited Create (Format ('%s (%d)', [FCustomMessage, AErrorCode]));
  end;

(*************************************************************************************************************************
 Class implementation for Base
**************************************************************************************************************************)

  constructor TCalculatorBase.Create (AWrapper: TCalculatorWrapper; AHandle: TCalculatorHandle);
  begin
    if not Assigned (AWrapper) then
      raise ECalculatorException.Create (CALCULATOR_ERROR_INVALIDPARAM, '');
    if not Assigned (AHandle) then
      raise ECalculatorException.Create (CALCULATOR_ERROR_INVALIDPARAM, '');

    inherited Create ();
    FWrapper := AWrapper;
    FHandle := AHandle;
  end;

  destructor TCalculatorBase.Destroy;
  begin
    FWrapper.ReleaseInstance(self);
    inherited;
  end;

(*************************************************************************************************************************
 Class implementation for Variable
**************************************************************************************************************************)

  constructor TCalculatorVariable.Create (AWrapper: TCalculatorWrapper; AHandle: TCalculatorHandle);
  begin
    inherited Create (AWrapper, AHandle);
  end;

  destructor TCalculatorVariable.Destroy;
  begin
    inherited;
  end;

  function TCalculatorVariable.GetValue(): Double;
  begin
    FWrapper.CheckError (Self, FWrapper.CalculatorVariable_GetValueFunc (FHandle, Result));
  end;

  procedure TCalculatorVariable.SetValue(const AValue: Double);
  begin
    FWrapper.CheckError (Self, FWrapper.CalculatorVariable_SetValueFunc (FHandle, AValue));
  end;

(*************************************************************************************************************************
 Class implementation for Calculator
**************************************************************************************************************************)

  constructor TCalculatorCalculator.Create (AWrapper: TCalculatorWrapper; AHandle: TCalculatorHandle);
  begin
    inherited Create (AWrapper, AHandle);
  end;

  destructor TCalculatorCalculator.Destroy;
  begin
    inherited;
  end;

  procedure TCalculatorCalculator.EnlistVariable(const AVariable: TCalculatorVariable);
  begin
    if not Assigned (AVariable) then
      raise ECalculatorException.CreateCustomMessage (CALCULATOR_ERROR_INVALIDPARAM, 'AVariable is a nil value.');
    FWrapper.CheckError (Self, FWrapper.CalculatorCalculator_EnlistVariableFunc (FHandle, AVariable.FHandle));
  end;

  function TCalculatorCalculator.GetEnlistedVariable(const AIndex: Cardinal): TCalculatorVariable;
  var
    HVariable: TCalculatorHandle;
  begin
    Result := nil;
    HVariable := nil;
    FWrapper.CheckError (Self, FWrapper.CalculatorCalculator_GetEnlistedVariableFunc (FHandle, AIndex, HVariable));
    if Assigned (HVariable) then
      Result := TCalculatorVariable.Create (FWrapper, HVariable);
  end;

  procedure TCalculatorCalculator.ClearVariables();
  begin
    FWrapper.CheckError (Self, FWrapper.CalculatorCalculator_ClearVariablesFunc (FHandle));
  end;

  function TCalculatorCalculator.Multiply(): TCalculatorVariable;
  var
    HInstance: TCalculatorHandle;
  begin
    Result := nil;
    HInstance := nil;
    FWrapper.CheckError (Self, FWrapper.CalculatorCalculator_MultiplyFunc (FHandle, HInstance));
    if Assigned (HInstance) then
      Result := TCalculatorVariable.Create (FWrapper, HInstance);
  end;

  function TCalculatorCalculator.Add(): TCalculatorVariable;
  var
    HInstance: TCalculatorHandle;
  begin
    Result := nil;
    HInstance := nil;
    FWrapper.CheckError (Self, FWrapper.CalculatorCalculator_AddFunc (FHandle, HInstance));
    if Assigned (HInstance) then
      Result := TCalculatorVariable.Create (FWrapper, HInstance);
  end;

(*************************************************************************************************************************
 Wrapper class implementation
**************************************************************************************************************************)

  constructor TCalculatorWrapper.Create (ADLLName: String);
  {$IFDEF MSWINDOWS}
  var
    AWideString: WideString;
  {$ENDIF MSWINDOWS}
  begin
    inherited Create;
    {$IFDEF MSWINDOWS}
      AWideString := UTF8Decode(ADLLName + #0);
      FModule := LoadLibraryW (PWideChar (AWideString));
    {$ELSE}
      FModule := dynlibs.LoadLibrary (ADLLName);
    {$ENDIF MSWINDOWS}
    if FModule = 0 then
      raise ECalculatorException.Create (CALCULATOR_ERROR_COULDNOTLOADLIBRARY, '');

    FCalculatorVariable_GetValueFunc := LoadFunction ('calculator_variable_getvalue');
    FCalculatorVariable_SetValueFunc := LoadFunction ('calculator_variable_setvalue');
    FCalculatorCalculator_EnlistVariableFunc := LoadFunction ('calculator_calculator_enlistvariable');
    FCalculatorCalculator_GetEnlistedVariableFunc := LoadFunction ('calculator_calculator_getenlistedvariable');
    FCalculatorCalculator_ClearVariablesFunc := LoadFunction ('calculator_calculator_clearvariables');
    FCalculatorCalculator_MultiplyFunc := LoadFunction ('calculator_calculator_multiply');
    FCalculatorCalculator_AddFunc := LoadFunction ('calculator_calculator_add');
    FCalculatorGetVersionFunc := LoadFunction ('calculator_getversion');
    FCalculatorGetLastErrorFunc := LoadFunction ('calculator_getlasterror');
    FCalculatorReleaseInstanceFunc := LoadFunction ('calculator_releaseinstance');
    FCalculatorCreateVariableFunc := LoadFunction ('calculator_createvariable');
    FCalculatorCreateCalculatorFunc := LoadFunction ('calculator_createcalculator');
    
    checkBinaryVersion();
  end;

  destructor TCalculatorWrapper.Destroy;
  begin
    {$IFDEF MSWINDOWS}
      if FModule <> 0 then
        FreeLibrary (FModule);
    {$ELSE}
      if FModule <> 0 then
        UnloadLibrary (FModule);
    {$ENDIF MSWINDOWS}
    inherited;
  end;

  procedure TCalculatorWrapper.CheckError (AInstance: TCalculatorBase; AErrorCode: TCalculatorResult);
  var
    AErrorMessage: String;
  begin
    if AInstance <> nil then begin
      if AInstance.FWrapper <> Self then
        raise ECalculatorException.CreateCustomMessage (CALCULATOR_ERROR_INVALIDCAST, 'invalid wrapper call');
    end;
    if AErrorCode <> CALCULATOR_SUCCESS then begin
      AErrorMessage := '';
      if Assigned (AInstance) then
        GetLastError(AInstance, AErrorMessage);
      raise ECalculatorException.Create (AErrorCode, AErrorMessage);
    end;
  end;

  {$IFDEF MSWINDOWS}
  function TCalculatorWrapper.LoadFunction (AFunctionName: AnsiString; FailIfNotExistent: Boolean): FARPROC;
  begin
    Result := GetProcAddress (FModule, PAnsiChar (AFunctionName));
    if FailIfNotExistent and not Assigned (Result) then
      raise ECalculatorException.CreateCustomMessage (CALCULATOR_ERROR_COULDNOTFINDLIBRARYEXPORT, 'could not find function ' + AFunctionName);
  end;
  {$ELSE}
  function TCalculatorWrapper.LoadFunction (AFunctionName: AnsiString; FailIfNotExistent: Boolean): Pointer;
  begin
    Result := dynlibs.GetProcAddress (FModule, AFunctionName);
    if FailIfNotExistent and not Assigned (Result) then
      raise ECalculatorException.CreateCustomMessage (CALCULATOR_ERROR_COULDNOTFINDLIBRARYEXPORT, 'could not find function ' + AFunctionName);
  end;
  {$ENDIF MSWINDOWS}

  procedure TCalculatorWrapper.checkBinaryVersion();
  var
    AMajor, AMinor, AMicro: Cardinal;
  begin
    GetVersion(AMajor, AMinor, AMicro);
    if (AMajor <> CALCULATOR_VERSION_MAJOR) then
      raise ECalculatorException.Create(CALCULATOR_ERROR_INCOMPATIBLEBINARYVERSION, '');
  end;
  
  procedure TCalculatorWrapper.GetVersion(out AMajor: Cardinal; out AMinor: Cardinal; out AMicro: Cardinal);
  begin
    CheckError (nil, CalculatorGetVersionFunc (AMajor, AMinor, AMicro));
  end;

  function TCalculatorWrapper.GetLastError(const AInstance: TCalculatorBase; out AErrorMessage: String): Boolean;
  var
    bytesNeededErrorMessage: Cardinal;
    bytesWrittenErrorMessage: Cardinal;
    bufferErrorMessage: array of Char;
    ResultHasError: Byte;
  begin
    if not Assigned (AInstance) then
      raise ECalculatorException.CreateCustomMessage (CALCULATOR_ERROR_INVALIDPARAM, 'AInstance is a nil value.');
    bytesNeededErrorMessage:= 0;
    bytesWrittenErrorMessage:= 0;
    ResultHasError := 0;
    CheckError (nil, CalculatorGetLastErrorFunc (AInstance.FHandle, 0, bytesNeededErrorMessage, nil, ResultHasError));
    SetLength (bufferErrorMessage, bytesNeededErrorMessage);
    CheckError (nil, CalculatorGetLastErrorFunc (AInstance.FHandle, bytesNeededErrorMessage, bytesWrittenErrorMessage, @bufferErrorMessage[0], ResultHasError));
    AErrorMessage := StrPas (@bufferErrorMessage[0]);
    Result := (ResultHasError <> 0);
  end;

  procedure TCalculatorWrapper.ReleaseInstance(const AInstance: TCalculatorBase);
  begin
    if not Assigned (AInstance) then
      raise ECalculatorException.CreateCustomMessage (CALCULATOR_ERROR_INVALIDPARAM, 'AInstance is a nil value.');
    CheckError (nil, CalculatorReleaseInstanceFunc (AInstance.FHandle));
  end;

  function TCalculatorWrapper.CreateVariable(const AInitialValue: Double): TCalculatorVariable;
  var
    HInstance: TCalculatorHandle;
  begin
    Result := nil;
    HInstance := nil;
    CheckError (nil, CalculatorCreateVariableFunc (AInitialValue, HInstance));
    if Assigned (HInstance) then
      Result := TCalculatorVariable.Create (Self, HInstance);
  end;

  function TCalculatorWrapper.CreateCalculator(): TCalculatorCalculator;
  var
    HInstance: TCalculatorHandle;
  begin
    Result := nil;
    HInstance := nil;
    CheckError (nil, CalculatorCreateCalculatorFunc (HInstance));
    if Assigned (HInstance) then
      Result := TCalculatorCalculator.Create (Self, HInstance);
  end;


end.
