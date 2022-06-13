unit SPU.OrmTypes;

interface

uses
  mormot.orm.core, mormot.core.base;

type
  TOrmSpuShopProvider = class(TOrm)
  private
    FName: RawUtf8;
  published
    property Name: RawUtf8 read FName write FName;
  end;

implementation

end.
