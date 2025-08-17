Imports System.Drawing

Module COMMON

    '================                                                           'entnommen aus DEFINE.INC
    '#Const USR_COM0 = 1                                                        'User-Copyright

    '#Const WANT_TIM0 = 1                                                       'activate runtime measurement

    '#Const FRONTPANEL0 = 0                                                     'no frontpanel emulation
    '#Const BUS_8080 = 1                                                        'no emulation of 8080 bus status

    '#Const HISIZE0 = 1                                                         'history
    Public Const HISIZE As Byte = 100                                           ' number of entrys in history 

    '#Const SBSIZE0 = 1                                                         'breakpoint
    Public Const SBSIZE As Byte = 9                                             ' number of software breakpoints 

    '#Const CNTL_C0 = 1                                                         'cntl-c will stop running emulation
    Public cntl_c As Integer                                                    ' flag for cntl-c entered
    '#Const CNTL_BS0 = 1                                                        'cntl-\ will stop running emulation
    Public cntl_bs As Integer                                                   ' flag for cntl-\ entered

    '#Const WANT_INT0 = 1                                                       'activate CPU's interrupt
    '#Const WANT_SPC0 = 1                                                       'activate SP over-/underrun handling 0000<->FFFF
    '#Const WANT_PCC0 = 1                                                       'activate PC overrun        handling FFFF->0000
    Public Const Z80_UNDOC0 = 1                                                 'compile undocumented Z80 instructions

    '#Const DEBUG0 = 0
    '#Const DEBUG1 = 0

    'DEBUG0=0

    '================                                                           'entnommen aus VARIA.PAS
    Public Const COPYR1 As String = "Z80-Emulator als Basisemulator"
    Public Const COPYR2 As String = "Copyright (C) 1987-2008 by Udo Munk"
    Public Const RELEASE As String = "1.17"
    Public Const USR_COM As String = "DEG2000-System Emulator"
    Public Const USR_CPR As String = "Copyright (C) 1996-2025 by Marcus Herbote"
    Public Const USR_CO1 As String = "D E G 2 0 0 0   Software"
    Public Const USR_CP1 As String = "Copyright (C) 1981-1982 by IfR             Berlin/GDR"
    Public Const USR_CP2 As String = "Copyright (C) 1983-1985 by K EAW           Berlin/GDR"
    Public Const USR_CP3 As String = "Copyright (C) 1986-1990 by WMK ""7.Oktober"" Berlin/GDR"
    Public Const Test1 As String = "D E G 2 0 0 0"
    Public Const Test2 As String = "Release "
    Public Const Test3 As String = "Version fuer MiniTAP mit TRAM, neue Tastatur/ATS"
    'Public Const DEGstatc As String = "E:....  F:...  INS:. CAP:. NUM:. SCR:.  L[S:. CTRL:. ALT:.]  R[ALT:. CTRL:. S:.]"

    Public Const adr_err As String = "address out of range"

    Public Const const_Seg_BWS As Byte = 3                                      ' Adresse BWS im DEG2000 
    Public Const const_CPU_SPEED As Byte = 0                                    ' default CPU speed
    Public Const const_LENCMD As Byte = 80                                      ' length of command buffers etc 

    Public HEX As String = "0123456789ABCDEF"

    Public const_BWSspalten As Long = My.Settings.BWSspalten
    Public const_BWSzeilen As Long = My.Settings.BWSzeilen
    Public const_PixelanzX As Byte = My.Settings.PixelanzX
    Public const_PixelanzY As Byte = My.Settings.PixelanzY
    Public const_cPIx As UInteger = My.Settings.PixelanzX
    Public const_cPIy As UInteger = My.Settings.PixelanzY

    Public const_NextCharTast As UInteger = My.Settings.NextCharTast
    Public const_KeyCodes As UInteger = My.Settings.KeyCodes

    Public ProgVerz As String = My.Settings.ProgVerz                            '"D:\\devel\1 DEG2000\\"

    Public FontDateinameStart As String = ""                                    'ProgVerz + "FONT\\7024-0.FNT"
    Public BinVerzeichnis As String = ""                                        'ProgVerz + "ORIG\\"
    Public COMVerzeichnis As String = ""
    Public FontVerzeichnis As String = ""
    Public MemVerzeichnis As String = ""
    Public TapeVerzeichnis As String = ""
    Public WavVerzeichnis As String = ""

    Public EBDC(0 To 255) As Byte

    Public Const S_FLAG As Byte = 128                                           ' bit definitions of CPU flags 
    Public Const Z_FLAG As Byte = 64
    Public Const F5_FLAG As Byte = 32
    Public Const H_FLAG As Byte = 16
    Public Const F3_FLAG As Byte = 8
    Public Const P_FLAG As Byte = 4
    Public Const N_FLAG As Byte = 2
    Public Const C_FLAG As Byte = 1
    '
    Public Const CPU_MEMR As Byte = 128                                         ' bit definitions for CPU bus status
    Public Const CPU_INP As Byte = 64
    Public Const CPU_M1 As Byte = 32
    Public Const CPU_OUT As Byte = 16
    Public Const CPU_HLTA As Byte = 8
    Public Const CPU_STACK As Byte = 4
    Public Const CPU_WO As Byte = 2
    Public Const CPU_INTA As Byte = 1
    Public Const CPU_NONE As Byte = 0
    '                                                                           ' operation of simulated CPU
    Public Const SINGLE_STEP As Byte = 2                                        ' single step                   ' 1.17 = 3 ?
    Public Const CONTIN_RUN As Byte = 1                                         ' continual run 
    Public Const STOPPED As Byte = 0                                            ' stop CPU because of error 

    '                                                                           ' causes of error 
    Public Const NONE As Byte = 0                                               ' no error 
    Public Const OPHALT As Byte = 1                                             ' HALT      op-code    trap 
    Public Const IOTRAP As Byte = 2                                             ' IN/OUT               trap 
    Public Const IOERROR As Byte = 3                                            ' fatal I/O error
    Public Const OPTRAP1 As Byte = 4                                            ' illegal 1 byte op-code trap
    Public Const OPTRAP2 As Byte = 5                                            ' illegal 2 byte op-code trap 
    Public Const OPTRAP4 As Byte = 6                                            ' illegal 4 byte op-code trap 
    Public Const USERINT As Byte = 7                                            ' user      interrupt 
    Public Const POWEROFF As Byte = 255                                         ' CPU off, no error

    '                                                                           ' type of CPU interrupt 
    Public Const INT_NONE As Byte = 0                                           ' 
    Public Const INT_NMI As Byte = 1                                            ' non maskable interrupt 
    Public Const INT_INT As Byte = 2                                            ' maskable interrupt 

    Public Const PTAS As Byte = 0                                               'Programmier     -Tastatur
    Public Const STAS As Byte = 1                                               'Schreibmaschinen-Tastatur

    Public Const break_flag As Boolean = True                                   'TRUE=break at HALT, FALSE=execute HALT

    Public f_flag As Byte

    Public vZ80cpu As Z80cpu
    Public Cursor(const_BWSspalten, const_BWSzeilen) As Boolean
    Public USR_REL As String
    Public FontDateiname As String
    Public BinDateiname As String

    Public PFebene As Integer                                                   'PF-Tastenebene 0...3
    Public PSTAS As Byte                                                        'PTAS or STAS
    Public LOGfile As Boolean                                                   'soll LOGfile erstellt werden oder nicht
    Public NextCharTast0 As Integer                                             'aktuelle Anzahl Tastatur-Zeichen
    Public NextCharTast1(const_NextCharTast) As Boolean                         'zeigt an ob Zeichen gültig ist
    Public NextCharTast2(const_NextCharTast) As UInt16
    Public KeyCodes1(const_KeyCodes) As String
    Public KeyCodes2(const_KeyCodes) As Byte

    Public regHistorieColors(7, 1) As Color
    '        Public Const A__Color As Byte = Color.FromArgb(192, 255, 255)                     ' A

    Public Function HexAnzeige_Byte(ByVal Wert As Byte) As String
        HexAnzeige_Byte = Mid(HEX, ((Wert And 255) \ 16) + 1, 1) + Mid(HEX, ((Wert And 255) And 15) + 1, 1)
    End Function ' HexAnzeige_Byte
    Public Function HexAnzeige_WordByte(ByVal Wert As ULong, ByVal Steuerung As String) As String
        Select Case UCase(Steuerung)
            Case "H"
                HexAnzeige_WordByte = Mid(HEX, ((Wert \ 256) \ 16) + 1, 1) + Mid(HEX, ((Wert \ 256) And 15) + 1, 1)
            Case "L"
                HexAnzeige_WordByte = Mid(HEX, ((Wert And 255) \ 16) + 1, 1) + Mid(HEX, ((Wert And 255) And 15) + 1, 1)
            Case "B"
                HexAnzeige_WordByte = Mid(HEX, ((Wert \ 256) \ 16) + 1, 1) + Mid(HEX, ((Wert \ 256) And 15) + 1, 1) +
                                      Mid(HEX, ((Wert And 255) \ 16) + 1, 1) + Mid(HEX, ((Wert And 255) And 15) + 1, 1)
            Case "B "
                HexAnzeige_WordByte = Mid(HEX, ((Wert \ 256) \ 16) + 1, 1) + Mid(HEX, ((Wert \ 256) And 15) + 1, 1) + " " +
                                      Mid(HEX, ((Wert And 255) \ 16) + 1, 1) + Mid(HEX, ((Wert And 255) And 15) + 1, 1)
            Case "S"
                HexAnzeige_WordByte = Mid(HEX, ((Wert \ 256) \ 16) + 1, 1)
            Case Else
                HexAnzeige_WordByte = ""
        End Select
    End Function ' HexAnzeige_WordByte

    Public Function Byte2SByte(ByVal b As UInt16) As SByte
        b = b And &HFF
        If b > 127 Then
            Byte2SByte = b - 256
        Else
            Byte2SByte = b
        End If
        'Byte2SByte = Convert.ToSByte(IIf(b > 127, b - 256, b))
    End Function ' Byte2SByte

    Public Function atoi(ByRef cmd As String, ByRef i As Integer) As ULong
        Dim num As ULong

        num = 0
        Do While i <= Len(cmd) And InStr(HEX, UCase(Mid(cmd, i, 1)), CompareMethod.Text) > 0 _
                               And InStr(HEX, UCase(Mid(cmd, i, 1)), CompareMethod.Text) < 11
            num = num * 10
            num = num + InStr(HEX, UCase(Mid(cmd, i, 1)), CompareMethod.Text) - 1
            i = i + 1
        Loop
        atoi = num
    End Function ' atoi
    Public Function exatoi(ByRef cmd As String, ByRef i As Integer) As ULong
        Dim num As ULong

        num = 0
        Do While i <= Len(cmd) And InStr(HEX, UCase(Mid(cmd, i, 1)), CompareMethod.Text) > 0
            num = num * 16
            num = num + InStr(HEX, UCase(Mid(cmd, i, 1)), CompareMethod.Text) - 1
            i = i + 1
        Loop
        exatoi = num
    End Function ' exatoi
    Public Function nextI(ByRef cmd As String, ByRef i As Integer) As Boolean
        Do While Mid(cmd, i, 1) = "," Or Mid(cmd, i, 1) = " "
            i = i + 1
        Loop
        If i > Len(cmd) Then
            nextI = True
        Else
            nextI = False
        End If
    End Function ' nextI
    Public Function NextHexValue(ByRef cmd As String) As Long
        Dim num As Long
        Dim i As Integer
        Dim cmd1 As String

        num = 0
        'Get next Hex-Value as string
        cmd1 = ""
        Do While Len(cmd) > 0 And Left(cmd, 1) <> "," And Left(cmd, 1) <> " "
            cmd1 = cmd1 + Left(cmd, 1)
            cmd = Right(cmd, Len(cmd) - 1)
        Loop
        If Len(cmd) > 0 Then
            cmd = Right(cmd, Len(cmd) - 1)
        End If

        'String to Value
        For i = 1 To Len(cmd1)
            If InStr(HEX, UCase(Mid(cmd1, i, 1)), CompareMethod.Text) > 0 Then
                num = num * 16
                num = num + InStr(HEX, UCase(Mid(cmd1, i, 1)), CompareMethod.Text) - 1
            Else
                num = -1
                Exit For
            End If
        Next

        '
        NextHexValue = num
    End Function ' NextHexValue

    Public Sub initGrid(obj As Object,
                        BColorView As System.Drawing.Color, BColorSelect As System.Drawing.Color,
                        FColorView As System.Drawing.Color, FColorSelect As System.Drawing.Color)
        Dim i As Integer

        With obj
            .Rows.Clear()

            Select Case UCase(obj.name)
                Case UCase("regHistory")
                    .ColumnHeadersBorderStyle = DataGridViewHeaderBorderStyle.Single
                    .ColumnHeadersDefaultCellStyle.BackColor = Color.LightGray
                    'For i = 0 To 21
                    '    .Columns(i).HeaderCell.Style.Alignment = DataGridViewContentAlignment.MiddleCenter
                    'Next i
                    '.ColumnHeadersDefaultCellStyle.Alignment = Windows.Forms.DataGridViewContentAlignment.MiddleCenter
                    Haupt.regHistory.ColumnHeadersBorderStyle = DataGridViewHeaderBorderStyle.Single
                    Haupt.regHistory.ColumnHeadersDefaultCellStyle.WrapMode = False
                    Haupt.regHistory.ColumnHeadersDefaultCellStyle.Font = New Drawing.Font("Arial", 9, FontStyle.Bold)

                    '.ColumnHeadersDefaultCellStyle.Alignment =
                    '.ColumnHeadersDefaultCellStyle.Alignment 
                    'ContentAlignment.MiddleCenter
                Case Else
                    .ColumnHeadersDefaultCellStyle.BackColor = Drawing.SystemColors.ActiveBorder
            End Select

            With .DefaultCellStyle                                                                      ' Alignment
                Select Case UCase(obj.name)
                    Case UCase("cpuStatus"),
                         UCase("CMDliste")
                        .Alignment = Windows.Forms.DataGridViewContentAlignment.MiddleLeft
                    Case UCase("HSanzeige")
                        .Alignment = Windows.Forms.DataGridViewContentAlignment.BottomRight
                        'Case UCase("regHistory")
                        '.Alignment = Windows.Forms.DataGridViewContentAlignment.MiddleCenter
                    Case Else
                        .Alignment = Windows.Forms.DataGridViewContentAlignment.MiddleCenter
                End Select
                .BackColor = Drawing.SystemColors.Control
                .ForeColor = FColorView
            End With

            '.RowTemplate.DefaultCellStyle.SelectionBackColor = Drawing.SystemColors.Control
            '.RowTemplate.DefaultCellStyle.SelectionForeColor = FColor

            Select Case UCase(obj.name)                                                                 ' Color's
                Case UCase("regAF"),
                     UCase("regBL"), UCase("regBL_")                                                    ' ursprünglich anz=2                    
                    For i = 0 To 2 Step 2
                        .Columns(i).DefaultCellStyle.BackColor = Drawing.SystemColors.Control
                        .Columns(i).DefaultCellStyle.ForeColor = Drawing.Color.DarkGray
                        .Columns(i).DefaultCellStyle.SelectionBackColor = Drawing.SystemColors.Control
                        .Columns(i).DefaultCellStyle.SelectionForeColor = Drawing.Color.DarkGray
                    Next i
                    For i = 1 To 3 Step 2
                        .Columns(i).DefaultCellStyle.BackColor = BColorView
                        .Columns(i).DefaultCellStyle.ForeColor = FColorView
                        .Columns(i).DefaultCellStyle.SelectionBackColor = BColorSelect
                        .Columns(i).DefaultCellStyle.SelectionForeColor = FColorSelect
                    Next i
                Case UCase("regXY"),
                     UCase("cpuStatus")                                                                 ' ursprünglich anz=1
                    .Columns(0).DefaultCellStyle.BackColor = Drawing.SystemColors.Control
                    .Columns(0).DefaultCellStyle.ForeColor = Drawing.Color.DarkGray
                    .Columns(0).DefaultCellStyle.SelectionBackColor = Drawing.SystemColors.Control
                    .Columns(0).DefaultCellStyle.SelectionForeColor = Drawing.Color.DarkGray

                    .Columns(1).DefaultCellStyle.BackColor = BColorView
                    .Columns(1).DefaultCellStyle.ForeColor = FColorView
                    .Columns(1).DefaultCellStyle.SelectionBackColor = BColorSelect
                    .Columns(1).DefaultCellStyle.SelectionForeColor = FColorSelect
                Case UCase("regHistory")
                    .Columns(0).HeaderCell.Style.BackColor = BColorView                                 ' PC
                    .Columns(0).HeaderCell.Style.ForeColor = FColorView
                    .Columns(0).DefaultCellStyle.BackColor = BColorView
                    .Columns(0).DefaultCellStyle.ForeColor = FColorView
                    .Columns(0).DefaultCellStyle.SelectionBackColor = BColorView
                    .Columns(0).DefaultCellStyle.SelectionForeColor = FColorView

                    .Columns(1).HeaderCell.Style.BackColor = regHistorieColors(1, 0)                    ' A
                    .Columns(1).HeaderCell.Style.ForeColor = regHistorieColors(1, 1)
                    .Columns(1).DefaultCellStyle.BackColor = regHistorieColors(1, 0)
                    .Columns(1).DefaultCellStyle.ForeColor = regHistorieColors(1, 1)

                    For i = 2 To 9                                                                      ' flag's
                        .Columns(i).HeaderCell.Style.BackColor = regHistorieColors(2, 0)
                        .Columns(i).HeaderCell.Style.ForeColor = regHistorieColors(2, 1)
                        .Columns(i).DefaultCellStyle.BackColor = regHistorieColors(2, 0)
                        .Columns(i).DefaultCellStyle.ForeColor = regHistorieColors(2, 1)
                    Next i
                    For i = 10 To 11                                                                    ' I, IFF
                        .Columns(i).HeaderCell.Style.BackColor = regHistorieColors(3, 0)
                        .Columns(i).HeaderCell.Style.ForeColor = regHistorieColors(3, 1)
                        .Columns(i).DefaultCellStyle.BackColor = regHistorieColors(3, 0)
                        .Columns(i).DefaultCellStyle.ForeColor = regHistorieColors(3, 1)
                    Next i
                    For i = 12 To 14                                                                    '      BC, DE, HL
                        .Columns(i).HeaderCell.Style.BackColor = regHistorieColors(4, 0)
                        .Columns(i).HeaderCell.Style.ForeColor = regHistorieColors(4, 1)
                        .Columns(i).DefaultCellStyle.BackColor = regHistorieColors(4, 0)
                        .Columns(i).DefaultCellStyle.ForeColor = regHistorieColors(4, 1)
                    Next i
                    For i = 15 To 18                                                                    ' AF', BC', DE', HL'
                        .Columns(i).HeaderCell.Style.BackColor = regHistorieColors(5, 0)
                        .Columns(i).HeaderCell.Style.ForeColor = regHistorieColors(5, 1)
                        .Columns(i).DefaultCellStyle.BackColor = regHistorieColors(5, 0)
                        .Columns(i).DefaultCellStyle.ForeColor = regHistorieColors(5, 1)
                    Next i
                    For i = 19 To 20                                                                    ' IX, IY
                        .Columns(i).HeaderCell.Style.BackColor = regHistorieColors(6, 0)
                        .Columns(i).HeaderCell.Style.ForeColor = regHistorieColors(6, 1)
                        .Columns(i).DefaultCellStyle.BackColor = regHistorieColors(6, 0)
                        .Columns(i).DefaultCellStyle.ForeColor = regHistorieColors(6, 1)
                    Next i

                    .Columns(21).HeaderCell.Style.BackColor = regHistorieColors(7, 0)                   ' SP
                    .Columns(21).HeaderCell.Style.ForeColor = regHistorieColors(7, 1)
                    .Columns(21).DefaultCellStyle.BackColor = regHistorieColors(7, 0)
                    .Columns(21).DefaultCellStyle.ForeColor = regHistorieColors(7, 1)
                    For i = 0 To 21
                        .Columns(i).HeaderCell.Style.Alignment = DataGridViewContentAlignment.MiddleCenter
                    Next i

                    '.RowTemplate.DefaultCellStyle.BackColor = Drawing.SystemColors.Control
                    '.RowTemplate.DefaultCellStyle.ForeColor = FColorView
                    '.RowTemplate.DefaultCellStyle.SelectionBackColor = Drawing.SystemColors.Control
                    '.RowTemplate.DefaultCellStyle.SelectionForeColor = FColorSelect
                Case Else                                                                               ' ursprünglich anz=0
                    .RowTemplate.DefaultCellStyle.BackColor = BColorView
                    .RowTemplate.DefaultCellStyle.ForeColor = FColorView
                    .RowTemplate.DefaultCellStyle.SelectionBackColor = BColorSelect
                    .RowTemplate.DefaultCellStyle.SelectionForeColor = FColorSelect
            End Select
        End With
    End Sub ' initGrid
    Public Sub PrintGrid(obj As Object, hilf() As String,
                         Optional ByVal Height1 As Long = 15)
        '                        Optional ByVal FColor As ColorDepth = &HFFA9A9A9)
        Dim DisplayAnz As Integer
        With obj
            '            .DefaultCellStyle.ForeColor = QBColor(FColor)
            .Rows.Add(hilf)
            .Rows(.Rows.Count - 1).Height = Height1

            Select Case UCase(obj.name)
                Case UCase("CMDliste"),
                     UCase("regHistory")

                    If .Rows.Count > 0 Then
                        DisplayAnz = .displayedrowcount(True) - 1
                        If .Rows.Count > DisplayAnz Then
                            .FirstDisplayedScrollingRowIndex = .Rows.Count - 1 - DisplayAnz '.DisplayedRowCount(True)
                        End If
                    End If
            End Select

            Select Case UCase(obj.name)                                                                             ' damit letzte Zeile auch dargestellt wird
                Case UCase("CMDliste"),
                     UCase("regHistory")
                    If obj.Rows.Count > 2 Then
                        obj.CurrentCell.Selected = False
                        obj.CurrentCell = obj.Item(0, obj.Rows.Count - 2)
                        obj.FirstDisplayedScrollingRowIndex = obj.Rows.Count - 1
                    End If
            End Select
        End With
    End Sub ' PrintGrid
    Public Sub PrintGridColor(obj As Object, BColorView As Drawing.Color, FColorView As Drawing.Color, BColorSelect As Drawing.Color, FColorSelect As Drawing.Color)
        With obj
            .RowTemplate.DefaultCellStyle.BackColor = BColorView
            .RowTemplate.DefaultCellStyle.ForeColor = FColorView
            .RowTemplate.DefaultCellStyle.SelectionBackColor = BColorSelect
            .RowTemplate.DefaultCellStyle.SelectionForeColor = FColorSelect
        End With
    End Sub ' PrintGrid

    ' Left in VB.NET nachgebaut
    Public Function LeftString(ByVal sText As String, ByVal nLen As Integer) As String
        If nLen > sText.Length Then nLen = sText.Length
        Return (sText.Substring(0, nLen))
    End Function
    ' Right in VB.NET nachgebaut
    Public Function RightString(ByVal sText As String, ByVal nLen As Integer) As String
        If nLen > sText.Length Then nLen = sText.Length
        Return (sText.Substring(sText.Length - nLen))
    End Function

#Region "zentrale Routinen"
    Public Sub inc(ByRef par1 As Byte, Optional ByRef par2 As Byte = 0)
        Call COMMON.vZ80cpu.FlagHflag1((par1 And &HF) + 1 > &HF)
        Call COMMON.vZ80cpu.RegPlus1(par1)

        Call COMMON.vZ80cpu.FlagPflag1(par1 = &H80)
        Call COMMON.vZ80cpu.FlagSflag1((par1 And &H80))
        Call COMMON.vZ80cpu.FlagZflag2(par1 <> 0)
        Call COMMON.vZ80cpu.FlagNflag2()

        If par2 > 0 Then par2 = par1
    End Sub ' inc
    Public Sub dec(ByRef par1 As Byte, Optional ByRef par2 As Byte = 0)
        'Call COMMON.vZ80cpu.FlagHflag1(((CInt(par1) - 1) And &HF))
        par1 = (CInt(par1) - 1) And &HFF
        Call COMMON.vZ80cpu.FlagHflag1(par1 And &HF)
        Call COMMON.vZ80cpu.FlagPflag1(par1 = &H7F)
        Call COMMON.vZ80cpu.FlagSflag1(par1 And &H80)
        Call COMMON.vZ80cpu.FlagZflag2(par1 <> 0)
        Call COMMON.vZ80cpu.FlagNflag1()

        If par2 > 0 Then par2 = par1
    End Sub ' dec
    Public Sub add(ByVal par1 As Byte)
        Dim i As Integer
        Dim j As SByte

        Call COMMON.vZ80cpu.FlagHflag1((COMMON.vZ80cpu.A And &HF) + (par1 And &HF) > &HF)
        Call COMMON.vZ80cpu.FlagCflag1(CInt(COMMON.vZ80cpu.A) + CInt(par1) > 255)
        i = CInt(COMMON.vZ80cpu.A) + CInt(par1)         'CInt(COMMON.Byte2SByte(COMMON.vZ80cpu.A)) + CInt(COMMON.Byte2SByte(par1))
        j = COMMON.Byte2SByte(i)
        COMMON.vZ80cpu.A = i And &HFF

        Call COMMON.vZ80cpu.FlagPflag1((j < -128) Or (j > 127))
        Call COMMON.vZ80cpu.FlagSflag1((i And &H80))
        Call COMMON.vZ80cpu.FlagZflag2(COMMON.vZ80cpu.A <> 0)
        Call COMMON.vZ80cpu.FlagNflag2()
    End Sub ' add
    Public Sub adc(ByVal par1 As Byte)
        Dim i As Integer
        Dim j As SByte
        Dim carry As Integer

        If (COMMON.vZ80cpu.F And COMMON.C_FLAG) = COMMON.C_FLAG Then carry = 1 Else carry = 0
        Call COMMON.vZ80cpu.FlagHflag1((COMMON.vZ80cpu.A And &HF) + (par1 And &HF) + carry > &HF)
        Call COMMON.vZ80cpu.FlagCflag1(CInt(COMMON.vZ80cpu.A) + CInt(par1) + carry > 255)
        i = CInt(COMMON.vZ80cpu.A) + CInt(par1) + carry           'i = CInt(COMMON.Byte2SByte(COMMON.vZ80cpu.A)) + CInt(COMMON.Byte2SByte(par1)) + carry
        j = COMMON.Byte2SByte(i)
        COMMON.vZ80cpu.A = i And &HFF

        Call COMMON.vZ80cpu.FlagPflag1((j < -128) Or (j > 127))
        Call COMMON.vZ80cpu.FlagSflag1((i And &H80))
        Call COMMON.vZ80cpu.FlagZflag2(COMMON.vZ80cpu.A <> 0)
        Call COMMON.vZ80cpu.FlagNflag2()
    End Sub ' adc
    Public Sub sub1(ByVal par1 As Byte)
        Dim i As Integer

        Call COMMON.vZ80cpu.FlagHflag1((par1 And &HF) > (COMMON.vZ80cpu.A And &HF))
        Call COMMON.vZ80cpu.FlagCflag1(par1 > COMMON.vZ80cpu.A)
        i = CInt(COMMON.vZ80cpu.A) - CInt(par1)         'i = CInt(COMMON.Byte2SByte(COMMON.vZ80cpu.A)) - CInt(COMMON.Byte2SByte(par1))
        COMMON.vZ80cpu.A = i And &HFF

        Call COMMON.vZ80cpu.FlagPflag1((i < -128) Or (i > 127))
        Call COMMON.vZ80cpu.FlagSflag1((i And &H80))
        Call COMMON.vZ80cpu.FlagZflag2(COMMON.vZ80cpu.A <> 0)
        Call COMMON.vZ80cpu.FlagNflag1()
    End Sub ' sub
    Public Sub sbc(ByVal par1 As Byte)
        Dim i As Integer
        Dim carry As Integer

        If (COMMON.vZ80cpu.F And COMMON.C_FLAG) = COMMON.C_FLAG Then carry = 1 Else carry = 0
        Call COMMON.vZ80cpu.FlagHflag1((CInt(par1) And &HF) + carry > (COMMON.vZ80cpu.A And &HF))
        Call COMMON.vZ80cpu.FlagCflag1(CInt(par1) + carry > COMMON.vZ80cpu.A)
        i = CInt(COMMON.vZ80cpu.A) - CInt(par1) - carry                 'i = CInt(COMMON.Byte2SByte(COMMON.vZ80cpu.A)) - CInt(COMMON.Byte2SByte(par1)) - carry
        COMMON.vZ80cpu.A = i And &HFF

        Call COMMON.vZ80cpu.FlagPflag1((i < -128) Or (i > 127))
        Call COMMON.vZ80cpu.FlagSflag1((i And &H80))
        Call COMMON.vZ80cpu.FlagZflag2(COMMON.vZ80cpu.A <> 0)
        Call COMMON.vZ80cpu.FlagNflag1()
    End Sub ' sbc
    Public Sub and1(ByVal par1 As Byte)
        COMMON.vZ80cpu.A = COMMON.vZ80cpu.A And par1
        Call COMMON.vZ80cpu.FlagSflag1((COMMON.vZ80cpu.A And &H80))
        Call COMMON.vZ80cpu.FlagZflag2(COMMON.vZ80cpu.A <> 0)
        Call COMMON.vZ80cpu.FlagPflag2(COMMON.vZ80cpu.parrity(COMMON.vZ80cpu.A) = 1)
        COMMON.vZ80cpu.F = COMMON.vZ80cpu.F Or H_FLAG
        COMMON.vZ80cpu.F = COMMON.vZ80cpu.F And Not (N_FLAG Or C_FLAG)
    End Sub ' and
    Public Sub or1(ByVal par1 As Byte)
        COMMON.vZ80cpu.A = COMMON.vZ80cpu.A Or par1
        Call COMMON.vZ80cpu.FlagSflag1((COMMON.vZ80cpu.A And &H80))
        Call COMMON.vZ80cpu.FlagZflag2(COMMON.vZ80cpu.A <> 0)
        Call COMMON.vZ80cpu.FlagPflag2(COMMON.vZ80cpu.parrity(COMMON.vZ80cpu.A) = 1)
        COMMON.vZ80cpu.F = COMMON.vZ80cpu.F And Not (COMMON.H_FLAG Or COMMON.N_FLAG Or COMMON.C_FLAG)
    End Sub ' or1
    Public Sub xor1(ByVal par1 As Byte)
        COMMON.vZ80cpu.A = COMMON.vZ80cpu.A Xor par1
        Call COMMON.vZ80cpu.FlagSflag1((COMMON.vZ80cpu.A And &H80))
        Call COMMON.vZ80cpu.FlagZflag2(COMMON.vZ80cpu.A <> 0)
        Call COMMON.vZ80cpu.FlagPflag2(COMMON.vZ80cpu.parrity(COMMON.vZ80cpu.A) = 1)
        COMMON.vZ80cpu.F = COMMON.vZ80cpu.F And Not (COMMON.H_FLAG Or COMMON.N_FLAG Or COMMON.C_FLAG)
    End Sub ' xor
#End Region
End Module
