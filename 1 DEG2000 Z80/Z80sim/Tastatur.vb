Imports System.Drawing.Text
Imports System.Runtime.CompilerServices
Imports System.Runtime.InteropServices
Imports System.Windows.Input
Imports System.Windows.Media

Public Class Tastatur

    'Dim sprites As Object = My.Resources.ResourceManager

    Private Declare Sub keybd_event Lib "user32" (ByVal bVk As Byte, ByVal bScan As Byte, ByVal dwFlags As Integer, ByVal dwExtraInfo As Integer)
    Private Const VK_CAPITAL As Integer = &H14
    Private Const VK_NUMLOCK As Integer = &H90
    Private Const VK_SCROLL As Integer = &H91
    Private Const KEYEVENTF_EXTENDEDKEY As Integer = &H1
    Private Const KEYEVENTF_KEYUP As Integer = &H2

    Private KleinGross As Char
    Private Const Klein As Char = "a"
    Private Const Gross As Char = "A"

    Private Shift As Boolean
    Private ShiftKeyDown As Boolean
    Private ShiftAusEin As Boolean
    Private DirCodeMerker As Boolean
    Private StartKey As Boolean
    Private ToggleLockTastE As Boolean

    Public Sub New()
        ' Dieser Aufruf ist für den Designer erforderlich.
        InitializeComponent()
        ' Fügen Sie Initialisierungen nach dem InitializeComponent()-Aufruf hinzu.
    End Sub

#Region "Globale Routinen"
    Private Sub Tastatur_Load(sender As System.Object, e As System.EventArgs) Handles MyBase.Load
        Call Init_PF()
        Call Init_PFi()
        Call Fehleranzeige(System.Drawing.Color.WhiteSmoke)
        COMMON.PSTAS = STAS         ' Schreibmaschinen-Tastatur
        Tasttype.Text = "Typ: Schreibmaschine"
        ShiftAusEin = False
        ShiftKeyDown = False
        KleinGross = Klein
        Me.KG.Text = Klein
        Me.ShiftEA.Text = ShiftAusEin
        Call ShiftLockClickAus()    ' UmschalterWeiss()
        Call NumLockClickEin()
        Call ScrollLockClickAus()
        Call HideFocus()
        Shift = False
        DirCodeMerker = False
        StartKey = True
        ToggleLockTastE = False

        Call COMMON.initGrid(TastBuffer, System.Drawing.Color.LightGray, System.Drawing.Color.LightGray, System.Drawing.Color.Black, System.Drawing.Color.Black)
        Call HideFocus()
    End Sub ' Tastatur_Load

    Public Sub FillBuffer()
        Dim i, k As Integer
        Dim row As Integer
        Dim col As Integer
        Dim hilf1() As String
        Dim hilf2 As String
        Dim B As UShort
        Try
            With Me.TastBuffer
                ' alten Inhalt löschen
                For i = .RowCount - 1 To 0 Step -1
                    .Rows.RemoveAt(i)
                Next
                ' neue Inhalt aufbauen
                If COMMON.NextCharTast0 > 0 Then
                    k = 0
                    hilf2 = ""
                    row = 0
                    col = 0
                    For i = 1 To COMMON.NextCharTast0
                        If k = 0 Then           ' neue Zeile im Grid erzeugen
                            hilf1 = {"", "", "", "", "", "", "", "", "", "", "", "", ""}
                            .Rows.Add(hilf1)
                            .Rows(.Rows.Count - 1).Height = 20
                            .Rows(row).Cells(col).Value = row + 1
                        End If
                        k = k + 1
                        If COMMON.NextCharTast1(i) Then
                            col = col + 1
                            B = COMMON.NextCharTast2(i)
                            .Rows(row).Cells(col).Value = COMMON.vZ80cpu.HexAnzeigeWordByte(B, "B")
                            hilf2 = hilf2 + Chr(B And &HFF)
                            If col = 10 Then
                                .Rows(row).Cells(12).Value = hilf2
                                row = row + 1
                                col = 0
                                hilf2 = ""
                                k = 0
                            End If
                        Else
                            Exit For
                        End If
                    Next i
                    If col > 0 Then
                        .Rows(row).Cells(12).Value = hilf2
                    End If
                End If
            End With
        Catch ex As Exception
            MsgBox("Tastatur.FillBuffer: " + ex.Message)
        End Try
    End Sub

    Private Sub HideFocus()
        If dummy.Visible Then Call dummy.Focus()
    End Sub ' HideFocus

    Private Sub Click2Buffer(TastCode As UInt16)
        If TastCode = 0 Then Exit Sub
        If COMMON.NextCharTast0 < COMMON.const_NextCharTast - 1 Then
            COMMON.NextCharTast0 = COMMON.NextCharTast0 + 1

            COMMON.NextCharTast1(COMMON.NextCharTast0) = True
            COMMON.NextCharTast2(COMMON.NextCharTast0) = TastCode
        End If
        Call Haupt.ToolStripStatusAnzeigen()
        Call FillBuffer()
        If Shift And Not My.Computer.Keyboard.ShiftKeyDown Then
            Call Shift_Aus()
            ''Shift = False
            'Button94.PerformClick()
        End If
    End Sub
    Private Sub Click2Buffer1(TastCode As UInt16)
        Call Click2Buffer(TastCode)
    End Sub

    Private Sub Buffer_Click(sender As Object, e As EventArgs) Handles Button123.Click
        Select Case Button123.Text
            Case "Buffer On"
                Me.Height = 565
                Button123.Text = "Buffer Off"
            Case "Buffer Off"
                Me.Height = 328
                Button123.Text = "Buffer On"
            Case Else
        End Select
    End Sub

    Private Function ShiftEbene(Taste As Char) As Boolean
        If KleinGross = Klein Then
            ShiftEbene = False
        Else
            ShiftEbene = True
        End If
        'ShiftEbene = False

        'Select Case Taste
        '    Case "\", "|", "{", "[", "]", "}", "a"
        '        If (COMMON.PSTAS = COMMON.STAS And Not ShiftAusEin) Or
        '           (COMMON.PSTAS = COMMON.PTAS And (Not ShiftAusEin Or KleinGross = Gross)) Then
        '            ShiftEbene = True
        '        End If
        '    Case Else
        '        If (COMMON.PSTAS = COMMON.STAS And ShiftAusEin) Or
        '           (COMMON.PSTAS = COMMON.PTAS And (Not ShiftAusEin Or KleinGross = Klein)) Then
        '            ShiftEbene = True
        '        End If
        'End Select
    End Function

#End Region

#Region "Umschalter Fehleranzeige"
    Public Sub Fehleranzeige(color As System.Drawing.Color)
        Button47.BackColor = color
        Button48.BackColor = color
        Button49.BackColor = color
    End Sub ' Init_ET2
#End Region

#Region "Umschalten PF-Tasten-Ebenen"
    Private PFbutton1(0 To 3) As Button
    Private PFbutton2(0 To 11) As Button
    Private Sub Init_PF()
        PFbutton1(0) = Button1
        PFbutton1(1) = Button6
        PFbutton1(2) = Button11
        PFbutton1(3) = Button16

        PFbutton2(0) = Button2
        PFbutton2(1) = Button3
        PFbutton2(2) = Button4
        PFbutton2(3) = Button7
        PFbutton2(4) = Button8
        PFbutton2(5) = Button9
        PFbutton2(6) = Button12
        PFbutton2(7) = Button13
        PFbutton2(8) = Button14
        PFbutton2(9) = Button17
        PFbutton2(10) = Button18
        PFbutton2(11) = Button19

        COMMON.PFebene = 0
    End Sub
    Private Sub Init_PFi()
        Dim i As Integer
        Dim j As Integer
        Dim s As String
        Dim t As String
        For i = 0 To 3
            If i = COMMON.PFebene Then
                PFbutton1(i).BackColor = System.Drawing.Color.Red
            Else
                PFbutton1(i).BackColor = System.Drawing.Color.WhiteSmoke
            End If
        Next i
        j = COMMON.PFebene * 12
        For i = 0 To 11
            j = j + 1
            s = ""
            t = ""
            If i < 9 Then s = s + " "
            If j < 12 Then t = t + "  "
            If j < 13 Then
                PFbutton2(i).Text = CStr(j)
            Else
                PFbutton2(i).Text = CStr(i + 1) + s + t + " " + CStr(j)
            End If
        Next i
    End Sub ' Init_PF
    Private Sub Ebene0_Click(sender As Object, e As EventArgs) Handles Button5.Click
        COMMON.PFebene = 0
        Call Init_PFi()
        Call Click2Buffer(&H200 + COMMON.KeyCodes2(41))      'D59
        Call HideFocus()
    End Sub
    Private Sub Ebene1_Click(sender As Object, e As EventArgs) Handles Button10.Click
        COMMON.PFebene = 1
        Call Init_PFi()
        Call Click2Buffer(&H200 + COMMON.KeyCodes2(42))      'C59
        Call HideFocus()
    End Sub
    Private Sub Ebene2_Click(sender As Object, e As EventArgs) Handles Button15.Click
        COMMON.PFebene = 2
        Call Init_PFi()
        Call Click2Buffer(&H200 + COMMON.KeyCodes2(43))      'B59
        Call HideFocus()
    End Sub
    Private Sub Ebene3_Click(sender As Object, e As EventArgs) Handles Button20.Click
        COMMON.PFebene = 3
        Call Init_PFi()
        Call Click2Buffer(&H200 + COMMON.KeyCodes2(44))      'A59
        Call HideFocus()
    End Sub
#End Region

#Region "PF - Tasten"
    Private Sub PF01_Click(sender As Object, e As EventArgs) Handles Button2.Click
        Call Click2Buffer(&H200 + COMMON.KeyCodes2(29) + COMMON.PFebene * 12)      'D54
        Call HideFocus()
    End Sub
    Private Sub PF02_Click(sender As Object, e As EventArgs) Handles Button3.Click
        Call Click2Buffer(&H200 + COMMON.KeyCodes2(30) + COMMON.PFebene * 12)      'D56
        Call HideFocus()
    End Sub
    Private Sub PF03_Click(sender As Object, e As EventArgs) Handles Button4.Click
        Call Click2Buffer(&H200 + COMMON.KeyCodes2(31) + COMMON.PFebene * 12)      'D57
        Call HideFocus()
    End Sub

    Private Sub PF04_Click(sender As Object, e As EventArgs) Handles Button7.Click
        Call Click2Buffer(&H200 + COMMON.KeyCodes2(32) + COMMON.PFebene * 12)      'C54
        Call HideFocus()
    End Sub
    Private Sub PF05_Click(sender As Object, e As EventArgs) Handles Button8.Click
        Call Click2Buffer(&H200 + COMMON.KeyCodes2(33) + COMMON.PFebene * 12)      'C56
        Call HideFocus()
    End Sub
    Private Sub PF06_Click(sender As Object, e As EventArgs) Handles Button9.Click
        Call Click2Buffer(&H200 + COMMON.KeyCodes2(34) + COMMON.PFebene * 12)      'C57
        Call HideFocus()
    End Sub
    Private Sub PF07_Click(sender As Object, e As EventArgs) Handles Button12.Click
        Call Click2Buffer(&H200 + COMMON.KeyCodes2(35) + COMMON.PFebene * 12)      'B54
        Call HideFocus()
    End Sub
    Private Sub PF08_Click(sender As Object, e As EventArgs) Handles Button13.Click
        Call Click2Buffer(&H200 + COMMON.KeyCodes2(36) + COMMON.PFebene * 12)      'B56
        Call HideFocus()
    End Sub
    Private Sub PF09_Click(sender As Object, e As EventArgs) Handles Button14.Click
        Call Click2Buffer(&H200 + COMMON.KeyCodes2(37) + COMMON.PFebene * 12)      'B57
        Call HideFocus()
    End Sub
    Private Sub PF10_Click(sender As Object, e As EventArgs) Handles Button17.Click
        Call Click2Buffer(&H200 + COMMON.KeyCodes2(38) + COMMON.PFebene * 12)      'A54
        Call HideFocus()
    End Sub
    Private Sub PF11_Click(sender As Object, e As EventArgs) Handles Button18.Click
        Call Click2Buffer(&H200 + COMMON.KeyCodes2(39) + COMMON.PFebene * 12)      'A56
        Call HideFocus()
    End Sub
    Private Sub PF12_Click(sender As Object, e As EventArgs) Handles Button19.Click
        Call Click2Buffer(&H200 + COMMON.KeyCodes2(40) + COMMON.PFebene * 12)      'A57
        Call HideFocus()
    End Sub
#End Region

#Region "Ziffern 0 ... 9"
    Private Sub Click_0(sender As Object, e As EventArgs) Handles Button74.Click
        If ShiftEbene("0") Then
            Call Click2Buffer(Asc("_"))
        Else
            Call Click2Buffer(Asc("0"))
        End If
        Call HideFocus()
    End Sub
    Private Sub Click_1(sender As Object, e As EventArgs) Handles Button83.Click
        If ShiftEbene("1") Then
            Call Click2Buffer(Asc("!"))
        Else
            Call Click2Buffer(Asc("1"))
        End If
        Call HideFocus()
    End Sub
    Private Sub Click_2(sender As Object, e As EventArgs) Handles Button82.Click
        If ShiftEbene("2") Then
            Call Click2Buffer(Asc(""""))
        Else
            Call Click2Buffer(Asc("2"))
        End If
        Call HideFocus()
    End Sub
    Private Sub Click_3(sender As Object, e As EventArgs) Handles Button81.Click
        If ShiftEbene("3") Then
            Call Click2Buffer(Asc("#"))
        Else
            Call Click2Buffer(Asc("3"))
        End If
        Call HideFocus()
    End Sub
    Private Sub Click_4(sender As Object, e As EventArgs) Handles Button80.Click
        If ShiftEbene("4") Then
            Call Click2Buffer(Asc("$"))
        Else
            Call Click2Buffer(Asc("4"))
        End If
        Call HideFocus()
    End Sub
    Private Sub Click_5(sender As Object, e As EventArgs) Handles Button79.Click
        If ShiftEbene("5") Then
            Call Click2Buffer(Asc("%"))
        Else
            Call Click2Buffer(Asc("5"))
        End If
        Call HideFocus()
    End Sub
    Private Sub Click_6(sender As Object, e As EventArgs) Handles Button78.Click
        If ShiftEbene("6") Then
            Call Click2Buffer(Asc("&"))
        Else
            Call Click2Buffer(Asc("6"))
        End If
        Call HideFocus()
    End Sub
    Private Sub Click_7(sender As Object, e As EventArgs) Handles Button77.Click
        If ShiftEbene("7") Then
            Call Click2Buffer(Asc("'"))
        Else
            Call Click2Buffer(Asc("7"))
        End If
        Call HideFocus()
    End Sub
    Private Sub Click_8(sender As Object, e As EventArgs) Handles Button76.Click
        If ShiftEbene("8") Then
            Call Click2Buffer(Asc("("))
        Else
            Call Click2Buffer(Asc("8"))
        End If
        Call HideFocus()
    End Sub
    Private Sub Click_9(sender As Object, e As EventArgs) Handles Button75.Click
        If ShiftEbene("9") Then
            Call Click2Buffer(Asc(")"))
        Else
            Call Click2Buffer(Asc("9"))
        End If
        Call HideFocus()
    End Sub
#End Region

#Region "NumPad0 ... NumPad9"
    Private Sub Click2Buffer2(value1 As Byte, value2 As Byte)
        Select Case Button46.BackColor
            Case System.Drawing.Color.WhiteSmoke
                Call Click2Buffer(&H100 + value2)
            Case System.Drawing.Color.Red
                Select Case Button66.BackColor
                    Case System.Drawing.Color.WhiteSmoke
                        Call Click2Buffer(&H100 + value1)
                    Case System.Drawing.Color.Red
                        Call Click2Buffer(&H110 + value1)
                End Select
        End Select
    End Sub
    Private Sub Click_NP0(sender As Object, e As EventArgs) Handles Button23.Click
        Call Click2Buffer2(0, &H30)
        Call HideFocus()
    End Sub
    Private Sub Click_NP1(sender As Object, e As EventArgs) Handles Button27.Click
        Call Click2Buffer2(1, &H31)
        Call HideFocus()
    End Sub
    Private Sub Click_NP2(sender As Object, e As EventArgs) Handles Button26.Click
        Call Click2Buffer2(2, &H32)
        Call HideFocus()
    End Sub
    Private Sub Click_NP3(sender As Object, e As EventArgs) Handles Button25.Click
        Call Click2Buffer2(3, &H33)
        Call HideFocus()
    End Sub
    Private Sub Click_NP4(sender As Object, e As EventArgs) Handles Button31.Click
        Call Click2Buffer2(4, &H34)
        Call HideFocus()
    End Sub
    Private Sub Click_NP5(sender As Object, e As EventArgs) Handles Button30.Click
        Call Click2Buffer2(5, &H35)
        Call HideFocus()
    End Sub
    Private Sub Click_NP6(sender As Object, e As EventArgs) Handles Button29.Click
        Call Click2Buffer2(6, &H36)
        Call HideFocus()
    End Sub
    Private Sub Click_NP7(sender As Object, e As EventArgs) Handles Button35.Click
        Call Click2Buffer2(7, &H37)
        Call HideFocus()
    End Sub
    Private Sub Click_NP8(sender As Object, e As EventArgs) Handles Button34.Click
        Call Click2Buffer2(8, &H38)
        Call HideFocus()
    End Sub
    Private Sub Click_NP9(sender As Object, e As EventArgs) Handles Button33.Click
        Call Click2Buffer2(9, &H39)
        Call HideFocus()
    End Sub
#End Region
#Region "NumPadA ... NumPadF"
    Private Sub Click_NPA(sender As Object, e As EventArgs) Handles Button22.Click      ' Hex "A"
        Call Click2Buffer2(10, COMMON.KeyCodes2(23))      'A52
        Call HideFocus()
    End Sub
    Private Sub Click_NPB(sender As Object, e As EventArgs) Handles Button21.Click      ' Hex "B"
        Call Click2Buffer2(11, COMMON.KeyCodes2(24))      'A53
        Call HideFocus()
    End Sub
    Private Sub Click_NPC(sender As Object, e As EventArgs) Handles Button24.Click      ' Hex "C"
        Call Click2Buffer2(12, COMMON.KeyCodes2(25))      'A50
        Call HideFocus()
    End Sub
    Private Sub Click_NPD(sender As Object, e As EventArgs) Handles Button28.Click      ' Hex "D"
        Call Click2Buffer2(13, COMMON.KeyCodes2(26))      'B50
        Call HideFocus()
    End Sub
    Private Sub Click_NPE(sender As Object, e As EventArgs) Handles Button32.Click      ' Hex "E"
        Call Click2Buffer2(14, COMMON.KeyCodes2(27))      'C50
        Call HideFocus()
    End Sub
    Private Sub Click_NPF(sender As Object, e As EventArgs) Handles Button36.Click      ' Hex "F"
        Call Click2Buffer2(15, COMMON.KeyCodes2(28))      'D50
        Call HideFocus()
    End Sub
#End Region

#Region "Buchstaben A ... Z"
    Private Sub Click_AZ(TastCode As Char)
        Dim keyNew As UInteger
        keyNew = Buchstabe2KeyCode(Asc(TastCode))

        'keyNew = Asc(TastCode)                          'Buchstaben A ... Z
        'Select Case PSTAS
        '    Case STAS
        '        If KleinGross = Gross Then
        '            keyNew = Asc(TastCode) + &H20       'Buchstaben a ... z
        '        End If
        '    Case PTAS
        '        If KleinGross = Klein Then
        '            keyNew = Asc(TastCode) + &H20       'Buchstaben a ... z
        '        End If
        'End Select
        Call Click2Buffer(keyNew)

        Call HideFocus()
    End Sub
    Private Function Buchstabe2KeyCode(TasCode As Keys) As UInteger
        Dim keyNew As UInteger
        keyNew = TasCode                          'Buchstaben A ... Z
        Select Case PSTAS
            Case STAS
                If KleinGross = Gross Then
                    keyNew = TasCode + &H20       'Buchstaben a ... z
                End If
            Case PTAS
                If KleinGross = Klein Then
                    keyNew = TasCode + &H20       'Buchstaben a ... z
                End If
        End Select
        Buchstabe2KeyCode = keyNew
    End Function

    Private Sub Click_A(sender As Object, e As EventArgs) Handles Button95.Click
        Call Click_AZ("A")
    End Sub
    Private Sub Click_B(sender As Object, e As EventArgs) Handles Button109.Click
        Call Click_AZ("B")
    End Sub
    Private Sub Click_C(sender As Object, e As EventArgs) Handles Button107.Click
        Call Click_AZ("C")
    End Sub
    Private Sub Click_D(sender As Object, e As EventArgs) Handles Button97.Click
        Call Click_AZ("D")
    End Sub
    Private Sub Click_E(sender As Object, e As EventArgs) Handles Button86.Click
        Call Click_AZ("E")
    End Sub
    Private Sub Click_F(sender As Object, e As EventArgs) Handles Button98.Click
        Call Click_AZ("F")
    End Sub
    Private Sub Click_G(sender As Object, e As EventArgs) Handles Button99.Click
        Call Click_AZ("G")
    End Sub
    Private Sub Click_H(sender As Object, e As EventArgs) Handles Button100.Click
        Call Click_AZ("H")
    End Sub
    Private Sub Click_I(sender As Object, e As EventArgs) Handles Button91.Click
        Call Click_AZ("I")
    End Sub
    Private Sub Click_J(sender As Object, e As EventArgs) Handles Button101.Click
        Call Click_AZ("J")
    End Sub
    Private Sub Click_K(sender As Object, e As EventArgs) Handles Button102.Click
        Call Click_AZ("K")
    End Sub
    Private Sub Click_L(sender As Object, e As EventArgs) Handles Button103.Click
        Call Click_AZ("L")
    End Sub
    Private Sub Click_M(sender As Object, e As EventArgs) Handles Button111.Click
        Call Click_AZ("M")
    End Sub
    Private Sub Click_N(sender As Object, e As EventArgs) Handles Button110.Click
        Call Click_AZ("N")
    End Sub
    Private Sub Click_O(sender As Object, e As EventArgs) Handles Button92.Click
        Call Click_AZ("O")
    End Sub
    Private Sub Click_P(sender As Object, e As EventArgs) Handles Button93.Click
        Call Click_AZ("P")
    End Sub
    Private Sub Click_Q(sender As Object, e As EventArgs) Handles Button84.Click
        Call Click_AZ("Q")
    End Sub
    Private Sub Click_R(sender As Object, e As EventArgs) Handles Button87.Click
        Call Click_AZ("R")
    End Sub
    Private Sub Click_S(sender As Object, e As EventArgs) Handles Button96.Click
        Call Click_AZ("S")
    End Sub
    Private Sub Click_T(sender As Object, e As EventArgs) Handles Button88.Click
        Call Click_AZ("T")
    End Sub
    Private Sub Click_U(sender As Object, e As EventArgs) Handles Button90.Click
        Call Click_AZ("U")
    End Sub
    Private Sub Click_V(sender As Object, e As EventArgs) Handles Button108.Click
        Call Click_AZ("V")
    End Sub
    Private Sub Click_W(sender As Object, e As EventArgs) Handles Button85.Click
        Call Click_AZ("W")
    End Sub
    Private Sub Click_X(sender As Object, e As EventArgs) Handles Button106.Click
        Call Click_AZ("X")
    End Sub
    Private Sub Click_Y(sender As Object, e As EventArgs) Handles Button105.Click
        Call Click_AZ("Y")
    End Sub
    Private Sub Click_Z(sender As Object, e As EventArgs) Handles Button89.Click
        Call Click_AZ("Z")
    End Sub
#End Region

#Region "Spezielle Tasten"
    Private Sub Click_S01(sender As Object, e As EventArgs) Handles Button104.Click           '
        'If My.Computer.Keyboard.CapsLock Or My.Computer.Keyboard.ShiftKeyDown Then
        If ShiftEbene("\") Then
            Call Click2Buffer(&H100 + Asc("\"))
        Else
            Call Click2Buffer(&H100 + Asc("|"))
        End If
        Call HideFocus()
    End Sub
    Private Sub Click_S02(sender As Object, e As EventArgs) Handles Button73.Click
        If ShiftEbene("-") Then
            Call Click2Buffer(&H100 + Asc("="))
        Else
            Call Click2Buffer(&H100 + Asc("-"))
        End If
        Call HideFocus()
    End Sub
    Private Sub Click_S03(sender As Object, e As EventArgs) Handles Button72.Click
        If ShiftEbene("^") Then
            Call Click2Buffer(&H100 + &H7E)
        Else
            Call Click2Buffer(&H100 + Asc("^"))
        End If
        Call HideFocus()
    End Sub
    Private Sub Click_S04(sender As Object, e As EventArgs) Handles Button119.Click
        If ShiftEbene("@") Then
            Call Click2Buffer(&H100 + Asc("`"))
        Else
            Call Click2Buffer(&H100 + Asc("@"))
        End If
        Call HideFocus()
    End Sub
    Private Sub Click_S05(sender As Object, e As EventArgs) Handles Button120.Click
        If ShiftEbene("{") Then
            Call Click2Buffer(&H100 + Asc("{"))
        Else
            Call Click2Buffer(&H100 + Asc("["))
        End If
        Call HideFocus()
    End Sub
    Private Sub Click_S06(sender As Object, e As EventArgs) Handles Button116.Click
        If ShiftEbene(";") Then
            Call Click2Buffer(&H100 + Asc("+"))
        Else
            Call Click2Buffer(&H100 + Asc(";"))
        End If
        Call HideFocus()
    End Sub
    Private Sub Click_S07(sender As Object, e As EventArgs) Handles Button117.Click
        If ShiftEbene(":") Then
            Call Click2Buffer(&H100 + Asc("*"))
        Else
            Call Click2Buffer(&H100 + Asc(":"))
        End If
        Call HideFocus()
    End Sub
    Private Sub Click_S08(sender As Object, e As EventArgs) Handles Button118.Click
        If ShiftEbene("}") Then
            Call Click2Buffer(&H100 + Asc("}"))
        Else
            Call Click2Buffer(&H100 + Asc("]"))
        End If
        Call HideFocus()
    End Sub
    Private Sub Click_S09(sender As Object, e As EventArgs) Handles Button112.Click
        If ShiftEbene(",") Then
            Call Click2Buffer(&H100 + Asc("<"))
        Else
            Call Click2Buffer(&H100 + Asc(","))
        End If
        Call HideFocus()
    End Sub
    Private Sub Click_S10(sender As Object, e As EventArgs) Handles Button113.Click
        If ShiftEbene(".") Then
            Call Click2Buffer(&H100 + Asc(">"))
        Else
            Call Click2Buffer(&H100 + Asc("."))
        End If
        Call HideFocus()
    End Sub
    Private Sub Click_S11(sender As Object, e As EventArgs) Handles Button114.Click
        If ShiftEbene("?") Then
            Call Click2Buffer(&H100 + Asc("?"))
        Else
            Call Click2Buffer(&H100 + Asc("/"))
        End If
        Call HideFocus()
    End Sub
#End Region

#Region "Sondertasten"
    Private Sub ET1_Click(sender As Object, e As EventArgs) Handles Button59.Click
        Call Click2Buffer(&H200 + COMMON.KeyCodes2(1))      'A10
        Call HideFocus()
    End Sub
    Private Sub ET2_Click(sender As Object, e As EventArgs) Handles Button63.Click
        Call Click2Buffer(&H200 + COMMON.KeyCodes2(0))      'A00   'RESET
        Call HideFocus()
    End Sub

    Private Sub TabLeft_Click(sender As Object, e As EventArgs) Handles Button60.Click
        Call Click2Buffer(&H200 + COMMON.KeyCodes2(8))      'C15
        Call HideFocus()
    End Sub
    Private Sub CursorUp_CLick(sender As Object, e As EventArgs) Handles Button53.Click
        Call Click2Buffer(&H200 + COMMON.KeyCodes2(9))      'C16
        Call HideFocus()
    End Sub
    Private Sub TabRight_Click(sender As Object, e As EventArgs) Handles Button56.Click
        Call Click2Buffer(&H200 + COMMON.KeyCodes2(10))     'C17
        Call HideFocus()
    End Sub

    Private Sub CursorLeft_Click(sender As Object, e As EventArgs) Handles Button61.Click
        Call Click2Buffer(&H200 + COMMON.KeyCodes2(5))      'B15
        Call HideFocus()
    End Sub
    Private Sub Home_Click(sender As Object, e As EventArgs) Handles Button54.Click
        Call Click2Buffer(&H200 + COMMON.KeyCodes2(6))      'B16
        Call HideFocus()
    End Sub
    Private Sub CursorRight_Click(sender As Object, e As EventArgs) Handles Button58.Click
        Call Click2Buffer(&H200 + COMMON.KeyCodes2(7))      'B17
        Call HideFocus()
    End Sub

    Private Sub Enter_Click(sender As Object, e As EventArgs) Handles Button51.Click
        Call Click2Buffer(&H200 + COMMON.KeyCodes2(2))      'A15
        Call HideFocus()
    End Sub
    Private Sub CursorDown_Click(sender As Object, e As EventArgs) Handles Button57.Click
        Call Click2Buffer(&H200 + COMMON.KeyCodes2(3))      'A16
        Call HideFocus()
    End Sub
    Private Sub PageUp_Click(sender As Object, e As EventArgs) Handles Button50.Click
        Call Click2Buffer(&H200 + COMMON.KeyCodes2(4))      'A17                                '&HFC ?
        Call HideFocus()
    End Sub

    Private Sub DEL_Click(sender As Object, e As EventArgs) Handles Button69.Click
        Call Click2Buffer(&H200 + COMMON.KeyCodes2(12))     'E17
        Call HideFocus()
    End Sub
    Private Sub InsLine_Click(sender As Object, e As EventArgs) Handles Button52.Click
        Call Click2Buffer(&H200 + COMMON.KeyCodes2(13))     'D16
        Call HideFocus()
    End Sub
    Private Sub DelLine_Click(sender As Object, e As EventArgs) Handles Button55.Click
        Call Click2Buffer(&H200 + COMMON.KeyCodes2(14))     'D17
        Call HideFocus()
    End Sub

    Private Sub InsMod_Click(sender As Object, e As EventArgs) Handles Button70.Click
        Select Case Button122.BackColor
            Case System.Drawing.Color.WhiteSmoke
                Button122.BackColor = System.Drawing.Color.Red
            Case System.Drawing.Color.Red
                Button122.BackColor = System.Drawing.Color.WhiteSmoke
        End Select
        Call Click2Buffer(&H200 + COMMON.KeyCodes2(11))      'E16
        Call HideFocus()
    End Sub

    Private Sub TABS_Click(sender As Object, e As EventArgs) Handles Button71.Click
        Call Click2Buffer(&H200 + COMMON.KeyCodes2(15))      'E13
        Call HideFocus()
    End Sub
    Private Sub TABL_Click(sender As Object, e As EventArgs) Handles Button121.Click
        Call Click2Buffer(&H200 + COMMON.KeyCodes2(16))      'D15
        Call HideFocus()
    End Sub

    Private Sub CI_Click(sender As Object, e As EventArgs) Handles Button45.Click
        Call Click2Buffer(&H200 + COMMON.KeyCodes2(17))      'F54
        Call HideFocus()
    End Sub
    Private Sub M_Click(sender As Object, e As EventArgs) Handles Button44.Click
        Call Click2Buffer(&H200 + COMMON.KeyCodes2(18))      'F56
        Call HideFocus()
    End Sub
    Private Sub RES_Click(sender As Object, e As EventArgs) Handles Button43.Click
        Call Fehleranzeige(System.Drawing.Color.WhiteSmoke)         'Fehleranzeige deaktivieren

        Call Click2Buffer(&H200 + COMMON.KeyCodes2(19))      'F57
        Call HideFocus()
    End Sub

    Private Sub CE_Click(sender As Object, e As EventArgs) Handles Button68.Click
        Select Case Button46.BackColor
            Case System.Drawing.Color.WhiteSmoke
                Button46.BackColor = System.Drawing.Color.Red
            Case System.Drawing.Color.Red
                Button46.BackColor = System.Drawing.Color.WhiteSmoke
        End Select
        'Call Click2Buffer(&H200 + COMMON.KeyCodes2(22))      'A99
        Call HideFocus()
    End Sub

    Private Sub ESC_Click(sender As Object, e As EventArgs) Handles Button65.Click
        Call Click2Buffer(&H200 + COMMON.KeyCodes2(20))      'E00
        Call HideFocus()
    End Sub
    Private Sub CTRL_Click(sender As Object, e As EventArgs) Handles Button64.Click
        Call Click2Buffer(&H200 + COMMON.KeyCodes2(21))      'D00
        Call HideFocus()
    End Sub

    Private Sub Blank_Click(sender As Object, e As EventArgs) Handles Button62.Click
        Call Click2Buffer(&H20)
        Call HideFocus()
    End Sub
#End Region

#Region "Shift"
    Private Sub KleinGrossUmschalten()
        Select Case KleinGross
            Case Klein
                Call UmschaltGross()
            Case Gross
                Call UmschaltKlein()
        End Select
    End Sub
    Private Sub Shift_Ein()
        Call KleinGrossUmschalten()
        'Call UmschalterRot()
        Call ShiftEin()
        Shift = True
        Button67.BackColor = System.Drawing.Color.Red
        Button67.Image = DEG2000.My.Resources.Shift1r
        Button115.BackColor = System.Drawing.Color.Red
        Button115.Image = DEG2000.My.Resources.Shift1r
    End Sub
    Private Sub Shift_Aus()
        Call KleinGrossUmschalten()
        'Call UmschalterWeiss()
        Call ShiftAus()
        Shift = False
        Button67.BackColor = System.Drawing.SystemColors.ControlLight
        Button67.Image = DEG2000.My.Resources.Shift1
        Button115.BackColor = System.Drawing.SystemColors.ControlLight
        Button115.Image = DEG2000.My.Resources.Shift1
    End Sub
    Private Sub ShiftLeft_Click(sender As Object, e As EventArgs) Handles Button67.Click
        Call ShiftClick()
    End Sub
    Private Sub ShiftRight_Click(sender As Object, e As EventArgs) Handles Button115.Click
        Call ShiftClick()
    End Sub
    Private Sub ShiftClick()
        Select Case Button67.BackColor
            Case System.Drawing.Color.Red
                Call Shift_Aus()
            Case Else
                Call Shift_Ein()
        End Select
    End Sub
#End Region

#Region "ShiftLock"
    Private Sub ShiftLock_Click(sender As Object, e As EventArgs) Handles Button94.Click
        ToggleLockTastE = True
        ' Feststeller für 2. Ebene Tasten
        Call ShiftLockClick()
        Call KleinGrossUmschalten()
        Call HideFocus()
    End Sub
    Private Sub ShiftLockClick()
        Select Case Button66.BackColor
            Case System.Drawing.Color.WhiteSmoke
                Call UmschalterRot()
                Call ShiftLockClickEin()
            Case System.Drawing.Color.Red
                Call UmschalterWeiss()
                Call ShiftLockClickAus()
        End Select
    End Sub
#End Region

#Region "STAS - PTAS"
#Region "Umschalter für Klein- / Gross- Buchstaben"
    Private Sub UmschaltKlein()
        KleinGross = Klein
        Me.KG.Text = Klein

        Button83.Text = "1"
        Button82.Text = "2"
        Button81.Text = "3"
        Button80.Text = "4"
        Button79.Text = "5"
        Button78.Text = "6"
        Button77.Text = "7"
        Button76.Text = "8"
        Button75.Text = "9"
        Button74.Text = "0"
        Button73.Text = "-"
        Button72.Text = "^"

        Button84.Text = "q"
        Button85.Text = "w"
        Button86.Text = "e"
        Button87.Text = "r"
        Button88.Text = "t"
        Button89.Text = "z"
        Button90.Text = "u"
        Button91.Text = "i"
        Button92.Text = "o"
        Button93.Text = "p"
        Button119.Text = "@"
        Button120.Text = "["

        Button95.Text = "a"
        Button96.Text = "s"
        Button97.Text = "d"
        Button98.Text = "f"
        Button99.Text = "g"
        Button100.Text = "h"
        Button101.Text = "j"
        Button102.Text = "k"
        Button103.Text = "l"
        Button116.Text = ";"
        Button117.Text = ":"
        Button118.Text = "]"

        Button104.Text = "|"
        Button105.Text = "y"
        Button106.Text = "x"
        Button107.Text = "c"
        Button108.Text = "v"
        Button109.Text = "b"
        Button110.Text = "n"
        Button111.Text = "m"
        Button112.Text = ","
        Button113.Text = "."
        Button114.Text = "/"
    End Sub
    Private Sub UmschaltGross()
        KleinGross = Gross
        Me.KG.Text = Gross

        Button83.Text = "!"
        Button82.Text = """"
        Button81.Text = "#"
        Button80.Text = "$"
        Button79.Text = "%"
        Button78.Text = "&&"
        Button77.Text = "'"
        Button76.Text = "("
        Button75.Text = ")"
        Button74.Text = "_"
        Button73.Text = "="
        Button72.Text = "_"

        Button84.Text = "Q"
        Button85.Text = "W"
        Button86.Text = "E"
        Button87.Text = "R"
        Button88.Text = "T"
        Button89.Text = "Z"
        Button90.Text = "U"
        Button91.Text = "I"
        Button92.Text = "O"
        Button93.Text = "P"
        Button119.Text = "`"
        Button120.Text = "{"

        Button95.Text = "A"
        Button96.Text = "S"
        Button97.Text = "D"
        Button98.Text = "F"
        Button99.Text = "G"
        Button100.Text = "H"
        Button101.Text = "J"
        Button102.Text = "K"
        Button103.Text = "L"
        Button116.Text = "+"
        Button117.Text = "*"
        Button118.Text = "}"

        Button104.Text = "\"
        Button105.Text = "Y"
        Button106.Text = "X"
        Button107.Text = "C"
        Button108.Text = "V"
        Button109.Text = "B"
        Button110.Text = "N"
        Button111.Text = "M"
        Button112.Text = "<"
        Button113.Text = ">"
        Button114.Text = "?"
    End Sub
#End Region
#Region "Umschalter für Button66.BackColor"
    Private Sub UmschalterWeiss()
        Button66.BackColor = System.Drawing.Color.WhiteSmoke
    End Sub
    Private Sub UmschalterRot()
        Button66.BackColor = System.Drawing.Color.Red
    End Sub
#End Region
#Region "Umschalter für Shift"
    Private Sub ShiftAus()
        ShiftAusEin = False
        Me.ShiftEA.Text = ShiftAusEin
    End Sub
    Private Sub ShiftEin()
        ShiftAusEin = True
        Me.ShiftEA.Text = ShiftAusEin
    End Sub
#End Region
#Region "Toggle ShiftLock, NumLock und ScrollLock phys. Tastatur"
    Private Sub ToggleLockTast(ByVal bVk As Byte)
        ' Toggle CapsLock
        ' Simulate the Key Press
        keybd_event(bVk, &H45, KEYEVENTF_EXTENDEDKEY Or 0, 0)
        ' Simulate the Key Release
        keybd_event(bVk, &H45, KEYEVENTF_EXTENDEDKEY Or KEYEVENTF_KEYUP, 0)
    End Sub

#Region "ShiftLock"
    Private Sub ShiftLockClickEin()
        If Not Control.IsKeyLocked(Keys.CapsLock) Then
            Call ToggleLockTast(VK_CAPITAL)
        End If
    End Sub
    Public Sub ShiftLockClickAus()
        If Control.IsKeyLocked(Keys.CapsLock) Then
            Call ToggleLockTast(VK_CAPITAL)
        End If
    End Sub
#End Region

#Region "NumLock"
    Public Sub NumLockClickEin()
        If Not Control.IsKeyLocked(Keys.NumLock) Then
            Call ToggleLockTast(VK_NUMLOCK)
        End If
    End Sub
    Public Sub NumLockClickAus()
        If Control.IsKeyLocked(Keys.NumLock) Then
            Call ToggleLockTast(VK_NUMLOCK)
        End If
    End Sub
#End Region

#Region "ScrollLock"
    Public Sub ScrollLockClickEin()
        If Not Control.IsKeyLocked(Keys.Scroll) Then
            Call ToggleLockTast(VK_SCROLL)
        End If
    End Sub
    Public Sub ScrollLockClickAus()
        If Control.IsKeyLocked(Keys.Scroll) Then
            Call ToggleLockTast(VK_SCROLL)
        End If
    End Sub

#End Region

#Region "Grundstellung"
    Public Sub PSTAS_Grundstellung()
        Select Case COMMON.PSTAS
            Case COMMON.STAS
                Tasttype.Text = "Typ: Schreibmaschine"
                Call UmschaltKlein()
            Case COMMON.PTAS
                Tasttype.Text = "Typ: Programmierung"
                Call UmschaltGross()
        End Select
        Call UmschalterWeiss()
        Call ShiftAus()
    End Sub
#End Region

#End Region

#End Region

#Region "Physische Tastatur"
    Private Sub Tastatur_KeyUp(sender As Object, e As Windows.Forms.KeyEventArgs) Handles MyBase.KeyUp
        If StartKey Then
            Call HideFocus()
        Else
            Call TastKeyUp(e)
        End If
    End Sub
    Public Sub TastKeyUp(e As Windows.Forms.KeyEventArgs)
        Select Case e.KeyCode
            Case Keys.ShiftKey
                If Not My.Computer.Keyboard.ShiftKeyDown Then
                    Call Shift_Aus()
                    ShiftKeyDown = False
                End If
        End Select
    End Sub

    Private Sub Tastatur_KeyDown(sender As Object, e As Windows.Forms.KeyEventArgs) Handles MyBase.KeyDown
        If Not DirCodeMerker Then
            StartKey = False
            Call TastKeyDown(e)
        End If
    End Sub
    Public Sub TastKeyDown(e As Windows.Forms.KeyEventArgs)
        ' physische Tastatur
        Dim keyNew As UInteger

        Try
            'My.Application.Log.WriteEntry("Tastatur:TastKeyDown ToggleLockTastE=" + Str(ToggleLockTastE) + ", e.KeyCode" + Str(e.KeyCode), TraceEventType.Information, 3)
            If ToggleLockTastE Then
                ToggleLockTastE = False
                Exit Sub
            End If
            Select Case e.KeyCode
                Case Keys.Capital
                    Call ShiftLockClick()
                    Call KleinGrossUmschalten()
                    keyNew = e.KeyCode

                Case Keys.ShiftKey
                    If Not ShiftKeyDown Then
                        ShiftKeyDown = True
                        Call Shift_Ein()
                    End If

                Case Keys.NumPad0 To Keys.NumPad9                   'Ziffern auf NumPad
                    keyNew = e.KeyCode - &H30

                Case &H30 To &H39                                   'Ziffern    0 ... 9 
                    If My.Computer.Keyboard.CtrlKeyDown And My.Computer.Keyboard.AltKeyDown Then
                        Select Case e.KeyCode
                            Case &H37
                                keyNew = Asc("{")
                            Case &H38
                                keyNew = Asc("[")
                            Case &H39
                                keyNew = Asc("]")
                            Case &H30
                                keyNew = Asc("}")
                        End Select
                    ElseIf ShiftEbene("=") Then
                        Select Case e.KeyCode
                            Case &H30
                                keyNew = Asc("=")
                            Case &H31
                                keyNew = Asc("!")
                            Case &H32
                                keyNew = Asc("""")
                            Case &H33
                                keyNew = Asc("§")
                            Case &H34
                                keyNew = Asc("$")
                            Case &H35
                                keyNew = Asc("%")
                            Case &H36
                                keyNew = Asc("&")
                            Case &H37
                                keyNew = Asc("/")
                            Case &H38
                                keyNew = Asc("(")
                            Case &H39
                                keyNew = Asc(")")
                        End Select
                    Else
                        keyNew = e.KeyCode
                    End If

                Case &H41 To &H5A
                    keyNew = Buchstabe2KeyCode(e.KeyCode)
                    'keyNew = e.KeyCode                          'Buchstaben A ... Z
                    'Select Case PSTAS
                    '    Case STAS
                    '        If KleinGross = Gross Then
                    '            keyNew = e.KeyCode + &H20       'Buchstaben a ... z
                    '        End If
                    '    Case PTAS
                    '        If KleinGross = Klein Then
                    '            keyNew = e.KeyCode + &H20       'Buchstaben a ... z
                    '        End If
                    'End Select

                Case Keys.Oem102
                    If My.Computer.Keyboard.CtrlKeyDown And My.Computer.Keyboard.AltKeyDown Then
                        keyNew = Asc("|")
                    ElseIf ShiftAusEin Then
                        keyNew = Asc(">")
                    Else
                        keyNew = Asc("<")
                    End If

                Case Keys.Oemcomma
                    If ShiftAusEin Then
                        keyNew = Asc(";")
                    Else
                        keyNew = Asc(",")
                    End If
                Case Keys.OemPeriod
                    If ShiftAusEin Then
                        keyNew = Asc(":")
                    Else
                        keyNew = Asc(".")
                    End If

                Case Keys.OemMinus
                    If ShiftAusEin Then
                        keyNew = Asc("_")
                    Else
                        keyNew = Asc("-")
                    End If
                Case Keys.Oemplus
                    If ShiftAusEin Then
                        keyNew = Asc("*")
                    Else
                        keyNew = Asc("+")
                    End If

                'Case Keys.Oem3
                '    If My.Computer.Keyboard.CapsLock Or My.Computer.Keyboard.ShiftKeyDown Then
                '        keyNew = Asc("Ö")
                '    Else
                '        keyNew = Asc("ö")
                '    End If
                'Case Keys.Oem7
                '    If My.Computer.Keyboard.CapsLock Or My.Computer.Keyboard.ShiftKeyDown Then
                '        keyNew = Asc("Ä")
                '    Else
                '        keyNew = Asc("ä")
                '    End If
                'Case Keys.Oem1
                '    If My.Computer.Keyboard.CapsLock Or My.Computer.Keyboard.ShiftKeyDown Then
                '        keyNew = Asc("Ü")
                '    Else
                '        keyNew = Asc("ü")
                '    End If
                Case Keys.Oem4
                    If My.Computer.Keyboard.CtrlKeyDown And My.Computer.Keyboard.AltKeyDown Then
                        keyNew = Asc("\")
                    ElseIf ShiftAusEin Then
                        keyNew = Asc("?")
                    Else
                        'keyNew = Asc("ß")
                        keyNew = Keys.Oem4
                    End If

                Case Keys.Oem2
                    If ShiftAusEin Then
                        keyNew = Asc("'")
                    Else
                        keyNew = Asc("#")
                    End If

                Case Keys.Left
                    keyNew = &H200 + COMMON.KeyCodes2(5)            'B15
                Case Keys.Right
                    keyNew = &H200 + COMMON.KeyCodes2(7)            'B17
                Case Keys.Up
                    keyNew = &H200 + COMMON.KeyCodes2(9)            'C16
                Case Keys.Down
                    keyNew = &H200 + COMMON.KeyCodes2(3)            'A16

                Case Keys.PageDown
                    keyNew = &H200 + COMMON.KeyCodes2(4)            'A50
                Case Keys.PageUp
                    keyNew = &H200 + COMMON.KeyCodes2(25)           'A17 '&HFC ?

                Case Keys.Home
                    keyNew = &H200 + COMMON.KeyCodes2(6)            'B16
                Case Keys.End
                    keyNew = &H200 + COMMON.KeyCodes2(27)           'C50
                Case Keys.Insert
                    keyNew = &H200 + COMMON.KeyCodes2(11)           'E16    '&H2
                Case Keys.Delete
                    keyNew = &H200 + COMMON.KeyCodes2(12)           'E17   '&H1B

                Case Keys.Enter
                    keyNew = &H200 + COMMON.KeyCodes2(1)            'A10
                Case Keys.Escape
                    keyNew = &H200 + COMMON.KeyCodes2(20)           'E00
                Case Keys.Tab
                    keyNew = &H200 + &H1F           '&H9
                Case Keys.Back
                    keyNew = &H200 + &HF7           'cursor left

                Case Keys.F1
                    keyNew = &H200 + COMMON.KeyCodes2(29) + COMMON.PFebene * 12      'D54
                Case Keys.F2
                    keyNew = &H200 + COMMON.KeyCodes2(30) + COMMON.PFebene * 12      'D56
                Case Keys.F3
                    keyNew = &H200 + COMMON.KeyCodes2(31) + COMMON.PFebene * 12      'D57
                Case Keys.F4
                    keyNew = &H200 + COMMON.KeyCodes2(32) + COMMON.PFebene * 12      'C54
                Case Keys.F5
                    keyNew = &H200 + COMMON.KeyCodes2(33) + COMMON.PFebene * 12      'C56
                Case Keys.F6
                    keyNew = &H200 + COMMON.KeyCodes2(34) + COMMON.PFebene * 12      'C57
                Case Keys.F7
                    keyNew = &H200 + COMMON.KeyCodes2(35) + COMMON.PFebene * 12      'B54
                Case Keys.F8
                    keyNew = &H200 + COMMON.KeyCodes2(36) + COMMON.PFebene * 12      'B56
                Case Keys.F9
                    keyNew = &H200 + COMMON.KeyCodes2(37) + COMMON.PFebene * 12      'B57
                Case Keys.F10
                    keyNew = &H200 + COMMON.KeyCodes2(38) + COMMON.PFebene * 12      'A54
                Case Keys.F11
                    keyNew = &H200 + COMMON.KeyCodes2(39) + COMMON.PFebene * 12      'A56
                Case Keys.F12
                    keyNew = &H200 + COMMON.KeyCodes2(40) + COMMON.PFebene * 12      'A57
                Case Else
                    keyNew = e.KeyCode
            End Select

            If My.Computer.Keyboard.CtrlKeyDown And My.Computer.Keyboard.AltKeyDown Then
                Select Case keyNew
                    Case Asc("{"), Asc("}"),
                         Asc("["), Asc("]"),
                         Asc("|"), Asc("\")
                        Call Click2Buffer(keyNew)
                End Select
            Else
                Select Case keyNew
                    Case Keys.Shift, Keys.ShiftKey, Keys.LShiftKey, Keys.RShiftKey, Keys.Capital, Keys.Oem8
                    Case Keys.ControlKey
                    Case Keys.LWin, Keys.RWin, Keys.Menu, Keys.Apps
                    Case Keys.PrintScreen, Keys.Scroll, Keys.Pause
                    Case Keys.Oem3, Keys.Oem7, Keys.Oem1, Keys.Oem4, Keys.Oem5           'ö ä ü ß ^

                    Case Else
                        Call Click2Buffer(keyNew)
                End Select
            End If
            Call Haupt.ToolStripStatusAnzeigen()
        Catch ex As Exception
            MsgBox("Tastatur.TastKeyDown: " + ex.Message)
        End Try
    End Sub
#End Region


#Region "Input eigenen Tastatur-Code"
    Dim Dir_Code As String

    Private Sub DC_Input(sender As Object, e As EventArgs) Handles Button124.Click
        If Not DirCodeMerker Then
            DirCodeMerker = True
            Dir_Code = ""

            DirCode1.Visible = True
            DirCode2.Visible = True
            DirCode2.Text = Dir_Code
            DirCode2.Select()
        Else
            DirCode2.Visible = False
            DirCode1.Visible = False
            DirCodeMerker = False
        End If
    End Sub

    Private Sub DirCode_KeyPress(sender As Object, e As Windows.Forms.KeyPressEventArgs) Handles DirCode2.KeyPress
        Dim directCode As UInt16
        Select Case e.KeyChar
            Case "a", "b", "c", "d", "e", "f"
                e.KeyChar = Chr(Asc(e.KeyChar) - &H20)
            Case "A", "B", "C", "D", "E", "F", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9"
            Case vbCr
                Try
                    directCode = "&H" + DirCode2.Text
                    DirCode2.Visible = False
                    DirCode1.Visible = False
                    DirCodeMerker = False
                    Click2Buffer(directCode)
                Catch ex As Exception
                    MsgBox("Tastatur.DirCode_KeyPress: " + "Code is not a HEX-Value!")
                    e.KeyChar = "0"
                End Try
            Case Else
                MsgBox("Tastatur.DirCode_KeyPress: " + "Code is not a HEX-Value!")
                e.KeyChar = "0"
        End Select
    End Sub


#End Region

End Class ' Tastatur
