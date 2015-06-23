unit DN.Graphics;

interface

uses
  Types,
  System.UITypes,
  Graphics,
  Windows,
  Math;

procedure GradientFillRectVertical(ACanvas: TCanvas; const AStartColor, AEndColor: TColor; const ARect: TRect); inline;
function RGBToColor(const R, G, B: Byte): TColor; inline;
function AlterColor(const AColor: TColor; const AAmount: SmallInt): TColor; inline;

implementation

procedure GradientFillRectVertical(ACanvas: TCanvas; const AStartColor, AEndColor: TColor; const ARect: TRect);
var
  LVertices: array[0..1] of TTriVertex;
  LMeshes: array[0..0] of GRADIENT_RECT;
begin
  LVertices[0].x := ARect.Left;
  LVertices[0].y := ARect.Top;
  LVertices[0].Red := TColors(AStartColor).R shl 8;
  LVertices[0].Green := TColors(AStartColor).G shl 8;
  LVertices[0].Blue := TColors(AStartColor).B shl 8;
  LVertices[0].Alpha := 255 shl 8;

  LVertices[1].x := ARect.Right;
  LVertices[1].y := ARect.Bottom;
  LVertices[1].Red := TColors(AEndColor).R shl 8;
  LVertices[1].Green := TColors(AEndColor).G shl 8;
  LVertices[1].Blue := TColors(AEndColor).B shl 8;
  LVertices[1].Alpha := 255 shl 8;

  LMeshes[0].UpperLeft := 0;
  LMeshes[0].LowerRight := 1;

  GradientFill(ACanvas.Handle, @LVertices[0], Length(LVertices), @LMeshes[0], Length(LMeshes), GRADIENT_FILL_RECT_V);
end;

function RGBToColor(const R, G, B: Byte): TColor; inline;
begin
  TColors(Result).R := R;
  TColors(Result).G := G;
  TColors(Result).B := B;
end;

function AlterColor(const AColor: TColor; const AAmount: SmallInt): TColor; inline;
begin
  Result := RGBToColor(
    Max(GetRValue(AColor) + AAmount, 0),
    Max(GetGValue(AColor) + AAmount, 0),
    Max(GetBValue(AColor) + AAmount, 0));
end;

end.