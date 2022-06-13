unit AtbMarket.Shop.Model;

interface

uses
  SPU.Shop.Model,
  AtbMarket.OrmTypes,
  AtbMarket.Types;

type
  TAtbMarketStoreModel = class(TspuStoreModel, IatbShop)
  protected
    FRegionId: Integer;
    FRegion: string;
    FCityId: Integer;
    FAdress: string;
    FLong: string;
    FLat: string;
    FShedule: string;
    FIs247: Integer;
  public
    constructor Create(AOrmAtbShop: TOrmAtbShop; const ShopName: string); overload;
    constructor Create(AAtbShop: IatbShop); overload;
    function GetAdress: string;
    function GetCity: string;
    function GetId: Integer;
    function GetRegion: string;
    function GetRegionId: Integer;
    function GetCityId: Integer;
    function GetLat: string;
    function GetLong: string;
    function GetIs247: Integer;
    function GetShedule: string;
  end;

implementation

{ TAtbMarketStoreModel }

constructor TAtbMarketStoreModel.Create(AOrmAtbShop: TOrmAtbShop; const ShopName: string);
begin
  FShopName := ShopName;
  FShopID := AOrmAtbShop.ShopId;

  FAdress := AOrmAtbShop.Adress;
  FRegionId := AOrmAtbShop.RegionId;
  FRegion := AOrmAtbShop.Region;
  FCityId := AOrmAtbShop.CityId;
  FCity := AOrmAtbShop.City;
  FLong := AOrmAtbShop.Long;
  FLat := AOrmAtbShop.Lat;
  FShedule := AOrmAtbShop.Shedule;
  FIs247 := AOrmAtbShop.Is247;
end;

constructor TAtbMarketStoreModel.Create(AAtbShop: IatbShop);
begin
  FShopID := AAtbShop.Id;
  FAdress := AAtbShop.Adress;
  FRegionId := AAtbShop.RegionId;
  FRegion := AAtbShop.Region;
  FCityId := AAtbShop.CityId;
  FCity := AAtbShop.City;
  FLong := AAtbShop.Long;
  FLat := AAtbShop.Lat;
  FShedule := AAtbShop.Shedule;
  FIs247 := AAtbShop.Is247;
end;

function TAtbMarketStoreModel.GetAdress: string;
begin
  Result := FAdress;
end;

function TAtbMarketStoreModel.GetCity: string;
begin
  Result := FCity;
end;

function TAtbMarketStoreModel.GetCityId: Integer;
begin
  Result := FCityId;
end;

function TAtbMarketStoreModel.GetId: Integer;
begin
  Result := GetShopID;
end;

function TAtbMarketStoreModel.GetIs247: Integer;
begin
  Result := FIs247;
end;

function TAtbMarketStoreModel.GetLat: string;
begin
  Result := FLat;
end;

function TAtbMarketStoreModel.GetLong: string;
begin
  Result := FLong;
end;

function TAtbMarketStoreModel.GetRegion: string;
begin
  Result := FRegion;
end;

function TAtbMarketStoreModel.GetRegionId: Integer;
begin
  Result := FRegionId;
end;

function TAtbMarketStoreModel.GetShedule: string;
begin
  Result := FShedule;
end;

end.
