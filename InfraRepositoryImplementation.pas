unit InfraRepositoryImplementation;

interface

{$I mormot.defines.inc}

uses
  SysUtils,
  mormot.core.base,
  mormot.core.os,
  mormot.orm.base,
  mormot.orm.core,
  mormot.db.raw.sqlite3,

  mormot.rest.sqlite3,
  mormot.db.raw.sqlite3.static,
  DomTypes,
  DomRepositoryInterfaces;

type
  TOrmSample = class(TOrm)
  private
    FName: RawUTF8;
    FQuestion: RawUTF8;
    FTime: TModTime;
  published
    property Name: RawUTF8 read FName write FName;
    property Question: RawUTF8 read FQuestion write FQuestion;
    property Time: TModTime read FTime write FTime;
  end;

  TStoreRepository = class(TInterfacedObject, IStoreRepository)
  private
    FOrmServer: TRestServerDB;
    FRestOrm: IRestOrm;
  protected
    function GetSample(const AName: TName): TOrmSample;
  public
    constructor Create; overload;
    destructor Destroy; override;
    function RetrieveSample(var ASample: TSample): TStoreRepositoryError;
    function SaveNewSample(var ASample: TSample): TStoreRepositoryError;
  end;

function CreateSampleModel: TOrmModel;

implementation

function CreateSampleModel: TOrmModel;
begin
  result := TOrmModel.Create([TOrmSample]);
end;

{
  ****************************** TStoreRepository *******************************
}
constructor TStoreRepository.Create;
begin
  inherited Create;
  FOrmServer := TRestServerDB.Create(CreateSampleModel, ChangeFileExt(Executable.ProgramFileName, '.db'));
  FOrmServer.db.Synchronous := smOff;
  FOrmServer.db.LockingMode := lmExclusive;
  FOrmServer.Server.CreateMissingTables;
  FRestOrm := FOrmServer.orm;
end;

destructor TStoreRepository.Destroy;
begin
  FRestOrm := nil;
  FOrmServer.Free;
  inherited Destroy;
end;

function TStoreRepository.GetSample(const AName: TName): TOrmSample;
begin
  result := TOrmSample.Create(FRestOrm, 'Name=?', [AName]);
end;

function TStoreRepository.RetrieveSample(var ASample: TSample): TStoreRepositoryError;
var
  OrmSample: TOrmSample;
begin
  result := srNotFound;
  OrmSample := GetSample(ASample.Name);
  try
    if OrmSample.IDValue = 0 then
      exit;
    ASample.Question := OrmSample.Question;
    result := srSuccess;
  finally
    OrmSample.Free;
  end;
end;

function TStoreRepository.SaveNewSample(var ASample: TSample): TStoreRepositoryError;
var
  OrmSample: TOrmSample;
begin
  result := srWriteFailure;
  OrmSample := GetSample(ASample.Name);
  try
    if OrmSample.IDValue <> 0 then
    begin
      result := srDuplicatedInfo;
      exit;
    end;
    OrmSample.Name := ASample.Name;
    OrmSample.Question := ASample.Question;
    if FRestOrm.Add(OrmSample, true) > 0 then
      result := srSuccess
  finally
    OrmSample.Free;
  end;
end;

end.
