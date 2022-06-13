unit Unit1;

interface

uses
  ViewNavigator,
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Graphics,
  FMX.Dialogs,
  FMX.ListBox,
  FMX.Layouts;

type
  TForm1 = class(TForm)
    ListBox1: TListBox;
    ListBoxItem1: TListBoxItem;
    Layout1: TLayout;
    ListBoxItem2: TListBoxItem;
    procedure FormCreate(Sender: TObject);
    procedure ListBoxItem1Click(Sender: TObject);
    procedure ListBoxItem2Click(Sender: TObject);
  private
    { Private declarations }
    FViews: TViewNavigator;
  public
    { Public declarations }
    procedure RegisterViews(AViews: TArray<TvnControlClass>);
  end;

var
  Form1: TForm1;

implementation

uses
  UI.Shops,
  UI.Barcodes;
{$R *.fmx}

procedure TForm1.FormCreate(Sender: TObject);
begin
  FViews := TViewNavigator.Create;
  FViews.Parent := Layout1;
  RegisterViews([TUiShops, TUiBarcodes]);
  FViews.Navigate('ViewShops')
end;

procedure TForm1.ListBoxItem1Click(Sender: TObject);
begin
  FViews.Navigate('ViewShops');
end;

procedure TForm1.ListBoxItem2Click(Sender: TObject);
begin
  FViews.Navigate('ViewBarcodes');
end;

procedure TForm1.RegisterViews(AViews: TArray<TvnControlClass>);
var
  i: Integer;
begin
  for i := Low(AViews) to High(AViews) do
    FViews.Store.AddView(AViews[i]);
end;

end.
