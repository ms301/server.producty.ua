unit UI.Barcodes;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  System.Rtti, FMX.Grid.Style, FMX.Controls.Presentation, FMX.ScrollBox,
  FMX.Grid, VN.Attributes,
  SPU.AtbMarket.BarcodeController;

type

  [vnName('ViewBarcodes')]
  [vnLifeCycle(TvnLifeCycle.OnCreateDestroy)]
  TUiBarcodes = class(TFrame)
    Grid1: TGrid;
    StringColumn1: TStringColumn;
    StringColumn2: TStringColumn;
    ToolBar1: TToolBar;
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Grid1GetValue(Sender: TObject; const ACol, ARow: Integer; var Value: TValue);
  private
    { Private declarations }
    FProducts: TBarcodeController;
    procedure UpdateCount;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

  end;

implementation

uses
  FMX.DialogService,
  SPU.MainController, data;

{$R *.fmx}
{ TUiProducts }

constructor TUiBarcodes.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FProducts := TBarcodeController.Create(TMainController.Current.DB);
  UpdateCount;
end;

destructor TUiBarcodes.Destroy;
begin
  FProducts.Free;

  inherited Destroy;
end;

procedure TUiBarcodes.UpdateCount;
begin
  Grid1.RowCount := FProducts.Count;
  // Label1.Text := 'Count: ' + FShopController.Count.ToString;
end;

procedure TUiBarcodes.Button1Click(Sender: TObject);
begin
  TDialogService.InputQuery('Час працювати ручками', ['Введіть barcode: '], ['8000070038769'],
    procedure(const AResult: TModalResult; const AValues: array of string)
    begin
      FProducts.AddBarcode(string.Join('', AValues));
      UpdateCount;
    end);
end;

procedure TUiBarcodes.Button2Click(Sender: TObject);
var
  LProd: TOrmBarcode;
begin
  LProd := FProducts.Row[Grid1.Selected];
  FProducts.Delete(LProd.Barcodes);
  LProd.Free;

end;

procedure TUiBarcodes.Grid1GetValue(Sender: TObject; const ACol, ARow: Integer; var Value: TValue);
var
  LProd: TOrmBarcode;
begin
  LProd := FProducts.Row[ARow];
  case ACol of
    0:
      Value := LProd.Name;
    1:
      Value := LProd.Barcodes;
  end;
  LProd.Free;
end;

end.
