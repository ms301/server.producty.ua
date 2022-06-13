unit DomRepositoryInterfaces;

interface

{$I mormot.defines.inc}

uses
  mormot.core.interfaces,
  DomTypes;

type
  TStoreRepositoryError = (srSuccess, srNotFound, srDuplicatedInfo, srWriteFailure);

type
  IStoreRepository = interface(IInvokable)
    ['{F953DFBC-F69C-4E4C-967B-CDD40EA9DF5F}']
    function RetrieveSample(var ASample: TSample): TStoreRepositoryError;
    function SaveNewSample(var ASample: TSample): TStoreRepositoryError;
  end;

implementation

initialization

TInterfaceFactory.RegisterInterfaces([TypeInfo(IStoreRepository)]);

end.
