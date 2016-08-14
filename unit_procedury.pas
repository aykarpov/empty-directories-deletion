unit unit_procedury;


{$mode delphi}


interface




uses
    Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,
    //FileUtil, (* компилятор требует использовать модуль LazFileUtils *)
    LazFileUtils,
    unit_konstanty;

procedure Podgotovka_Memo( var Memo:Tmemo );
function KatalogPust( putw:TFileName; memo :TMemo ): Integer;
procedure Udalenie( memo :TMemo );




implementation

procedure Podgotovka_Memo( var Memo:Tmemo );
//любые действия с Memo
begin
  memo.Clear;
  memo.Lines.Add(Memo_Zacqem_ono_nugqno);
end;


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

procedure Esli_Najden_Fajl( sr: TSearchRec; var fajlov_vsego:integer );
//если найден файл, считаем, сколько их
//в принципе, их число не важно, важен факт их наличия,
//т.е. можно просто ставить флаг
begin
  if (sr.Attr and faDirectory) = 0 then
  begin
    inc( fajlov_vsego );
  end;
end;

procedure Esli_Najden_Katalog( sr: TSearchRec; var fajlov_vsego, fajlov_vnizu:integer; putw2: TFileName; memo:TMemo );
//если это каталог, то...
begin
  if (sr.Attr and faDirectory) <> 0 then
  begin
    //сообщим, что это каталог
    memo.Lines.Add( putw2+sr.Name + Memo_Najden_katalog );

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


function KatalogPust( putw:TFileName; memo :TMemo ): Integer;
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

    //FindNext возвращает 0, когда файды есть, и код ошибки, когда все перебраны
    poisk_okoncqen := FindNextUTF8(sr );
  end;

  //поиск полагается закрыть!
  FindCloseUTF8(sr );

  Result := fajlov_vsego;
end;


procedure Udalenie( memo :TMemo );
//запуск удаления
var
  stroka :string;
begin
  Memo.Clear;

  stroka := GetCurrentDirUTF8;
  KatalogPust( stroka+'\*.*', Memo );
end;

end.

