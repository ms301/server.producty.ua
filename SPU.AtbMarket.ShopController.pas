unit SPU.AtbMarket.ShopController;

interface

uses
  AtbMarket.Client,
  mormot.rest.sqlite3,
  mormot.db.raw.sqlite3.static,
  AtbMarket.Types, data,
  mormot.core.base, System.SysUtils;

type
  TatbShopController = class
  private
    FAtb: AtbMarket.Client.TatbShopController;
    FDb: TRestClientDB;
    FShopIds: TArray<TID>;
    function GetRow(const ARow: Integer): TOrmShop;
  public
    constructor Create(AClientDb: TRestClientDB);
    destructor Destroy; override;
    procedure UpdateFromServer(AOnUpdate: TProc<Integer, Integer>);
    procedure Find(const AName: string; const AID: Integer; var AShopOrm: TOrmShop);
    procedure Add(AShop: TatbShop);
    property Row[const ARow: Integer]: TOrmShop read GetRow;
    function Count: Int64;
    procedure Clear;
  end;

implementation

uses
  System.DateUtils,
  mormot.core.os;
{ TatbShopController }

procedure TatbShopController.Add(AShop: TatbShop);
var
  Rec: TOrmShop;
begin
  Rec := TOrmShop.Create;
  try
    Rec.Name := 'АТБ-Маркет';
    Rec.ShopId := AShop.Id;
    Rec.City := AShop.City;
    Rec.Addres := AShop.Adress;
    Rec.CreatedAt := DateToISO8601(Now);
    if FDb.Orm.Add(Rec, true) = 0 then
      raise Exception.Create('Error adding the data')
  finally
    Rec.Free;
  end;
end;

procedure TatbShopController.Clear;
begin
  FDb.Delete(TOrmShop, '1=1');
end;

function TatbShopController.Count: Int64;
begin
  Result := FDb.Orm.TableRowCount(TOrmShop);
end;

constructor TatbShopController.Create(AClientDb: TRestClientDB);
begin
  FAtb := AtbMarket.Client.TatbShopController.Create;
  FDb := AClientDb;
end;

destructor TatbShopController.Destroy;
begin
  FAtb.Free;
  inherited;
end;

procedure TatbShopController.Find(const AName: string; const AID: Integer; var AShopOrm: TOrmShop);
begin
  AShopOrm := TOrmShop.Create(FDb.Orm, 'Name=? AND ShopId=?', [AName, AID.ToString]);
end;

function TatbShopController.GetRow(const ARow: Integer): TOrmShop;
begin
  Result := TOrmShop.Create;
  var
  LRow := FDb.List([TOrmShop]).GetID(ARow + 1);
  FDb.Retrieve(LRow, Result);
end;

procedure TatbShopController.UpdateFromServer(AOnUpdate: TProc<Integer, Integer>);
var
  LShop: TOrmShop;
begin
  if Assigned(AOnUpdate) then
    AOnUpdate(-1, -1);
  var
  LShops := FAtb.List.Shops;
  for var I := Low(LShops) to High(LShops) do
  begin
    Find('АТБ-Маркет', LShops[I].Id, LShop);
    if LShop.Id = 0 then
    begin
      Add(LShops[I]);
      LShop.Free;
      Continue;
    end;
    if Assigned(AOnUpdate) then
      AOnUpdate(I, High(LShops));
  end;
end;

end.
