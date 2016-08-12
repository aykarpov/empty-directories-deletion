unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
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

{$R *.dfm}

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
  poisk_okoncqen := FindFirst( putw, atribut, sr );

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
          RemoveDir( putw2+sr.Name+'\' );
        end;
        fajlov_vsego := fajlov_vsego + fajlov_vnizu;
      end;
    end;

    //FindNext возвращает 0, когда файды есть, и код ошибки, когда все перебраны
    poisk_okoncqen := FindNext( sr );
  end;
  FindClose( sr );

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
  stroka := GetCurrentDir;

  Memo1.Clear;
  KatalogPust( stroka+'\*.*', Memo1 );

  beep;
end;

end.
