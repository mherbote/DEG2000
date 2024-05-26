Imports System.Drawing
Imports System.IO

Public Class BWS

    Public Enum eCursorTyp
        None
        Normal
        Invers
        Full
    End Enum

#Region "Local variables"
    Private Const FontdateiName As String = "D:\devel\1 DEG2000\FONT\7024-1.FNT"

    Private ReadOnly cBack As Color = System.Drawing.Color.Blue
    Private ReadOnly cFore As Color = System.Drawing.Color.Yellow
    Private ReadOnly cCursor As Color = System.Drawing.Color.Red

    'Pixel
    Private Const cPIx As UInteger = 2
    Private Const cPIy As UInteger = 2
    Private PIx As UInteger
    Private PIy As UInteger

    'Zeichen
    Private Const cZx As UInteger = 7
    Private Const cZy As UInteger = 16
    Private Zx As UInteger
    Private Zy As UInteger

    'Bildschirm
    Private Const cCursorTime As Integer = 100
    Private Const cBWSx As UInteger = 80
    Private Const cBWSy As UInteger = 25
    Private BWSx As UInteger
    Private BWSy As UInteger

    Private testbildWahl As UInt16

    'Dictionary's
    Private ZeichenDict As Dictionary(Of UInteger, Zeichen) = New Dictionary(Of UInteger, Zeichen)
    Private PictureBoxDict As Dictionary(Of UInteger, PictureBox) = New Dictionary(Of UInteger, PictureBox)

    Private Font1 As Font = New Font()
#End Region

    Public Sub New()
        InitializeComponent()

        ' Add any initialization after the InitializeComponent() call.
        PIx = cPIx
        PIy = cPIy
        Zx = cZx
        Zy = cZy
        BWSx = cBWSx
        BWSy = cBWSy
    End Sub

    Private Sub BWS_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        If Not Font1.LoadBwsFont(FontdateiName) Then
            End
        End If
        Zx = Font1.PixelanzX
        Zy = Font1.PixelanzY
        Font1.BwsFont2zeichenTemplate()

        Call BWS_Create()

        Call BWS_Zeichen(10, 10, &H21, System.Drawing.Color.DarkBlue, System.Drawing.Color.Yellow, System.Drawing.Color.DarkRed)
        Call BWS_Zeichen(12, 10)
        Call BWS_Zeichen(11, 11, &H41, System.Drawing.Color.Yellow, System.Drawing.Color.Red, System.Drawing.Color.Red)
        Call BWS_Zeichen(13, 13, &H81, System.Drawing.Color.Red, System.Drawing.Color.Green, System.Drawing.Color.Red)

        testbildWahl = 0
    End Sub

#Region "BWS Create"
    Private Sub BWS_Create()
        Dim x, y As UInteger
        Dim PB As PictureBox
        Dim Zeichen1 As Zeichen

        Try
            For y = 0 To BWSy - 1
                For x = 0 To BWSx - 1
                    PB = New PictureBox With
                        {
                            .Location = New System.Drawing.Point(x * Zx * PIx, y * Zy * PIy),
                            .Size = New System.Drawing.Size(PIx * Zx, PIy * Zy),
                            .BorderStyle = BorderStyle.None
                        }
                    Me.Controls.Add(PB)
                    PictureBoxDict.Add(y * BWSx + x, PB)

                    Zeichen1 = New Zeichen With
                        {
                            .PixelX = PIx,
                            .PixelY = PIy,
                            .ZeichenX = Zx,
                            .ZeichenY = Zy,
                            .ZeichenColorBack = cBack,
                            .ZeichenColorFore = cFore
                        }
                    ZeichenDict.Add(y * BWSx + x, Zeichen1)
                Next x
            Next y

            For y = 0 To BWSy - 1
                For x = 0 To BWSx - 1
                    Zeichen1 = ZeichenDict(y * BWSx + x)
                    PB = PictureBoxDict(y * BWSx + x)
                    Zeichen1.Init()
                    Zeichen1.SetZeichen(Zeichen1, Asc(" "), Font1.zeichenTemplateNormal)
                    PB.Image = Zeichen1.Image
                    PB.Refresh()
                Next x
            Next y

            Me.Height = PIy * Zy * BWSy + 39
            Me.Width = PIx * Zx * BWSx + 2 + 14
        Catch ex As Exception
            '            Debug.Print(ex.Message)
        End Try
    End Sub
#End Region

#Region "Zeichen auf BWS setzen"
    Private Sub BWS_Zeichen(X As UInteger, Y As UInteger,
                            CharCode As Byte,
                            BColor As Color, FColor As Color, CColor As Color)                                          ' Zeichen
        Dim PB As PictureBox
        Dim Zeichen1 As Zeichen

        Zeichen1 = ZeichenDict(Y * BWSx + X)
        PB = PictureBoxDict(Y * BWSx + X)
        Zeichen1.Init()

        Zeichen1.ZeichenColorBack = BColor
        Zeichen1.ZeichenColorFore = FColor
        Zeichen1.ZeichenColorCursor = CColor
        Zeichen1.SetZeichen(Zeichen1, CharCode, Font1.zeichenTemplateNormal)
        PB.Image = Zeichen1.Image
        PB.Refresh()
    End Sub
    Private Sub BWS_Zeichen(X As UInteger, Y As UInteger, CharCode As Byte)                                             ' Zeichen mit Standardfarben
        Dim PB As PictureBox
        Dim Zeichen1 As Zeichen

        Zeichen1 = ZeichenDict(Y * BWSx + X)
        PB = PictureBoxDict(Y * BWSx + X)
        Zeichen1.Init()

        Zeichen1.ZeichenColorBack = cBack
        Zeichen1.ZeichenColorFore = cFore
        Zeichen1.ZeichenColorCursor = cCursor
        Zeichen1.SetZeichen(Zeichen1, CharCode, Font1.zeichenTemplateNormal)
        PB.Image = Zeichen1.Image
        PB.Refresh()
    End Sub
    Private Sub BWS_Zeichen(X As UInteger, Y As UInteger)                                                               ' Leerzeichen mit Standardfarben
        Dim PB As PictureBox
        Dim Zeichen1 As Zeichen

        Zeichen1 = ZeichenDict(Y * BWSx + X)
        PB = PictureBoxDict(Y * BWSx + X)
        Zeichen1.Init()

        Zeichen1.ZeichenColorBack = cBack
        Zeichen1.ZeichenColorFore = cFore
        Zeichen1.ZeichenColorCursor = cCursor
        Zeichen1.SetZeichen(Zeichen1, &H20, Font1.zeichenTemplateNormal)
        PB.Image = Zeichen1.Image
        PB.Refresh()
    End Sub
#End Region

#Region "Testbilder"
    Private Function TestBild(Optional ByVal bildwahl As Int16 = -1) As Int16
        Dim test As String
        Dim _pZ, _pX1, _pY1 As Integer

        '        Blinken = False
        Select Case bildwahl
            Case 1
                Call SetCursor(10, 10, eCursorTyp.Normal)
                Call SetCursor(11, 11, eCursorTyp.Full)
                Call SetCursor(13, 13, eCursorTyp.Invers)
                TestBild = bildwahl
            Case 2
                Call ResetCursor(10, 10)
                Call ResetCursor(11, 11)
                Call ResetCursor(13, 13)
                TestBild = bildwahl
            Case 3
                ' Test Charset
                _pZ = &H0
                For _pY1 = 0 To BWSy - 1
                    For _pX1 = 0 To BWSx - 1
                        Call BWS_Zeichen(_pX1, _pY1, _pZ, System.Drawing.Color.Cornsilk, System.Drawing.Color.Black, System.Drawing.Color.Red)
                        'Debug.Print(Chr(pZ) + " X=" + Format(pX1) + " Y=" + Format(pY1))
                        _pZ = _pZ + 1
                        If _pZ = 255 Then _pZ = &H0
                    Next _pX1
                Next _pY1
                TestBild = bildwahl
            Case 4
                ' Test mit String "1234-6789+
                test = "----+----"
                For _pY1 = 0 To BWSy - 1
                    For _pX1 = 0 To BWSx - 1 Step 10
                        For _pZ = 0 To 8
                            Call BWS_Zeichen(_pX1 + _pZ, _pY1, Asc(Mid(test, _pZ + 1, 1)), System.Drawing.Color.Beige, System.Drawing.Color.Black, System.Drawing.Color.Red)
                        Next _pZ
                        Call BWS_Zeichen(_pX1 + _pZ, _pY1, &H30 + (_pX1 + 9) / 10, System.Drawing.Color.Beige, System.Drawing.Color.Black, System.Drawing.Color.Red)
                    Next _pX1
                Next _pY1
                TestBild = bildwahl
            Case 5
                For _pY1 = 0 To BWSy - 1
                    For _pX1 = 0 To BWSx - 1
                        Call BWS_Zeichen(_pX1, _pY1, Asc(" "), System.Drawing.Color.DarkBlue, System.Drawing.Color.Yellow, System.Drawing.Color.Red)
                    Next _pX1
                Next _pY1
                TestBild = bildwahl
            Case 6
                Call TestBild1(1, "Z80-Emulator als Basisemulator")
                Call TestBild1(2, "Copyright (C) 1987-2008 by Udo Munk")
                Call TestBild1(3, "Release 1.17")
                Call TestBild2(7, "DEG2000-System Emulator")
                Call TestBild3(9, "Release 0.01")
                Call TestBild3(11, "Version fuer MiniTAP mit TRAM, neue Tastatur/ATS")
                Call TestBild3(13, "Copyright (C) 1996-2021 by Marcus Herbote")
                Call TestBild1(17, "D E G 2 0 0 0   Software")
                Call TestBild1(18, "Copyright (C) 1981-1982 by IfR             Berlin/GDR")
                Call TestBild1(19, "Copyright (C) 1983-1985 by K EAW           Berlin/GDR")
                Call TestBild1(20, "Copyright (C) 1986-1990 by WMK ""7.Oktober"" Berlin/GDR")
                TestBild = bildwahl
        End Select
        'Me.blinken = False
    End Function ' TestBild
    Private Sub TestBild1(Y As Integer, Zeichen As String)                                                                                          ' Zeile 2,3,4,19,20,21
        Dim _pZ, _pX1 As Integer

        For _pX1 = 1 To Len(Zeichen)
            _pZ = Asc(Mid(Zeichen, _pX1, 1))
            Select Case _pZ
                Case &H20
                    Call BWS_Zeichen(_pX1 + 20, Y, _pZ, System.Drawing.Color.DarkBlue, System.Drawing.Color.Yellow, System.Drawing.Color.Red)       '&H1E
                Case Else
                    Call BWS_Zeichen(_pX1 + 20, Y, _pZ, System.Drawing.Color.DarkBlue, System.Drawing.Color.LightGray, System.Drawing.Color.Red)    '&H17
            End Select
        Next _pX1
    End Sub
    Private Sub TestBild2(Y As Integer, Zeichen As String)                                                                                          ' Zeile 8
        Dim _pZ, _pX1 As Integer

        For _pX1 = 1 To Len(Zeichen)
            _pZ = Asc(Mid(Zeichen, _pX1, 1))
            Call BWS_Zeichen(_pX1 + 20, Y, _pZ, System.Drawing.Color.DarkBlue, System.Drawing.Color.Red, System.Drawing.Color.Red)                  '&H1C
        Next _pX1
    End Sub
    Private Sub TestBild3(Y As Integer, Zeichen As String)                                                                                          ' Zeile 10,12,14
        Dim _pZ, _pX1 As Integer

        For _pX1 = 1 To Len(Zeichen)
            _pZ = Asc(Mid(Zeichen, _pX1, 1))
            Call BWS_Zeichen(_pX1 + 20, Y, _pZ, System.Drawing.Color.DarkBlue, System.Drawing.Color.Yellow, System.Drawing.Color.Red)               '&H1E
        Next _pX1
    End Sub
#End Region


    Private Sub BWS_Click(sender As Object, e As EventArgs) Handles MyBase.Click
        testbildWahl = TestBild(testbildWahl + 1)
    End Sub

#Region "Cursor"
    Private Sub tCursor_Tick(sender As Object, e As EventArgs) Handles tCursor.Tick
        Dim PB As PictureBox
        Dim Zeichen1 As Zeichen
        '        Dim IScursor As Boolean
        Dim _X, _Y As Integer

        For _Y = 0 To BWSy - 1
            For _X = 1 To BWSx - 1
                Zeichen1 = ZeichenDict(_Y * BWSx + _X)
                PB = PictureBoxDict(_Y * BWSx + _X)
                Zeichen1.Init()
                Zeichen1.Image = PB.Image

                Call ChangeImage(Zeichen1)
                PB.Image = Zeichen1.Image
                PB.Refresh()
            Next
        Next
    End Sub
    Public Sub SetCursor(X As Integer, Y As Integer, CursorTyp As eCursorTyp)
        Dim Zeichen1 As Zeichen

        Zeichen1 = ZeichenDict(Y * BWSx + X)

        Zeichen1.IsCursor = True
        Zeichen1.CursorTyp = CursorTyp
        Zeichen1.CursorStatus = eCursorTyp.None

        tCursor.Enabled = True
        tCursor.Interval = cCursorTime
    End Sub
    Private Sub ChangeImage(ByRef Zeichen1 As Zeichen)
        If Zeichen1.IsCursor Then
            Select Case Zeichen1.CursorTyp
                Case eCursorTyp.Normal
                    Select Case Zeichen1.CursorStatus
                        Case eCursorTyp.None
                            Zeichen1.Image = Zeichen1.ImageNormal
                            Zeichen1.CursorStatus = eCursorTyp.Normal
                            Zeichen1.IsCursorActiv = True
                        Case Else
                            Zeichen1.Image = Zeichen1.ImageNone
                            Zeichen1.CursorStatus = eCursorTyp.None
                            Zeichen1.IsCursorActiv = False
                    End Select
                Case eCursorTyp.Invers
                    Select Case Zeichen1.CursorStatus
                        Case eCursorTyp.None
                            Zeichen1.Image = Zeichen1.ImageInvers
                            Zeichen1.CursorStatus = eCursorTyp.Invers
                            Zeichen1.IsCursorActiv = True
                        Case Else
                            Zeichen1.Image = Zeichen1.ImageNone
                            Zeichen1.CursorStatus = eCursorTyp.None
                            Zeichen1.IsCursorActiv = False
                    End Select
                Case eCursorTyp.Full
                    Select Case Zeichen1.CursorStatus
                        Case eCursorTyp.None
                            Zeichen1.Image = Zeichen1.ImageFull
                            Zeichen1.CursorStatus = eCursorTyp.Full
                            Zeichen1.IsCursorActiv = True
                        Case Else
                            Zeichen1.Image = Zeichen1.ImageNone
                            Zeichen1.CursorStatus = eCursorTyp.None
                            Zeichen1.IsCursorActiv = False
                    End Select
            End Select
        Else
            Zeichen1.Image = Zeichen1.ImageNone
            Zeichen1.CursorStatus = eCursorTyp.None
            Zeichen1.IsCursorActiv = False
        End If
    End Sub
    Public Sub ResetCursor(X As Integer, Y As Integer)
        Dim PB As PictureBox
        Dim Zeichen1 As Zeichen
        Dim _x, _y As Integer
        Dim test As Boolean

        Zeichen1 = ZeichenDict(Y * BWSx + X)
        PB = PictureBoxDict(Y * BWSx + X)
        Zeichen1.IsCursor = False

        If Zeichen1.IsCursorActiv Then
            Call ChangeImage(Zeichen1)
        End If
        PB.Image = Zeichen1.Image
        PB.Refresh()

        test = False
        For _y = 0 To BWSy - 1
            For _x = 0 To BWSx - 1
                Zeichen1 = ZeichenDict(_y * BWSx + _x)
                If Zeichen1.IsCursor Then
                    test = True
                End If
            Next _x
        Next _y

        If Not test Then
            tCursor.Enabled = False
            PB.Refresh()
        End If
    End Sub
#End Region

End Class
