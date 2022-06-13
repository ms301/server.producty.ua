unit SPU.Shop.Model;

interface

type
  IspuShopModel = interface
    ['{71030F92-07DF-4D01-BB5A-8E543525A2EF}']

    function GetShopID: Integer;
    function GetShopName: string;
    function GetCity: string;
  end;

  TspuStoreModel = class(TInterfacedObject, IspuShopModel)
  protected
    FShopName: string;
    FShopID: Integer;
    FCity: string;
  public
    constructor Create; virtual; abstract;
    function GetShopName: string;
    function GetShopID: Integer;
    function GetCity: string;
  end;

implementation

{ TspuStoreModel }

function TspuStoreModel.GetCity: string;
begin
  Result := FCity;
end;

function TspuStoreModel.GetShopID: Integer;
begin
  Result := FShopID;
end;

function TspuStoreModel.GetShopName: string;
begin
  Result := FShopName;
end;

end.
