unit data;

interface

uses
  mormot.orm.core,
  mormot.core.base,
  mormot.orm.base;

const
  HTTP_PORT = '11111';

type
  TOrmShop = class(TOrm)
  private
    FName: RawUTF8;
    FShopId: Integer;
    FCity: RawUTF8;
    FAddres: RawUTF8;
    FCreatedAt: RawUTF8;
  published
    property Name: RawUTF8 read FName write FName;
    property ShopId: Integer read FShopId write FShopId;
    property City: RawUTF8 read FCity write FCity;
    property Addres: RawUTF8 read FAddres write FAddres;
    property CreatedAt: RawUTF8 read FCreatedAt write FCreatedAt;
  end;

  TOrmBarcode = class(TOrm)
  private
    FBarcodes: RawUTF8;
    FName: RawUTF8;
  published
    property Barcodes: RawUTF8 read FBarcodes write FBarcodes;
    property Name: RawUTF8 read FName write FName;
  end;

  TOrmProductScan = class(TOrm)
  private
    FBarcode: TOrmBarcode;
    FPrice: RawUTF8;
    FScanedAt: RawUTF8;
  published
    property Barcode: TOrmBarcode read FBarcode write FBarcode;
    property Price: RawUTF8 read FPrice write FPrice;
    property ScanedAt: RawUTF8 read FScanedAt write FScanedAt;
  end;

  TOrmProduct = class(TOrm)
  private
    FName: RawUTF8;
    FBarcode: RawUTF8;
  published
    property Name: RawUTF8 read FName write FName;
    property Barcode: RawUTF8 read FBarcode write FBarcode;
  end;

function CreateShopModel: TOrmModel;

implementation

uses
  AtbMarket.OrmTypes;

function CreateShopModel: TOrmModel;
begin
  Result := TOrmModel.Create([TOrmShop, TOrmAtbShop, TOrmProduct, TOrmBarcode]);
end;

end.
