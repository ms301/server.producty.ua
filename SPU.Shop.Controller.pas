unit SPU.Shop.Controller;

interface

uses
  SPU.Shop.Model,
  mormot.rest.sqlite3;

type
  IspuShopController = interface
    ['{1C4D0E4C-F6D1-4401-B16F-B7502E42385E}']
    function GetCount: Integer;
    procedure Add(AShop: IspuShopModel);

  end;

  TspuShopController = class(TInterfacedObject, IspuShopController)
  private
    FDb: TRestClientDB;
  protected

  public
    constructor Create(AClientDb: TRestClientDB);
    function GetCount: Integer;
    procedure Add(AShop: IspuShopModel);

  end;

implementation

uses
  data;

{ TspuShopController }

procedure TspuShopController.Add(AShop: IspuShopModel);
begin

end;

constructor TspuShopController.Create(AClientDb: TRestClientDB);
begin
  FDb := AClientDb;
end;

function TspuShopController.GetCount: Integer;
begin
  Result := FDb.Orm.TableRowCount(TOrmShop);
end;

end.
