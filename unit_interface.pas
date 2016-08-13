unit unit_interface;

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

interface

uses
{$IFnDEF FPC}
  Windows,
{$ELSE}
  LCLIntf, LCLType, LMessages,
{$ENDIF}
  Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, FileUtil, unit_konstanty;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Memo1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

type
  tspisok_katalogov = array of string;
  tkniga = record
    avtor,nazvanie :string;
    najdena :Boolean;
  end;



var
  Form1: TForm1;

implementation

{$IFnDEF FPC}
  {$R *.dfm}
{$ELSE}
  {$R *.lfm}
{$ENDIF}

//Цель:
//войти в каталог
//если файл - считать
//если каталог - войти
//если каталог пуст - стереть
//передать число файлов вверх
//
//
//
//
//
//

function KatalogPust( putw:TFileName; memo :TMemo ): Integer;
var
  atribut :integer;
  poisk_bbs, sr: TSearchRec;
  poisk_okoncqen :Integer;
  fajlov_vsego, fajlov_vnizu :Integer;
  putw2: TFileName;
  bbs, teg_fajl,avtor,nazvanie :TextFile;
  i, probel :Integer;
  teg_katalog : string;
  nakl_cqerta :Integer;
  stroka, katalog :string;
  temp_kniga :tkniga;
  iskomye_fajly :Boolean;
begin
  fajlov_vsego := 0;
  //готовим вспомогательные имена файлов
  putw2 := Copy( putw, 1, Length( putw )-3 );

  //обходим каталоги
  poisk_okoncqen := 0;

  atribut := faAnyFile;
  poisk_okoncqen := FindFirstUTF8(putw,atribut,sr ); { *Converted from FindFirst* }

  while poisk_okoncqen=0 do
  begin
    if (sr.Name <> '.') and (sr.Name <> '..') then
    begin
      if (sr.Attr and faDirectory) = 0 then
      begin
        inc( fajlov_vsego );
      end;

      if (sr.Attr and faDirectory) <> 0 then
      begin
        memo.Lines.Add( putw2+sr.Name + ' - katalog' );

        //ObxodKatalogov( putw2+sr.Name+'\*.*', memo, tegi, temp_kniga );
        fajlov_vnizu := KatalogPust( putw2+sr.Name+'\*.*', memo );
        if fajlov_vnizu = 0 then
        begin
          RemoveDirUTF8(putw2+sr.Name+'\' ); { *Converted from RemoveDir* }
        end;
        fajlov_vsego := fajlov_vsego + fajlov_vnizu;
      end;
    end;

    //FindNext возвращает 0, когда файды есть, и код ошибки, когда все перебраны
    poisk_okoncqen := FindNextUTF8(sr ); { *Converted from FindNext* }
  end;
  FindCloseUTF8(sr ); { *Converted from FindClose* }

  Result := fajlov_vsego;
end;



procedure TForm1.Button1Click(Sender: TObject);
var
  atribut :Integer;
  sr: TSearchRec;
  stroka :string;
  spisok: tspisok_katalogov;
  kniga :tkniga;

begin
  stroka := GetCurrentDirUTF8; { *Converted from GetCurrentDir* }

  Memo1.Clear;
  KatalogPust( stroka+'\*.*', Memo1 );

  beep;
end;

procedure TForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  //отладочные сообщения - удалить!
  memo1.Clear;
  //memo1.Lines.Add( 'ВСЕ ПУСТЫЕ КАТАЛОГИ УДАЛЕНЫ' );
  //showmessage( 'Завершение работы' );
end;

procedure Podgotovka_Memo( var Memo:Tmemo );
//любые действия с Memo
begin
  memo.Clear;
  memo.Lines.Add(Cqto_vyvoditsaq_v_Memo);
end;


procedure TForm1.FormCreate(Sender: TObject);
begin
  Podgotovka_Memo( Memo1 );
end;

procedure TForm1.Memo1Change(Sender: TObject);
begin

end;


end.
