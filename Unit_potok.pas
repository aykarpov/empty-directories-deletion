unit Unit_potok;

interface

uses

    LazFileUtils,

  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, unit_konstanty, unit_klassy;

type
  TPotok = class(TThread)
    memo :TMemo;  //memo, в которое будет выводиться имя текущего каталога
    flag :Boolean;
    i    :longint;
    tekuhqij_katalog :string; //переменная только для передачи значения в memo
    otcqoqt: tfajlotcqoqta;


  private
    { Private declarations }
    procedure Memo_Soobhqenie_o_zapuske;
    procedure Memo_Soobhqenie_ob_ostanovke;
    procedure Memo_Soobhqenie_o_tekuhqem_kataloge;
    function KatalogPust( putw:TFileName; memo :TMemo ): Integer;
    procedure Udalenie( memo :TMemo );
    procedure Esli_Najden_Fajl( sr: TSearchRec; var fajlov_vsego:integer );
    procedure Esli_Najden_Katalog( sr: TSearchRec; var fajlov_vsego, fajlov_vnizu:integer; putw2: TFileName; memo:TMemo );


  protected
    procedure Execute; override;
  end;





implementation

uses unit_procedury;


{ Important: Methods and properties of objects in visual components can only be
  used in a method called using Synchronize, for example,

      Synchronize(UpdateCaption);

  and UpdateCaption could look like,

    procedure TPotok.UpdateCaption;
    begin
      Form1.Caption := 'Updated in a thread';
    end; }

{ TPotok }


procedure TPotok.Memo_Soobhqenie_o_zapuske;
begin
   memo.Lines.Add( Memo_Potok_zapuhqen );
end; 


procedure TPotok.Memo_Soobhqenie_ob_ostanovke;
begin
   memo.Lines.Add( Memo_Potok_ostanovlen );
end;

procedure TPotok.Memo_Soobhqenie_o_tekuhqem_kataloge;
begin
  memo.Lines.Add( tekuhqij_katalog + Memo_Najden_katalog );
end;

procedure TPotok.Esli_Najden_Fajl( sr: TSearchRec; var fajlov_vsego:integer );
//если найден файл, считаем, сколько их
//в принципе, их число не важно, важен факт их наличия,
//т.е. можно просто ставить флаг
begin
  if (sr.Attr and faDirectory) = 0 then
  begin
    inc( fajlov_vsego );
  end;
end;


procedure TPotok.Esli_Najden_Katalog( sr: TSearchRec; var fajlov_vsego, fajlov_vnizu:integer; putw2: TFileName; memo:TMemo );
//если это каталог, то...
begin
  if (sr.Attr and faDirectory) <> 0 then
  begin
    //сообщим, что это каталог
    tekuhqij_katalog := putw2 + sr.Name;
    otcqoqt.Tekst_v_fajl(tekuhqij_katalog);
    Synchronize(Memo_Soobhqenie_o_tekuhqem_kataloge);

    //войдём в него, сотрём в нём всё, что можно, и посчитаем, сколько в нём файлов
    fajlov_vnizu := KatalogPust( putw2+sr.Name+'\*.*', memo );

    //если в нём нет файлов, сотрём его
    if fajlov_vnizu = 0 then
    begin
      RemoveDirUTF8(putw2+sr.Name+'\' );
    end;

    fajlov_vsego := fajlov_vsego + fajlov_vnizu;
  end;

end;

procedure TPotok.Udalenie( memo :TMemo );
//запуск удаления
var
  stroka :string;
begin
  Memo.Clear;

  stroka := GetCurrentDirUTF8;
  KatalogPust( stroka+'\*.*', Memo );
end;



function TPotok.KatalogPust( putw:TFileName; memo :TMemo ): Integer;
var
  atribut :integer;
  sr: TSearchRec;
  poisk_okoncqen :Integer;
  fajlov_vsego, fajlov_vnizu :Integer;
  putw2: TFileName;
begin
  fajlov_vsego := 0;
  //удаляем из имени файла маску *.*
  putw2 := Copy( putw, 1, Length( putw )-3 );

  //обходим каталоги
  poisk_okoncqen := 0;

  atribut := faAnyFile;
  poisk_okoncqen := FindFirstUTF8(putw,atribut,sr ); { *Converted from FindFirst* }

  while poisk_okoncqen=0 do
  begin
    if (sr.Name <> '.') and (sr.Name <> '..') then
    begin
      Esli_Najden_Fajl( sr, fajlov_vsego );
      Esli_Najden_Katalog( sr, fajlov_vsego, fajlov_vnizu, putw2, memo );
    end;

    //FindNext возвращает 0, когда файлы есть, и код ошибки, когда все перебраны
    poisk_okoncqen := FindNextUTF8(sr );
  end;

  //поиск полагается закрыть!
  FindCloseUTF8(sr );

  Result := fajlov_vsego;
end;




procedure TPotok.Execute;
begin
  { Place thread code here }
  Synchronize(Memo_Soobhqenie_o_zapuske);

  otcqoqt := tfajlotcqoqta.Start;
  otcqoqt.rabotaet := true;

  //удалить пустые каталоги
  Udalenie( Memo );




    if terminated = True then
    begin
      Synchronize(Memo_Soobhqenie_ob_ostanovke);
      otcqoqt.Final;
      //Break; //использовать только в цикле
      exit;
    end;

end;





end.
