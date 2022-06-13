unit SPU.AtbMarket.BarcodeController;

interface

uses
  mormot.rest.sqlite3,
  AtbMarket.Client, data;

type
  TBarcodeController = class
  private
    FDb: TRestClientDB;
    FAtbBar: TatbCustomerController;
    FDeviceID: string;
    function GetRow(const ARow: Integer): TOrmBarcode;
  public
    constructor Create(AClientDb: TRestClientDB);
    function Count: Int64;
    procedure AddBarcode(const ABarcode: string); overload;
    procedure AddBarcode(const AName, ABarcode: string); overload;
    procedure Delete(const ABarcode: string);
    procedure Find(const ACode: string; var ABar: TOrmBarcode);
    destructor Destroy; override;
    property DeviceID: string read FDeviceID write FDeviceID;
    property Row[const ARow: Integer]: TOrmBarcode read GetRow;
  end;

implementation

uses
  AtbMarket.Types, System.SysUtils;

{ TProductController }

procedure TBarcodeController.AddBarcode(const ABarcode: string);
var
  LScan: IatbProductScan;
  LBar: TOrmBarcode;
begin
  Find(ABarcode, LBar);
  try
    if LBar.ID = 0 then
    begin
      LScan := FAtbBar.ProductScan(ABarcode, 413, FDeviceID);
      if not LScan.Name.IsEmpty then
        AddBarcode(LScan.Name, ABarcode);
    end;
  finally
    LBar.Free;
  end;
end;

procedure TBarcodeController.AddBarcode(const AName, ABarcode: string);
var
  Rec: TOrmBarcode;
begin
  Rec := TOrmBarcode.Create;
  try
    Rec.Name := AName;
    Rec.Barcodes := ABarcode;
    if FDb.Orm.Add(Rec, true) = 0 then
      raise Exception.Create('Error adding the data')
  finally
    Rec.Free;
  end;
end;

function TBarcodeController.Count: Int64;
begin
  Result := FDb.Orm.TableRowCount(TOrmBarcode);
end;

constructor TBarcodeController.Create(AClientDb: TRestClientDB);
begin
  FDb := AClientDb;
  FAtbBar := TatbCustomerController.Create;
  FDeviceID := '0e511ea874f214c5';
end;

procedure TBarcodeController.Delete(const ABarcode: string);
begin
  FDb.Delete(TOrmBarcode, 'Barcodes=?', [ABarcode])
end;

destructor TBarcodeController.Destroy;
begin
  FAtbBar.Free;
  inherited;
end;

procedure TBarcodeController.Find(const ACode: string; var ABar: TOrmBarcode);
begin
  ABar := TOrmBarcode.Create(FDb.Orm, 'Barcodes=?', [ACode]);
end;

function TBarcodeController.GetRow(const ARow: Integer): TOrmBarcode;
begin
  Result := TOrmBarcode.Create;
  var
  LRow := FDb.List([TOrmBarcode]).GetID(ARow + 1);
  FDb.Retrieve(LRow, Result);
end;

end.
