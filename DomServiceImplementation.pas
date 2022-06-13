unit DomServiceImplementation;

interface

{$I mormot.defines.inc}

uses
  mormot.soa.server,
  DomTypes,
  DomServiceInterfaces,
  DomRepositoryInterfaces;

type
  TSampleService = class(TInjectableObjectRest, IStoreService)
  private
    FRepository: IStoreRepository;
  public
    constructor Create(ARepository: IStoreRepository); reintroduce;
    function AddSample(var ASample: TSample): TStoreServiceError;
    function FindSample(var ASample: TSample): TStoreServiceError;
  end;

implementation

{
  ******************************** TSampleService ********************************
}
constructor TSampleService.Create(ARepository: IStoreRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TSampleService.AddSample(var ASample: TSample): TStoreServiceError;
begin
  if (ASample.Name = '') or (ASample.Question = '') then
  begin
    Result := sMissingField;
    exit;
  end;
  if FRepository.SaveNewSample(ASample) = srSuccess then
    Result := sSuccess
  else
    Result := sPersistenceError;
end;

function TSampleService.FindSample(var ASample: TSample): TStoreServiceError;
begin
  if FRepository.RetrieveSample(ASample) = srSuccess then
    Result := sSuccess
  else
    Result := sNotFound;
end;

end.
