unit unit_procedury;


{$mode delphi}


interface




uses
    Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, FileUtil, unit_konstanty;

procedure Podgotovka_Memo( var Memo:Tmemo );



implementation

procedure Podgotovka_Memo( var Memo:Tmemo );
//любые действия с Memo
begin
  memo.Clear;
  memo.Lines.Add(Memo_Zacqem_ono_nugqno);
end;



end.

