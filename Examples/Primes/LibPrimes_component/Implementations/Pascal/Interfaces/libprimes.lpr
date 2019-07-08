(*++

Copyright (C) 2019 PrimeDevelopers

All rights reserved.

This file has been generated by the Automatic Component Toolkit (ACT) version 1.6.0-RC1.

Abstract: This is an autogenerated Pascal project file in order to allow easy
development of Prime Numbers Library.

Interface version: 1.2.0

*)

{$MODE DELPHI}
library libprimes;

uses
{$IFDEF UNIX}
  cthreads,
{$ENDIF UNIX}
  syncobjs,
  libprimes_types,
  libprimes_exports,
  Classes,
  sysutils;

exports
  libprimes_calculator_getvalue,
  libprimes_calculator_setvalue,
  libprimes_calculator_calculate,
  libprimes_calculator_setprogresscallback,
  libprimes_factorizationcalculator_getprimefactors,
  libprimes_sievecalculator_getprimes,
  libprimes_getversion,
  libprimes_getlasterror,
  libprimes_acquireinstance,
  libprimes_releaseinstance,
  libprimes_createfactorizationcalculator,
  libprimes_createsievecalculator,
  libprimes_setjournal;

begin

end.
