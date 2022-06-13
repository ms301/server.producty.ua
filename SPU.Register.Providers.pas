unit SPU.Register.Providers;

interface

uses
  SPU.MainController,
  SPU.Shop.Provider;

procedure RegisterProvider(AShopProvider: IspuShopProvider);

implementation

uses
  AtbMarket.Shop.Provider;

procedure RegisterProvider(AShopProvider: IspuShopProvider);
begin
  TMainController.Current.ShopProviders.Add(AShopProvider);
end;

initialization

RegisterProvider(TAtbMarketShopProvider.Create(TMainController.Current.DB));

end.
