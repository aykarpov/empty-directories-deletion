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
  Dialogs, StdCtrls, FileUtil, unit_konstanty, unit_procedury, Unit_potok;

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


var
  Form1: TForm1;

implementation

{$IFnDEF FPC}
  {$R *.dfm}
{$ELSE}
  {$R *.lfm}
{$ENDIF}




procedure TForm1.Button1Click(Sender: TObject);
begin
  //отключить кнопку, чтобы не запустить дважды одновременно
  button1.Enabled:= false;

  //удалить пустые каталоги
  Udalenie( Memo1 );

  //разблокировать кнопку
  button1.Enabled:= true;

  //просигналить о завершении
  beep;
  //желательно помигать значком в панели задач или выдать всплывающую подсказку.
  //пока не знаю, как это сделать


  // Cikl.Terminate;

  // Cikl.Suspend;

end;

procedure TForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  //отладочные сообщения - удалить!
  memo1.Clear;
  //memo1.Lines.Add( 'ВСЕ ПУСТЫЕ КАТАЛОГИ УДАЛЕНЫ' );
  //showmessage( 'Завершение работы' );


  Cikl.Terminate;
  Cikl.Destroy;
end;




procedure TForm1.FormCreate(Sender: TObject);
begin
  Podgotovka_Memo( Memo1 );


  Cikl := TPotok.Create( true );

  Cikl.Priority := tpNormal;
  cikl.memo := Memo1;
  Cikl.flag := False;
  //if Cikl.Suspended then
  //begin
  //  ShowMessage( 'Potok stoit!' );
  //end;
  Cikl.Resume;



end;

procedure TForm1.Memo1Change(Sender: TObject);
begin

end;


end.
