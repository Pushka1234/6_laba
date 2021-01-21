unit Unit1;

interface

uses
Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
Vcl.Controls, Vcl.Forms, Vcl.Dialogs, VclTee.TeeGDIPlus, VCLTee.Series,
VCLTee.TeEngine, Vcl.StdCtrls, Vcl.ExtCtrls, VCLTee.TeeProcs, VCLTee.Chart;

type
TForm1 = class(TForm)
Button1: TButton;
Chart1: TChart;
Label1: TLabel;
Edit1: TEdit;
Edit2: TEdit;
    Series1: TPointSeries;
    Series2: TLineSeries;
    Series3: TLineSeries;
procedure Button1Click(Sender: TObject);
private
{ Private declarations }
public
{ Public declarations }
end;

var
Form1: TForm1;
x0,x0z,xk,x,x1,x2,U,h,hz,eps,Wk,Mc,K : Extended;
n : Byte;
y,yz,y0,y0z,f : array [1..5] of real;


implementation

{$R *.dfm}
procedure Uravnenie(x:real);
begin
if y[1]<=0 then K:=1 else K:=-1;
if (K*sqrt(abs(2*y[1]))-y[2])>=0 then U:=1 else U:=-1;
F[1]:= Y[2];
F[2]:= U;
end;

procedure Euler(x0:real);
var x: real;
i: Byte;
begin
Uravnenie(x0);
for i := 1 to N do y[i]:=Y0[i]+h*F[i];
end;

procedure TForm1.Button1Click(Sender: TObject);
var i,j: integer;

begin
N:=2;
x0:=0; x0z:=x0; xk:=25; h:=0.005; hz:=h;
eps:= 0.001;
Y0[2]:=StrToFloat(edit2.Text);
Y0[1]:=StrToFloat(Edit1.Text);
x:=x0;
while sqr(y0[1])+sqr(y0[2])>0.001 do begin
Euler(x0);

for i := 1 to N do Yz[i]:=Y[i];
h:=h/2;
Euler(x0);

for i := 1 to N do Y0[i]:=Y[i];
x0:=x0+h;

Euler(x0);

j:=0;
for i := 1 to N do if abs(Yz[i]-Y[i])<eps*abs(Yz[i]) then j:=j+1;
if j=N then
begin
x0:=x0+h; x0z:=x0;
for i := 1 to N do begin
y0[i]:=y[i]; y0z[i]:=y[i];
end;
h:=hz;

Chart1.Series[0].AddXY(y[1],y[2]);
chart1.Series[1].AddXY(0,Y0[2]); Chart1.Series[1].AddXY(0,-Y0[2]);
Chart1.Series[2].AddXY(-Y0[1],0); chart1.Series[2].AddXY(y0[1],0);
Chart1.Refresh;

end
else begin
x0:=x0z; x:=x0;
for i := 1 to N do y0[i]:=y0z[i];

end;
chart1.SaveToBitmapFile('Pict.bmp');
end;
end;
end.
