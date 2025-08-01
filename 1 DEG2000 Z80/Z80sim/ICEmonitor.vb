Imports System
Imports System.IO
Imports System.Windows.Forms.VisualStyles.VisualStyleElement.ToolTip
Imports System.Windows.Input

Module ICEmonitor
    Public Cmd1 As String
    Public Cmd2 As String
    Public Cmd3 As Integer
    Public Cmd4 As Integer
    Public ramList As ULong

    Private ICEmonitorEnable As Boolean
    Private wrk_ram As ULong

    Public Sub EnableICE(ByVal Enable As Boolean)
        ICEmonitorEnable = Enable
    End Sub ' EnableICE

    Private Sub dohelp()
        Try
            '                                                                       Output help text
            Call COMMON.PrintGrid(Haupt.CMDliste, {"==> ?"})
            Call COMMON.PrintGrid(Haupt.CMDliste, {"r filename[,address]      read object into memory"})
            Call COMMON.PrintGrid(Haupt.CMDliste, {"d [address]               dump             memory"})
            Call COMMON.PrintGrid(Haupt.CMDliste, {"l [address]               list             memory"})
            Call COMMON.PrintGrid(Haupt.CMDliste, {"m [address]               modify           memory"})
            Call COMMON.PrintGrid(Haupt.CMDliste, {"f address,count,value     fill             memory"})
            Call COMMON.PrintGrid(Haupt.CMDliste, {"v from,to,count           move             memory"})
            Call COMMON.PrintGrid(Haupt.CMDliste, {"p address                 show/modify port       "})
            Call COMMON.PrintGrid(Haupt.CMDliste, {"g [address]               run         program    "})
            Call COMMON.PrintGrid(Haupt.CMDliste, {"t [count]                 trace       program    "})
            Call COMMON.PrintGrid(Haupt.CMDliste, {"ENTER                     single step program    "})
            Call COMMON.PrintGrid(Haupt.CMDliste, {"x [register]              show/modify register   "})
            Call COMMON.PrintGrid(Haupt.CMDliste, {"x f<flag>                 modify flag            "})
            Call COMMON.PrintGrid(Haupt.CMDliste, {"b[no] address[,pass]      set   soft breakpoint  "})
            Call COMMON.PrintGrid(Haupt.CMDliste, {"b                         show  soft breakpoints "})
            Call COMMON.PrintGrid(Haupt.CMDliste, {"b[no] c                   clear soft breakpoint  "})
            Call COMMON.PrintGrid(Haupt.CMDliste, {"h [address]               show  history          "})
            Call COMMON.PrintGrid(Haupt.CMDliste, {"h c                       clear history          "})
            Call COMMON.PrintGrid(Haupt.CMDliste, {"z start,stop              set trigger adr for t-state count"})
            Call COMMON.PrintGrid(Haupt.CMDliste, {"z                         show                t-state count"})
            Call COMMON.PrintGrid(Haupt.CMDliste, {"c                         measure clock frequency"})
            Call COMMON.PrintGrid(Haupt.CMDliste, {"s                         show settings          "})
            '       Call COMMON.PrintGrid(Haupt.CMDliste, {"! command                 execute UNIX command"})
            Call COMMON.PrintGrid(Haupt.CMDliste, {"q                         quit"})
        Catch ex As Exception
        End Try
    End Sub ' dohelp

    Private Sub doanzeige()
        Dim cmd As String

        cmd = UCase(Haupt.CommandLine.Text)
        If Len(cmd) > 2 Then
            cmd = Right(cmd, Len(cmd) - 2)
            Select Case cmd
                Case UCase("Test1")
                    Call BWS.TestBild(1)
                Case UCase("Test2")
                    Call BWS.TestBild(2)
                Case UCase("CR")
                    Call BWS.TestBild(0)
                Case UCase("clear")
                    Call BWS.TestBild(9)
            End Select
        End If
    End Sub ' doanzeige

    Private Sub dostep()
        Dim p As ULong

        Try
            Call Haupt.cpuState(COMMON.SINGLE_STEP)
            Call Haupt.cpuError(COMMON.NONE)
            '
            '            Call COMMON.PrintGrid(Haupt.CMDliste, {"==> "})
            p = COMMON.vZ80cpu.PC                                                   'CPU-Befehl disassemblieren
            Call Disass.disass(p)
            '
            Call Haupt.cpu.cpu()                                                    'CPU-Befehl ausführen
            '
            If COMMON.vZ80cpu.cpu_error = COMMON.OPHALT Then
                Call handelbreak()
            End If
            'Call cpu_err_msg()
            Call Haupt.PrintReg()

            If Haupt.HSAnzeigenVis1.Checked Then AnzeigeHS.SpeicherAnzeigen()
            If Haupt.BufferAnzeigenVis.Checked Then Call AnzeigeBuffer.AnzeigeBuffer1()
        Catch ex As Exception
            MsgBox("ICEmonitor.dostep: " + ex.Message)
        End Try
    End Sub ' dostep

    Private Sub dogo()                                                         'Run the CPU emulation endless
        Dim i As Integer
        Dim cmd As String

        If Tastatur.Visible Then                                                'Für Tastarureingabe aktives Fenster ändern
            Tastatur.Select()
        Else
            If BWS.Visible Then
                BWS.Select()
            End If
        End If

        cmd = UCase(Haupt.CommandLine.Text) : i = 2
        Haupt.CommandLine.Text = ""
        If Not COMMON.nextI(cmd, i) Then
            COMMON.vZ80cpu.PC = exatoi(cmd, i)
        End If

cont:
        Call Haupt.cpuState(COMMON.CONTIN_RUN)
        Call Haupt.cpuError(COMMON.NONE)

        Call COMMON.PrintGrid(Haupt.CMDliste, {"==> " + cmd})

        Call Haupt.cpu.cpu()
        System.Windows.Forms.Application.DoEvents()

        If COMMON.vZ80cpu.cpu_error = COMMON.OPHALT Then
            If Not handelbreak() Then
                If COMMON.vZ80cpu.cpu_error = COMMON.NONE Then GoTo cont
            Else
                Call Haupt.RegisterAnzeigenClick()
            End If
        End If

        'cpu_err_msg;
        Call Haupt.PrintReg()
    End Sub ' dogo

    Private Sub dodump()
        'Dim i, j As Integer
        'Dim byte1 As Byte
    End Sub ' dodump

    Private Sub dolist()
        Dim i As Integer
        Dim cmd As String

        cmd = UCase(Haupt.CommandLine.Text) : i = 2
        If Not COMMON.nextI(cmd, i) Then
            wrk_ram = exatoi(cmd, i)
        Else
            wrk_ram = ramList
        End If

        For i = 1 To 10
            wrk_ram = Disass.disass(wrk_ram)
            If wrk_ram > 65535 Then
                wrk_ram = 0
            End If
        Next i
        ramList = wrk_ram
    End Sub ' dolist


    Private Function handelbreak() As Boolean
        '	Handling of software breakpoints (HALT opcode):
        '
        '	Output:	True  ... breakpoint or other HALT opcode reached     (stop    )
        '	   	    False ... breakpoint reached, passcounter not reached (continue)
#If SBSIZE0 = 0 Then
        handel_break=False 
        Exit Function
#Else
        Dim i As Long
        Dim ibreak As Long

        ibreak = COMMON.vZ80cpu.PC - 1                                          ' store adr of breakpoint
        For i = 1 To COMMON.SBSIZE
            If COMMON.vZ80cpu.soft(i).sb_adr = ibreak Then
                GoTo was_softbreak
            End If
        Next
        handelbreak = False
        Exit Function

was_softbreak:
#If HISIZE0 = 1 Then
        '! Todo: 'correct history
#End If

        Call Haupt.cpuError(COMMON.NONE)                                                                                    ' HALT was a breakpoint
        COMMON.vZ80cpu.PCminus1()                                                                                           ' substitute HALT opcode by
        Call COMMON.vZ80cpu.Speicher_schreiben_Byte(COMMON.vZ80cpu.soft(i).sb_adr, COMMON.vZ80cpu.soft(i).sb_oldopc)        '                 original opcode
        Call Haupt.cpuState(COMMON.SINGLE_STEP)                                                                             ' and execute it
        Call Haupt.cpu.cpu()
        Call COMMON.vZ80cpu.Speicher_schreiben_Byte(COMMON.vZ80cpu.soft(i).sb_adr, &H76)                                    ' restore HALT opcode again
        COMMON.vZ80cpu.soft(i).sb_passcount = COMMON.vZ80cpu.soft(i).sb_passcount + 1                                       ' increment passcounter
        If COMMON.vZ80cpu.soft(i).sb_passcount <> COMMON.vZ80cpu.soft(i).sb_pass Then
            handelbreak = False
            Exit Function
        End If
        Call COMMON.PrintGrid(Haupt.CMDliste, {"Software breakpoint " + Format(i) + " reached at " + COMMON.vZ80cpu.HexAnzeigeWordByte(ibreak, "B")})
        COMMON.vZ80cpu.soft(i).sb_passcount = 0
        handelbreak = True
        Exit Function
#End If
    End Function ' handelbreak

    Private Sub dobreak()                                                     ' Software breakpoints
#If SBSIZE0 = 0 Then
        Call COMMON.PrintGrid(Haupt.CMDliste, {"==> b"})
        Call COMMON.PrintGrid(Haupt.CMDliste, {"    Sorry, no breakpoints available."})
        Call COMMON.PrintGrid(Haupt.CMDliste, {"    Please recompile with SBSIZE0=1."})
#Else
        Dim ibreak As Long
        Dim iaddr As Long
        Dim ipass As Long
        Dim cmd As String

        If COMMON.SBSIZE <= 0 Then
            Call COMMON.PrintGrid(Haupt.CMDliste, {"==> b"})
            Call COMMON.PrintGrid(Haupt.CMDliste, {"    Sorry, no breakpoints available."})
            Call COMMON.PrintGrid(Haupt.CMDliste, {"    Please recompile with COMMON.SBSIZE>0."})
            Exit Sub
        End If

        cmd = UCase(Haupt.CommandLine.Text)
        If Len(cmd) = 1 Then
            Call dobreak1()
            Exit Sub
        End If

        cmd = Right(cmd, Len(cmd) - 1)
        ibreak = COMMON.NextHexValue(cmd)
        Select Case ibreak
            Case -1
                Call COMMON.PrintGrid(Haupt.CMDliste, {"==> " + Haupt.CommandLine.Text})
                Call COMMON.PrintGrid(Haupt.CMDliste, {"    Input Error by break point number"})
                Exit Sub
            Case 0
                COMMON.vZ80cpu.sb_next = COMMON.vZ80cpu.sb_next + 1
                ibreak = COMMON.vZ80cpu.sb_next
                If COMMON.vZ80cpu.sb_next = COMMON.SBSIZE Then
                    COMMON.vZ80cpu.sb_next = 0
                End If
            Case Else
        End Select

        If ibreak > COMMON.SBSIZE Then
            Call COMMON.PrintGrid(Haupt.CMDliste, {"==> b"})
            Call COMMON.PrintGrid(Haupt.CMDliste, {"    breakpoint " + Format(ibreak) + " not available"})
            Exit Sub
        End If

        If Len(cmd) = 1 And UCase(cmd) = "C" Then   'clear soft break point
            Call COMMON.vZ80cpu.Speicher_schreiben_Byte(COMMON.vZ80cpu.soft(ibreak).sb_adr, COMMON.vZ80cpu.soft(ibreak).sb_oldopc)
            COMMON.vZ80cpu.soft(ibreak).sb_adr = 0
            COMMON.vZ80cpu.soft(ibreak).sb_oldopc = 0
            COMMON.vZ80cpu.soft(ibreak).sb_passcount = 0
            COMMON.vZ80cpu.soft(ibreak).sb_pass = 0
        Else
            If COMMON.vZ80cpu.soft(ibreak).sb_pass <> 0 Then
                Call COMMON.vZ80cpu.Speicher_schreiben_Byte(COMMON.vZ80cpu.soft(ibreak).sb_adr, COMMON.vZ80cpu.soft(ibreak).sb_oldopc)
            End If
            iaddr = COMMON.NextHexValue(cmd)
            If iaddr = -1 Then
                Call COMMON.PrintGrid(Haupt.CMDliste, {"==> " + Haupt.CommandLine.Text})
                Call COMMON.PrintGrid(Haupt.CMDliste, {"    Input Error by Address"})
                Exit Sub
            End If
            COMMON.vZ80cpu.soft(ibreak).sb_adr = iaddr
            COMMON.vZ80cpu.soft(ibreak).sb_oldopc = COMMON.vZ80cpu.Speicher_lesen_Byte(iaddr)
            Call COMMON.vZ80cpu.Speicher_schreiben_Byte(iaddr, &H76)            ' HALT Befehl
            If Len(cmd) > 0 Then
                ipass = COMMON.NextHexValue(cmd)
                If ipass = -1 Then
                    COMMON.vZ80cpu.soft(ibreak).sb_pass = 1
                Else
                    COMMON.vZ80cpu.soft(ibreak).sb_pass = ipass
                End If
            Else
                COMMON.vZ80cpu.soft(ibreak).sb_pass = 1
            End If
            COMMON.vZ80cpu.soft(ibreak).sb_passcount = 0
        End If
        Call dobreak1()
#End If
    End Sub ' dobreak
    Private Sub dobreak1()
        Call COMMON.PrintGrid(Haupt.CMDliste, {"==> " + Haupt.CommandLine.Text})
        Call COMMON.PrintGrid(Haupt.CMDliste, {"    No Addr Pass  Counter"})
        For i = 0 To COMMON.SBSIZE
            If COMMON.vZ80cpu.soft(i).sb_pass Then
                Call COMMON.PrintGrid(Haupt.CMDliste, {"    " + Format(i, "00") +
                                                       " " + COMMON.vZ80cpu.HexAnzeigeWordByte(COMMON.vZ80cpu.soft(i).sb_adr, "B") +
                                                       " " + Format(COMMON.vZ80cpu.soft(i).sb_pass, "00000") +
                                                       " " + Format(COMMON.vZ80cpu.soft(i).sb_passcount, "00000")})
            End If
        Next
    End Sub ' dobreak1

    Private Function dogetfile() As Integer
        '                                                                       Read a file into the memory of the emulated CPU.
        '                                                                       The following file formats are supported:
        '                                                                           binary images with Mostek header
        Dim i As Integer
        Dim ii As Integer
        Dim cmd As String
        Dim cm As String

        cmd = UCase(Haupt.CommandLine.Text) : i = 2
        Do While Mid(cmd, i, 1) = " " : i = i + 1 : Loop

        If i > Len(cmd) Then GoTo ende
        ii = 0
        cm = ""
        Do While i <= Len(cmd) And Mid(cmd, i, 1) <> ","
            cm = cm + Mid(cmd, i, 1)
            ii = ii + 1
            i = i + 1
        Loop
        If cm = "" Then
            MsgBox("ICEmonitor.dogetfile: " + "No input file given")
            i = 1
            GoTo ende
        End If
        COMMON.BinDateiname = COMMON.BinVerzeichnis + "\" + cm + ".bin"

        Call BWS.TestBild(9)
        Select Case MostekLaden(cm)
            Case 0
                Haupt.RegisterAnzeigen.Checked = False
                Call Haupt.RegisterAnzeigenChange()
                Call Haupt.InitTastBuffer()

                Call COMMON.PrintGrid(Haupt.CMDliste, {"==> " + cmd})

                If i <= Len(cmd) And Mid(cmd, i, 1) = "," Then
                    i = i + 1
                    wrk_ram = exatoi(cmd, i)
                    COMMON.vZ80cpu.PC = wrk_ram
                Else
                    '    '            wrk_ram = 0
                End If

                '    COMMON.vZ80cpu.PC = wrk_ram
                Call Haupt.PrintReg()
        End Select
ende:
        dogetfile = 0
    End Function ' do_getfile
    Private Function MostekLaden(ByVal cm As String) As Integer
        Dim err As Integer
        Dim fb(0 To &H28) As Byte
        'Dim BINfile As String

        err = 0
        cm = "\" + cm + ".bin"
        cm = COMMON.BinVerzeichnis + cm
        err = MostekLaden1(cm)

ende:
        MostekLaden = err
    End Function
    Private Function MostekLaden1(ByVal BINfile As String) As Integer
        Dim i, err As Integer
        Dim fb(0 To &H28) As Byte
        Dim PixelAnz, x, y As Integer
        Dim HSbereich As Integer
        Dim NextBINfile As String

        err = 0
        Try
            Dim fi As FileInfo
            fi = New FileInfo(BINfile)
            Dim fs As FileStream = fi.OpenRead
            fs.Read(fb, 0, 32)                                                  ' ersten 32 Byte laden
            fs.Close()
        Catch ex As Exception
            MsgBox("ICEmonitor.MostekLaden: " + "can't open file " + BINfile)
            err = 2
            GoTo ende
        End Try

        Select Case fb(0)                                                       ' Mostek heder
            Case &HFF                                                           ' Mostek header Standard = &HFF
                wrk_ram = 0
                err = loadmos(BINfile, 1, 1, &HFF)
                Call BWS.Init2()
            Case &HEF                                                           ' Einzeldatei in beliebigen Speicher laden
                HSbereich = fb(13)                                              ' HS-Bereich laden
                If HSbereich > Z80cpu.cSeg_HS Or HSbereich < 0 Then
                    MsgBox("ICEmonitor.MostekLaden: " + "HS-Bereich to great " + HSbereich.ToString() & vbCrLf & "in '" + BINfile + "'")
                    err = 22
                    GoTo ende
                End If

                err = loadmos(BINfile, 12, HSbereich, &HF0)                     ' Daten einlesen
                If err > 0 Then GoTo ende                                       ' Bei Fehler --> Abbruch

            Case &HFE                                                           ' abgeändert M.Herbote für Programm-Parameter
                Select Case fb(1)                                               ' PixelAnz = 1 | 2 | 3
                    Case 1, 2, 3
                        PixelAnz = fb(1)
                    Case Else
                        MsgBox("ICEmonitor.MostekLaden: " + "unknown PixelAnz, can't load file " + BINfile)
                        err = 4
                        GoTo ende
                End Select
                If fb(2) > COMMON.const_BWSzeilen Then                          ' BWSy
                    MsgBox("ICEmonitor.MostekLaden: " + "ZeilenAnz zu groß, can't load file " + BINfile)
                    err = 5
                    GoTo ende
                Else
                    y = fb(2)
                End If
                If fb(3) > COMMON.const_BWSspalten Then                         ' BWSx
                    MsgBox("ICEmonitor.MostekLaden: " + "SpaltenAnz zu groß, can't load file " + BINfile)
                    err = 6
                    GoTo ende
                Else
                    x = fb(3)
                End If
                Call Haupt.SetPixelGroesse(PixelAnz)
                Call BWS.Init(x, y)

                wrk_ram = 0
                err = loadmos(BINfile, 28, 1, &HFE)
                GoTo ende
            Case &HF0
                NextBINfile = ""                                                ' Next BIN-File-Dateiname einlesen
                For i = 1 To 28
                    If fb(i) = &H0 Then Exit For
                    NextBINfile = NextBINfile + Convert.ToChar(fb(i))
                Next
                If i = 1 Then
                    MsgBox("ICEmonitor.MostekLaden: " + "No next BIN-Filename")
                    err = 20
                    GoTo ende
                ElseIf i > 28 Then                                                  ' wenn kein &H00 als Abschluss, dann Fehler
                    MsgBox("ICEmonitor.MostekLaden: " + "next BIN-Filename too long " + NextBINfile)
                    err = 21
                    GoTo ende
                End If

                HSbereich = fb(29)                                              ' HS-Bereich laden
                If HSbereich > Z80cpu.cSeg_HS Or HSbereich < 0 Then
                    MsgBox("ICEmonitor.MostekLaden: " + "HS-Bereich to great " + HSbereich.ToString() & vbCrLf & "in '" + BINfile + "'")
                    err = 22
                    GoTo ende
                End If

                err = loadmos(BINfile, 28, HSbereich, &HF0)                     ' Daten einlesen
                If err > 0 Then GoTo ende                                       ' Bei Fehler --> Abbruch

                NextBINfile = COMMON.BinVerzeichnis + "\" + NextBINfile + ".bin"
                err = MostekLaden1(NextBINfile)
            Case Else
                MsgBox("ICEmonitor.MostekLaden: " + "unknown format, can't load file " + BINfile)
                err = 3
                GoTo ende
        End Select

ende:
        MostekLaden1 = err
    End Function
    Private Function loadmos(ByVal pfn As String, ByVal anz As Integer, ByVal HSbereich As Integer, ByVal FirstByte As Byte) As Integer
        '                                                                       Loader for binary images with Mostek header.
        '                                                                       Format of the first 3 bytes:
        '                                                                             0xff ll  lh
        '                                                                                      lh = load address high
        '                                                                                  ll = load address low
        Dim rc As Integer
        Dim w As Integer
        Dim count As Integer
        Dim readed As Integer
        Dim a As Integer
        Dim PC As Integer

        Dim fb(0 To 32) As Byte
        Dim fi As FileInfo

        rc = 0
        COMMON.vZ80cpu.ChangeHSbereich(HSbereich)
        Try
            fi = New FileInfo(pfn)
            Dim fs As FileStream = fi.OpenRead
            fs.Read(fb, 0, anz)

            If anz > 1 Then                                                         ' read PC
                fs.Read(fb, 0, 2)
                PC = fb(1) * 256 + fb(0)
            End If

            fs.Read(fb, 0, 2)                                                       ' read load address
            'If wrk_ram = 0 Then                                                     ' and set if not given
            wrk_ram = (fb(1) * 256 + fb(0))
            'End If

            count = &HFFFF - wrk_ram
            readed = 0
            w = wrk_ram
            Do
                a = fs.Read(fb, 0, 1)
                COMMON.vZ80cpu.Speicher_schreiben_Byte(wrk_ram, fb(0))
                wrk_ram = wrk_ram + 1
                count = count - 1
                readed = readed + 1
                If wrk_ram > &HFFFF Then
                    rc = 1
                End If
            Loop Until a = 0 Or wrk_ram > &HFFFF
            fs.Close()
        Catch ex As Exception

        End Try
        wrk_ram = w

        Call COMMON.PrintGrid(Haupt.CMDliste, {"Loader statistics for file " + pfn + ":"})
        Call COMMON.PrintGrid(Haupt.CMDliste, {"START : " + COMMON.HexAnzeige_WordByte(wrk_ram, "B") + " Bereich: " + HSbereich.ToString()})
        Call COMMON.PrintGrid(Haupt.CMDliste, {"END   : " + COMMON.HexAnzeige_WordByte(wrk_ram + readed - 1, "B")})
        Call COMMON.PrintGrid(Haupt.CMDliste, {"LOADED: " + COMMON.HexAnzeige_WordByte(readed, "B")})
        Select Case FirstByte
            Case &HFE
                Call COMMON.PrintGrid(Haupt.CMDliste, {"PC    : " + COMMON.HexAnzeige_WordByte(PC, "B")})
                COMMON.vZ80cpu.PC = PC
            Case Else
                COMMON.vZ80cpu.PC = w
        End Select
        Haupt.Refresh()

        loadmos = rc
    End Function ' loadmos

    Private Sub domodify()                                                     ' Memory change
        Dim i As Integer
        Dim cmd As String
        Dim gef As Boolean

        cmd = UCase(Haupt.CommandLine.Text)
        i = 2 : Do While Mid(cmd, i, 1) = " " : i = i + 1 : Loop : If i > Len(cmd) Then GoTo ende
        cmd = Right(cmd, Len(cmd) - i + 1)

        gef = True
        For i = 1 To Len(cmd)
            Select Case UCase(Mid(cmd, i, 1))
                Case "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F"
                Case Else
                    gef = False
            End Select
        Next

        If gef And Len(cmd) = 4 Then
            wrk_ram = (InStr(COMMON.HEX, Mid(cmd, 1, 1), CompareMethod.Text) - 1) * 4096 +
                      (InStr(COMMON.HEX, Mid(cmd, 2, 1), CompareMethod.Text) - 1) * 256 +
                      (InStr(COMMON.HEX, Mid(cmd, 3, 1), CompareMethod.Text) - 1) * 16 +
                      (InStr(COMMON.HEX, Mid(cmd, 4, 1), CompareMethod.Text) - 1)
            Cmd1 = "m"
            Cmd3 = 2
            Haupt.CommandLineBez.Rows(0).Cells(0).Value = "==> m   " + COMMON.HexAnzeige_WordByte(wrk_ram, "H") + COMMON.HexAnzeige_WordByte(wrk_ram, "L") + " = " +
                                                                       COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.Speicher_lesen_Byte(wrk_ram)) + " :"
        End If

ende:
    End Sub ' domodify
    Private Sub domodifymodify()
        Dim i As Integer
        Dim gef As Boolean
        gef = True : i = 0

        For i = 1 To Len(Haupt.CommandLine.Text)
            Select Case UCase(Mid(Haupt.CommandLine.Text, i, 1))
                Case "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F"
                Case Else
                    gef = False
            End Select
        Next

        If gef And Len(Haupt.CommandLine.Text) = 2 Then
            COMMON.vZ80cpu.Speicher_schreiben_Byte(wrk_ram, doregByte)
            wrk_ram = wrk_ram + 1
            If wrk_ram > &HFFFF Then wrk_ram = 0
            Haupt.CommandLineBez.Rows(0).Cells(0).Value = "==> m   " + COMMON.HexAnzeige_WordByte(wrk_ram, "H") + COMMON.HexAnzeige_WordByte(wrk_ram, "L") + " = " +
                                                                       COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.Speicher_lesen_Byte(wrk_ram)) + " :"
            Call AnzeigeHS.SpeicherAnzeigen(100)
            Haupt.CommandLine.Text = ""
        End If
    End Sub ' domodifymodify

    Private Sub dofill()                                                       ' Memory fill
        Dim i As Integer
        Dim j As ULong
        Dim p As ULong
        Dim val As Byte
        Dim cmd As String

        cmd = UCase(Haupt.CommandLine.Text)
        i = 2 : If COMMON.nextI(cmd, i) Then GoTo ende
        j = COMMON.exatoi(cmd, i)
        If j < 0 Then
            MsgBox("ICEmonitor.dofill: " + "adr_err")
            GoTo ende
        End If
        p = j                                                                   ' Speicheradresse
        If COMMON.nextI(cmd, i) Then GoTo ende
        j = exatoi(cmd, i)                                                      ' Anzahl (count) 
        If COMMON.nextI(cmd, i) Then GoTo ende
        val = exatoi(cmd, i)                                                    ' Fillbyte
        Do While j > 0
            COMMON.vZ80cpu.Speicher_schreiben_Byte(p, val)
            p = p + 1 : If (p > 65535) Then p = 0
            j = j - 1
        Loop
        Call COMMON.PrintGrid(Haupt.CMDliste, {"==> " + cmd})
        Call AnzeigeHS.SpeicherAnzeigen(100)

ende:
    End Sub ' dofill

    Private Sub domove()
        Dim i As Integer
        Dim j As ULong
        Dim p1, p2 As ULong
        Dim cmd As String

        cmd = UCase(Haupt.CommandLine.Text)
        i = 2 : If COMMON.nextI(cmd, i) Then GoTo ende
        j = COMMON.exatoi(cmd, i)
        If j < 0 Then
            MsgBox("ICEmonitor.domove: " + "adr_err")
            GoTo ende
        End If
        p1 = j                                                                  ' Von - Adresse
        If COMMON.nextI(cmd, i) Then GoTo ende
        p2 = exatoi(cmd, i)                                                     ' Zu  - Adresse
        If COMMON.nextI(cmd, i) Then GoTo ende
        j = COMMON.exatoi(cmd, i)                                               ' Anzahl (count)
        Do While j > 0
            COMMON.vZ80cpu.Speicher_schreiben_Byte(p2, COMMON.vZ80cpu.Speicher_lesen_Byte(p1))
            p1 = p1 + 1 : If (p1 > 65535) Then p1 = 0
            p2 = p2 + 1 : If (p2 > 65535) Then p2 = 0
            j = j - 1
        Loop
        Call COMMON.PrintGrid(Haupt.CMDliste, {"==> " + cmd})
        Call AnzeigeHS.SpeicherAnzeigen(100)

ende:
    End Sub ' domove

    Private Sub doreg()
        Dim i As Integer
        Dim cmd As String
        Dim cm As String

        cmd = UCase(Haupt.CommandLine.Text)
        i = 2 : Do While Mid(cmd, i, 1) = " " : i = i + 1 : Loop : If i > Len(cmd) Then GoTo ende

        cm = ""
        Do While i <= Len(cmd)
            cm = cm + Mid(cmd, i, 1)
            i = i + 1
        Loop

        Select Case cm
            Case "AF'"
                Call doregset("AF'", CULng(COMMON.vZ80cpu.A_ * 256 + COMMON.vZ80cpu.F_))
            Case "BC'"
                Call doregset("BC'", CULng(COMMON.vZ80cpu.B_ * 256 + COMMON.vZ80cpu.C_))
            Case "DE'"
                Call doregset("DE'", CULng(COMMON.vZ80cpu.D_ * 256 + COMMON.vZ80cpu.E_))
            Case "HL'"
                Call doregset("HL'", CULng(COMMON.vZ80cpu.H_ * 256 + COMMON.vZ80cpu.L_))

            Case "AF"
                Call doregset("AF", CULng(COMMON.vZ80cpu.A * 256 + COMMON.vZ80cpu.F))
            Case "BC"
                Call doregset("BC", CULng(COMMON.vZ80cpu.B * 256 + COMMON.vZ80cpu.C))
            Case "DE"
                Call doregset("DE", CULng(COMMON.vZ80cpu.D * 256 + COMMON.vZ80cpu.E))
            Case "HL"
                Call doregset("HL", CULng(COMMON.vZ80cpu.H * 256 + COMMON.vZ80cpu.L))

            Case "PC"
                Call doregset("PC", COMMON.vZ80cpu.PC)
            Case "IX"
                Call doregset("IX", COMMON.vZ80cpu.IX)
            Case "IY"
                Call doregset("IY", COMMON.vZ80cpu.IY)

            Case "A'"
                Call doregset("A'", COMMON.vZ80cpu.A_)
            Case "F'"
                Call doregset("F'", COMMON.vZ80cpu.F_)
            Case "B'"
                Call doregset("B'", COMMON.vZ80cpu.B_)
            Case "C'"
                Call doregset("C'", COMMON.vZ80cpu.C_)
            Case "D'"
                Call doregset("D'", COMMON.vZ80cpu.D_)
            Case "E'"
                Call doregset("E'", COMMON.vZ80cpu.E_)
            Case "H'"
                Call doregset("H'", COMMON.vZ80cpu.H_)
            Case "L'"
                Call doregset("L'", COMMON.vZ80cpu.L_)

            Case "A"
                Call doregset("A", COMMON.vZ80cpu.A)
            Case "F"
                Call doregset("F", COMMON.vZ80cpu.F)
            Case "B"
                Call doregset("B", COMMON.vZ80cpu.B)
            Case "C"
                Call doregset("C", COMMON.vZ80cpu.C)
            Case "D"
                Call doregset("D", COMMON.vZ80cpu.D)
            Case "E"
                Call doregset("E", COMMON.vZ80cpu.E)
            Case "H"
                Call doregset("H", COMMON.vZ80cpu.H)
            Case "L"
                Call doregset("L", COMMON.vZ80cpu.L)

            Case "I"
                Call doregset("I", COMMON.vZ80cpu.III)
            Case "SP"
                Call doregset("SP", COMMON.vZ80cpu.STACK)

            Case "FS"
            Case "FZ"
            Case "FH"
            Case "FP"
            Case "FN"
            Case "FC"

            Case Else
                MsgBox("ICEmonitor.doreg: " + "Can't change register " + cm)
        End Select
ende:
    End Sub ' doreg
    Private Sub doreset()
        Cmd1 = ""
        Cmd2 = ""
        Cmd3 = 1
        Haupt.CommandLineBez.Rows(0).Cells(0).Value = "==> "
    End Sub ' doreset
    Private Sub doregset(ByVal reg1 As String, ByVal reg2 As Byte)
        Cmd1 = "x"
        Cmd2 = reg1
        Cmd3 = 2
        Cmd4 = 1
        Haupt.CommandLineBez.Rows(0).Cells(0).Value = "==> x   " + reg1 + " = " + COMMON.HexAnzeige_Byte(reg2) + " :"
    End Sub ' doregset
    Private Sub doregset(ByVal reg1 As String, ByVal reg2 As ULong)
        Cmd1 = "x"
        Cmd2 = reg1
        Cmd3 = 2
        Cmd4 = 2
        Haupt.CommandLineBez.Rows(0).Cells(0).Value = "==> x " + reg1 + " = " + COMMON.HexAnzeige_WordByte(reg2, "H") + COMMON.HexAnzeige_WordByte(reg2, "L") + " :"
    End Sub ' doregset
    Private Sub doregmodify()
        Dim i As Integer
        Dim gef As Boolean
        gef = True : i = 0

        For i = 1 To Len(Haupt.CommandLine.Text)
            Select Case UCase(Mid(Haupt.CommandLine.Text, i, 1))
                Case "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F"
                Case Else
                    gef = False
            End Select
        Next

        If gef And Len(Haupt.CommandLine.Text) = Cmd4 * 2 Then
            Select Case Cmd2
                Case "AF'"
                    COMMON.vZ80cpu.A_ = doregByte()
                    COMMON.vZ80cpu.F_ = doregByte(3)
                Case "BC'"
                    COMMON.vZ80cpu.B_ = doregByte()
                    COMMON.vZ80cpu.C_ = doregByte(3)
                Case "DE'"
                    COMMON.vZ80cpu.D_ = doregByte()
                    COMMON.vZ80cpu.E_ = doregByte(3)
                Case "HL'"
                    COMMON.vZ80cpu.H_ = doregByte()
                    COMMON.vZ80cpu.L_ = doregByte(3)

                Case "AF"
                    COMMON.vZ80cpu.A = doregByte()
                    COMMON.vZ80cpu.F = doregByte(3)
                Case "BC"
                    COMMON.vZ80cpu.B = doregByte()
                    COMMON.vZ80cpu.C = doregByte(3)
                Case "DE"
                    COMMON.vZ80cpu.D = doregByte()
                    COMMON.vZ80cpu.E = doregByte(3)
                Case "HL"
                    COMMON.vZ80cpu.H = doregByte()
                    COMMON.vZ80cpu.L = doregByte(3)

                Case "PC"
                    COMMON.vZ80cpu.PC = doregByte() * 256 + doregByte(3)
                Case "IX"
                    COMMON.vZ80cpu.IX = doregByte() * 256 + doregByte(3)
                Case "IY"
                    COMMON.vZ80cpu.IY = doregByte() * 256 + doregByte(3)

                Case "A'"
                    COMMON.vZ80cpu.A_ = doregByte()
                Case "F'"
                    COMMON.vZ80cpu.F_ = doregByte()
                Case "B'"
                    COMMON.vZ80cpu.B_ = doregByte()
                Case "C'"
                    COMMON.vZ80cpu.C_ = doregByte()
                Case "D'"
                    COMMON.vZ80cpu.D_ = doregByte()
                Case "E'"
                    COMMON.vZ80cpu.E_ = doregByte()
                Case "H'"
                    COMMON.vZ80cpu.H_ = doregByte()
                Case "L'"
                    COMMON.vZ80cpu.L_ = doregByte()

                Case "A"
                    COMMON.vZ80cpu.A = doregByte()
                Case "F"
                    COMMON.vZ80cpu.F = doregByte()
                Case "B"
                    COMMON.vZ80cpu.B = doregByte()
                Case "C"
                    COMMON.vZ80cpu.C = doregByte()
                Case "D"
                    COMMON.vZ80cpu.D = doregByte()
                Case "E"
                    COMMON.vZ80cpu.E = doregByte()
                Case "H"
                    COMMON.vZ80cpu.H = doregByte()
                Case "L"
                    COMMON.vZ80cpu.L = doregByte()

                Case "I"
                    COMMON.vZ80cpu.III = doregByte()
                Case "SP"
                    COMMON.vZ80cpu.STACK = doregByte() * 256 + doregByte(3)
                    If Haupt.BufferAnzeigenVis.Checked Then Call AnzeigeBuffer.AnzeigeBuffer2()

                Case "FS"
                Case "FZ"
                Case "FH"
                Case "FP"
                Case "FN"
                Case "FC"
            End Select
            '
            Call doreset()
            Call Haupt.PrintReg()
            Haupt.CommandLine.Text = ""
        End If
    End Sub ' doregmodify
    Private Function doregByte(Optional ByVal Start As Integer = 1) As Byte
        doregByte = (InStr(COMMON.HEX, Mid(Haupt.CommandLine.Text, Start + 0, 1), CompareMethod.Text) - 1) * 16 +
                    (InStr(COMMON.HEX, Mid(Haupt.CommandLine.Text, Start + 1, 1), CompareMethod.Text) - 1)
    End Function ' doregByte

    Public Sub mon()
        '                                                                       The function mon() is the dialog user interface, called
        '                                                                       from the simulation just after program start.
        Dim eoj As Integer
        'Dim c1 As String

        If Not ICEmonitor.ICEmonitorEnable Then Exit Sub

        Select Case Cmd3
            Case 1
                Haupt.CommandLine.Enabled = False
                Haupt.CommandLine.BackColor = Drawing.SystemColors.Control
                eoj = 1
                If COMMON.vZ80cpu.x_flag = 1 Then
                End If
                '
                '        Do
                If Haupt.CommandLine.Text = "" Then
                    dostep()
                Else
                    Select Case LCase(Mid(Haupt.CommandLine.Text, 1, 1))
                        Case "a"
                            doanzeige()
                        Case "t"
                            'dotrace()
                        Case "g"
                            dogo()
                        Case "d"
                            dodump()
                        Case "l"
                            dolist()
                        Case "m"
                            domodify()
                        Case "f"
                            dofill()
                        Case "v"
                            domove()
                        Case "x"
                            doreg()
                        Case "p"
                            'doport()
                        Case "b"
                            dobreak()
                        Case "h"
                            'dohist()
                        Case "z"
                            'docount()
                        Case "c"
                            'doclock()
                        Case "s"
                            'doshow()
                        Case "?"
                            dohelp()
                        Case "r"
                            dogetfile()
                        Case "!"
                            'dounix()
                        Case "q"
                            eoj = 0
                        Case Else
                            Haupt.CMDliste.Text = Haupt.CMDliste.Text + vbCrLf + "'" + Haupt.CommandLine.Text + "' What ???"
                            Haupt.CommandLine.Text = ""
                    End Select
                End If
                '        Loop Until eoj = 0
                ICEmonitor.ICEmonitorEnable = False
                If eoj = 0 Then
                    If COMMON.LOGfile Then
                        My.Application.Log.WriteEntry("ICEmonitor:mon q-Command", TraceEventType.Information, 2)
                        My.Application.Log.WriteEntry("Log-Datei schliessen", TraceEventType.Information, 2)
                        My.Application.Log.DefaultFileLogWriter.Close()
                    End If

                    Tastatur.ShiftLockClickAus()
                    End
                End If
                Call COMMON.PrintGridColor(Haupt.CMDliste, Drawing.Color.Gainsboro, Drawing.Color.Black, Drawing.Color.Gainsboro, Drawing.Color.Black)
                Call COMMON.PrintGrid(Haupt.CMDliste, {""})
                Haupt.CommandLine.Text = ""
            Case 2
                Select Case Cmd1                                                ' ICE -Command
                    Case "x"
                        Select Case LCase(Mid(Haupt.CommandLine.Text, 1, 1))
                            Case ""
                                Call doreset()
                            Case Else
                                Call doregmodify()
                        End Select
                    Case "m"
                        Select Case LCase(Mid(Haupt.CommandLine.Text, 1, 1))
                            Case ""
                                doreset()
                            Case Else
                                domodifymodify()
                        End Select
                End Select
        End Select
    End Sub ' mon
End Module ' ICEmonitor
