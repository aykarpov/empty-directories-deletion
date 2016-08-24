unit unit_klassy;

{$mode delphi}

interface

uses
  Classes, SysUtils;

type
  tFajlOtcqoqta = class
    fajl :textfile;
    rabotaet :boolean;
    procedure Tekst_v_fajl( stroka :string );
    constructor Start;
    destructor Final;
  end;

implementation

procedure tFajlOtcqoqta.Tekst_v_fajl( stroka :string );
begin
  if rabotaet = true then
  begin
    writeln( fajl, stroka );
  end;
end;

constructor tFajlOtcqoqta.Start;
begin
  inherited Create;

  rabotaet := true;

  if rabotaet = true then
  begin
    assignfile( fajl, 'udaleno.log' );
    rewrite( fajl );
    writeln( fajl, 'Начало удаления' );
  end;
end;

destructor tFajlOtcqoqta.Final;
begin
  rabotaet := true;

  if rabotaet = true then
  begin
    writeln( fajl, 'Конец удаления' );
    closefile( fajl );
  end;
  inherited Destroy;
end;


end.

