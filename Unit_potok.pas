unit Unit_potok;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TPotok = class(TThread)
    memo :TMemo;
    //edit :TEdit;
    flag :Boolean;
    i    :longint;

  private
    { Private declarations }
    procedure UpdateMemo;

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


procedure TPotok.UpdateMemo;
begin
   memo.Lines.Add( IntToStr( i ) );
end; 


procedure TPotok.Execute;
begin
  { Place thread code here }



  i := 0;
  repeat
    if (i mod 365) = 0 then
    begin
      //memo.Lines.Add( IntToStr( i ) );
      Synchronize(UpdateMemo);
      //Suspend;
    end;

    if flag = True then
    begin
      //i := StrToInt( edit.Text );
      flag := False;
    end;


    if terminated = True then
    begin
      i:= -9999;
      //  Podgotovka_Memo( memo );
      Synchronize(UpdateMemo);
      Break;
    end;

    inc( i );
    Sleep( 1 );
  until i >= 10000000;
end;





end.
