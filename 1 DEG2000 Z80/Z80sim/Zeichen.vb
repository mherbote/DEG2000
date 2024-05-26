Imports System.Drawing


Public Class Zeichen
    Public Image As Bitmap = New Bitmap(10 * 30, 10 * 30, System.Drawing.Imaging.PixelFormat.Format32bppArgb)

    Public ImageNone As Bitmap = New Bitmap(10 * 30, 10 * 30, System.Drawing.Imaging.PixelFormat.Format32bppArgb)
    Public ImageNormal As Bitmap = New Bitmap(10 * 30, 10 * 30, System.Drawing.Imaging.PixelFormat.Format32bppArgb)
    Public ImageInvers As Bitmap = New Bitmap(10 * 30, 10 * 30, System.Drawing.Imaging.PixelFormat.Format32bppArgb)
    Public ImageFull As Bitmap = New Bitmap(10 * 30, 10 * 30, System.Drawing.Imaging.PixelFormat.Format32bppArgb)

    ' Lokale Eigenschaften

#Region "Pixel Größe und Zeichencode"
    Private _pixelX As UInteger
    Property PixelX() As UInteger
        Get
            Return _pixelX
        End Get
        Set(value As UInteger)
            _pixelX = value
        End Set
    End Property
    Private _pixelY As UInteger
    Public Property PixelY() As UInteger
        Get
            Return _pixelY
        End Get
        Set(ByVal value As UInteger)
            _pixelY = value
        End Set
    End Property

    Private _zeichenCode As Byte
    Public Property ZeichenCode() As Byte
        Get
            Return _zeichenCode
        End Get
        Set(ByVal value As Byte)
            _zeichenCode = value
        End Set
    End Property
#End Region

#Region "Zeichen Größe"
    Private _zeichenX As UInteger
    Public Property ZeichenX() As UInteger
        Get
            Return _zeichenX
        End Get
        Set(ByVal value As UInteger)
            _zeichenX = value
        End Set
    End Property
    Private _zeichenY As UInteger
    Public Property ZeichenY() As UInteger
        Get
            Return _zeichenY
        End Get
        Set(ByVal value As UInteger)
            _zeichenY = value
        End Set
    End Property
#End Region

#Region "Zeichen Color''s"
    Private _colorBack As Color
    Public Property ZeichenColorBack() As Color
        Get
            Return _colorBack
        End Get
        Set(ByVal value As Color)
            _colorBack = value
        End Set
    End Property
    Private _colorFore As Color
    Public Property ZeichenColorFore() As Color
        Get
            Return _colorFore
        End Get
        Set(ByVal value As Color)
            _colorFore = value
        End Set
    End Property
    Private _colorCursor As Color
    Public Property ZeichenColorCursor() As Color
        Get
            Return _colorCursor
        End Get
        Set(ByVal value As Color)
            _colorCursor = value
        End Set
    End Property
#End Region

    'Public Sub Init()
    '    'Image = New Bitmap(PixelX * ZeichenX, PixelY * ZeichenY, System.Drawing.Imaging.PixelFormat.Format32bppArgb)
    'End Sub

    Public Sub SetZeichen(Z As Zeichen, Code As Byte, ZeichenTemplate As Boolean(,,))
        Dim pX1, pX2, pY1, pY2 As UInteger
        Dim x, y As UInteger
        x = 0
        y = 0

        Try
            For pY1 = 0 To PixelY * ZeichenY - PixelY Step PixelY
                y = pY1 / PixelY
                For pX1 = 0 To PixelX * ZeichenX - PixelX Step PixelX
                    x = pX1 / PixelX
                    'Debug.WriteLine("pX1=" + Format(pX1) + ",pY1=" + Format(pY1) + "  x=" + Format(x) + ",y=" + Format(y))
                    Z.ZeichenCode = Code
                    If (ZeichenTemplate(Code, y, x)) Then
                        For pX2 = 0 To PixelX - 1
                            For pY2 = 0 To PixelY - 1
                                Image.SetPixel(pX1 + pX2, pY1 + pY2, ZeichenColorFore)
                                ImageNone.SetPixel(pX1 + pX2, pY1 + pY2, ZeichenColorFore)

                                ImageNormal.SetPixel(pX1 + pX2, pY1 + pY2, ZeichenColorFore)
                                ImageInvers.SetPixel(pX1 + pX2, pY1 + pY2, ZeichenColorBack)
                                ImageFull.SetPixel(pX1 + pX2, pY1 + pY2, ZeichenColorCursor)
                                'Debug.Write("pX1=" + Format(pX1) + ",pY1=" + Format(pY1) + "  x=" + Format(x) + ",y=" + Format(y))
                                'Debug.WriteLine("   1 X=" + Format(pX1 + pX2) + ",Y=" + Format(pY1 + pY2) + " " + ZeichenColorFore.ToString + " " + Format(ZeichenTemplate(y, x)))
                            Next pY2
                        Next pX2
                    Else
                        For pX2 = 0 To PixelX - 1
                            For pY2 = 0 To PixelY - 1
                                Image.SetPixel(pX1 + pX2, pY1 + pY2, ZeichenColorBack)
                                ImageNone.SetPixel(pX1 + pX2, pY1 + pY2, ZeichenColorBack)

                                ImageNormal.SetPixel(pX1 + pX2, pY1 + pY2, ZeichenColorBack)
                                ImageInvers.SetPixel(pX1 + pX2, pY1 + pY2, ZeichenColorFore)
                                ImageFull.SetPixel(pX1 + pX2, pY1 + pY2, ZeichenColorCursor)
                                'Debug.Write("pX1=" + Format(pX1) + ",pY1=" + Format(pY1) + "  x=" + Format(x) + ",y=" + Format(y))
                                'Debug.WriteLine("   1 X=" + Format(pX1 + pX2) + ",Y=" + Format(pY1 + pY2) + " " + ZeichenColorBack.ToString + " " + Format(ZeichenTemplate(y, x)))
                            Next pY2
                        Next pX2
                    End If
                Next pX1
            Next pY1
            For pY1 = PixelY * ZeichenY - 4 * PixelY To PixelY * ZeichenY - 3 * PixelY Step PixelY
                For pX1 = 0 To PixelX * ZeichenX - PixelX Step PixelX
                    For pX2 = 0 To PixelX - 1
                        For pY2 = 0 To PixelY - 1
                            ImageNormal.SetPixel(pX1 + pX2, pY1 + pY2, ZeichenColorCursor)
                        Next pY2
                    Next pX2
                Next pX1
            Next pY1
        Catch ex As Exception
            Debug.Print(ex.Message)
        End Try
    End Sub


End Class
