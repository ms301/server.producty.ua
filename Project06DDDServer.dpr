program Project06DDDServer;

{$APPTYPE CONSOLE}

{$I mormot.defines.inc}
uses
  mormot.core.base,
  mormot.core.log,
  mormot.core.os,
  mormot.db.raw.sqlite3,
  mormot.orm.core,
  mormot.rest.http.server,
  data in 'data.pas',
  DomRepositoryInterfaces in 'DomRepositoryInterfaces.pas',
  DomServiceImplementation in 'DomServiceImplementation.pas',
  DomServiceInterfaces in 'DomServiceInterfaces.pas',
  DomTypes in 'DomTypes.pas',
  InfraRepositoryImplementation in 'InfraRepositoryImplementation.pas',
  server in 'server.pas';

var
  ServiceServer: TServiceServer;
  StoreRepository: IStoreRepository;
  HttpServer: TRestHttpServer;
  LogFamily: TSynLogFamily;
begin
  LogFamily := SQLite3Log.Family;
  LogFamily.Level := LOG_VERBOSE;
  LogFamily.PerThreadLog := ptIdentifiedInOnFile;
  LogFamily.EchoToConsole := LOG_VERBOSE;
  try
    StoreRepository := TStoreRepository.Create;
    try
      ServiceServer := TServiceServer.Create(StoreRepository);
      try
        HttpServer := TRestHttpServer.Create(HTTP_PORT, [ServiceServer], '+', HTTP_DEFAULT_MODE);
        HttpServer.AccessControlAllowOrigin := '*';
        try
          Writeln('Server started on port ' + HTTP_PORT);
          Readln;
        finally
          HttpServer.Free;
        end;
      finally
        ServiceServer.Free;
      end;
    finally
      StoreRepository := nil;
    end;
  finally
  end;
end.
