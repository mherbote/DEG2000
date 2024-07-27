'TODO:      1. ResetCursor bei neuem BWS

Imports System.Drawing
Imports System.IO

Public Class BWS


#Region "Local variables"

#Region "Cursor"
    Public Enum eCursorTyp
        None
        Normal
        Invers
        Full
    End Enum

    Private _CursorX As Int16
    Public Property CursorX() As Int16
        Get
            Return _CursorX
        End Get
        Set(ByVal value As Int16)
            _CursorX = value
        End Set
    End Property
    Private _CursorY As Int16
    Public Property CursorY() As Int16
        Get
            Return _CursorY
        End Get
        Set(ByVal value As Int16)
            _CursorY = value
        End Set
    End Property

    Private _IsCursor As Boolean
    Public Property IsCursor() As Boolean
        Get
            Return _IsCursor
        End Get
        Set(ByVal value As Boolean)
            _IsCursor = value
        End Set
    End Property
    Private _IsCursorActiv As Boolean
    Public Property IsCursorActiv() As Boolean
        Get
            Return _IsCursorActiv
        End Get
        Set(ByVal value As Boolean)
            _IsCursorActiv = value
        End Set
    End Property
    Private _CursorTyp As BWS.eCursorTyp
    Public Property CursorTyp() As BWS.eCursorTyp
        Get
            Return _CursorTyp
        End Get
        Set(ByVal value As BWS.eCursorTyp)
            _CursorTyp = value
        End Set
    End Property
    Private _CursorStatus As BWS.eCursorTyp
    Public Property CursorStatus() As BWS.eCursorTyp
        Get
            Return _CursorStatus
        End Get
        Set(ByVal value As BWS.eCursorTyp)
            _CursorStatus = value
        End Set
    End Property
#End Region

#Region "Color Eigenschaften"
    Private ReadOnly cBack As Color = System.Drawing.Color.Blue
    Private ReadOnly cFore As Color = System.Drawing.Color.Yellow
    Private ReadOnly cCursor As Color = System.Drawing.Color.Red

    Private _BackColorBWS As Color
    Public Property BackColorBWS() As Color
        Get
            Return _BackColorBWS
        End Get
        Set(ByVal value As Color)
            _BackColorBWS = value
        End Set
    End Property

    Private _ForeColorBWS As Color
    Public Property ForeColorBWS() As Color
        Get
            Return _ForeColorBWS
        End Get
        Set(ByVal value As Color)
            _ForeColorBWS = value
        End Set
    End Property

    Private _CursorColorBWS As Color
    Public Property CursorColorBWS() As Color
        Get
            Return _CursorColorBWS
        End Get
        Set(ByVal value As Color)
            _CursorColorBWS = value
        End Set
    End Property
#End Region

#Region "Pixel Eigenschaften"
    'Private Const cPIx As UInteger = 1
    'Private Const cPIy As UInteger = 1
    Private PIx As UInteger
    Private PIy As UInteger
#End Region

#Region "Zeichen Eigenschaften"
    Private Const cZx As UInteger = 7
    Private Const cZy As UInteger = 16
    Private Zx As UInteger
    Private Zy As UInteger
#End Region

#Region "Bildschirm Eigenschaften"
    Private Const cCursorTime As Integer = 100
    Private Const cBWSx As UInteger = 80
    Private Const cBWSy As UInteger = 25

    Private _BWSfcControlArray As Color = System.Drawing.Color.White
    Private _BWSbcControlArray As Color = System.Drawing.Color.Blue

    Private _BWSx As UInteger
    Public Property BWSx() As UInteger
        Get
            Return _BWSx
        End Get
        Set(ByVal value As UInteger)
            _BWSx = value
        End Set
    End Property
    Private _BWSy As UInteger
    Public Property BWSy() As UInteger
        Get
            Return _BWSy
        End Get
        Set(ByVal value As UInteger)
            _BWSy = value
        End Set
    End Property

    Private testbildWahl As UInt16
#End Region

#Region "Dictionary's"
    Private ZeichenDict As Dictionary(Of UInteger, Zeichen) = New Dictionary(Of UInteger, Zeichen)
    Private PictureBoxDict As Dictionary(Of UInteger, PictureBox) = New Dictionary(Of UInteger, PictureBox)

    Private Font1 As Font = New Font()
#End Region

#End Region

#Region "Init-Teil"
    Public Sub New()
        InitializeComponent()
    End Sub

    Public Sub Init(ByVal x1 As Integer, ByVal y1 As Integer, FontdateiName As String)
        ' Add any initialization after the InitializeComponent() call.
        IsCursor = False                                'Cursor
        IsCursorActiv = False
        CursorTyp = eCursorTyp.Full
        CursorStatus = eCursorTyp.None

        BackColorBWS = cBack                            'Color
        ForeColorBWS = cFore
        CursorColorBWS = cCursor

        PIx = COMMON.const_cPIx                         'Pixel
        PIy = COMMON.const_cPIy

        Zx = cZx                                        'Zeichen
        Zy = cZy

        BWSx = cBWSx                                    'Bildschirm
        BWSy = cBWSy
        testbildWahl = 1

        Uhrzeit.Enabled = True

        If Not Font1.LoadBwsFont(FontdateiName) Then
            End
        End If
        Zx = Font1.PixelanzX
        Zy = Font1.PixelanzY
        BWSx = x1
        BWSy = y1

        Font1.BwsFont2zeichenTemplate()

        Call CreateBWS(0)

        Me.Height = PIy * Zy * BWSy + 39                '39
        Me.Width = PIx * Zx * BWSx + 2 + 14             '14
    End Sub
    Public Sub Init(ByVal x1 As Integer, ByVal y1 As Integer)
        BWSx = x1
        BWSy = y1

        Call CreateBWS(0)

        Me.Height = PIy * Zy * BWSy + 39                '39
        Me.Width = PIx * Zx * BWSx + 2 + 14             '14
    End Sub
#End Region

#Region "Change BWS"
    Private Sub changeBWS()
        Dim x, y As UInteger
        Dim PB As PictureBox

        Try
            Font1.BwsFont2zeichenTemplate()

            For y = 0 To BWSy - 1                                                                                       ' zeichenTemplate löschen
                For x = 0 To BWSx - 1
                    PB = PictureBoxDict(y * BWSx + x)
                    PB.Dispose()

                    PictureBoxDict.Remove(y * BWSx + x)
                    ZeichenDict.Remove(y * BWSx + x)
                Next x
            Next y

            Call CreateBWS(1)
        Catch ex As Exception

        End Try
    End Sub

    Private Sub CreateBWS(Code As Byte)
        Dim x, y As UInteger
        Dim Code1 As Byte
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

                    Zeichen1 = ZeichenDict(y * BWSx + x)
                    PB = PictureBoxDict(y * BWSx + x)
                    'Zeichen1.Init()
                    Select Case Code
                        Case 0                                                                                          'Create mit " "
                            Code1 = Asc(" ")
                        Case 1                                                                                          'Init mit Speicher
                            Code1 = COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.Seg_BWS * 1024 * 4 + (y) * BWSx + x)
                    End Select
                    Zeichen1.SetZeichen(Zeichen1, Code1, Font1.zeichenTemplateNormal)
                    PB.Image = Zeichen1.Image
                    PB.Refresh()
                Next x
            Next y

        Catch ex As Exception
            '            Debug.Print(ex.Message)
        End Try
    End Sub

    Public Sub ChangeFont(FontdateiName As String)
        Try
            If Not Font1.LoadBwsFont(FontdateiName) Then                                                                ' neuen Font laden
                End
            End If
            Zx = Font1.PixelanzX
            Zy = Font1.PixelanzY
        Catch ex As Exception

        End Try
    End Sub

    Public Sub ChangePixel(pX As UInteger, pY As UInteger)
        PIx = pX
        PIy = pY

        Call ChangePixel1()
    End Sub
    Public Sub ChangePixel1()
        Try
            Select Case PIx
                Case 1
                    Me.Width = PIx * Zx * BWSx + 2 + 14
                Case 2
                    Me.Width = PIx * Zx * BWSx + 2 + 14
                Case 3
                    Me.Width = PIx * Zx * BWSx + 2 + 14
            End Select

            Select Case PIy
                Case 1
                    Me.Height = PIy * Zy * BWSy + 39
                Case 2
                    Me.Height = PIy * Zy * BWSy + 39
                Case 3
                    Me.Height = PIy * Zy * BWSy + 39
            End Select

            Call changeBWS()
        Catch ex As Exception

        End Try
    End Sub
#End Region

#Region "Zeichen auf BWS setzen"
    'Public Sub Mem2BWS(BColor As Color, FColor As Color, CColor As Color)
    '    Dim _pZ, _pX1, _pY1 As Integer

    '    For _pY1 = 0 To BWSy - 1
    '        For _pX1 = 0 To BWSx - 1
    '            _pZ = COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.Seg_BWS * 1024 * 4 + (_pY1) * 80 + _pX1)
    '            Call BWS_Zeichen(_pX1, _pY1, _pZ, BColor, FColor, CColor)
    '            'Debug.Print(Chr(_pZ) + " X=" + Format(_pX1) + " Y=" + Format(_pY1))
    '        Next _pX1
    '    Next _pY1
    'End Sub
    Public Sub BWS_Zeichen(X As UInteger, Y As UInteger,
                           CharCode As Byte,
                           BColor As Color, FColor As Color, CColor As Color)                                          ' Zeichen
        Dim PB As PictureBox
        Dim Zeichen1 As Zeichen

        Zeichen1 = ZeichenDict(Y * BWSx + X)
        PB = PictureBoxDict(Y * BWSx + X)
        'Zeichen1.Init()

        Zeichen1.ZeichenColorBack = BColor
        Zeichen1.ZeichenColorFore = FColor
        Zeichen1.ZeichenColorCursor = CColor
        Zeichen1.SetZeichen(Zeichen1, CharCode, Font1.zeichenTemplateNormal)
        PB.Image = Zeichen1.Image
        PB.Refresh()
    End Sub
    Public Sub BWS_Zeichen(X As UInteger, Y As UInteger, CharCode As Byte)                                             ' Zeichen mit Standardfarben
        Dim PB As PictureBox
        Dim Zeichen1 As Zeichen

        Zeichen1 = ZeichenDict(Y * BWSx + X)
        PB = PictureBoxDict(Y * BWSx + X)
        'Zeichen1.Init()

        Zeichen1.ZeichenColorBack = cBack
        Zeichen1.ZeichenColorFore = cFore
        Zeichen1.ZeichenColorCursor = cCursor
        Zeichen1.SetZeichen(Zeichen1, CharCode, Font1.zeichenTemplateNormal)
        PB.Image = Zeichen1.Image
        PB.Refresh()
    End Sub
    Public Sub BWS_Zeichen(X As UInteger, Y As UInteger)                                                               ' Leerzeichen mit Standardfarben
        Dim PB As PictureBox
        Dim Zeichen1 As Zeichen

        Zeichen1 = ZeichenDict(Y * BWSx + X)
        PB = PictureBoxDict(Y * BWSx + X)
        'Zeichen1.Init()

        Zeichen1.ZeichenColorBack = cBack
        Zeichen1.ZeichenColorFore = cFore
        Zeichen1.ZeichenColorCursor = cCursor
        Zeichen1.SetZeichen(Zeichen1, &H20, Font1.zeichenTemplateNormal)
        PB.Image = Zeichen1.Image
        PB.Refresh()
    End Sub
#End Region

#Region "Testbilder"
    Public Sub TestBild(Optional ByVal bildwahl As Integer = -1)
        Dim _pZ, _pX1, _pY1 As Integer
        Dim bColor As Color

        bColor = System.Drawing.Color.Blue         'DarkBlue
        If bildwahl = -1 Then
            bildwahl = testbildWahl
        End If
        Select Case bildwahl
            Case 0                                                                                                                                  ' Copyright Anzeige
                Call CopyRight()
                For _pY1 = 0 To BWSy - 1
                    For _pX1 = 0 To BWSx - 1
                        _pZ = COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.Seg_BWS * 1024 * 4 + (_pY1) * 80 + _pX1)
                        Select Case _pY1
                            Case 7
                                Call BWS_Zeichen(_pX1, _pY1, _pZ, bColor, System.Drawing.Color.Red, cCursor)                 '&H1C
                            Case 17
                                Select Case _pZ
                                    Case &H20
                                        Call BWS_Zeichen(_pX1, _pY1, _pZ, bColor, System.Drawing.Color.Yellow, cCursor)      '&H1E
                                    Case Else
                                        Call BWS_Zeichen(_pX1, _pY1, _pZ, bColor, System.Drawing.Color.White, cCursor)       '&H1F       '&H70
                                End Select
                            Case 1, 2, 3, 18, 19, 20
                                Select Case _pZ
                                    Case &H20
                                        Call BWS_Zeichen(_pX1, _pY1, _pZ, bColor, System.Drawing.Color.Yellow, cCursor)      '&H1E
                                    Case Else
                                        Call BWS_Zeichen(_pX1, _pY1, _pZ, bColor, System.Drawing.Color.LightGray, cCursor)   '&H17
                                End Select
                            Case 24
                                Call BWS_Zeichen(_pX1, _pY1, 45, bColor, System.Drawing.Color.Yellow, cCursor)              '&H1E
                            Case Else
                                Call BWS_Zeichen(_pX1, _pY1, _pZ, bColor, System.Drawing.Color.Yellow, cCursor)              '&H1E
                        End Select
                        'Debug.Print(Chr(_pZ) + " X=" + Format(_pX1) + " Y=" + Format(_pY1))
                    Next _pX1
                Next _pY1
            Case 1                                                                                                                                  ' Test Charset
                Call InitCharset()
                'Call Mem2BWS(System.Drawing.Color.Cornsilk, System.Drawing.Color.Black, System.Drawing.Color.Red)
                Me.Refresh()
                testbildWahl = 2
            Case 2                                                                                                                                  ' Test mit String "1234-6789+
                Call InitTestString()
                'Call Mem2BWS(System.Drawing.Color.Beige, System.Drawing.Color.Black, System.Drawing.Color.Red)
                testbildWahl = 1
                Me.Refresh()
            Case 9                                                                                                                                  ' ClrScr
                Call InitClrScr()
                'Call Mem2BWS(System.Drawing.Color.Blue, System.Drawing.Color.Yellow, System.Drawing.Color.Red)
                testbildWahl = 9
        End Select
    End Sub ' TestBild
    Private Sub InitClrScr()
        Dim _pZ, _pX1, _pY1 As Integer
        Dim start, p As Integer
        '
        BackColorBWS = cBack
        ForeColorBWS = cFore
        CursorColorBWS = cCursor
        ResetCursor()
        start = COMMON.vZ80cpu.Seg_BWS * 1024 * 4
        p = 0
        _pZ = Asc(" ")
        Try

            For _pY1 = 0 To BWSy - 1
                For _pX1 = 0 To BWSx - 1
                    COMMON.vZ80cpu.Speicher_schreiben_Byte(start + p, _pZ)
                    p = p + 1
                Next _pX1
            Next _pY1
        Catch ex As Exception

        End Try
        If AnzeigeHS.Visible Then AnzeigeHS.Repaint()
    End Sub
    Private Sub InitCharset()
        Dim _pZ, _pX1, _pY1 As Integer
        Dim start, p As Integer
        '
        BackColorBWS = System.Drawing.Color.Cornsilk
        ForeColorBWS = System.Drawing.Color.Black
        CursorColorBWS = System.Drawing.Color.Red
        ResetCursor()
        start = COMMON.vZ80cpu.Seg_BWS * 1024 * 4
        p = 0
        _pZ = &H0
        For _pY1 = 0 To BWSy - 1
            For _pX1 = 0 To BWSx - 1
                COMMON.vZ80cpu.Speicher_schreiben_Byte(start + p, _pZ)
                p = p + 1
                _pZ = _pZ + 1
                If _pZ = 255 Then _pZ = &H0
            Next _pX1
        Next _pY1
        If AnzeigeHS.Visible Then AnzeigeHS.Repaint()
    End Sub
    Private Sub InitTestString()
        Dim test, test1 As String
        Dim _pZ, _pX1, _pY1 As Integer
        Dim start, p As Integer
        '
        BackColorBWS = System.Drawing.Color.Beige
        ForeColorBWS = System.Drawing.Color.Black
        CursorColorBWS = System.Drawing.Color.Red
        ResetCursor()
        start = COMMON.vZ80cpu.Seg_BWS * 1024 * 4

        test = "----+----"
        p = 0
        For _pY1 = 0 To BWSy - 1
            For _pX1 = 0 To BWSx - 1 Step 10
                Select Case _pX1
                    Case 0
                        test1 = String.Format("{00}", _pY1 + 1)
                        If test1.Length < 2 Then test1 = "0" + test1
                        test1 = test1 + "--+----"
                    Case Else
                        test1 = test
                End Select
                For _pZ = 0 To 8
                    COMMON.vZ80cpu.Speicher_schreiben_Byte(start + p, Asc(Mid(test1, _pZ + 1, 1)))
                    p = p + 1
                Next _pZ
                COMMON.vZ80cpu.Speicher_schreiben_Byte(start + p, &H30 + (_pX1 + 9) / 10)
                'ResetCursor()           '(_pX1 + 9, _pY1) '???
                p = p + 1
            Next _pX1
        Next _pY1
        If AnzeigeHS.Visible Then AnzeigeHS.Repaint()
    End Sub
    Public Sub CopyRight()
        Dim p As Integer
        Dim start As Integer
        '
        Haupt.start = True
        start = COMMON.vZ80cpu.Seg_BWS * 1024 * 4
        'For p = 0 To 1024 * 4 - 1 : COMMON.vZ80cpu.Speicher_schreiben_Byte(start + p, Asc(" ")) : Next
        For p = 0 To (BWSy * BWSx) - 1 : COMMON.vZ80cpu.Speicher_schreiben_Byte(start + p, Asc(" ")) : Next

        For p = 1 To Len(COMMON.COPYR1) : COMMON.vZ80cpu.Speicher_schreiben_Byte(start + p - 1 + 20 + 1 * 80, Asc(Mid(COMMON.COPYR1, p, 1))) : Next
        For p = 1 To Len(COMMON.COPYR2) : COMMON.vZ80cpu.Speicher_schreiben_Byte(start + p - 1 + 20 + 2 * 80, Asc(Mid(COMMON.COPYR2, p, 1))) : Next
        For p = 1 To Len(COMMON.Test2) : COMMON.vZ80cpu.Speicher_schreiben_Byte(start + p - 1 + 20 + 3 * 80, Asc(Mid(COMMON.Test2, p, 1))) : Next
        For p = 1 To Len(COMMON.RELEASE) : COMMON.vZ80cpu.Speicher_schreiben_Byte(start + p - 1 + 28 + 3 * 80, Asc(Mid(COMMON.RELEASE, p, 1))) : Next

        For p = 1 To Len(COMMON.USR_COM) : COMMON.vZ80cpu.Speicher_schreiben_Byte(start + p - 1 + 20 + 7 * 80, Asc(Mid(COMMON.USR_COM, p, 1))) : Next
        For p = 1 To Len(COMMON.Test2) : COMMON.vZ80cpu.Speicher_schreiben_Byte(start + p - 1 + 20 + 9 * 80, Asc(Mid(COMMON.Test2, p, 1))) : Next
        For p = 1 To Len(COMMON.USR_REL) : COMMON.vZ80cpu.Speicher_schreiben_Byte(start + p - 1 + 28 + 9 * 80, Asc(Mid(COMMON.USR_REL, p, 1))) : Next
        For p = 1 To Len(COMMON.Test3) : COMMON.vZ80cpu.Speicher_schreiben_Byte(start + p - 1 + 20 + 11 * 80, Asc(Mid(COMMON.Test3, p, 1))) : Next
        For p = 1 To Len(COMMON.USR_CPR) : COMMON.vZ80cpu.Speicher_schreiben_Byte(start + p - 1 + 20 + 13 * 80, Asc(Mid(COMMON.USR_CPR, p, 1))) : Next

        For p = 1 To Len(COMMON.USR_CO1) : COMMON.vZ80cpu.Speicher_schreiben_Byte(start + p - 1 + 20 + 17 * 80, Asc(Mid(COMMON.USR_CO1, p, 1))) : Next  '&H70
        For p = 1 To Len(COMMON.USR_CP1) : COMMON.vZ80cpu.Speicher_schreiben_Byte(start + p - 1 + 20 + 18 * 80, Asc(Mid(COMMON.USR_CP1, p, 1))) : Next  '&H17
        For p = 1 To Len(COMMON.USR_CP2) : COMMON.vZ80cpu.Speicher_schreiben_Byte(start + p - 1 + 20 + 19 * 80, Asc(Mid(COMMON.USR_CP2, p, 1))) : Next  '&H17
        For p = 1 To Len(COMMON.USR_CP3) : COMMON.vZ80cpu.Speicher_schreiben_Byte(start + p - 1 + 20 + 20 * 80, Asc(Mid(COMMON.USR_CP3, p, 1))) : Next  '&H17
        Haupt.start = False
        If AnzeigeHS.Visible Then AnzeigeHS.Repaint()
    End Sub ' CopyRight
#End Region

#Region "Cursor"
    Private Sub tCursor_Tick(sender As Object, e As EventArgs) Handles tCursor.Tick
        Dim PB As PictureBox
        Dim Zeichen1 As Zeichen
        '        Dim IScursor As Boolean

        Zeichen1 = ZeichenDict(CursorY * BWSx + CursorX)
        PB = PictureBoxDict(CursorY * BWSx + CursorX)
        'Zeichen1.Init()
        Zeichen1.Image = PB.Image

        Call ChangeImage(Zeichen1)
        PB.Image = Zeichen1.Image
        PB.Refresh()

        'tCursor.Enabled = False     'zusätzlich   '???
    End Sub

    Public Sub SetCursorTyp(CursorTypVar As eCursorTyp)
        Me.CursorTyp = CursorTypVar
    End Sub
    Public Sub SetCursor(X As Int16, Y As Int16)
        Dim Zeichen1 As Zeichen

        If Me.IsCursor Then                             'Wenn ein Cursor gesetzt, dann löschen
            ResetCursor()
        End If

        CursorX = X
        CursorY = Y
        Zeichen1 = ZeichenDict(Y * BWSx + X)

        Me.IsCursor = True
        Me.CursorStatus = eCursorTyp.None
        tCursor.Enabled = True
        tCursor.Interval = cCursorTime
    End Sub
    Public Overrides Sub ResetCursor()
        Dim PB As PictureBox
        Dim Zeichen1 As Zeichen

        tCursor.Enabled = False

        Zeichen1 = ZeichenDict(CursorY * BWSx + CursorX)
        PB = PictureBoxDict(CursorY * BWSx + CursorX)
        Me.IsCursor = False

        If Me.IsCursorActiv Then
            Call ChangeImage(Zeichen1)
            Me.IsCursorActiv = False
        End If
        PB.Image = Zeichen1.Image
        PB.Refresh()
    End Sub
    Private Sub ChangeImage(ByRef Zeichen1 As Zeichen)
        If Me.IsCursor Then
            Select Case Me.CursorTyp
                Case eCursorTyp.Normal
                    Select Case Me.CursorStatus
                        Case eCursorTyp.None
                            Zeichen1.Image = Zeichen1.ImageNormal
                            Me.CursorStatus = eCursorTyp.Normal
                            Me.IsCursorActiv = True
                        Case Else
                            Zeichen1.Image = Zeichen1.ImageNone
                            Me.CursorStatus = eCursorTyp.None
                            Me.IsCursorActiv = False
                    End Select
                Case eCursorTyp.Invers
                    Select Case Me.CursorStatus
                        Case eCursorTyp.None
                            Zeichen1.Image = Zeichen1.ImageInvers
                            Me.CursorStatus = eCursorTyp.Invers
                            Me.IsCursorActiv = True
                        Case Else
                            Zeichen1.Image = Zeichen1.ImageNone
                            Me.CursorStatus = eCursorTyp.None
                            Me.IsCursorActiv = False
                    End Select
                Case eCursorTyp.Full
                    Select Case Me.CursorStatus
                        Case eCursorTyp.None
                            Zeichen1.Image = Zeichen1.ImageFull
                            Me.CursorStatus = eCursorTyp.Full
                            Me.IsCursorActiv = True
                        Case Else
                            Zeichen1.Image = Zeichen1.ImageNone
                            Me.CursorStatus = eCursorTyp.None
                            Me.IsCursorActiv = False
                    End Select
            End Select
        Else
            Zeichen1.Image = Zeichen1.ImageNone
            Me.CursorStatus = eCursorTyp.None
            Me.IsCursorActiv = False
        End If
    End Sub
#End Region

#Region "Tastatur"
    Private Sub BWS_KeyDown(sender As Object, e As KeyEventArgs) Handles MyBase.KeyDown
        Call Tastatur.TastKeyDown(e)
    End Sub

    Private Sub BWS_KeyUp(sender As Object, e As KeyEventArgs) Handles MyBase.KeyUp
        Call Tastatur.TastKeyUp(e)
    End Sub
#End Region

#Region "ControlArray"
    Public Sub ResetControlArray(ByVal BackColor As Color, ByVal ForeColor As Color)
        _BWSbcControlArray = BackColor
        _BWSfcControlArray = ForeColor

        Call ResetControlArray2()
    End Sub
    Public Sub ResetControlArray2()
        Dim _pX1, _pY1 As Integer

        For _pY1 = 24 To BWSy - 1
            For _pX1 = 0 To BWSx - 1
                Select Case _pY1
                    Case 24
                        Call BWS_Zeichen(_pX1, _pY1, 45, _BWSbcControlArray, _BWSfcControlArray, cCursor)
                    Case Else
                        Call BWS_Zeichen(_pX1, _pY1, 32, _BWSbcControlArray, _BWSfcControlArray, cCursor)
                End Select
            Next _pX1
        Next _pY1
    End Sub
    Public Sub TextToControlArray(ByVal Text As String, ByVal Zeile As Integer, ByVal Spalte As Integer)
        Dim B, i As Byte
        If String.IsNullOrEmpty(Text) Then
            MsgBox("BWS:TextToControlArray: Text darf nicht Leer oder Null sein!")
        Else
            For i = 0 To Len(Text) - 1
                B = Asc(Text.Substring(i, 1))
                Call BWS_Zeichen(Spalte + i, Zeile - 1, B, _BWSbcControlArray, _BWSfcControlArray, cCursor)
            Next i
        End If
    End Sub
    Public Sub ErrorToControlArray(ByVal Text As String, ByVal Zeile As Integer, ByVal Spalte As Integer, ByVal BackColor As Color, ByVal ForeColor As Color, ByVal TimerValue As Integer)
        Dim B, i As Byte
        If String.IsNullOrEmpty(Text) Then
            MsgBox("BWS:ErrorToControlArray: Text darf nicht Leer oder Null sein!")
        Else
            For i = 0 To Len(Text) - 1
                B = Asc(Text.Substring(i, 1))
                Call BWS_Zeichen(Spalte + i, Zeile - 1, B, BackColor, ForeColor, cCursor)
            Next i
            tError.Interval = TimerValue
            tError.Enabled = True
        End If
    End Sub
    Private Sub tError_Tick(sender As Object, e As EventArgs) Handles tError.Tick
        Call ResetControlArray(_BWSbcControlArray, _BWSfcControlArray)
        tError.Enabled = False
    End Sub
#End Region

#Region "Timer für Uhrzeitanzeige"
    Private Sub Uhr_Tick(sender As Object, e As EventArgs) Handles Uhrzeit.Tick
        Dim Time_str As String

        If Not Me.Visible Then Exit Sub
        If BWSy < 32 Then Exit Sub
        Time_str = Format$(Now, "HH:mm:ss")
        Call TextToControlArray(Time_str, 32, 36)
    End Sub
#End Region

End Class
