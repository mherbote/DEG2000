Public Class Z80cpu
    Public Const cSeg_HS As Byte = 5
    Public Seg_BWS As Byte
    Public Seg_HS(0 To 15) As Byte

    Public HS(0 To 15, 0 To cSeg_HS) As Hauptspeicher

    Public XFN(0 To COMMON.const_LENCMD) As Char                                ' buffer for filename (option -x)
    Public A, F, B, C, D, E, H, L As Byte                                       ' Z80 primary   registers   
    Public A_, F_, B_, C_, D_, E_, H_, L_ As Byte                               ' Z80 secondary registers
    Public PC As ULong                                                          ' Z80 programm counter *PC
    Public STACK As ULong                                                       ' Z80 stackpointer     *STACK
    Public III As Byte                                                          ' Z80 interrupt register
    Public IFF As Byte                                                          ' Z80 interrupt flags
    Public IX, IY As ULong                                                      ' Z80 
    Public R As ULong                                                           ' Z80 refresh register

    Public wrk_ram As UShort                                                    ' workpointer into memory for dump etc. *wrk_ram
    Public cpu_state As Integer                                                 '       status of CPU emulation
    Public cpu_error As Byte                                                    ' error status of CPU emulation
    Public int_mode As Integer                                                  ' CPU interrupt mode (IM0, IM1, IM2)
    Public int_type As Integer                                                  ' type of interrupt <===   völlig unklar (indentisch mit int_mode?)
    '                                                                           ' Flags to control operation of simulation
    Public s_flag As Integer                                                    ' flag for -s option
    Public l_flag As Integer                                                    ' flag for -l option
    Public m_flag As Integer                                                    ' flag for -m option
    Public x_flag As Integer                                                    ' flag for -x option
    Public i_flag As Integer                                                    ' flag for -i option
    Public f_flag As Integer                                                    ' flag for -f option
#If Z80_UNDOC0 = 1 Then
    Public z_flag As Integer                                                    ' flag for -z option
#End If
    Public cntl_c As Integer                                                    ' flag for cntl-c entered 
    Public cntl_bs As Integer                                                   ' flag for cntl-\ entered

    Public parrity(0 To 255) As UInt16

#If BUS_8080 = 1 Then
    Public cpu_bus As Byte
#End If

#If HISIZE0 = 1 Then
    Public Class history                                                        ' Structure of a history entry
        Public h_adr As UShort                                                  ' address of execution
        Public h_af As UShort                                                   ' register AF
        Public h_bc As UShort                                                   ' register BC
        Public h_de As UShort                                                   ' register DE
        Public h_hl As UShort                                                   ' register HL
        Public h_ix As UShort                                                   ' register IX
        Public h_iy As UShort                                                   ' register IY
        Public h_sp As UShort                                                   ' register SP
    End Class

    Public his(0 To HISIZE) As history                                          ' memory to hold trace information
    Public h_next As Integer                                                    ' index into trace memory 
    Public h_flag As Integer                                                    ' flag  for  trace memory overrun
#End If

#If SBSIZE0 = 1 Then
    Public Class softbreak                                                      ' structure of a breakpoint        
        Public sb_adr As UShort                                                 ' address of breakpoint
        Public sb_oldopc As Byte                                                ' op-code at adress of breakpoint
        Public sb_passcount As Integer                                          ' pass counter of breakpoint
        Public sb_pass As Integer                                               ' no. of pass to break
    End Class

    Public soft(0 To SBSIZE) As softbreak                                       ' memory to hold breakpoint informations
    Public sb_next As Integer                                                   ' index into breakpoint memory
#End If

    Public tmax As Integer                                                      ' max t-stats to execute in 10ms
#If WANT_TIM0 = 1 Then
    Public t_states As ULong                                                    ' number of counted T states
    Public t_flag As Integer                                                    ' flag;  1 = on, 0 = off
    Public t_start As UShort                                                    ' start address for measurement
    Public t_end As UShort                                                      ' end address for measurement
    '    #if !defined(COHERENT) || defined(_I386)
    '        BYTE *t_start =	ram + 65535;	 start address for measurement
    '        BYTE *t_end = ram + 65535;	 end address for measurement
    '#Else
    '        BYTE *t_start =	ram + 32767;
    '        BYTE *t_end = ram + 32767;
    '#End If
#End If

#If FRONTPANEL0 = 1 Then
    Public fp_clock As UInteger
    Public fp_led_address As ULong                                              ' lights for address bus
    Public fp_led_data As Byte                                                  ' ligths for data bus
#End If

#Region "Sub New()"
    Public Sub New()
        Dim i, j As Integer

        For i = 0 To 15                                                         'Alle Speicher-Bereiche auf "1" einstellen
            Me.Seg_HS(i) = 1                                                    '     Grundstellung für DEG2000 Emulator Version 1.2
        Next i

        For j = 0 To cSeg_HS                                                    '64 kByte Speicher-Bereiche
            For i = 0 To 15                                                     'HS Blöcke zu 4 kByte
                Try
                    Me.HS(i, j) = New Hauptspeicher
                Catch ex As Exception
                    MsgBox("Z80cpu.Speicher_bereitstellen: " + "Not enough memory for 'Hauptspeicher' " + Format(i) + "," + Format(j) + ".")
                End Try
            Next i
        Next j

#If HISIZE0 = 1 Then
        For i = 0 To HISIZE
            his(i) = New history
        Next i
#End If

#If SBSIZE0 = 1 Then
        For i = 0 To SBSIZE
            Me.soft(i) = New softbreak
            Me.sb_next = 0
        Next
#End If
        '                                                                       'Register löschen
        A = 0 : F = 0 : B = 0 : C = 0 : D = 0 : E = 0 : H = 0 : L = 0
        A_ = 0 : F_ = 0 : B_ = 0 : C_ = 0 : D_ = 0 : E_ = 0 : H_ = 0 : L_ = 0
        IX = 0 : IY = 0 : PC = 0 : STACK = 0 : III = 0 : IFF = 0 : R = 0

        '        Me.BWS = New BildSpeicher

        ' Table to get parritys as fast as possible 
        '0
        parrity(&H0) = 0 : parrity(&H1) = 1 : parrity(&H2) = 1 : parrity(&H3) = 0
        parrity(&H4) = 1 : parrity(&H5) = 0 : parrity(&H6) = 0 : parrity(&H7) = 1
        parrity(&H8) = 1 : parrity(&H9) = 0 : parrity(&HA) = 0 : parrity(&HB) = 1
        parrity(&HC) = 0 : parrity(&HD) = 1 : parrity(&HE) = 1 : parrity(&HF) = 0
        '1
        parrity(&H10) = 1 : parrity(&H11) = 0 : parrity(&H12) = 0 : parrity(&H13) = 1
        parrity(&H14) = 0 : parrity(&H15) = 1 : parrity(&H16) = 1 : parrity(&H17) = 0
        parrity(&H18) = 0 : parrity(&H19) = 1 : parrity(&H1A) = 1 : parrity(&H1B) = 0
        parrity(&H1C) = 1 : parrity(&H1D) = 0 : parrity(&H1E) = 0 : parrity(&H1F) = 1
        '2
        parrity(&H20) = 1 : parrity(&H21) = 0 : parrity(&H22) = 0 : parrity(&H23) = 1
        parrity(&H24) = 0 : parrity(&H25) = 1 : parrity(&H26) = 1 : parrity(&H27) = 0
        parrity(&H28) = 0 : parrity(&H29) = 1 : parrity(&H2A) = 1 : parrity(&H2B) = 0
        parrity(&H2C) = 1 : parrity(&H2D) = 0 : parrity(&H2E) = 0 : parrity(&H2F) = 1
        '3
        parrity(&H30) = 0 : parrity(&H31) = 1 : parrity(&H32) = 1 : parrity(&H33) = 0
        parrity(&H34) = 1 : parrity(&H35) = 0 : parrity(&H36) = 0 : parrity(&H37) = 1
        parrity(&H38) = 1 : parrity(&H39) = 0 : parrity(&H3A) = 0 : parrity(&H3B) = 1
        parrity(&H3C) = 0 : parrity(&H3D) = 1 : parrity(&H3E) = 1 : parrity(&H3F) = 0
        '4
        parrity(&H40) = 1 : parrity(&H41) = 0 : parrity(&H42) = 0 : parrity(&H43) = 1
        parrity(&H44) = 0 : parrity(&H45) = 1 : parrity(&H46) = 1 : parrity(&H47) = 0
        parrity(&H48) = 0 : parrity(&H49) = 1 : parrity(&H4A) = 1 : parrity(&H4B) = 0
        parrity(&H4C) = 1 : parrity(&H4D) = 0 : parrity(&H4E) = 0 : parrity(&H4F) = 1
        '5
        parrity(&H50) = 0 : parrity(&H51) = 1 : parrity(&H52) = 1 : parrity(&H53) = 0
        parrity(&H54) = 1 : parrity(&H55) = 0 : parrity(&H56) = 0 : parrity(&H57) = 1
        parrity(&H58) = 1 : parrity(&H59) = 0 : parrity(&H5A) = 0 : parrity(&H5B) = 1
        parrity(&H5C) = 0 : parrity(&H5D) = 1 : parrity(&H5E) = 1 : parrity(&H5F) = 0
        '6
        parrity(&H60) = 0 : parrity(&H61) = 1 : parrity(&H62) = 1 : parrity(&H63) = 0
        parrity(&H64) = 1 : parrity(&H65) = 0 : parrity(&H66) = 0 : parrity(&H67) = 1
        parrity(&H68) = 1 : parrity(&H69) = 0 : parrity(&H6A) = 0 : parrity(&H6B) = 1
        parrity(&H6C) = 0 : parrity(&H6D) = 1 : parrity(&H6E) = 1 : parrity(&H6F) = 0
        '7
        parrity(&H70) = 1 : parrity(&H71) = 0 : parrity(&H72) = 0 : parrity(&H73) = 1
        parrity(&H74) = 0 : parrity(&H75) = 1 : parrity(&H76) = 1 : parrity(&H77) = 0
        parrity(&H78) = 0 : parrity(&H79) = 1 : parrity(&H7A) = 1 : parrity(&H7B) = 0
        parrity(&H7C) = 1 : parrity(&H7D) = 0 : parrity(&H7E) = 0 : parrity(&H7F) = 1
        '8
        parrity(&H80) = 1 : parrity(&H81) = 0 : parrity(&H82) = 0 : parrity(&H83) = 1
        parrity(&H84) = 0 : parrity(&H85) = 1 : parrity(&H86) = 1 : parrity(&H87) = 0
        parrity(&H88) = 0 : parrity(&H89) = 1 : parrity(&H8A) = 1 : parrity(&H8B) = 0
        parrity(&H8C) = 1 : parrity(&H8D) = 0 : parrity(&H8E) = 0 : parrity(&H8F) = 1
        '9
        parrity(&H90) = 0 : parrity(&H91) = 1 : parrity(&H92) = 1 : parrity(&H93) = 0
        parrity(&H94) = 1 : parrity(&H95) = 0 : parrity(&H96) = 0 : parrity(&H97) = 1
        parrity(&H98) = 1 : parrity(&H99) = 0 : parrity(&H9A) = 0 : parrity(&H9B) = 1
        parrity(&H9C) = 0 : parrity(&H9D) = 1 : parrity(&H9E) = 1 : parrity(&H9F) = 0
        'A
        parrity(&HA0) = 0 : parrity(&HA1) = 1 : parrity(&HA2) = 1 : parrity(&HA3) = 0
        parrity(&HA4) = 1 : parrity(&HA5) = 0 : parrity(&HA6) = 0 : parrity(&HA7) = 1
        parrity(&HA8) = 1 : parrity(&HA9) = 0 : parrity(&HAA) = 0 : parrity(&HAB) = 1
        parrity(&HAC) = 0 : parrity(&HAD) = 1 : parrity(&HAE) = 1 : parrity(&HAF) = 0
        'B
        parrity(&HB0) = 1 : parrity(&HB1) = 0 : parrity(&HB2) = 0 : parrity(&HB3) = 1
        parrity(&HB4) = 0 : parrity(&HB5) = 1 : parrity(&HB6) = 1 : parrity(&HB7) = 0
        parrity(&HB8) = 0 : parrity(&HB9) = 1 : parrity(&HBA) = 1 : parrity(&HBB) = 0
        parrity(&HBC) = 1 : parrity(&HBD) = 0 : parrity(&HBE) = 0 : parrity(&HBF) = 1
        'C
        parrity(&HC0) = 0 : parrity(&HC1) = 1 : parrity(&HC2) = 1 : parrity(&HC3) = 0
        parrity(&HC4) = 1 : parrity(&HC5) = 0 : parrity(&HC6) = 0 : parrity(&HC7) = 1
        parrity(&HC8) = 1 : parrity(&HC9) = 0 : parrity(&HCA) = 0 : parrity(&HCB) = 1
        parrity(&HCC) = 0 : parrity(&HCD) = 1 : parrity(&HCE) = 1 : parrity(&HCF) = 0
        'D
        parrity(&HD0) = 1 : parrity(&HD1) = 0 : parrity(&HD2) = 0 : parrity(&HD3) = 1
        parrity(&HD4) = 0 : parrity(&HD5) = 1 : parrity(&HD6) = 1 : parrity(&HD7) = 0
        parrity(&HD8) = 0 : parrity(&HD9) = 1 : parrity(&HDA) = 1 : parrity(&HDB) = 0
        parrity(&HDC) = 1 : parrity(&HDD) = 0 : parrity(&HDE) = 0 : parrity(&HDF) = 1
        'E
        parrity(&HE0) = 1 : parrity(&HE1) = 0 : parrity(&HE2) = 0 : parrity(&HE3) = 1
        parrity(&HE4) = 0 : parrity(&HE5) = 1 : parrity(&HE6) = 1 : parrity(&HE7) = 0
        parrity(&HE8) = 0 : parrity(&HE9) = 1 : parrity(&HEA) = 1 : parrity(&HEB) = 0
        parrity(&HEC) = 1 : parrity(&HED) = 0 : parrity(&HEE) = 0 : parrity(&HEF) = 1
        'F
        parrity(&HF0) = 0 : parrity(&HF1) = 1 : parrity(&HF2) = 1 : parrity(&HF3) = 0
        parrity(&HF4) = 1 : parrity(&HF5) = 0 : parrity(&HF6) = 0 : parrity(&HF7) = 1
        parrity(&HF8) = 1 : parrity(&HF9) = 0 : parrity(&HFA) = 0 : parrity(&HFB) = 1
        parrity(&HFC) = 0 : parrity(&HFD) = 1 : parrity(&HFE) = 1 : parrity(&HFF) = 0
    End Sub ' New
#End Region

    Protected Overrides Sub Finalize()
        MyBase.Finalize()
    End Sub ' Finalize

#Region "BMK Speicher Routinen"
    Public Sub ChangeHSbereich(ByVal Bereich As Byte)
        Dim i As Integer
        For i = 0 To 15
            Seg_HS(i) = Bereich
        Next
    End Sub

    Public Function Seg_Adresse(ByVal Adresse As UShort) As Byte
        Seg_Adresse = (Adresse \ 256) \ 16
    End Function ' Seg_Adresse
    Public Function Speicher_lesen_Byte(ByVal Adresse As UShort) As Byte
        Dim SegAdr As Byte

        SegAdr = Seg_Adresse(Adresse)
        Speicher_lesen_Byte = HS(SegAdr, Seg_HS(SegAdr)).HS(Adresse And &HFFF)
    End Function ' Speicher_lesen_Byte
    Public Function Speicher_lesen_Byte1(ByVal Adresse As UShort, ByVal Bereich As Byte) As Byte
        Dim SegAdr As Byte

        SegAdr = Seg_Adresse(Adresse)
        Speicher_lesen_Byte1 = HS(SegAdr, Bereich).HS(Adresse And &HFFF)
    End Function ' Speicher_lesen_Byte
    Public Function Speicher_lesen_Word(ByVal Adresse As UShort) As UShort
        Dim SegAdr As Byte

        SegAdr = Seg_Adresse(Adresse)
        Speicher_lesen_Word = HS(SegAdr, Seg_HS(SegAdr)).HS((Adresse And &HFFF) + 1) * 256 +
                              HS(SegAdr, Seg_HS(SegAdr)).HS((Adresse And &HFFF))
    End Function ' Speicher_lesen_Word
    Public Sub Speicher_schreiben_Byte(ByVal Adresse As UShort, ByVal B As Byte)
        Dim SegAdr As Byte
        Dim Bereich As Byte

        SegAdr = Seg_Adresse(Adresse)
        Bereich = Seg_HS(SegAdr)

        Call Speicher_schreiben_Byte1(Adresse, B, Bereich)
    End Sub ' Speicher_schreiben_Byte
    Public Sub Speicher_schreiben_Byte1(ByVal Adresse As UShort, ByVal B As Byte, ByVal Bereich As Byte)
        Dim x As ULong
        Dim y As ULong
        Dim adr As ULong
        Dim SegAdr As Byte

        SegAdr = Seg_Adresse(Adresse)
        HS(SegAdr, Bereich).HS(Adresse And &HFFF) = B

        If Bereich = 1 And Seg_Adresse(Adresse) = COMMON.const_Seg_BWS And Not Haupt.start Then
            adr = Adresse - COMMON.const_Seg_BWS * &H1000 : y = 0
            Do While adr >= COMMON.const_BWSspalten
                y = y + 1
                adr = adr - COMMON.const_BWSspalten
            Loop
            x = adr
            '    If x > 0 And y > 0 Then 
            Debug.Print(Format(y) + ", " + Format(x))
            'Call BWS.Set_Char(B, x, y, System.Drawing.Color.Cornsilk, System.Drawing.Color.Black)
            If x < COMMON.const_BWSspalten And y < COMMON.const_BWSzeilen Then
                'If (B And &H80) = &H80 Then             '???  Test auf Bit 7 ersetzen durch IO-Routine
                '    Call BWS.SetCursor(x, y)
                'Else
                '    Call BWS.ResetCursor()
                'End If
                Call BWS.BWS_Zeichen(x, y, B, BWS.BackColorBWS, BWS.ForeColorBWS, BWS.CursorColorBWS)
            End If
        End If
    End Sub
    'Public Sub Speicher_schreiben_Byte2(ByVal Adresse As UShort, ByVal B As Byte, ByVal Farbe As Byte)
    'End Sub ' Speicher_schreiben_Byte1
    Public Sub Speicher_schreiben_Word(ByVal Adresse As UShort, ByVal W As UShort)
        Dim SegAdr As Byte

        SegAdr = Seg_Adresse(Adresse)
        HS(SegAdr, Seg_HS(SegAdr)).HS((Adresse And &HFFF) + 1) = W \ 256
        HS(SegAdr, Seg_HS(SegAdr)).HS((Adresse And &HFFF)) = W And 255
    End Sub ' Speicher_schreiben_Word
    'Public Sub BWSanzeigen(Optional ByVal blinkenEin As Boolean = False)
    '    Dim Z, S As Integer
    '    Dim B As Byte

    '    'Call BWS.Mem2BWS(System.Drawing.Color.LightGray, System.Drawing.Color.Black, System.Drawing.Color.Red)
    '    'TODO
    '    ''# Call clrscr()
    '    'BWS.Blinken = False
    '    'For Z = 0 To BWS.BWSy - 1
    '    '    For S = 0 To BWS.BWSx - 1
    '    '        B = HS(Seg_BWS).HS(Z * BWS.BWSx + S)
    '    '        Call BWS.BWS_Zeichen(S, Z, B, System.Drawing.Color.LightGray, System.Drawing.Color.Black, System.Drawing.Color.Red)
    '    '    Next S
    '    'Next Z
    '    'BWS.RePaint()
    '    '
    '    '# GotoXY(s1+1,z1+1);
    'End Sub ' BWSanzeigen
#End Region

#Region "BMK Konvertierungen"
    Public Function HexAnzeigeByte(ByVal Wert As Byte) As String
        HexAnzeigeByte = HEX(((Wert And 255) \ 16)) + HEX(((Wert And 255) And 15))
    End Function ' HexAnzeigeByte
    Public Function HexAnzeigeWordByte(ByVal Wert As UShort, ByVal Steuerung As Char) As String
        Select Case UCase(Steuerung)
            Case "H"
                HexAnzeigeWordByte = HEX(((Wert \ 256) \ 16)) + HEX(((Wert \ 256) And 15))
            Case "L"
                HexAnzeigeWordByte = HEX(((Wert And 255) \ 16)) + HEX(((Wert And 255) And 15))
            Case "B"
                HexAnzeigeWordByte = HEX(((Wert \ 256) \ 16)) + HEX(((Wert \ 256) And 15)) +
                                      HEX(((Wert And 255) \ 16)) + HEX(((Wert And 255) And 15))
            Case "S"
                HexAnzeigeWordByte = HEX(((Wert \ 256) \ 16))
            Case Else
                HexAnzeigeWordByte = ""
        End Select
    End Function ' HexAnzeigeWordByte
#End Region

    Delegate Function opfunc() As ULong
    Delegate Function opfuncp(ByVal Data As Integer) As ULong
    Delegate Function opfunc2(ByRef s As String, ByVal p As Integer) As ULong

#Region "BMK Register 'STACK' erhöhen / verringern"
    Public Sub SPplus1()
        Dim sp1 As Long
        sp1 = COMMON.vZ80cpu.STACK + 1
        COMMON.vZ80cpu.STACK = sp1 And &HFFFF
#If WANT_SPC0 = 1 Then
        If (sp1 > 65535) Then COMMON.vZ80cpu.STACK = 0
#End If
    End Sub ' SPplus1
    Public Sub SPminus1()
        Dim sp1 As Long
        sp1 = COMMON.vZ80cpu.STACK - 1
        COMMON.vZ80cpu.STACK = sp1 And &HFFFF
#If WANT_SPC0 = 1 Then
        If (sp1 < 0) Then COMMON.vZ80cpu.STACK = &HFFFF
#End If
    End Sub ' SPminus1
#End Region

#Region "BMK Register 'PC' erhöhen / verringern"
    Public Sub PCplus1()
        Dim PC1 As Long
        Try

            PC1 = COMMON.vZ80cpu.PC + 1
            COMMON.vZ80cpu.PC = PC1 And &HFFFF
#If WANT_PCC0 = 1 Then                                                           ' check for PC overrun
            If PC1 > 65535 Then COMMON.vZ80cpu.PC = 0
#End If
        Catch ex As Exception
            MsgBox("Z80cpu.PCplus1: " + ex.Message)
        End Try
    End Sub ' PCplus1
    Public Sub PCminus1()
        Dim PC1 As Long
        PC1 = COMMON.vZ80cpu.PC - 1
        COMMON.vZ80cpu.PC = PC1 And &HFFFF
#If WANT_PCC0 = 1 Then                                                           ' check for PC overrun
        If PC1 < 0 Then COMMON.vZ80cpu.PC = &HFFFF
#End If
    End Sub ' PCminus1
    Public Sub PCplusI(ByVal anz As SByte)
        If anz < 0 Then
            For i = 1 To -1 * anz
                Call PCminus1()
            Next
        Else
            For i = 1 To anz
                Call PCplus1()
            Next
        End If
    End Sub ' PCplusI
#End Region

#Region "BMK Register 'IX'/'IY' erhöhen / verringern"
    Public Sub IXYplus1(ByRef i1 As ULong)
        Dim i2 As Long
        i2 = i1 + 1
        i1 = i2 And &HFFFF
    End Sub ' IXYplus1
    Public Function IXYminus1(ByRef i1 As ULong) As Boolean
        Dim i2 As Long
        i2 = i1 - 1
        i1 = i2 And &HFFFF
        If i2 < 0 Then IXYminus1 = True Else IXYminus1 = False
    End Function ' IXYminus1
#End Region

#Region "BMK Byte-Register erhöhen / verringern"
    Public Function RegPlus1(ByRef reg1 As Byte) As Boolean
        Dim reg2 As Integer
        reg2 = reg1 + 1
        reg1 = reg2 And &HFF
        If reg2 > &HFF Then RegPlus1 = True Else RegPlus1 = False
    End Function ' RegPlus1
    Public Function RegMinus1(ByRef reg1 As Byte) As Boolean
        Dim reg2 As Integer
        reg2 = reg1 - 1
        reg1 = reg2 And &HFF
        If reg2 < 0 Then RegMinus1 = True Else RegMinus1 = False
    End Function ' RegMinus1
#End Region

#Region "BMK Flagroutinen"
    Public Sub FlagCflag1(ByVal test As Boolean)                                            '0
        If test Then Me.F = Me.F Or COMMON.C_FLAG Else Me.F = Me.F And Not COMMON.C_FLAG
    End Sub ' Flag_Cflag1
    Public Sub FlagCflag2(ByVal test As Boolean)
        If test Then Me.F = Me.F And Not COMMON.C_FLAG Else Me.F = Me.F Or COMMON.C_FLAG
    End Sub ' Flag_Cflag2

    Public Sub FlagNflag1()                                                                 '1
        Me.F = Me.F Or COMMON.N_FLAG
    End Sub ' Flag_Nflag1
    Public Sub FlagNflag2()
        Me.F = Me.F And Not COMMON.N_FLAG
    End Sub ' Flag_Nflag2

    Public Sub FlagPflag1(ByVal test As Boolean)                                            '2
        If test Then Me.F = Me.F Or COMMON.P_FLAG Else Me.F = Me.F And Not COMMON.P_FLAG
    End Sub ' Flag_Pflag1
    Public Sub FlagPflag2(ByVal test As Boolean)
        If test Then Me.F = Me.F And Not COMMON.P_FLAG Else Me.F = Me.F Or COMMON.P_FLAG
    End Sub ' Flag_Pflag2

    Public Sub FlagF3flag1()                                                                 '3
        Me.F = Me.F Or COMMON.F3_FLAG
    End Sub ' Flag_Nflag1
    Public Sub FlagF3flag2()
        Me.F = Me.F And Not COMMON.F3_FLAG
    End Sub ' Flag_Nflag2

    Public Sub FlagHflag1(ByVal test As Boolean)                                            '4
        If test Then Me.F = Me.F Or COMMON.H_FLAG Else Me.F = Me.F And Not COMMON.H_FLAG
    End Sub ' Flag_Hflag1
    Public Sub FlagHflag2(ByVal test As Boolean)
        If test Then Me.F = Me.F And Not COMMON.H_FLAG Else Me.F = Me.F Or COMMON.H_FLAG
    End Sub ' Flag_Hflag2

    Public Sub FlagF5flag1()                                                                 '5
        Me.F = Me.F Or COMMON.F5_FLAG
    End Sub ' Flag_Nflag1
    Public Sub FlagF5flag2()
        Me.F = Me.F And Not COMMON.F5_FLAG
    End Sub ' Flag_Nflag2

    Public Sub FlagZflag1(ByVal test As Boolean)                                            '6
        If test Then Me.F = Me.F Or COMMON.Z_FLAG Else Me.F = Me.F And Not COMMON.Z_FLAG
    End Sub ' Flag_Zflag1
    Public Sub FlagZflag2(ByVal test As Boolean)
        If test Then Me.F = Me.F And Not COMMON.Z_FLAG Else Me.F = Me.F Or COMMON.Z_FLAG
    End Sub ' Flag_Zflag2
    Public Sub FlagZPflag(ByVal test As Boolean)
        If test Then Me.F = Me.F And Not (COMMON.Z_FLAG Or COMMON.P_FLAG) Else Me.F = Me.F Or (COMMON.Z_FLAG Or COMMON.P_FLAG)
    End Sub ' Flag_Zflag2

    Public Sub FlagSflag1(ByVal test As Boolean)                                            '7
        If test Then Me.F = Me.F Or COMMON.S_FLAG Else Me.F = Me.F And Not COMMON.S_FLAG
    End Sub ' Flag_Sflag1
    Public Sub FlagSflag2(ByVal test As Boolean)
        If test Then Me.F = Me.F And Not COMMON.S_FLAG Else Me.F = Me.F Or COMMON.S_FLAG
    End Sub ' Flag_Sflag2
#End Region

#Region "BMK bus_front"
    Public Sub busfront(ByVal bus As Byte)
#If BUS_8080 = 1 Then
        COMMON.vZ80cpu.cpu_bus = bus
#End If
#If FRONTPANEL0 = 1 Then
        '#        fp_sampleLightGroup(0, 0)
#End If
    End Sub ' bus_front
#End Region

    Public Sub fgets()  '(ByVal cmd As String)
    End Sub ' fgets

    Public Sub inton()
    End Sub ' int_on
    Public Sub intoff()
    End Sub ' int_off

    Public Sub userint()
    End Sub ' user_int
    Public Sub quitint()
    End Sub ' quit_int

End Class

Public Class Hauptspeicher
    Public HS(0 To 1024 * 4 - 1) As Byte
    Public Sub New()
        Dim i As Integer
        For i = 0 To 1024 * 4 - 1
            HS(i) = 0
        Next i
    End Sub
End Class
