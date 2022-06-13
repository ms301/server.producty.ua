unit SPU.Shop.Provider;

interface

uses
  System.Generics.Collections,
  SPU.Shop.Model,
  System.SysUtils;

type
  IspuShopProvider = interface
    ['{1E44DDB9-8D77-4308-B897-0620DE96227C}']
    function GetName: string;
    function Count: Integer;
    function GetShopByIndex(const AIndex: Integer): IspuShopModel;
    procedure UpdateFromServer(AOnUpdate: TProc<Integer, Integer>);
  end;

  TspuShopProviderController = class
  private
    FShopProviders: TDictionary<string, IspuShopProvider>;
  public
    procedure Add(AShopProvider: IspuShopProvider);
    procedure Find(const AName: string; var AShopProvider: IspuShopProvider);
    function Count: Integer;
    constructor Create;
    destructor Destroy; override;
    function ShopProviders: TArray<string>;
    function Shops: TArray<IspuShopProvider>;
  end;

implementation

uses
  SPU.OrmTypes;

{ TspuShopProvider }

procedure TspuShopProviderController.Add(AShopProvider: IspuShopProvider);
begin
  FShopProviders.Add(AShopProvider.GetName, AShopProvider);
end;

function TspuShopProviderController.Count: Integer;
begin
  Result := FShopProviders.Count;
end;

constructor TspuShopProviderController.Create;
begin
  FShopProviders := TDictionary<string, IspuShopProvider>.Create;
end;

destructor TspuShopProviderController.Destroy;
begin
  FShopProviders.Free;
  inherited;
end;

procedure TspuShopProviderController.Find(const AName: string; var AShopProvider: IspuShopProvider);
begin
  if not FShopProviders.TryGetValue(AName, AShopProvider) then
    AShopProvider := nil;
end;

function TspuShopProviderController.ShopProviders: TArray<string>;
begin
  Result := FShopProviders.Keys.ToArray;
end;

function TspuShopProviderController.Shops: TArray<IspuShopProvider>;
begin
  Result := FShopProviders.Values.ToArray;
end;

end.
