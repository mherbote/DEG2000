Imports System
Imports System.Drawing
Imports System.IO

Public Class Haupt

    Public cpu As New CPU1
    Public IOsim As New IOsim

    Public start As Boolean

    Private LocationSet As Boolean

    'Private wrk_ram As ULong

#Region "Init"
    Public Sub New()
        ' This call is required by the designer.
        InitializeComponent()

    End Sub

    Public Sub InitTastBuffer()
        COMMON.NextCharTast0 = 0
        For iii = 0 To COMMON.const_NextCharTast - 1 : COMMON.NextCharTast1(iii) = False : Next iii

        For iii = 0 To COMMON.const_KeyCodes - 1
            COMMON.KeyCodes1(iii) = ".."
            COMMON.KeyCodes1(iii) = 0
        Next iii

        COMMON.KeyCodes1(0) = "A00"         'ET2
        COMMON.KeyCodes1(1) = "A10"         'ET1

        COMMON.KeyCodes1(2) = "A15"         'new line
        COMMON.KeyCodes1(3) = "A16"         'Cursor Down
        COMMON.KeyCodes1(4) = "A17"         'Pos Quit

        COMMON.KeyCodes1(5) = "B15"         'Cursor Left
        COMMON.KeyCodes1(6) = "B16"         'Pos1 Home
        COMMON.KeyCodes1(7) = "B17"         'Cursor Right

        COMMON.KeyCodes1(8) = "C15"         'TAB Left
        COMMON.KeyCodes1(9) = "C16"         'Cursor Up
        COMMON.KeyCodes1(10) = "C17"        'TAB Right

        COMMON.KeyCodes1(11) = "E16"        'INS MOD
        COMMON.KeyCodes1(12) = "E17"        'DEL
        COMMON.KeyCodes1(13) = "D16"        'INS LIN
        COMMON.KeyCodes1(14) = "D17"        'DEL LIN

        COMMON.KeyCodes1(15) = "E13"        'TABS
        COMMON.KeyCodes1(16) = "D15"        'TABL

        COMMON.KeyCodes1(17) = "F54"        'CI
        COMMON.KeyCodes1(18) = "F56"        'M
        COMMON.KeyCodes1(19) = "F57"        'RES

        COMMON.KeyCodes1(20) = "E00"        'ESC
        COMMON.KeyCodes1(21) = "D00"        'CTRL
        COMMON.KeyCodes1(22) = "A99"        'CE

        COMMON.KeyCodes1(23) = "A52"        'A  00
        COMMON.KeyCodes1(24) = "A53"        'B  000
        COMMON.KeyCodes1(25) = "A50"        'C  Neg Quit
        COMMON.KeyCodes1(26) = "B50"        'D  SYS
        COMMON.KeyCodes1(27) = "C50"        'E  END
        COMMON.KeyCodes1(28) = "D50"        'F  ABS

        COMMON.KeyCodes1(29) = "D54"        'PF01
        COMMON.KeyCodes1(30) = "D56"        'PF02
        COMMON.KeyCodes1(31) = "D57"        'PF03
        COMMON.KeyCodes1(32) = "C54"        'PF04
        COMMON.KeyCodes1(33) = "C56"        'PF05
        COMMON.KeyCodes1(34) = "C57"        'PF06
        COMMON.KeyCodes1(35) = "B54"        'PF07
        COMMON.KeyCodes1(36) = "B56"        'PF08
        COMMON.KeyCodes1(37) = "B57"        'PF09
        COMMON.KeyCodes1(38) = "A54"        'PF10
        COMMON.KeyCodes1(39) = "A56"        'PF11
        COMMON.KeyCodes1(40) = "A57"        'PF12

        'MsgBox(ProgVerz + My.Settings.FontVerzeichnis + "\CODES_OLD.KEY")
        Call GetKeyCodes(ProgVerz + My.Settings.FontVerzeichnis + "\CODES_OLD.KEY")
    End Sub
    Public Sub GetKeyCodes(ByVal datei As String)
        Dim file As System.IO.StreamReader
        Dim stringReader As String
        Dim i As Integer
        Try
            For i = 0 To COMMON.const_KeyCodes - 1
                COMMON.KeyCodes2(i) = 0
            Next i

            file = My.Computer.FileSystem.OpenTextFileReader(datei)
            Do Until file.EndOfStream
                stringReader = file.ReadLine()
                If stringReader.Length > 3 Then
                    If stringReader(3) = vbTab Then
                        For i = 0 To COMMON.const_KeyCodes - 1
                            If COMMON.KeyCodes1(i) = stringReader(0) + stringReader(1) + stringReader(2) Then
                                If stringReader(4) + stringReader(5) <> ".." Then
                                    COMMON.KeyCodes2(i) = "&H" + stringReader(4) + stringReader(5)
                                End If
                                Exit For
                            End If
                        Next i
                    End If
                End If
            Loop
        Catch ex As Exception
            MsgBox("Haupt.GetKeyCodes: " + ex.Message)
            End
        End Try
    End Sub

    Private Sub Haupt_Load(sender As System.Object, e As System.EventArgs) Handles MyBase.Load
        Dim ParamStr As String()

        ''Init LogFile
        'My.Application.Log.DefaultFileLogWriter.BaseFileName = System.IO.Path.Combine(Application.StartupPath, "DEG200-LOG")
        'My.Application.Log.DefaultFileLogWriter.Append = False
        'My.Application.Log.DefaultFileLogWriter.AutoFlush = True
        'My.Application.Log.WriteEntry("")
        'My.Application.Log.WriteEntry("=================================================================", TraceEventType.Information, 1)
        'My.Application.Log.WriteEntry("DEG200 gestartet", TraceEventType.Information, 1)

        ' Add any initialization after the InitializeComponent() call.
        regHistorieColors(0, 0) = System.Drawing.Color.AliceBlue                             ' PC
        regHistorieColors(0, 1) = System.Drawing.Color.Black
        regHistorieColors(1, 0) = System.Drawing.Color.FromArgb(192, 255, 255)               ' A
        regHistorieColors(1, 1) = System.Drawing.Color.Black
        regHistorieColors(2, 0) = System.Drawing.Color.FromArgb(192, 255, 192)               ' flag's
        regHistorieColors(2, 1) = System.Drawing.Color.Black
        regHistorieColors(3, 0) = System.Drawing.Color.FromArgb(155, 192, 192)               ' I, IFF
        regHistorieColors(3, 1) = System.Drawing.Color.Black
        regHistorieColors(4, 0) = System.Drawing.Color.FromArgb(192, 255, 255)               '      BC, DE, HL
        regHistorieColors(4, 1) = System.Drawing.Color.Black
        regHistorieColors(5, 0) = System.Drawing.Color.FromArgb(192, 192, 255)               ' AF', BC', DE', HL'
        regHistorieColors(5, 1) = System.Drawing.Color.Black
        regHistorieColors(6, 0) = System.Drawing.Color.FromArgb(255, 255, 192)               ' IX, IY
        regHistorieColors(6, 1) = System.Drawing.Color.Black
        regHistorieColors(7, 0) = System.Drawing.Color.FromArgb(255, 192, 255)               ' SP
        regHistorieColors(7, 1) = System.Drawing.Color.Black

        Call SetPixelGroesse(COMMON.const_cPIx)
        Call RegisterAnzeigenChange()

        start = True

        AddHandler Me.CMDliste.MouseWheel, AddressOf CMDliste_MouseWheel
        AddHandler Me.regHistory.MouseWheel, AddressOf regHistory_MouseWheel

        COMMON.USR_REL = System.String.Format("{0}.{1:00}", My.Application.Info.Version.Major, My.Application.Info.Version.Minor)

        ParamStr = Environment.GetCommandLineArgs()
        If ParamStr.Length > 1 Then
            ProgVerz = ParamStr(1)
        Else
            ProgVerz = System.Windows.Forms.Application.StartupPath + "\"
        End If

        Call InitTastBuffer()

        COMMON.BinVerzeichnis = ProgVerz + My.Settings.BinVerzeichnis
        COMMON.MemVerzeichnis = ProgVerz + My.Settings.MemVerzeichnis
        COMMON.COMVerzeichnis = ProgVerz + My.Settings.COMVerzeichnis
        COMMON.TapeVerzeichnis = ProgVerz + My.Settings.TapeVerzeichnis
        COMMON.WavVerzeichnis = ProgVerz + My.Settings.WavVerzeichnis
        COMMON.FontDateinameStart = ProgVerz + My.Settings.FontVerzeichnis + "\" + My.Settings.FontDateiname
        COMMON.FontDateiname = COMMON.FontDateinameStart

        'MsgBox(ProgVerz & vbCrLf &
        '       COMMON.COMVerzeichnis & vbCrLf &
        '       COMMON.TapeVerzeichnis & vbCrLf &
        '       COMMON.FontDateinameStart & vbCrLf &
        '       COMMON.FontDateiname
        '      )

        COMMON.EBDC(&H0) = &H0 : COMMON.EBDC(&H1) = &H1 : COMMON.EBDC(&H2) = &H2 : COMMON.EBDC(&H3) = &H3 : COMMON.EBDC(&H4) = &H4 : COMMON.EBDC(&H5) = &H9 : COMMON.EBDC(&H6) = &H6 : COMMON.EBDC(&H7) = &H7
        COMMON.EBDC(&H8) = &H8 : COMMON.EBDC(&H9) = &H9 : COMMON.EBDC(&HA) = &HA : COMMON.EBDC(&HB) = &HB : COMMON.EBDC(&HC) = &HC : COMMON.EBDC(&HD) = &HD : COMMON.EBDC(&HE) = &HE : COMMON.EBDC(&HF) = &HF
        COMMON.EBDC(&H10) = &H10 : COMMON.EBDC(&H11) = &H11 : COMMON.EBDC(&H12) = &H12 : COMMON.EBDC(&H13) = &H13 : COMMON.EBDC(&H14) = &H14 : COMMON.EBDC(&H15) = &H15 : COMMON.EBDC(&H16) = &H8 : COMMON.EBDC(&H17) = &H17
        COMMON.EBDC(&H18) = &H18 : COMMON.EBDC(&H19) = &H19 : COMMON.EBDC(&H1A) = &H1A : COMMON.EBDC(&H1B) = &H1B : COMMON.EBDC(&H1C) = &H1C : COMMON.EBDC(&H1D) = &H1D : COMMON.EBDC(&H1E) = &H1E : COMMON.EBDC(&H1F) = &H1F
        COMMON.EBDC(&H20) = &H20 : COMMON.EBDC(&H21) = &H21 : COMMON.EBDC(&H22) = &H22 : COMMON.EBDC(&H23) = &H23 : COMMON.EBDC(&H24) = &H24 : COMMON.EBDC(&H25) = &HA : COMMON.EBDC(&H26) = &H17 : COMMON.EBDC(&H27) = &H1B
        COMMON.EBDC(&H28) = &H28 : COMMON.EBDC(&H29) = &H29 : COMMON.EBDC(&H2A) = &H2A : COMMON.EBDC(&H2B) = &H2B : COMMON.EBDC(&H2C) = &H2C : COMMON.EBDC(&H2D) = &H5 : COMMON.EBDC(&H2E) = &H6 : COMMON.EBDC(&H2F) = &H7
        COMMON.EBDC(&H30) = &H30 : COMMON.EBDC(&H31) = &H31 : COMMON.EBDC(&H32) = &H36 : COMMON.EBDC(&H33) = &H33 : COMMON.EBDC(&H34) = &H34 : COMMON.EBDC(&H35) = &H35 : COMMON.EBDC(&H36) = &H36 : COMMON.EBDC(&H37) = &H34
        COMMON.EBDC(&H38) = &H38 : COMMON.EBDC(&H39) = &H39 : COMMON.EBDC(&H3A) = &H3A : COMMON.EBDC(&H3B) = &H3B : COMMON.EBDC(&H3C) = &H14 : COMMON.EBDC(&H3D) = &H15 : COMMON.EBDC(&H3E) = &H3E : COMMON.EBDC(&H3F) = &H1A
        COMMON.EBDC(&H40) = &H20 : COMMON.EBDC(&H41) = &H41 : COMMON.EBDC(&H42) = &H42 : COMMON.EBDC(&H43) = &H43 : COMMON.EBDC(&H44) = &H44 : COMMON.EBDC(&H45) = &H45 : COMMON.EBDC(&H46) = &H46 : COMMON.EBDC(&H47) = &H47
        COMMON.EBDC(&H48) = &H48 : COMMON.EBDC(&H49) = &H49 : COMMON.EBDC(&H4A) = &H5B : COMMON.EBDC(&H4B) = &H2E : COMMON.EBDC(&H4C) = &H3C : COMMON.EBDC(&H4D) = &H28 : COMMON.EBDC(&H4E) = &H2B : COMMON.EBDC(&H4F) = &H21
        COMMON.EBDC(&H50) = &H26 : COMMON.EBDC(&H51) = &H51 : COMMON.EBDC(&H52) = &H52 : COMMON.EBDC(&H53) = &H53 : COMMON.EBDC(&H54) = &H54 : COMMON.EBDC(&H55) = &H55 : COMMON.EBDC(&H56) = &H56 : COMMON.EBDC(&H57) = &H57
        COMMON.EBDC(&H58) = &H58 : COMMON.EBDC(&H59) = &H59 : COMMON.EBDC(&H5A) = &H5D : COMMON.EBDC(&H5B) = &H24 : COMMON.EBDC(&H5C) = &H2A : COMMON.EBDC(&H5D) = &H29 : COMMON.EBDC(&H5E) = &H3B : COMMON.EBDC(&H5F) = &H5E
        COMMON.EBDC(&H60) = &H2D : COMMON.EBDC(&H61) = &H2F : COMMON.EBDC(&H62) = &H62 : COMMON.EBDC(&H63) = &H63 : COMMON.EBDC(&H64) = &H64 : COMMON.EBDC(&H65) = &H65 : COMMON.EBDC(&H66) = &H66 : COMMON.EBDC(&H67) = &H67
        COMMON.EBDC(&H68) = &H68 : COMMON.EBDC(&H69) = &H69 : COMMON.EBDC(&H6A) = &H7C : COMMON.EBDC(&H6B) = &H2C : COMMON.EBDC(&H6C) = &H25 : COMMON.EBDC(&H6D) = &H5F : COMMON.EBDC(&H6E) = &H3E : COMMON.EBDC(&H6F) = &H3F
        COMMON.EBDC(&H70) = &H70 : COMMON.EBDC(&H71) = &H71 : COMMON.EBDC(&H72) = &H72 : COMMON.EBDC(&H73) = &H73 : COMMON.EBDC(&H74) = &H74 : COMMON.EBDC(&H75) = &H75 : COMMON.EBDC(&H76) = &H76 : COMMON.EBDC(&H77) = &H77
        COMMON.EBDC(&H78) = &H78 : COMMON.EBDC(&H79) = &H60 : COMMON.EBDC(&H7A) = &H3A : COMMON.EBDC(&H7B) = &H23 : COMMON.EBDC(&H7C) = &H40 : COMMON.EBDC(&H7D) = &H27 : COMMON.EBDC(&H7E) = &H3D : COMMON.EBDC(&H7F) = &H22
        COMMON.EBDC(&H80) = &H80 : COMMON.EBDC(&H81) = &H61 : COMMON.EBDC(&H82) = &H62 : COMMON.EBDC(&H83) = &H63 : COMMON.EBDC(&H84) = &H64 : COMMON.EBDC(&H85) = &H65 : COMMON.EBDC(&H86) = &H66 : COMMON.EBDC(&H87) = &H67
        COMMON.EBDC(&H88) = &H68 : COMMON.EBDC(&H89) = &H69 : COMMON.EBDC(&H8A) = &H8A : COMMON.EBDC(&H8B) = &H8B : COMMON.EBDC(&H8C) = &H8C : COMMON.EBDC(&H8D) = &H8D : COMMON.EBDC(&H8E) = &H8E : COMMON.EBDC(&H8F) = &H8F
        COMMON.EBDC(&H90) = &H90 : COMMON.EBDC(&H91) = &H6A : COMMON.EBDC(&H92) = &H6B : COMMON.EBDC(&H93) = &H6C : COMMON.EBDC(&H94) = &H6D : COMMON.EBDC(&H95) = &H6E : COMMON.EBDC(&H96) = &H6F : COMMON.EBDC(&H97) = &H70
        COMMON.EBDC(&H98) = &H71 : COMMON.EBDC(&H99) = &H72 : COMMON.EBDC(&H9A) = &H9A : COMMON.EBDC(&H9B) = &H9B : COMMON.EBDC(&H9C) = &H9C : COMMON.EBDC(&H9D) = &H9D : COMMON.EBDC(&H9E) = &H9E : COMMON.EBDC(&H9F) = &H9F
        COMMON.EBDC(&HA0) = &HA0 : COMMON.EBDC(&HA1) = &H7E : COMMON.EBDC(&HA2) = &H73 : COMMON.EBDC(&HA3) = &H74 : COMMON.EBDC(&HA4) = &H75 : COMMON.EBDC(&HA5) = &H76 : COMMON.EBDC(&HA6) = &H77 : COMMON.EBDC(&HA7) = &H78
        COMMON.EBDC(&HA8) = &H79 : COMMON.EBDC(&HA9) = &H7A : COMMON.EBDC(&HAA) = &HAA : COMMON.EBDC(&HAB) = &HAB : COMMON.EBDC(&HAC) = &HAC : COMMON.EBDC(&HAD) = &HAD : COMMON.EBDC(&HAE) = &HAE : COMMON.EBDC(&HAF) = &HAF
        COMMON.EBDC(&HB0) = &HB0 : COMMON.EBDC(&HB1) = &HB1 : COMMON.EBDC(&HB2) = &HB2 : COMMON.EBDC(&HB3) = &HB3 : COMMON.EBDC(&HB4) = &HB4 : COMMON.EBDC(&HB5) = &HB5 : COMMON.EBDC(&HB6) = &HB6 : COMMON.EBDC(&HB7) = &HB7
        COMMON.EBDC(&HB8) = &HB8 : COMMON.EBDC(&HB9) = &HB9 : COMMON.EBDC(&HBA) = &HBA : COMMON.EBDC(&HBB) = &HBB : COMMON.EBDC(&HBC) = &HBC : COMMON.EBDC(&HBD) = &HBD : COMMON.EBDC(&HBE) = &HBE : COMMON.EBDC(&HBF) = &HBF
        COMMON.EBDC(&HC0) = &H7B : COMMON.EBDC(&HC1) = &H41 : COMMON.EBDC(&HC2) = &H42 : COMMON.EBDC(&HC3) = &H43 : COMMON.EBDC(&HC4) = &H44 : COMMON.EBDC(&HC5) = &H45 : COMMON.EBDC(&HC6) = &H46 : COMMON.EBDC(&HC7) = &H47
        COMMON.EBDC(&HC8) = &H48 : COMMON.EBDC(&HC9) = &H49 : COMMON.EBDC(&HCA) = &HCA : COMMON.EBDC(&HCB) = &HCB : COMMON.EBDC(&HCC) = &HCC : COMMON.EBDC(&HCD) = &HCD : COMMON.EBDC(&HCE) = &HCE : COMMON.EBDC(&HCF) = &HCF
        COMMON.EBDC(&HD0) = &H7D : COMMON.EBDC(&HD1) = &H4A : COMMON.EBDC(&HD2) = &H4B : COMMON.EBDC(&HD3) = &H4C : COMMON.EBDC(&HD4) = &H4D : COMMON.EBDC(&HD5) = &H4E : COMMON.EBDC(&HD6) = &H4F : COMMON.EBDC(&HD7) = &H50
        COMMON.EBDC(&HD8) = &H51 : COMMON.EBDC(&HD9) = &H52 : COMMON.EBDC(&HDA) = &HDA : COMMON.EBDC(&HDB) = &HDB : COMMON.EBDC(&HDC) = &HDC : COMMON.EBDC(&HDD) = &HDD : COMMON.EBDC(&HDE) = &HDE : COMMON.EBDC(&HDF) = &HDF
        COMMON.EBDC(&HE0) = &H5C : COMMON.EBDC(&HE1) = &HE1 : COMMON.EBDC(&HE2) = &H53 : COMMON.EBDC(&HE3) = &H54 : COMMON.EBDC(&HE4) = &H55 : COMMON.EBDC(&HE5) = &H56 : COMMON.EBDC(&HE6) = &H57 : COMMON.EBDC(&HE7) = &H58
        COMMON.EBDC(&HE8) = &H59 : COMMON.EBDC(&HE9) = &H5A : COMMON.EBDC(&HEA) = &HEA : COMMON.EBDC(&HEB) = &HEB : COMMON.EBDC(&HEC) = &HEC : COMMON.EBDC(&HED) = &HED : COMMON.EBDC(&HEE) = &HEE : COMMON.EBDC(&HEF) = &HEF
        COMMON.EBDC(&HF0) = &H30 : COMMON.EBDC(&HF1) = &H31 : COMMON.EBDC(&HF2) = &H32 : COMMON.EBDC(&HF3) = &H33 : COMMON.EBDC(&HF4) = &H34 : COMMON.EBDC(&HF5) = &H35 : COMMON.EBDC(&HF6) = &H36 : COMMON.EBDC(&HF7) = &H37
        COMMON.EBDC(&HF8) = &H38 : COMMON.EBDC(&HF9) = &H39 : COMMON.EBDC(&HFA) = &HFA : COMMON.EBDC(&HFB) = &HFB : COMMON.EBDC(&HFC) = &HFC : COMMON.EBDC(&HFD) = &HFD : COMMON.EBDC(&HFE) = &HFE : COMMON.EBDC(&HFF) = &H7F

        If COMMON.const_BWSspalten * COMMON.const_BWSzeilen > 4096 Then
            MsgBox("Haupt.Haupt_Load: " + "Der BWS darf nicht größer als 4096 Byte sein!")
            End
        End If

        With BWS
            .Top = Me.Top
            .Left = Me.Left + Me.Width - 14
            .Init(COMMON.const_BWSspalten, COMMON.const_BWSzeilen, COMMON.FontDateiname)
        End With

        COMMON.vZ80cpu = New Z80cpu
        COMMON.vZ80cpu.Seg_BWS = COMMON.const_Seg_BWS
        '
        Timer2.Interval = 1
        Timer2.Enabled = True
        '
        SplashScreen1.ShowDialog()

        Dim vcpu As New CPU1

        'COMMON.vZ80cpu.t_flag = 0
        'Call vcpu.cpu()

        Call init_CMDliste()

        Call COMMON.initGrid(regHistory, regHistorieColors(0, 0), regHistorieColors(0, 0), regHistorieColors(0, 1), regHistorieColors(0, 1))

        Call COMMON.initGrid(regXY, Drawing.Color.LightSalmon, Drawing.Color.LightSalmon, Drawing.Color.Black, Drawing.Color.Black)
        Call COMMON.PrintGrid(regXY, {"PC", ""})
        Call COMMON.PrintGrid(regXY, {"SP", ""})
        Call COMMON.PrintGrid(regXY, {"IX", ""})
        Call COMMON.PrintGrid(regXY, {"IY", ""})

        Call COMMON.initGrid(cpuStatus, Drawing.SystemColors.ControlLight, Drawing.SystemColors.ControlLight, Drawing.Color.Black, Drawing.Color.Black)
        Call COMMON.PrintGrid(cpuStatus, {"CPU State      ", ""})
        Call COMMON.PrintGrid(cpuStatus, {"CPU Error      ", ""})
        Call COMMON.PrintGrid(cpuStatus, {"CPU Int Mode   ", ""})
        Call COMMON.PrintGrid(cpuStatus, {"Interrupt Typ  ", ""})
        Call COMMON.PrintGrid(cpuStatus, {"Interrupt Flags", ""})
        Call COMMON.PrintGrid(cpuStatus, {"Interrupt Reg  ", ""})
        Call COMMON.PrintGrid(cpuStatus, {"Refresh   Reg  ", ""})

        Call COMMON.initGrid(regAF, Drawing.Color.LightYellow, Drawing.Color.LightYellow, Drawing.Color.Black, Drawing.Color.Black)
        Call COMMON.PrintGrid(regAF, {"A", "", "F", ""}) : Call COMMON.PrintGrid(regAF, {"A'", "", "F'", ""})

        Call COMMON.initGrid(regBL, Drawing.Color.LightPink, Drawing.Color.LightPink, Drawing.Color.Black, Drawing.Color.Black)
        Call COMMON.initGrid(regBL_, Drawing.Color.LightPink, Drawing.Color.LightPink, Drawing.Color.Black, Drawing.Color.Black)
        Call COMMON.PrintGrid(regBL, {"B", "", "C", ""}) : Call COMMON.PrintGrid(regBL_, {"B'", "", "C'", ""})
        Call COMMON.PrintGrid(regBL, {"D", "", "E", ""}) : Call COMMON.PrintGrid(regBL_, {"D'", "", "E'", ""})
        Call COMMON.PrintGrid(regBL, {"H", "", "L", ""}) : Call COMMON.PrintGrid(regBL_, {"H'", "", "L'", ""})

        Call Me.cpuState(COMMON.STOPPED)
        Call Me.cpuError(COMMON.NONE)
        Call Me.intMode(COMMON.INT_NONE)
        Call PrintReg()
        Call ToolStripStatusAnzeigen()
        Call ICEmonitor.EnableICE(False)
        CommandLine.Enabled = False

        Call KeyboardVis.PerformClick() 'KeyboardVisChange()

        Call LaufwerkeVis.PerformClick()
    End Sub ' Haupt_Load

    Private Sub Haupt_Activated(sender As Object, e As System.EventArgs) Handles Me.Activated
        Call GetCommandLine()
    End Sub ' Haupt_Activated

    'BMK Init CMDliste
    Private Sub init_CMDliste()
        Call COMMON.initGrid(CMDliste, Drawing.Color.Gainsboro, Drawing.Color.Gainsboro, Drawing.Color.Black, Drawing.Color.Black)      'AliceBlue
        '        Call COMMON.initGrid(CommandLineBez, Drawing.Color.AliceBlue, Drawing.Color.Black, 0)
        '
        Const h1 As Long = 15
        Call COMMON.PrintGridColor(CMDliste, Drawing.Color.Gainsboro, Drawing.Color.RosyBrown, Drawing.Color.Gainsboro, Drawing.Color.RosyBrown)
        Call COMMON.PrintGrid(CMDliste, {"#######  #####    ###            #####    ###   #     #"}, h1)
        Call COMMON.PrintGrid(CMDliste, {"     #  #     #  #   #          #     #    #    ##   ##"}, h1)
        Call COMMON.PrintGrid(CMDliste, {"    #   #     # #     #         #          #    # # # #"}, h1)
        Call COMMON.PrintGrid(CMDliste, {"   #     #####  #     #  #####   #####     #    #  #  #"}, h1)
        Call COMMON.PrintGrid(CMDliste, {"  #     #     # #     #               #    #    #     #"}, h1)
        Call COMMON.PrintGrid(CMDliste, {" #      #     #  #   #          #     #    #    #     #"}, h1)
        Call COMMON.PrintGrid(CMDliste, {"#######  #####    ###            #####    ###   #     #"}, h1)

        Call COMMON.PrintGrid(CMDliste, {""})
        Call COMMON.PrintGridColor(CMDliste, Drawing.Color.Gainsboro, Drawing.Color.DarkBlue, Drawing.Color.Gainsboro, Drawing.Color.DarkBlue)
        Call COMMON.PrintGrid(CMDliste, {"Release " + RELEASE + ", " + COPYR1})
        Call COMMON.PrintGrid(CMDliste, {""})
        If (f_flag > 0) Then
            Call COMMON.PrintGrid(CMDliste, {"CPU speed is " + Format(f_flag) + "MHz"})
        Else
            Call COMMON.PrintGrid(CMDliste, {"CPU speed is unlimited"})
        End If
#If USR_COM0 = 1 Then
        Call COMMON.PrintGrid(CMDliste, {""})
        Call COMMON.PrintGridColor(CMDliste, Drawing.Color.Blue, Drawing.Color.Yellow, Drawing.Color.Blue, Drawing.Color.Yellow)
        Call COMMON.PrintGrid(CMDliste, {USR_COM + " Release " + USR_REL + ", " + USR_CPR})
        Call COMMON.PrintGridColor(CMDliste, Drawing.Color.Gainsboro, Drawing.Color.Black, Drawing.Color.Gainsboro, Drawing.Color.Black)
        Call COMMON.PrintGrid(CMDliste, {""})
#End If
        Call COMMON.PrintGridColor(CMDliste, Drawing.Color.Gainsboro, Drawing.Color.Black, Drawing.Color.Gainsboro, Drawing.Color.Black)
        Call COMMON.PrintGrid(CMDliste, {""})

        Call COMMON.initGrid(CommandLineBez, Drawing.Color.AliceBlue, Drawing.Color.AliceBlue, Drawing.Color.Brown, Drawing.Color.Brown)
        Call COMMON.PrintGrid(CommandLineBez, {"==>"})
        ICEmonitor.Cmd1 = ""
        ICEmonitor.Cmd2 = ""
        ICEmonitor.Cmd3 = 1
        ICEmonitor.Cmd4 = 1
    End Sub ' init_CMDliste

    Private Sub CMDliste_MouseWheel(ByVal sender As Object, ByVal e As Windows.Forms.MouseEventArgs)
        Me.CMDliste.Select()

        If e.Delta < 0 Then
            '+
            Me.CMDliste.FirstDisplayedScrollingRowIndex = Me.CMDliste.FirstDisplayedScrollingRowIndex + 1
        Else
            '-
            If Me.CMDliste.FirstDisplayedScrollingRowIndex > 0 Then
                Me.CMDliste.FirstDisplayedScrollingRowIndex = Me.CMDliste.FirstDisplayedScrollingRowIndex - 1
            End If
        End If
        Me.CMDliste.Refresh()
    End Sub
#End Region

#Region "BMK Register anzeigen"
    Public Sub PrintReg()
        Try
            Call PrintRegAkt()
            Call PrintRegListe()
        Catch ex As Exception
        End Try
    End Sub ' PrintReg

#Region "Change CPU Stati"
    Public Sub cpuState(ByVal cpuStateNew As Integer)
        If COMMON.vZ80cpu.cpu_state <> cpuStateNew Or cpuStatus.Rows(0).Cells(1).Value = "" Then
            COMMON.vZ80cpu.cpu_state = cpuStateNew
            Call cpu_state()
        End If
    End Sub
    Public Sub cpuError(ByVal cpuErrorNew As Byte)
        If COMMON.vZ80cpu.cpu_error <> cpuErrorNew Or cpuStatus.Rows(1).Cells(1).Value = "" Then
            COMMON.vZ80cpu.cpu_error = cpuErrorNew
            Call cpu_error()
        End If
    End Sub
    Public Sub intMode(ByRef intModeNew As Integer)
        If COMMON.vZ80cpu.int_mode <> intModeNew Or cpuStatus.Rows(2).Cells(1).Value = "" Then
            COMMON.vZ80cpu.int_mode = intModeNew
            Call int_mode()
        End If
    End Sub
#End Region
#Region "Anzeigen CPU Stati"
    Public Sub cpu_state()
        Select Case COMMON.vZ80cpu.cpu_state                                    'CPU State
            Case COMMON.SINGLE_STEP
                cpuStatus.Rows(0).Cells(1).Value = "Single Step"
            Case COMMON.CONTIN_RUN
                cpuStatus.Rows(0).Cells(1).Value = "Continues Run"
            Case Else
                cpuStatus.Rows(0).Cells(1).Value = "Stopped"
        End Select
    End Sub
    Public Sub cpu_error()
        Select Case COMMON.vZ80cpu.cpu_error                                    'CPU Error
            Case COMMON.OPHALT
                cpuStatus.Rows(1).Cells(1).Value = "HALT           OP-Code Trap"
            Case COMMON.IOTRAP
                cpuStatus.Rows(1).Cells(1).Value = "IN/OUT                 Trap"
            Case COMMON.OPTRAP1
                cpuStatus.Rows(1).Cells(1).Value = "Illegal 1 Byte OP-Code Trap"
            Case COMMON.OPTRAP2
                cpuStatus.Rows(1).Cells(1).Value = "Illegal 2 Byte OP-Code Trap"
            Case COMMON.OPTRAP4
                cpuStatus.Rows(1).Cells(1).Value = "Illegal 4 Byte OP-Code Trap"
            Case COMMON.USERINT
                cpuStatus.Rows(1).Cells(1).Value = "User Interrupt"
            Case Else
                cpuStatus.Rows(1).Cells(1).Value = "No Error"
        End Select
    End Sub
    Public Sub int_mode()
        Select Case COMMON.vZ80cpu.int_mode                                     'CPU Int Mode
            Case COMMON.INT_NONE
                cpuStatus.Rows(2).Cells(1).Value = "IM 0   NONE"
            Case COMMON.INT_NMI
                cpuStatus.Rows(2).Cells(1).Value = "IM 1   NMI"
            Case COMMON.INT_INT
                cpuStatus.Rows(2).Cells(1).Value = "IM 2   INT"
            Case Else
                cpuStatus.Rows(2).Cells(1).Value = ""
        End Select
    End Sub
    Public Sub int_type()
        Select Case COMMON.vZ80cpu.int_type                                     'Interrupt Typ
            Case Else
                cpuStatus.Rows(3).Cells(1).Value = ""
        End Select
    End Sub
    Public Sub IFFs()
        Select Case COMMON.vZ80cpu.IFF                                          'Interrupt Flags
            Case Else
                cpuStatus.Rows(4).Cells(1).Value = ""
        End Select
    End Sub
    Public Sub IIIs()
        Select Case COMMON.vZ80cpu.III                                          'Interrupt Reg
            Case Else
                cpuStatus.Rows(5).Cells(1).Value = ""
        End Select
    End Sub
    Public Sub R()
        Select Case COMMON.vZ80cpu.R                                            'Refresh Reg
            Case Else
                cpuStatus.Rows(6).Cells(1).Value = ""
                'cpuStatus.Rows(6).Cells(1).Value = COMMON.HexAnzeige_WordByte(COMMON.vZ80cpu.R, "B ")
        End Select
    End Sub
#End Region

    Public Sub PrintRegAkt()
        'Call cpu_state()
        'Call cpu_error()
        'Call int_mode()
        'Call int_type()
        'Call IFFs()
        'Call IIIs()
        'Call R()

        If RegisterAnzeigen.Checked = True Then
            '                                                                       Output all CPU registers
            If (COMMON.vZ80cpu.F And COMMON.S_FLAG) = COMMON.S_FLAG Then Me.flagS.CheckState = Windows.Forms.CheckState.Checked Else Me.flagS.CheckState = Windows.Forms.CheckState.Unchecked
            If (COMMON.vZ80cpu.F And COMMON.Z_FLAG) = COMMON.Z_FLAG Then Me.flagZ.CheckState = Windows.Forms.CheckState.Checked Else Me.flagZ.CheckState = Windows.Forms.CheckState.Unchecked
            If (COMMON.vZ80cpu.F And COMMON.H_FLAG) = COMMON.H_FLAG Then Me.flagH.CheckState = Windows.Forms.CheckState.Checked Else Me.flagH.CheckState = Windows.Forms.CheckState.Unchecked
            If (COMMON.vZ80cpu.F And COMMON.P_FLAG) = COMMON.P_FLAG Then Me.flagP.CheckState = Windows.Forms.CheckState.Checked Else Me.flagP.CheckState = Windows.Forms.CheckState.Unchecked
            If (COMMON.vZ80cpu.F And COMMON.N_FLAG) = COMMON.N_FLAG Then Me.flagN.CheckState = Windows.Forms.CheckState.Checked Else Me.flagN.CheckState = Windows.Forms.CheckState.Unchecked
            If (COMMON.vZ80cpu.F And COMMON.C_FLAG) = COMMON.C_FLAG Then Me.flagC.CheckState = Windows.Forms.CheckState.Checked Else Me.flagC.CheckState = Windows.Forms.CheckState.Unchecked

            regAF.Rows(0).Cells(1).Value = COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.A) : regAF.Rows(1).Cells(1).Value = COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.A_)
            regAF.Rows(0).Cells(3).Value = COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.F) : regAF.Rows(1).Cells(3).Value = COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.F_)

            regBL.Rows(0).Cells(1).Value = COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.B) : regBL_.Rows(0).Cells(1).Value = COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.B_)
            regBL.Rows(0).Cells(3).Value = COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.C) : regBL_.Rows(0).Cells(3).Value = COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.C_)
            regBL.Rows(1).Cells(1).Value = COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.D) : regBL_.Rows(1).Cells(1).Value = COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.D_)
            regBL.Rows(1).Cells(3).Value = COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.E) : regBL_.Rows(1).Cells(3).Value = COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.E_)
            regBL.Rows(2).Cells(1).Value = COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.H) : regBL_.Rows(2).Cells(1).Value = COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.H_)
            regBL.Rows(2).Cells(3).Value = COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.L) : regBL_.Rows(2).Cells(3).Value = COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.L_)


            'Me.reg.Text = COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.III)

            regXY.Rows(0).Cells(1).Value = COMMON.HexAnzeige_WordByte(COMMON.vZ80cpu.PC, "B ")
            regXY.Rows(1).Cells(1).Value = COMMON.HexAnzeige_WordByte(COMMON.vZ80cpu.STACK, "B ")
            regXY.Rows(2).Cells(1).Value = COMMON.HexAnzeige_WordByte(COMMON.vZ80cpu.IX, "B ")
            regXY.Rows(3).Cells(1).Value = COMMON.HexAnzeige_WordByte(COMMON.vZ80cpu.IY, "B ")
        End If
    End Sub ' Print_RegAkt
    Public Sub PrintRegListe()
        Dim hilf() As String

        hilf = {COMMON.HexAnzeige_WordByte(COMMON.vZ80cpu.PC, "B"), COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.A),
                PrintFlag("S"), PrintFlag("Z"), PrintFlag("F5"), PrintFlag("H"), PrintFlag("F3"), PrintFlag("P/V"), PrintFlag("N"), PrintFlag("C"),
                COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.III), PrintIFF(),
                COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.B) + COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.C),
                COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.D) + COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.E),
                COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.H) + COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.L),
                COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.A_) + COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.F_),
                COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.B_) + COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.C_),
                COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.D_) + COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.E_),
                COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.H_) + COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.L_),
                COMMON.HexAnzeige_WordByte(COMMON.vZ80cpu.IX, "B"),
                COMMON.HexAnzeige_WordByte(COMMON.vZ80cpu.IY, "B"),
                COMMON.HexAnzeige_WordByte(COMMON.vZ80cpu.STACK, "B")
               }

        Call COMMON.PrintGrid(Me.regHistory, hilf, 20)
    End Sub ' Print_RegAktListe
    Private Function PrintFlag(ByVal flag As String) As String
        Select Case UCase(flag)
            Case "S"
                If (COMMON.vZ80cpu.F And COMMON.S_FLAG) = COMMON.S_FLAG Then PrintFlag = "1" Else PrintFlag = "0"
            Case "Z"
                If (COMMON.vZ80cpu.F And COMMON.Z_FLAG) = COMMON.Z_FLAG Then PrintFlag = "1" Else PrintFlag = "0"
            Case "F5"
                If (COMMON.vZ80cpu.F And COMMON.F5_FLAG) = COMMON.F5_FLAG Then PrintFlag = "1" Else PrintFlag = "0"
            Case "H"
                If (COMMON.vZ80cpu.F And COMMON.H_FLAG) = COMMON.H_FLAG Then PrintFlag = "1" Else PrintFlag = "0"
            Case "F3"
                If (COMMON.vZ80cpu.F And COMMON.F3_FLAG) = COMMON.F3_FLAG Then PrintFlag = "1" Else PrintFlag = "0"
            Case "P/V"
                If (COMMON.vZ80cpu.F And COMMON.P_FLAG) = COMMON.P_FLAG Then PrintFlag = "1" Else PrintFlag = "0"
            Case "N"
                If (COMMON.vZ80cpu.F And COMMON.N_FLAG) = COMMON.N_FLAG Then PrintFlag = "1" Else PrintFlag = "0"
            Case "C"
                If (COMMON.vZ80cpu.F And COMMON.C_FLAG) = COMMON.C_FLAG Then PrintFlag = "1" Else PrintFlag = "0"
            Case Else
                PrintFlag = "0"
        End Select
    End Function ' Print_Flag
    Private Function PrintIFF() As String
        Dim hilf As String
        hilf = ""
        If COMMON.vZ80cpu.IFF And 1 = 1 Then hilf = hilf + "1" Else hilf = hilf + "0"
        hilf = hilf + " "
        If COMMON.vZ80cpu.IFF And 2 = 2 Then hilf = hilf + "1" Else hilf = hilf + "0"
        PrintIFF = hilf
    End Function ' Print_IFF

    Private Sub regHistory_MouseWheel(ByVal sender As Object, ByVal e As Windows.Forms.MouseEventArgs)
        Me.regHistory.Select()

        If e.Delta < 0 Then
            '+
            Me.regHistory.FirstDisplayedScrollingRowIndex = Me.regHistory.FirstDisplayedScrollingRowIndex + 1
        Else
            '-
            If Me.regHistory.FirstDisplayedScrollingRowIndex > 0 Then
                Me.regHistory.FirstDisplayedScrollingRowIndex = Me.regHistory.FirstDisplayedScrollingRowIndex - 1
            End If
        End If
        Me.regHistory.Refresh()
    End Sub
#End Region

#Region "BMK CPU Fehler anzeigen"
    Public Sub cpuerrmsg()
        Dim hilf As String
        '                                                                       Error handler after CPU is stopped
        Select Case COMMON.vZ80cpu.cpu_error
            Case COMMON.NONE
                hilf = ""
            Case COMMON.OPHALT
                hilf = "HALT Op-Code reached at " + HexAnzeige_WordByte(COMMON.vZ80cpu.PC - 1, "B")
            Case COMMON.IOTRAP
                hilf = "I/O  Trap at " + HexAnzeige_WordByte(COMMON.vZ80cpu.PC, "B")
            Case COMMON.IOERROR
                hilf = "Fatal I/O Error at " + HexAnzeige_WordByte(COMMON.vZ80cpu.PC, "B")
            Case COMMON.OPTRAP1
                hilf = "Op-Code Trap at " + HexAnzeige_WordByte(COMMON.vZ80cpu.PC - 1, "B") + " " + HexAnzeige_Byte(COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.PC - 1))
            Case COMMON.OPTRAP2
                hilf = "Op-Code Trap at " + HexAnzeige_WordByte(COMMON.vZ80cpu.PC - 2, "B") + " " + HexAnzeige_Byte(COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.PC - 2)) +
                                                                                              " " + HexAnzeige_Byte(COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.PC - 1))
            Case COMMON.OPTRAP4
                hilf = "Op-Code Trap at " + HexAnzeige_WordByte(COMMON.vZ80cpu.PC - 4, "B") + " " + HexAnzeige_Byte(COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.PC - 4)) +
                                                                                              " " + HexAnzeige_Byte(COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.PC - 3)) +
                                                                                              " " + HexAnzeige_Byte(COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.PC - 2)) +
                                                                                              " " + HexAnzeige_Byte(COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.PC - 1))
            Case COMMON.USERINT
                hilf = "User Interrupt"
            Case COMMON.POWEROFF
            Case Else
                hilf = "Unknown error " + Format(COMMON.vZ80cpu.cpu_error)
        End Select
    End Sub
#End Region

#Region "Click routinen"
    Private Sub MenuStrip1_ItemClicked(sender As System.Object, e As System.Windows.Forms.ToolStripItemClickedEventArgs) Handles MenuStrip1.ItemClicked
    End Sub ' MenuStrip1_ItemClicked

    'BMK AboutBox anzeigen
    Private Sub InfoÜberZ80EmulatorToolStripMenuItem_Click(sender As System.Object, e As System.EventArgs) Handles InfoÜberZ80EmulatorToolStripMenuItem.Click
        AboutBox1.ShowDialog()
    End Sub ' InfoÜberZ80EmulatorToolStripMenuItem_Click
#End Region

#Region "Timer routinen"
    Private Sub TestbildChange_Tick(sender As Object, e As EventArgs) Handles TestbildChange.Tick
        If Not BWS.Visible Then BWS.Show()
        start = False
        BWS.TestBild()
        start = True
    End Sub ' TestbildChange_Tick   'TestBild wechseln

    Private Sub SplashScreenStarttime_Tick(sender As Object, e As EventArgs) Handles SplashScreenStarttime.Tick
        SplashScreenStarttime.Enabled = False
        TestbildChange.Enabled = False
        SplashScreen1.Hide()
        BWS.TestBild(0)
    End Sub ' Timer3_Tick

    Private Sub Timer2_Tick(sender As System.Object, e As System.EventArgs) Handles Timer2.Tick
        Timer2.Enabled = False

        BWS.Show()
        Call BWS.TestBild()

        TestbildChange.Interval = 100
        TestbildChange.Enabled = True
        SplashScreen1.Select()
    End Sub ' Timer2_Tick
#End Region

#Region "BMK Menü Datei"

#Region "Speicher löschen ..."
    Private Sub SpeicherLoeschen_Click(sender As System.Object, e As System.EventArgs) Handles SpeicherLoeschen.Click
        Call SpeicherLoeschenClick(&H0)
    End Sub ' SpeicherLoeschen_Click
    Private Sub SpeicherLoeschen00_Click(sender As System.Object, e As System.EventArgs) Handles SpeicherLoeschen00.Click
        Call SpeicherLoeschenClick(&H0)
    End Sub ' SpeicherLoeschen00_Click
    Private Sub SpeicherLoeschenFF_Click(sender As System.Object, e As System.EventArgs) Handles SpeicherLoeschenFF.Click
        Call SpeicherLoeschenClick(&HFF)
    End Sub ' SpeicherLoeschenFF_Click
    Private Sub SpeicherLoeschenClick(ByVal wert As Byte)
        Dim i As Integer

        For i = 0 To &HFFFF
            COMMON.vZ80cpu.Speicher_schreiben_Byte(i, wert)
        Next
        Call AnzeigeHSrefresh()
    End Sub ' SpeicherLoeschenClick
    Private Sub AnzeigeHSrefresh()
        If AnzeigeHS.Visible Then
            Call AnzeigeHS.SpeicherAnzeigen()
        End If
    End Sub ' AnzeigeHSrefresh
#End Region

#Region "gesamten Speicher laden"
    Private Sub SpeicherLaden_Click(sender As System.Object, e As System.EventArgs) Handles SpeicherLaden.Click
        'BWS.BackColorBWS = BWS.cBack       '???
        'BWS.ForeColorBWS = BWS.cFore
        'BWS.CursorColorBWS = BWS.cCursor

        OpenFileDialog1.InitialDirectory = COMMON.MemVerzeichnis
        OpenFileDialog1.FileName = "*.MEM;*.DEG"
        If OpenFileDialog1.ShowDialog() = Windows.Forms.DialogResult.OK Then

            COMMON.BinDateiname = OpenFileDialog1.FileName
            Call SpeicherLaden1()
        End If
        Call AnzeigeHSrefresh()
    End Sub ' SpeicherLaden_Click
    Private Sub SpeicherLaden1()
        Dim bb As Byte
        Dim w As UInteger
        Dim fb(0) As Byte

        Try
            Dim fi As FileInfo
            fi = New FileInfo(COMMON.BinDateiname)
            Dim fs As FileStream = fi.OpenRead

            For bb = 0 To Z80cpu.cSeg_HS
                For w = 0 To &HFFFF
                    fs.Read(fb, 0, 1)
                    COMMON.vZ80cpu.Speicher_schreiben_Byte1(w, fb(0), bb)
                Next w
            Next bb
            fs.Close()
        Catch ex As Exception

        End Try
    End Sub ' SpeicherLaden
#End Region

#Region "gesamten Speicher abspeichern"
    Private Sub SpeicherSpeichern_Click(sender As Object, e As EventArgs) Handles SpeichernToolStripMenuItem.Click
        SaveFileDialog1.InitialDirectory = COMMON.MemVerzeichnis
        SaveFileDialog1.FileName = "*.MEM"
        If SaveFileDialog1.ShowDialog() = Windows.Forms.DialogResult.OK Then
            COMMON.BinDateiname = SaveFileDialog1.FileName
            Call SpeicherSpeichern(COMMON.BinDateiname)
        End If
    End Sub
    Private Shared Function SpeicherSpeichern(pfn As String) As Integer
        Dim bb As Byte
        Dim w As UInteger
        Dim b(0) As Byte

        Try
            Dim fi As FileInfo
            fi = New FileInfo(pfn)
            Dim fs As FileStream = fi.OpenWrite
            For bb = 0 To Z80cpu.cSeg_HS
                For w = 0 To &HFFFF
                    b(0) = COMMON.vZ80cpu.Speicher_lesen_Byte1(w, bb)
                    fs.Write(b, 0, 1)
                Next w
            Next bb
            fs.Close()
        Catch ex As Exception

        End Try

        SpeicherSpeichern = 0
    End Function
#End Region

#Region "COM-Datei einlesen für SYS 4"
    Private Sub COMdatei_Click(sender As Object, e As EventArgs) Handles COMDateiFürS4LadenToolStripMenuItem.Click
        Dim i As Integer

        OpenFileDialog1.InitialDirectory = COMMON.COMVerzeichnis
        OpenFileDialog1.FileName = "*.COM"
        If OpenFileDialog1.ShowDialog() = Windows.Forms.DialogResult.OK Then
            Try
                '1) Z80 Abarbeitung anhalten
                Call CPUbreak()

                '2) HS-Speicher Global auf SYS4 "Anwender" ("Anwender"-TRAM) schalten
                For i = 0 To 15
                    COMMON.vZ80cpu.Seg_HS(i) = IOsim.UM2(i)
                Next

                '3) COM-Datei einlesen
                COMMON.BinDateiname = OpenFileDialog1.FileName
                Call SpeicherLaden2()

                '4) PC auf 0100H stellen
                COMMON.vZ80cpu.PC = &H100

                '5) Register-Anzeige ausschalten
                RegisterAnzeigen.Checked = False
                Call RegisterAnzeigenChange()
                Call PrintReg()
            Catch ex As Exception

            End Try
        End If
    End Sub
    Private Function SpeicherLaden2() As Integer
        Dim w As UInteger
        Dim fb(0 To 32) As Byte

        Try
            Dim fi As FileInfo
            fi = New FileInfo(COMMON.BinDateiname)
            Dim fs As FileStream = fi.OpenRead

            w = &H100
            Do While w < &HD000 And (fs.Read(fb, 0, 1) > 0)
                COMMON.vZ80cpu.Speicher_schreiben_Byte1(w, fb(0), 4)
                w = w + 1
            Loop
            fs.Close()
        Catch ex As Exception

        End Try
        SpeicherLaden2 = 0
    End Function ' SpeicherLaden
#End Region

#End Region

#Region "BMK Menü Einstellungen"
    Private Sub ChangeFont_Click_1(sender As Object, e As EventArgs) Handles ChangeFont.Click
        OpenFileDialog1.FileName = "*.FNT"
        OpenFileDialog1.InitialDirectory = ProgVerz + My.Settings.FontVerzeichnis

        Try
            If OpenFileDialog1.ShowDialog() = Windows.Forms.DialogResult.OK Then
                COMMON.FontDateiname = OpenFileDialog1.FileName

                Call BWS.ChangeFont(COMMON.FontDateiname)
            End If
        Catch ex As Exception

        End Try
    End Sub ' ChangeFont_Click

#Region "PixelGröße"
    Public Sub ToolStripMenuItem3_Click(sender As Object, e As EventArgs) Handles ToolStripMenuItem3.Click              '1
        Call SetPixelGroesse(1)
    End Sub
    Private Sub ToolStripMenuItem4_Click(sender As Object, e As EventArgs) Handles ToolStripMenuItem4.Click             '2
        Call SetPixelGroesse(2)
    End Sub
    Private Sub ToolStripMenuItem5_Click(sender As Object, e As EventArgs) Handles ToolStripMenuItem5.Click             '3
        Call SetPixelGroesse(3)
    End Sub

    Public Sub SetPixelGroesse(anzahl As Int32)
        Dim LaufwerkeV, KassettenV As Boolean                                                                           'Merker, ob Fenster visible

        LaufwerkeV = Laufwerke.Visible
        KassettenV = Kassetten.Visible

        If KassettenV Then Kassetten.Hide()
        If LaufwerkeV Then Laufwerke.Hide()

        Select Case anzahl
            Case 1
                If Not ToolStripMenuItem3.Checked Then
                    ToolStripMenuItem3.Checked = True
                    ToolStripMenuItem4.Checked = False
                    ToolStripMenuItem5.Checked = False
                End If
                BWS.ChangePixel(1, 1)
            Case 2
                If Not ToolStripMenuItem4.Checked Then
                    ToolStripMenuItem3.Checked = False
                    ToolStripMenuItem4.Checked = True
                    ToolStripMenuItem5.Checked = False
                    BWS.ChangePixel(2, 2)
                End If
            Case 3
                If Not ToolStripMenuItem5.Checked Then
                    ToolStripMenuItem3.Checked = False
                    ToolStripMenuItem4.Checked = False
                    ToolStripMenuItem5.Checked = True
                    BWS.ChangePixel(3, 3)
                End If
            Case Else
        End Select

        If LaufwerkeV Then
            With Laufwerke
                .Top = Me.Top
                If BWS.Visible Then
                    .Top = .Top + BWS.Height - 7
                End If
                .Left = BWS.Left + 7
                .Show()
            End With
        End If
        If KassettenV Then
            With Kassetten
                .Top = Me.Top
                If BWS.Visible Then
                    .Top = .Top + BWS.Height - 7
                End If
                Select Case anzahl
                    Case 1, 2
                        If Laufwerke.Visible Then
                            .Top = .Top + Laufwerke.Height
                        End If
                        .Left = BWS.Left
                    Case 3
                        .Left = BWS.Left
                        If Laufwerke.Visible Then
                            .Left = .Left + Laufwerke.Width
                        End If
                End Select
                .Show()
            End With
        End If
    End Sub
#End Region

#Region "Change Cursor-Typ"
    Private Sub None_Click(sender As Object, e As EventArgs) Handles NoneToolStripMenuItem.Click
        BWS.SetCursorTyp(BWS.eCursorTyp.None)
    End Sub

    Private Sub Normal_Click(sender As Object, e As EventArgs) Handles NornalToolStripMenuItem.Click
        BWS.SetCursorTyp(BWS.eCursorTyp.Normal)
    End Sub

    Private Sub Invers_Click(sender As Object, e As EventArgs) Handles InversToolStripMenuItem.Click
        BWS.SetCursorTyp(BWS.eCursorTyp.Invers)
    End Sub

    Private Sub Full_Click(sender As Object, e As EventArgs) Handles FullToolStripMenuItem.Click
        BWS.SetCursorTyp(BWS.eCursorTyp.Full)
    End Sub
#End Region

#End Region

#Region "BMK Menü Anzeigen"
    Private Sub BWSvis_Click(sender As System.Object, e As System.EventArgs) Handles BWSvis.Click
        Select Case BWSvis.Checked
            Case True
                BWSvis.Checked = False
                BWS.Hide()
            Case False
                BWSvis.Checked = True
                BWS.Top = Me.Top
                BWS.Left = Me.Left + Me.Width
                BWS.Show()
        End Select
    End Sub ' BWSvis_Click

    Private Sub KeyboardVis_Click(sender As System.Object, e As System.EventArgs) Handles KeyboardVis.Click
        Select Case KeyboardVis.Checked
            Case False
                KeyboardVis.Checked = False
                Tastatur.Hide()
                If HSAnzeigenVis1.Checked = True Then
                    AnzeigeHS.Top = Me.Top + Me.Height - 7
                End If
            Case True
                KeyboardVis.Checked = True
                Tastatur.Show()
                Tastatur.Top = Me.Top + Me.Height - 7
                If HSAnzeigenVis1.Checked = True Then
                    Tastatur.Top = Tastatur.Top + AnzeigeHS.Height - 7
                End If
                Tastatur.Left = Me.Left - (Tastatur.Width - Me.Width)
        End Select
    End Sub

    Private Sub HSAnzeigenVis1_Click(sender As System.Object, e As System.EventArgs) Handles HSAnzeigenVis1.Click
        Select Case HSAnzeigenVis1.Checked
            Case True
                HSAnzeigenVis1.Checked = False
                AnzeigeHS.Hide()
        End Select
    End Sub ' HSAnzeigenVis1_Click

#Region "BMK Speicher anzeigen"
    Private Sub HSAnzeigenVisPar(sender As System.Object, e As System.EventArgs, ByVal adresse As Integer)
        Select Case HSAnzeigenVis1.Checked
            Case False
                HSAnzeigenVis1.Checked = True
                With AnzeigeHS
                    .Show()
                    .Top = Me.Top + Me.Height - 7
                    If KeyboardVis.Checked = True Then
                        Tastatur.Top = Tastatur.Top + .Height - 7
                    End If
                    .Left = Me.Left + (Me.Width - .Width)
                    .Select()
                End With
        End Select
        '
        AnzeigeHS.SpeicherAnzeigen(adresse)
    End Sub ' HSAnzeigenVisPar
    Private Sub HSAnzeigenVis0000_Click(sender As System.Object, e As System.EventArgs) Handles HSAnzeigenVis0000.Click
        Call HSAnzeigenVisPar(sender, e, 0)
    End Sub ' HSAnzeigenVis0000_Click
    Private Sub HSAnzeigenVis1000_Click(sender As System.Object, e As System.EventArgs) Handles HSAnzeigenVis1000.Click
        Call HSAnzeigenVisPar(sender, e, 1)
    End Sub ' HSAnzeigenVis1000_Click
    Private Sub HSAnzeigenVis2000_Click(sender As System.Object, e As System.EventArgs) Handles HSAnzeigenVis2000.Click
        Call HSAnzeigenVisPar(sender, e, 2)
    End Sub ' HSAnzeigenVis2000_Click
    Private Sub HSAnzeigenVis3000_Click(sender As System.Object, e As System.EventArgs) Handles HSAnzeigenVis3000.Click
        Call HSAnzeigenVisPar(sender, e, 3)
    End Sub ' HSAnzeigenVis3000_Click
    Private Sub HSAnzeigenVis4000_Click(sender As System.Object, e As System.EventArgs) Handles HSAnzeigenVis4000.Click
        Call HSAnzeigenVisPar(sender, e, 4)
    End Sub ' HSAnzeigenVis4000_Click
    Private Sub HSAnzeigenVis5000_Click(sender As System.Object, e As System.EventArgs) Handles HSAnzeigenVis5000.Click
        Call HSAnzeigenVisPar(sender, e, 5)
    End Sub ' HSAnzeigenVis5000_Click
    Private Sub HSAnzeigenVis6000_Click(sender As System.Object, e As System.EventArgs) Handles HSAnzeigenVis6000.Click
        Call HSAnzeigenVisPar(sender, e, 6)
    End Sub ' HSAnzeigenVis6000_Click
    Private Sub HSAnzeigenVis7000_Click(sender As System.Object, e As System.EventArgs) Handles HSAnzeigenVis7000.Click
        Call HSAnzeigenVisPar(sender, e, 7)
    End Sub ' HSAnzeigenVis7000_Click
    Private Sub HSAnzeigenVis8000_Click(sender As System.Object, e As System.EventArgs) Handles HSAnzeigenVis8000.Click
        Call HSAnzeigenVisPar(sender, e, 8)
    End Sub ' HSAnzeigenVis8000_Click
    Private Sub HSAnzeigenVis9000_Click(sender As System.Object, e As System.EventArgs) Handles HSAnzeigenVis9000.Click
        Call HSAnzeigenVisPar(sender, e, 9)
    End Sub ' HSAnzeigenVis9000_Click
    Private Sub HSAnzeigenVisA000_Click(sender As System.Object, e As System.EventArgs) Handles HSAnzeigenVisA000.Click
        Call HSAnzeigenVisPar(sender, e, &HA)
    End Sub ' HSAnzeigenVisA000_Click
    Private Sub HSAnzeigenVisB000_Click(sender As System.Object, e As System.EventArgs) Handles HSAnzeigenVisB000.Click
        Call HSAnzeigenVisPar(sender, e, &HB)
    End Sub ' HSAnzeigenVisB000_Click
    Private Sub HSAnzeigenVisC000_Click(sender As System.Object, e As System.EventArgs) Handles HSAnzeigenVisC000.Click
        Call HSAnzeigenVisPar(sender, e, &HC)
    End Sub ' HSAnzeigenVisC000_Click
    Private Sub HSAnzeigenVisD000_Click(sender As System.Object, e As System.EventArgs) Handles HSAnzeigenVisD000.Click
        Call HSAnzeigenVisPar(sender, e, &HD)
    End Sub ' HSAnzeigenVisD000_Click
    Private Sub HSAnzeigenVisE000_Click(sender As System.Object, e As System.EventArgs) Handles HSAnzeigenVisE000.Click
        Call HSAnzeigenVisPar(sender, e, &HE)
    End Sub ' HSAnzeigenVisE000_Click
    Private Sub HSAnzeigenVisF000_Click(sender As System.Object, e As System.EventArgs) Handles HSAnzeigenVisF000.Click
        Call HSAnzeigenVisPar(sender, e, &HF)
    End Sub ' HSAnzeigenVisF000_Click
    Private Sub HSAnzeigenVisBWS_Click(sender As System.Object, e As System.EventArgs) Handles HSAnzeigenVisBWS.Click
        Call HSAnzeigenVisPar(sender, e, COMMON.const_Seg_BWS)
    End Sub ' HSAnzeigenVisBWS_Click
#End Region

    Private Sub LaufwerkeVis_Click(sender As Object, e As EventArgs) Handles LaufwerkeVis.Click
        Select Case LaufwerkeVis.Checked
            Case True
                LaufwerkeVis.Checked = True
                Laufwerke.Show()
                Laufwerke.Top = Me.Top
                If BWSvis.Checked = True Then
                    Laufwerke.Top = Laufwerke.Top + BWS.Height - 7
                End If
                If HSAnzeigenVis1.Checked = True Then
                    Laufwerke.Top = Laufwerke.Top + AnzeigeHS.Height - 7
                End If
                Laufwerke.Left = Me.Left + Me.Width - 7
            Case False
                LaufwerkeVis.Checked = False
                Laufwerke.Hide()
        End Select
    End Sub

    Private Sub KassetteAnzeigen_Click(sender As System.Object, e As System.EventArgs) Handles KassetteAnzeigen.Click
        Call KassetteAnzeigenChange()
    End Sub ' KassetteAnzeigen_Click
    Public Sub KassetteAnzeigenChange()
        Select Case KassetteAnzeigen.Checked
            Case False
                KassetteAnzeigen.Checked = False
                Kassetten.Hide()
            Case True
                KassetteAnzeigen.Checked = True
                With Kassetten
                    .Show()
                    .Top = Me.Top
                    If BWS.Visible Then
                        .Top = .Top + BWS.Height - 7
                    End If
                    If Laufwerke.Visible Then
                        .Top = .Top + Laufwerke.Height
                    End If
                    .Left = Me.Left + Me.Width - 14
                End With
        End Select
    End Sub

    Private Sub FensterToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles FensterToolStripMenuItem.Click
        FensterToolStripMenuItem.Checked = Not FensterToolStripMenuItem.Checked
    End Sub

    Private Sub RegisterAnzeigen_Click(sender As Object, e As EventArgs) Handles RegisterAnzeigen.Click
        Call RegisterAnzeigenClick()
    End Sub
    Public Sub RegisterAnzeigenClick()
        RegisterAnzeigen.Checked = Not RegisterAnzeigen.Checked
        Call RegisterAnzeigenChange()
        Call PrintRegAkt()
    End Sub

#End Region

#Region "Bildschirm Anzeigen - Testbilder"
    Private Sub CopyRightToolStripMenuItem_Click(sender As System.Object, e As System.EventArgs) Handles CopyRightToolStripMenuItem.Click
        Call BWS.TestBild(0)
    End Sub ' CopyRightToolStripMenuItem_Click
    Private Sub Testbild1ToolStripMenuItem_Click(sender As System.Object, e As System.EventArgs) Handles Testbild1ToolStripMenuItem.Click
        Call BWS.TestBild(1)
    End Sub ' Testbild1ToolStripMenuItem_Click
    Private Sub Testbild2ToolStripMenuItem_Click(sender As System.Object, e As System.EventArgs) Handles Testbild2ToolStripMenuItem.Click
        Call BWS.TestBild(2)
    End Sub ' Testbild2ToolStripMenuItem_Click
    Private Sub LeerToolStripMenuItem_Click(sender As System.Object, e As System.EventArgs) Handles LeerToolStripMenuItem.Click
        Call BWS.TestBild(9)
        'TODO
        Call BWS.SetCursor(1, 29)           '???
    End Sub ' LeerToolStripMenuItem_Click
#End Region

#Region "BMK Menü CPU-Z80"
    Private Sub CPUbreak_Click(sender As Object, e As EventArgs) Handles BreakToolStripMenuItem.Click
        Call CPUbreak()
    End Sub
    Public Sub CPUbreak()
        RegisterAnzeigen.Checked = True
        Call RegisterAnzeigenChange()
        Call Me.cpuState(COMMON.SINGLE_STEP)
        'Call PrintReg()
        Call PrintRegListe()
    End Sub

    Private Sub CPUgo_Click(sender As Object, e As EventArgs) Handles GoToolStripMenuItem.Click
        If Tastatur.Visible Then                                                'Für Tastarureingabe aktives Fenster ändern
            Tastatur.Select()
        Else
            If BWS.Visible Then
                BWS.Select()
            End If
        End If
        Call Me.cpuState(COMMON.CONTIN_RUN)
        Call Me.cpuError(COMMON.NONE)
        Call cpu.cpu()
    End Sub
#End Region

#Region "BMK CommandLine"
    Private Sub CommandLine_TextChanged(sender As System.Object, e As System.EventArgs) Handles CommandLine.TextChanged
        Call ICEmonitor.EnableICE(True)
    End Sub ' CommandLine_TextChanged
    Private Sub CommandLine_KeyDown(sender As Object, e As KeyEventArgs) Handles CommandLine.KeyDown
        Call ToolStripStatusAnzeigen()
    End Sub
    Private Sub CommandLine_KeyUp(sender As Object, e As KeyEventArgs) Handles CommandLine.KeyUp
        Call ToolStripStatusAnzeigen()
    End Sub
    Private Sub CommandLine_KeyPress(sender As Object, e As System.Windows.Forms.KeyPressEventArgs) Handles CommandLine.KeyPress
        Select Case e.KeyChar
            Case ControlChars.CrLf
                Try
                    Call ICEmonitor.EnableICE(True)
                    Call ICEmonitor.mon()
                    Call GetCommandLine()
                Catch ex As Exception

                End Try
        End Select
    End Sub ' CommandLine_KeyPress

    Private Sub GetCommandLine()
        CommandLine.BackColor = Drawing.Color.White
        CommandLine.Enabled = True
        Call ICEmonitor.EnableICE(False)
        Me.Select()
        'With CommandLine1
        '.CurrentCell = .Rows(0).Cells(0)
        '.BeginEdit(False)
        'End With
        Me.start = False
        CommandLine.Focus()
    End Sub
#End Region

#Region "Form: location change"
    Private Sub Haupt_LocationChanged(sender As Object, e As EventArgs) Handles MyBase.LocationChanged
        If LocationSet Then Exit Sub

        If FensterToolStripMenuItem.Checked Then
            With AnzeigeHS
                If .Visible Then
                    .Top = Me.Top + Me.Height - 7
                    .Left = Me.Left + (Me.Width - .Width)
                End If
            End With

            With Tastatur
                If .Visible Then
                    Tastatur.Top = Me.Top + Me.Height - 7
                    If HSAnzeigenVis1.Checked = True Then
                        Tastatur.Top = Tastatur.Top + AnzeigeHS.Height - 7
                    End If
                    .Left = Me.Left - (Tastatur.Width - Me.Width)
                End If
            End With

            With BWS
                If .Visible Then
                    .Top = Me.Top
                    .Left = Me.Left + Me.Width - 14
                    .Refresh()
                End If
            End With

            With Laufwerke
                If .Visible Then
                    .Top = Me.Top
                    If BWS.Visible Then
                        .Top = .Top + BWS.Height - 7
                    End If
                    .Left = BWS.Left + 7
                End If
            End With

            With Kassetten
                If .Visible Then
                    .Top = Me.Top
                    If BWS.Visible Then
                        .Top = .Top + BWS.Height - 7
                    End If
                    If Laufwerke.Visible Then
                        .Top = .Top + Laufwerke.Height
                    End If
                    .Left = BWS.Left
                End If
            End With
        End If
    End Sub
#End Region

#Region "RegisterAnzeigenChange"
    Public Sub RegisterAnzeigenChange()
        If RegisterAnzeigen.Checked = True Then
            cpuStatus.Visible = True
            regXY.Visible = True
            regAF.Visible = True
            regBL.Visible = True
            regBL_.Visible = True
            Panel1.Visible = True
        Else
            cpuStatus.Visible = True
            regXY.Visible = False
            regAF.Visible = False
            regBL.Visible = False
            regBL_.Visible = False
            Panel1.Visible = False
        End If
    End Sub
#End Region

#Region "ToolStripStatusAnzeigen"
    Public Sub ToolStripStatusAnzeigen()
        Dim ToolStripINS As String
        Dim ToolStripCAP As String
        Dim ToolStripNUM As String
        Dim ToolStripSCR As String

        Dim ToolStripLS As String
        Dim ToolStripLCTRL As String
        Dim ToolStripLALT As String

        'Dim ToolStripRS As String
        'Dim ToolStripRCTRL As String
        'Dim ToolStripRALT As String

        Dim ToolStripText As String

        '===================
        ToolStripINS = "INS:1  "

        '===================
        If My.Computer.Keyboard.CapsLock Then
            ToolStripCAP = "CAP:1 "
        Else
            ToolStripCAP = "CAP:0 "
        End If
        If My.Computer.Keyboard.NumLock Then
            ToolStripNUM = "NUM:1 "
        Else
            ToolStripNUM = "NUM:0 "
        End If
        If My.Computer.Keyboard.ScrollLock Then
            ToolStripSCR = "SCR:1  "
        Else
            ToolStripSCR = "SCR:0  "
        End If

        '===================
        If My.Computer.Keyboard.ShiftKeyDown Then
            ToolStripLS = "[Shift:1 "
        Else
            ToolStripLS = "[Shift:0 "
        End If
        If My.Computer.Keyboard.CtrlKeyDown Then
            ToolStripLCTRL = "CTRL:1 "
        Else
            ToolStripLCTRL = "CTRL:0 "
        End If
        If My.Computer.Keyboard.AltKeyDown Then
            ToolStripLALT = "ALT:1]  "
        Else
            ToolStripLALT = "ALT:0]  "
        End If

        '===================
        'ToolStripRS = "R[S:0 "
        'ToolStripRCTRL = "CTRL:0 "
        'ToolStripRALT = "ALT:0] "

        '===================
        'ToolStripStatusLabel1.Text = COMMON.DEGstatc
        ToolStripText = ""
        ToolStripText = ToolStripText + ToolStripINS
        ToolStripText = ToolStripText + ToolStripCAP + ToolStripNUM + ToolStripSCR
        ToolStripText = ToolStripText + ToolStripLS + ToolStripLCTRL + ToolStripLALT
        ToolStripText = ToolStripText + Format(COMMON.NextCharTast0, "0000")
        'ToolStripText = ToolStripText + ToolStripRS + ToolStripRCTRL + ToolStripRALT
        ToolStripStatusLabel1.Text = ToolStripText
    End Sub
#End Region

    Private Sub Haupt_KeyPress(sender As Object, e As KeyPressEventArgs) Handles MyBase.KeyPress
    End Sub

    Private Sub Haupt_KeyDown(sender As Object, e As KeyEventArgs) Handles MyBase.KeyDown
        Call ToolStripStatusAnzeigen()
    End Sub

    Private Sub Beenden_Click(sender As Object, e As EventArgs) Handles BeendenToolStripMenuItem.Click
        My.Application.Log.WriteEntry("Haupt:Beenden_Click", TraceEventType.Information, 2)
        My.Application.Log.WriteEntry("Log-Datei schliessen", TraceEventType.Information, 2)
        My.Application.Log.DefaultFileLogWriter.Close()
        Tastatur.ShiftLockClickAus()
        End
    End Sub

    Private Sub Haupt_Close(sender As Object, e As FormClosedEventArgs) Handles MyBase.FormClosed
        My.Application.Log.WriteEntry("Haupt:Haupt_Close", TraceEventType.Information, 2)
        My.Application.Log.WriteEntry("Log-Datei schliessen", TraceEventType.Information, 2)
        My.Application.Log.DefaultFileLogWriter.Close()
        Tastatur.ShiftLockClickAus()
        End
    End Sub
End Class ' KeyboardVis_Click