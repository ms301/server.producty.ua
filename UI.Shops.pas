unit UI.Shops;

interface

uses
  AtbMarket.Client,
  AtbMarket.Types,
  System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  vn.Attributes, FMX.Controls.Presentation, System.Rtti, FMX.Grid.Style,
  FMX.ScrollBox, FMX.Grid,
  SPU.AtbMarket.ShopController, FMX.Layouts, FMX.ListBox;

type

  [vnName('ViewShops')]
  [vnLifeCycle(TvnLifeCycle.OnCreateDestroy)]
  TUiShops = class(TFrame)
    ToolBar1: TToolBar;
    Grid1: TGrid;
    StringColumn2: TStringColumn;
    StringColumn3: TStringColumn;
    StringColumn4: TStringColumn;
    Button1: TButton;
    StatusBar1: TStatusBar;
    Label1: TLabel;
    ProgressBar1: TProgressBar;
    StringColumn5: TStringColumn;
    Button2: TButton;
    ListBox1: TListBox;
    procedure Button1Click(Sender: TObject);
    procedure Grid1GetValue(Sender: TObject; const ACol, ARow: Integer; var Value: TValue);
    procedure ListBox1ItemClick(const Sender: TCustomListBox; const Item: TListBoxItem);
  private
    { Private declarations }
    FCurrentShopProvider: string;
    procedure UpdateCount;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    { Public declarations }

  end;

implementation

uses
  System.SysUtils,
  SPU.MainController,
  data, SPU.Shop.Provider;

{$R *.fmx}

constructor TUiShops.Create(AOwner: TComponent);
begin
  inherited;
  ListBox1.Items.AddStrings(TMainController.Current.ShopProviders.ShopProviders);
  UpdateCount;
end;

destructor TUiShops.Destroy;
begin
  inherited;
end;

procedure TUiShops.Button1Click(Sender: TObject);
var
  LShopProvider: IspuShopProvider;
begin
  TMainController.Current.ShopProviders.Find(FCurrentShopProvider, LShopProvider);

  LShopProvider.UpdateFromServer(
    procedure(ACurrent, ATotal: Integer)
    begin
      ProgressBar1.Max := ATotal;
      ProgressBar1.Value := ACurrent;
    end);
  UpdateCount;
end;

procedure TUiShops.Grid1GetValue(Sender: TObject; const ACol, ARow: Integer; var Value: TValue);
var
  LShopProvider: IspuShopProvider;
begin
  TMainController.Current.ShopProviders.Find(FCurrentShopProvider, LShopProvider);
  if LShopProvider = nil then
    exit;
  case ACol of
    0:
      Value := LShopProvider.GetShopByIndex(ARow).GetShopID;
    1:
      Value := LShopProvider.GetShopByIndex(ARow).GetCity;
  end;
end;

procedure TUiShops.ListBox1ItemClick(const Sender: TCustomListBox; const Item: TListBoxItem);
begin
  FCurrentShopProvider := Item.Text;
  UpdateCount;
end;

procedure TUiShops.UpdateCount;
var
  LShopProvider: IspuShopProvider;
begin
  TMainController.Current.ShopProviders.Find(FCurrentShopProvider, LShopProvider);
  if Assigned(LShopProvider) then
  begin
    Grid1.RowCount := LShopProvider.Count;
    Label1.Text := 'Count: ' + LShopProvider.Count.ToString;
  end;
end;

end.
