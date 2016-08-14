unit unit_procedury;


{$mode delphi}


interface




uses
    Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, FileUtil, unit_konstanty;

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


procedure Udalenie( memo :TMemo );
//запуск удаления
var
  stroka :string;
begin
  stroka := GetCurrentDirUTF8;
  Memo.Clear;
  KatalogPust( stroka+'\*.*', Memo );
end;

end.

