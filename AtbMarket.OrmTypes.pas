unit AtbMarket.OrmTypes;

interface

uses
  mormot.orm.core,
  mormot.core.base;

type
  TOrmAtbProvider = class(TOrm)
  private
    FName: RawUtf8;
  published
    property Name: RawUtf8 read FName write FName;
  end;

  TOrmAtbShop = class(TOrm)
  private
    FShopId: Integer;
    FRegionId: Integer;
    FRegion: RawUtf8;
    FCityId: Integer;
    FCity: RawUtf8;
    FAdress: RawUtf8;
    FLong: string;
    FLat: string;
    FShedule: string;
    FIs247: Integer;
  published
    property ShopId: Integer read FShopId write FShopId;
    property RegionId: Integer read FRegionId write FRegionId;
    property Region: RawUtf8 read FRegion write FRegion;
    property CityId: Integer read FCityId write FCityId;
    property City: RawUtf8 read FCity write FCity;
    property Adress: RawUtf8 read FAdress write FAdress;
    property Long: string read FLong write FLong;
    property Lat: string read FLat write FLat;
    property Shedule: string read FShedule write FShedule;
    property Is247: Integer read FIs247 write FIs247;
  end;

implementation

end.
