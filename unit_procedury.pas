unit unit_procedury;


{$mode delphi}


interface




uses
    Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,
    //FileUtil, (* компилятор требует использовать модуль LazFileUtils *)
    LazFileUtils,
    unit_konstanty, Unit_potok;

procedure Podgotovka_Memo( var Memo:Tmemo );
procedure Potok_Zapusk(var Cikl :TPotok; Memo:TMemo );
procedure Potok_Ostanovka(var Cikl :TPotok; Memo:TMemo );
procedure Potok_Udalenie(var Cikl :TPotok; Memo:TMemo );

var
  Cikl :TPotok;




implementation

procedure Podgotovka_Memo( var Memo:Tmemo );
//любые действия с Memo
begin
  memo.Clear;
  memo.Lines.Add(Memo_Zacqem_ono_nugqno);
end;

procedure Potok_Zapusk(var Cikl :TPotok; Memo:TMemo );
begin
  //создадим экземпляр класса
  Cikl := TPotok.Create( false );

  //приоритет
  Cikl.Priority := tpNormal;

  //в какой Memo будем писать
  cikl.memo := Memo;
  Cikl.flag := False;

  //if Cikl.Suspended then

  //запуск потока
  //Cikl.Resume;
end;


procedure Potok_Ostanovka(var Cikl :TPotok; Memo:TMemo );
//просто остановка, не удаление!!!
begin
  Cikl.Terminate;
end;

procedure Potok_Udalenie(var Cikl :TPotok; Memo:TMemo );
begin
  memo.Lines.Add( Memo_Konec_raboty );

  Cikl.Terminate;
  //cikl.Free; (*нельзя использовать - ошибка доступа*)
  Cikl.Destroy;
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
//в принципе, осталось только найти способ запустить удаление в отдельном потоке




end.

