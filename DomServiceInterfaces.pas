unit DomServiceInterfaces;

interface

{$I mormot.defines.inc}

uses
  mormot.core.interfaces,
  DomTypes;

const
  EXAMPLE_CONTRACT = 'StoreService';

type
  TStoreServiceError = (sSuccess, sNotFound, sMissingField, sPersistenceError);

type
  IStoreService = interface(IInvokable)
    ['{B8DE093D-A027-4C61-A67B-638FB0F23242}']
    function AddSample(var ASample: TSample): TStoreServiceError;
    function FindSample(var ASample: TSample): TStoreServiceError;
  end;

implementation

initialization

TInterfaceFactory.RegisterInterfaces([TypeInfo(IStoreService)]);

end.
