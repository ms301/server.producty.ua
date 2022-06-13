program server.producty.ua;

uses
  System.StartUpCopy,
  FMX.Forms,
  Unit1 in 'Unit1.pas' {Form1},
  UI.Shops in 'UI.Shops.pas' {UiShops: TFrame},
  data in 'data.pas',
  SPU.AtbMarket.ShopController in 'SPU.AtbMarket.ShopController.pas',
  UI.Barcodes in 'UI.Barcodes.pas' {UiBarcodes: TFrame},
  SPU.AtbMarket.BarcodeController in 'SPU.AtbMarket.BarcodeController.pas',
  SPU.MainController in 'SPU.MainController.pas',
  SPU.AtbMarket.BarcodeScanerController in 'SPU.AtbMarket.BarcodeScanerController.pas',
  Unit2 in 'Unit2.pas' {Frame2: TFrame},
  SPU.Shop.Controller in 'SPU.Shop.Controller.pas',
  SPU.Shop.Model in 'SPU.Shop.Model.pas',
  SPU.Shop.Provider in 'SPU.Shop.Provider.pas',
  AtbMarket.Shop.Provider in 'AtbMarket.Shop.Provider.pas',
  AtbMarket.OrmTypes in 'AtbMarket.OrmTypes.pas',
  SPU.OrmTypes in 'SPU.OrmTypes.pas',
  AtbMarket.Shop.Model in 'AtbMarket.Shop.Model.pas',
  SPU.Register.Providers in 'SPU.Register.Providers.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
