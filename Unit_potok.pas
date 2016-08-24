unit Unit_potok;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, unit_konstanty;

type
  TPotok = class(TThread)
    memo :TMemo;  //memo, в которое будет выводиться имя текущего каталога
    flag :Boolean;
    i    :longint;

  private
    { Private declarations }
    procedure Memo_Soobhqenie_o_zapuske;
    procedure Memo_Soobhqenie_ob_ostanovke;

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


procedure TPotok.Execute;
begin
  { Place thread code here }
  Synchronize(Memo_Soobhqenie_o_zapuske);




    if terminated = True then
    begin
      Synchronize(Memo_Soobhqenie_ob_ostanovke);
      //Break; //использовать только в цикле
      exit;
    end;

end;





end.
