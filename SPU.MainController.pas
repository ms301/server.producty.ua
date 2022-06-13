unit SPU.MainController;

interface

uses
  mormot.rest.sqlite3, SPU.Shop.Provider;

type
  TMainController = class
  private
    class var FCurrent: TMainController;
  private
    FDB: TRestClientDB;
    FShopProviders: TspuShopProviderController;
  public
    constructor Create;
    destructor Destroy; override;
    class constructor Create;
    class Destructor Destroy;
    class property Current: TMainController read FCurrent;
  published
    property DB: TRestClientDB read FDB write FDB;
    property ShopProviders: TspuShopProviderController read FShopProviders write FShopProviders;
  end;

implementation

uses
  Data,
  System.SysUtils,
  mormot.core.os;

{ TMainController }

constructor TMainController.Create;
begin
  FDB := TRestClientDB.Create(CreateShopModel, nil, ChangeFileExt(Executable.ProgramFileName, '.db'), TRestServerDB,
    false, '');
  FDB.Server.Server.CreateMissingTables;
  FShopProviders := TspuShopProviderController.Create;
end;

class constructor TMainController.Create;
begin
  FCurrent := TMainController.Create;
end;

destructor TMainController.Destroy;
begin
  FShopProviders.Free;
  FDB.Free;
  inherited Destroy;
end;

class destructor TMainController.Destroy;
begin
  FCurrent.Free;
end;

end.
