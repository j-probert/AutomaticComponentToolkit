(*++

Copyright (C) 2019 PrimeDevelopers

All rights reserved.

This file has been generated by the Automatic Component Toolkit (ACT) version 1.6.0-RC1.

Abstract: This is an autogenerated Pascal exception class definition file in order to allow easy
development of Prime Numbers Library. The functions in this file need to be implemented. It needs to be generated only once.

Interface version: 1.2.0

*)

{$MODE DELPHI}
unit libprimes_exception;

interface

uses
  libprimes_types,
  libprimes_interfaces,
  Classes,
  sysutils;

type
  ELibPrimesException = class(Exception)
  private
    FErrorCode: TLibPrimesResult;
    FCustomMessage: String;
  public
    property ErrorCode: TLibPrimesResult read FErrorCode;
    property CustomMessage: String read FCustomMessage;
    constructor Create(AErrorCode: TLibPrimesResult);
    constructor CreateCustomMessage(AErrorCode: TLibPrimesResult; AMessage: String);
  end;


(*************************************************************************************************************************
 Definition of exception handling functionality for LibPrimes
**************************************************************************************************************************)

function HandleLibPrimesException(ALibPrimesObject: TObject; E: ELibPrimesException): TLibPrimesResult;
function HandleStdException(ALibPrimesObject: TObject; E: Exception): TLibPrimesResult;
function HandleUnhandledException(ALibPrimesObject: TObject): TLibPrimesResult;


implementation

  constructor ELibPrimesException.Create(AErrorCode: TLibPrimesResult);
  var
    ADescription: String;
  begin
    FErrorCode := AErrorCode;
    case FErrorCode of
      LIBPRIMES_ERROR_NOTIMPLEMENTED: ADescription := 'functionality not implemented';
      LIBPRIMES_ERROR_INVALIDPARAM: ADescription := 'an invalid parameter was passed';
      LIBPRIMES_ERROR_INVALIDCAST: ADescription := 'a type cast failed';
      LIBPRIMES_ERROR_BUFFERTOOSMALL: ADescription := 'a provided buffer is too small';
      LIBPRIMES_ERROR_GENERICEXCEPTION: ADescription := 'a generic exception occurred';
      LIBPRIMES_ERROR_COULDNOTLOADLIBRARY: ADescription := 'the library could not be loaded';
      LIBPRIMES_ERROR_COULDNOTFINDLIBRARYEXPORT: ADescription := 'a required exported symbol could not be found in the library';
      LIBPRIMES_ERROR_INCOMPATIBLEBINARYVERSION: ADescription := 'the version of the binary interface does not match the bindings interface';
      LIBPRIMES_ERROR_NORESULTAVAILABLE: ADescription := 'no result is available';
      LIBPRIMES_ERROR_CALCULATIONABORTED: ADescription := 'a calculation has been aborted';
      else
        ADescription := 'unknown';
    end;

    inherited Create(Format('Prime Numbers Library Error - %s (#%d)', [ ADescription, AErrorCode ]));
  end;

  constructor ELibPrimesException.CreateCustomMessage(AErrorCode: TLibPrimesResult; AMessage: String);
  begin
    FCustomMessage := AMessage;
    FErrorCode := AErrorCode;
    inherited Create(Format('%s(%d)', [FCustomMessage, AErrorCode]));
  end;

(*************************************************************************************************************************
 Implementation of exception handling functionality for LibPrimes
**************************************************************************************************************************)

function HandleLibPrimesException(ALibPrimesObject: TObject; E: ELibPrimesException): TLibPrimesResult;
begin
  result := E.ErrorCode;
  if Supports(ALibPrimesObject, ILibPrimesBase) then begin
    (ALibPrimesObject as ILibPrimesBase).RegisterErrorMessage(E.CustomMessage)
  end;
end;
function HandleStdException(ALibPrimesObject: TObject; E: Exception): TLibPrimesResult;
begin
  Result := LIBPRIMES_ERROR_GENERICEXCEPTION;
  if Supports(ALibPrimesObject, ILibPrimesBase) then begin
    (ALibPrimesObject as ILibPrimesBase).RegisterErrorMessage(E.Message)
  end;
end;
function HandleUnhandledException(ALibPrimesObject: TObject): TLibPrimesResult;
begin
  Result := LIBPRIMES_ERROR_GENERICEXCEPTION;
  if Supports(ALibPrimesObject, ILibPrimesBase) then begin
    (ALibPrimesObject as ILibPrimesBase).RegisterErrorMessage('Unhandled Exception')
  end;
end;
end.
