unit AtbMarket.Shop.Provider;

interface

uses
  SPU.Shop.Provider,
  AtbMarket.Client,
  mormot.rest.sqlite3,
  AtbMarket.Types,
  SPU.Shop.Model,
  System.SysUtils;

type
  TAtbMarketShopProvider = class(TInterfacedObject, IspuShopProvider)
  private
    FAtb: TatbShopController;
    FDb: TRestClientDB;
  protected
    function GetShopByIndex(const AIndex: Integer): IspuShopModel;
    function GetShopById(const AID: Integer): IatbShop;
  public
    function GetName: string;
    procedure Add(AShop: IatbShop);
    constructor Create(AClientDb: TRestClientDB);
    destructor Destroy; override;
    function Count: Integer;
    procedure UpdateFromServer(AOnUpdate: TProc<Integer, Integer>);
  end;

implementation

uses
  AtbMarket.OrmTypes,
  mormot.core.base,
  AtbMarket.Shop.Model;

{ TAtbMarketShopProvider }

procedure TAtbMarketShopProvider.Add(AShop: IatbShop);
var
  LAtb: TOrmAtbShop;
begin
  LAtb := TOrmAtbShop.Create;
  try
    LAtb.ShopId := AShop.Id;
    LAtb.RegionId := AShop.RegionId;
    LAtb.Region := AShop.Region;
    LAtb.CityId := AShop.CityId;
    LAtb.City := AShop.City;
    LAtb.Adress := AShop.Adress;
    LAtb.Long := AShop.Long;
    LAtb.Lat := AShop.Lat;
    LAtb.Shedule := AShop.Shedule;
    LAtb.Is247 := AShop.Is247;
    // LAtb.CreatedAt := DateToISO8601(Now);
    if FDb.Orm.Add(LAtb, true) = 0 then
      raise Exception.Create('Error adding the data')
  finally
    LAtb.Free;
  end;
end;

function TAtbMarketShopProvider.Count: Integer;
begin
  Result := FDb.TableRowCount(TOrmAtbShop);
end;

constructor TAtbMarketShopProvider.Create(AClientDb: TRestClientDB);
begin
  FAtb := TatbShopController.Create;
  FDb := AClientDb;
end;

destructor TAtbMarketShopProvider.Destroy;
begin
  FAtb.Free;
  inherited;
end;

function TAtbMarketShopProvider.GetName: string;
begin
  Result := 'АТБ-Маркет';
end;

function TAtbMarketShopProvider.GetShopById(const AID: Integer): IatbShop;
var
  LOrmAtbShop: TOrmAtbShop;
begin
  LOrmAtbShop := TOrmAtbShop.Create(FDb.Orm, 'ShopId=?', [AID.ToString]);
  try
    if LOrmAtbShop.Id > 0 then
      Result := TAtbMarketStoreModel.Create(LOrmAtbShop, Self.GetName)
    else
      Result := nil;
  finally
    LOrmAtbShop.Free;
  end;
end;

function TAtbMarketShopProvider.GetShopByIndex(const AIndex: Integer): IspuShopModel;
var
  LOrmAtbShop: TOrmAtbShop;
  LRow: TID;
begin
  LOrmAtbShop := TOrmAtbShop.Create;
  try
    LRow := FDb.List([TOrmAtbShop]).GetID(AIndex + 1);
    FDb.Retrieve(LRow, LOrmAtbShop);
    Result := TAtbMarketStoreModel.Create(LOrmAtbShop, Self.GetName);
  finally
    LOrmAtbShop.Free;
  end;
end;

procedure TAtbMarketShopProvider.UpdateFromServer(AOnUpdate: TProc<Integer, Integer>);
var
  LShop: IatbShop;
begin
  if Assigned(AOnUpdate) then
    AOnUpdate(-1, -1);
  var
  LShops := FAtb.List.Shops;
  for var I := Low(LShops) to High(LShops) do
  begin
    LShop := GetShopById(LShops[I].Id);
    if LShop = nil then
    begin
      Add(LShops[I]);
    end;
    if Assigned(AOnUpdate) then
      AOnUpdate(I, High(LShops));
  end;
end;

end.
