unit unit_klassy;

{$mode delphi}

interface

uses
  Classes, SysUtils;

type
  tFajlOtcqoqta = class
    fajl :textfile;
    procedure Tekst_v_fajl( stroka :string );
    constructor Start;
    destructor Final;
  end;

implementation

procedure tFajlOtcqoqta.Tekst_v_fajl( stroka :string );
begin
  writeln( fajl, stroka );
end;

constructor tFajlOtcqoqta.Start;
begin
  inherited Create;
  assignfile( fajl, 'udaleno.log' );
  rewrite( fajl );
  writeln( fajl, 'Начало удаления' );
end;

destructor tFajlOtcqoqta.Final;
begin
  writeln( fajl, 'Конец удаления' );
  closefile( fajl );
  inherited Destroy;
end;


end.

