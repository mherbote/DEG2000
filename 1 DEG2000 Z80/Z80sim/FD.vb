Imports DEG2000.Z80cpu

Module FD
    ' Like the function "cpu()" this one emulates multi byte opcodes starting with 0xFD

    Public Class op_fd
        Public op_sim(0 To 255) As opfunc

        Public Sub New()
            op_sim(&H0) = New opfunc(AddressOf trap_fd) : op_sim(&H1) = New opfunc(AddressOf trap_fd) : op_sim(&H2) = New opfunc(AddressOf trap_fd) : op_sim(&H3) = New opfunc(AddressOf trap_fd)
            op_sim(&H4) = New opfunc(AddressOf trap_fd) : op_sim(&H5) = New opfunc(AddressOf trap_fd) : op_sim(&H6) = New opfunc(AddressOf trap_fd) : op_sim(&H7) = New opfunc(AddressOf trap_fd)
            op_sim(&H8) = New opfunc(AddressOf trap_fd) : op_sim(&H9) = New opfunc(AddressOf op_addyb) : op_sim(&HA) = New opfunc(AddressOf trap_fd) : op_sim(&HB) = New opfunc(AddressOf trap_fd)
            op_sim(&HC) = New opfunc(AddressOf trap_fd) : op_sim(&HD) = New opfunc(AddressOf trap_fd) : op_sim(&HE) = New opfunc(AddressOf trap_fd) : op_sim(&HF) = New opfunc(AddressOf trap_fd)

            op_sim(&H10) = New opfunc(AddressOf trap_fd) : op_sim(&H11) = New opfunc(AddressOf trap_fd) : op_sim(&H12) = New opfunc(AddressOf trap_fd) : op_sim(&H13) = New opfunc(AddressOf trap_fd)
            op_sim(&H14) = New opfunc(AddressOf trap_fd) : op_sim(&H15) = New opfunc(AddressOf trap_fd) : op_sim(&H16) = New opfunc(AddressOf trap_fd) : op_sim(&H17) = New opfunc(AddressOf trap_fd)
            op_sim(&H18) = New opfunc(AddressOf trap_fd) : op_sim(&H19) = New opfunc(AddressOf op_addyd) : op_sim(&H1A) = New opfunc(AddressOf trap_fd) : op_sim(&H1B) = New opfunc(AddressOf trap_fd)
            op_sim(&H1C) = New opfunc(AddressOf trap_fd) : op_sim(&H1D) = New opfunc(AddressOf trap_fd) : op_sim(&H1E) = New opfunc(AddressOf trap_fd) : op_sim(&H1F) = New opfunc(AddressOf trap_fd)

            op_sim(&H20) = New opfunc(AddressOf trap_fd) : op_sim(&H21) = New opfunc(AddressOf op_ldiynn) : op_sim(&H22) = New opfunc(AddressOf op_ldiny) : op_sim(&H23) = New opfunc(AddressOf op_inciy)
            op_sim(&H24) = New opfunc(AddressOf trap_fd) : op_sim(&H25) = New opfunc(AddressOf trap_fd) : op_sim(&H26) = New opfunc(AddressOf trap_fd) : op_sim(&H27) = New opfunc(AddressOf trap_fd)
            op_sim(&H28) = New opfunc(AddressOf trap_fd) : op_sim(&H29) = New opfunc(AddressOf op_addyy) : op_sim(&H2A) = New opfunc(AddressOf op_ldiyinn) : op_sim(&H2B) = New opfunc(AddressOf op_deciy)
            op_sim(&H2C) = New opfunc(AddressOf trap_fd) : op_sim(&H2D) = New opfunc(AddressOf trap_fd) : op_sim(&H2E) = New opfunc(AddressOf trap_fd) : op_sim(&H2F) = New opfunc(AddressOf trap_fd)

            op_sim(&H30) = New opfunc(AddressOf trap_fd) : op_sim(&H31) = New opfunc(AddressOf trap_fd) : op_sim(&H32) = New opfunc(AddressOf trap_fd) : op_sim(&H33) = New opfunc(AddressOf trap_fd)
            op_sim(&H34) = New opfunc(AddressOf op_incyd) : op_sim(&H35) = New opfunc(AddressOf op_decyd) : op_sim(&H36) = New opfunc(AddressOf op_ldydn) : op_sim(&H37) = New opfunc(AddressOf trap_fd)
            op_sim(&H38) = New opfunc(AddressOf trap_fd) : op_sim(&H39) = New opfunc(AddressOf op_addys) : op_sim(&H3A) = New opfunc(AddressOf trap_fd) : op_sim(&H3B) = New opfunc(AddressOf trap_fd)
            op_sim(&H3C) = New opfunc(AddressOf trap_fd) : op_sim(&H3D) = New opfunc(AddressOf trap_fd) : op_sim(&H3E) = New opfunc(AddressOf trap_fd) : op_sim(&H3F) = New opfunc(AddressOf trap_fd)

            op_sim(&H40) = New opfunc(AddressOf trap_fd) : op_sim(&H41) = New opfunc(AddressOf trap_fd) : op_sim(&H42) = New opfunc(AddressOf trap_fd) : op_sim(&H43) = New opfunc(AddressOf trap_fd)
            op_sim(&H44) = New opfunc(AddressOf trap_fd) : op_sim(&H45) = New opfunc(AddressOf trap_fd) : op_sim(&H46) = New opfunc(AddressOf op_ldbyd) : op_sim(&H47) = New opfunc(AddressOf trap_fd)
            op_sim(&H48) = New opfunc(AddressOf trap_fd) : op_sim(&H49) = New opfunc(AddressOf trap_fd) : op_sim(&H4A) = New opfunc(AddressOf trap_fd) : op_sim(&H4B) = New opfunc(AddressOf trap_fd)
            op_sim(&H4C) = New opfunc(AddressOf trap_fd) : op_sim(&H4D) = New opfunc(AddressOf trap_fd) : op_sim(&H4E) = New opfunc(AddressOf op_ldcyd) : op_sim(&H4F) = New opfunc(AddressOf trap_fd)

            op_sim(&H50) = New opfunc(AddressOf trap_fd) : op_sim(&H51) = New opfunc(AddressOf trap_fd) : op_sim(&H52) = New opfunc(AddressOf trap_fd) : op_sim(&H53) = New opfunc(AddressOf trap_fd)
            op_sim(&H54) = New opfunc(AddressOf trap_fd) : op_sim(&H55) = New opfunc(AddressOf trap_fd) : op_sim(&H56) = New opfunc(AddressOf op_lddyd) : op_sim(&H57) = New opfunc(AddressOf trap_fd)
            op_sim(&H58) = New opfunc(AddressOf trap_fd) : op_sim(&H59) = New opfunc(AddressOf trap_fd) : op_sim(&H5A) = New opfunc(AddressOf trap_fd) : op_sim(&H5B) = New opfunc(AddressOf trap_fd)
            op_sim(&H5C) = New opfunc(AddressOf trap_fd) : op_sim(&H5D) = New opfunc(AddressOf trap_fd) : op_sim(&H5E) = New opfunc(AddressOf op_ldeyd) : op_sim(&H5F) = New opfunc(AddressOf trap_fd)

            op_sim(&H60) = New opfunc(AddressOf trap_fd) : op_sim(&H61) = New opfunc(AddressOf trap_fd) : op_sim(&H62) = New opfunc(AddressOf trap_fd) : op_sim(&H63) = New opfunc(AddressOf trap_fd)
            op_sim(&H64) = New opfunc(AddressOf trap_fd) : op_sim(&H65) = New opfunc(AddressOf trap_fd) : op_sim(&H66) = New opfunc(AddressOf op_ldhyd) : op_sim(&H67) = New opfunc(AddressOf trap_fd)
            op_sim(&H68) = New opfunc(AddressOf trap_fd) : op_sim(&H69) = New opfunc(AddressOf trap_fd) : op_sim(&H6A) = New opfunc(AddressOf trap_fd) : op_sim(&H6B) = New opfunc(AddressOf trap_fd)
            op_sim(&H6C) = New opfunc(AddressOf trap_fd) : op_sim(&H6D) = New opfunc(AddressOf trap_fd) : op_sim(&H6E) = New opfunc(AddressOf op_ldlyd) : op_sim(&H6F) = New opfunc(AddressOf trap_fd)

            op_sim(&H70) = New opfunc(AddressOf op_ldydb) : op_sim(&H71) = New opfunc(AddressOf op_ldydc) : op_sim(&H72) = New opfunc(AddressOf op_ldydd) : op_sim(&H73) = New opfunc(AddressOf op_ldyde)
            op_sim(&H74) = New opfunc(AddressOf op_ldydh) : op_sim(&H75) = New opfunc(AddressOf op_ldydl) : op_sim(&H76) = New opfunc(AddressOf trap_fd) : op_sim(&H77) = New opfunc(AddressOf op_ldyda)
            op_sim(&H78) = New opfunc(AddressOf trap_fd) : op_sim(&H79) = New opfunc(AddressOf trap_fd) : op_sim(&H7A) = New opfunc(AddressOf trap_fd) : op_sim(&H7B) = New opfunc(AddressOf trap_fd)
            op_sim(&H7C) = New opfunc(AddressOf trap_fd) : op_sim(&H7D) = New opfunc(AddressOf trap_fd) : op_sim(&H7E) = New opfunc(AddressOf op_ldayd) : op_sim(&H7F) = New opfunc(AddressOf trap_fd)

            op_sim(&H80) = New opfunc(AddressOf trap_fd) : op_sim(&H81) = New opfunc(AddressOf trap_fd) : op_sim(&H82) = New opfunc(AddressOf trap_fd) : op_sim(&H83) = New opfunc(AddressOf trap_fd)
            op_sim(&H84) = New opfunc(AddressOf trap_fd) : op_sim(&H85) = New opfunc(AddressOf trap_fd) : op_sim(&H86) = New opfunc(AddressOf op_adayd) : op_sim(&H87) = New opfunc(AddressOf trap_fd)
            op_sim(&H88) = New opfunc(AddressOf trap_fd) : op_sim(&H89) = New opfunc(AddressOf trap_fd) : op_sim(&H8A) = New opfunc(AddressOf trap_fd) : op_sim(&H8B) = New opfunc(AddressOf trap_fd)
            op_sim(&H8C) = New opfunc(AddressOf trap_fd) : op_sim(&H8D) = New opfunc(AddressOf trap_fd) : op_sim(&H8E) = New opfunc(AddressOf op_acayd) : op_sim(&H8F) = New opfunc(AddressOf trap_fd)

            op_sim(&H90) = New opfunc(AddressOf trap_fd) : op_sim(&H91) = New opfunc(AddressOf trap_fd) : op_sim(&H92) = New opfunc(AddressOf trap_fd) : op_sim(&H93) = New opfunc(AddressOf trap_fd)
            op_sim(&H94) = New opfunc(AddressOf trap_fd) : op_sim(&H95) = New opfunc(AddressOf trap_fd) : op_sim(&H96) = New opfunc(AddressOf op_suayd) : op_sim(&H97) = New opfunc(AddressOf trap_fd)
            op_sim(&H98) = New opfunc(AddressOf trap_fd) : op_sim(&H99) = New opfunc(AddressOf trap_fd) : op_sim(&H9A) = New opfunc(AddressOf trap_fd) : op_sim(&H9B) = New opfunc(AddressOf trap_fd)
            op_sim(&H9C) = New opfunc(AddressOf trap_fd) : op_sim(&H9D) = New opfunc(AddressOf trap_fd) : op_sim(&H9E) = New opfunc(AddressOf op_scayd) : op_sim(&H9F) = New opfunc(AddressOf trap_fd)

            op_sim(&HA0) = New opfunc(AddressOf trap_fd) : op_sim(&HA1) = New opfunc(AddressOf trap_fd) : op_sim(&HA2) = New opfunc(AddressOf trap_fd) : op_sim(&HA3) = New opfunc(AddressOf trap_fd)
            op_sim(&HA4) = New opfunc(AddressOf trap_fd) : op_sim(&HA5) = New opfunc(AddressOf trap_fd) : op_sim(&HA6) = New opfunc(AddressOf op_andyd) : op_sim(&HA7) = New opfunc(AddressOf trap_fd)
            op_sim(&HA8) = New opfunc(AddressOf trap_fd) : op_sim(&HA9) = New opfunc(AddressOf trap_fd) : op_sim(&HAA) = New opfunc(AddressOf trap_fd) : op_sim(&HAB) = New opfunc(AddressOf trap_fd)
            op_sim(&HAC) = New opfunc(AddressOf trap_fd) : op_sim(&HAD) = New opfunc(AddressOf trap_fd) : op_sim(&HAE) = New opfunc(AddressOf op_xoryd) : op_sim(&HAF) = New opfunc(AddressOf trap_fd)

            op_sim(&HB0) = New opfunc(AddressOf trap_fd) : op_sim(&HB1) = New opfunc(AddressOf trap_fd) : op_sim(&HB2) = New opfunc(AddressOf trap_fd) : op_sim(&HB3) = New opfunc(AddressOf trap_fd)
            op_sim(&HB4) = New opfunc(AddressOf trap_fd) : op_sim(&HB5) = New opfunc(AddressOf trap_fd) : op_sim(&HB6) = New opfunc(AddressOf op_oryd) : op_sim(&HB7) = New opfunc(AddressOf trap_fd)
            op_sim(&HB8) = New opfunc(AddressOf trap_fd) : op_sim(&HB9) = New opfunc(AddressOf trap_fd) : op_sim(&HBA) = New opfunc(AddressOf trap_fd) : op_sim(&HBB) = New opfunc(AddressOf trap_fd)
            op_sim(&HBC) = New opfunc(AddressOf trap_fd) : op_sim(&HBD) = New opfunc(AddressOf trap_fd) : op_sim(&HBE) = New opfunc(AddressOf op_cpyd) : op_sim(&HBF) = New opfunc(AddressOf trap_fd)

            op_sim(&HC0) = New opfunc(AddressOf trap_fd) : op_sim(&HC1) = New opfunc(AddressOf trap_fd) : op_sim(&HC2) = New opfunc(AddressOf trap_fd) : op_sim(&HC3) = New opfunc(AddressOf trap_fd)
            op_sim(&HC4) = New opfunc(AddressOf trap_fd) : op_sim(&HC5) = New opfunc(AddressOf trap_fd) : op_sim(&HC6) = New opfunc(AddressOf trap_fd) : op_sim(&HC7) = New opfunc(AddressOf trap_fd)
            op_sim(&HC8) = New opfunc(AddressOf trap_fd) : op_sim(&HC9) = New opfunc(AddressOf trap_fd) : op_sim(&HCA) = New opfunc(AddressOf trap_fd) : op_sim(&HCB) = New opfunc(AddressOf op_fdcb_handel)
            op_sim(&HCC) = New opfunc(AddressOf trap_fd) : op_sim(&HCD) = New opfunc(AddressOf trap_fd) : op_sim(&HCE) = New opfunc(AddressOf trap_fd) : op_sim(&HCF) = New opfunc(AddressOf trap_fd)

            op_sim(&HD0) = New opfunc(AddressOf trap_fd) : op_sim(&HD1) = New opfunc(AddressOf trap_fd) : op_sim(&HD2) = New opfunc(AddressOf trap_fd) : op_sim(&HD3) = New opfunc(AddressOf trap_fd)
            op_sim(&HD4) = New opfunc(AddressOf trap_fd) : op_sim(&HD5) = New opfunc(AddressOf trap_fd) : op_sim(&HD6) = New opfunc(AddressOf trap_fd) : op_sim(&HD7) = New opfunc(AddressOf trap_fd)
            op_sim(&HD8) = New opfunc(AddressOf trap_fd) : op_sim(&HD9) = New opfunc(AddressOf trap_fd) : op_sim(&HDA) = New opfunc(AddressOf trap_fd) : op_sim(&HDB) = New opfunc(AddressOf trap_fd)
            op_sim(&HDC) = New opfunc(AddressOf trap_fd) : op_sim(&HDD) = New opfunc(AddressOf trap_fd) : op_sim(&HDE) = New opfunc(AddressOf trap_fd) : op_sim(&HDF) = New opfunc(AddressOf trap_fd)

            op_sim(&HE0) = New opfunc(AddressOf trap_fd) : op_sim(&HE1) = New opfunc(AddressOf op_popiy) : op_sim(&HE2) = New opfunc(AddressOf trap_fd) : op_sim(&HE3) = New opfunc(AddressOf op_exspy)
            op_sim(&HE4) = New opfunc(AddressOf trap_fd) : op_sim(&HE5) = New opfunc(AddressOf op_pusiy) : op_sim(&HE6) = New opfunc(AddressOf trap_fd) : op_sim(&HE7) = New opfunc(AddressOf trap_fd)
            op_sim(&HE8) = New opfunc(AddressOf trap_fd) : op_sim(&HE9) = New opfunc(AddressOf op_jpiy) : op_sim(&HEA) = New opfunc(AddressOf trap_fd) : op_sim(&HEB) = New opfunc(AddressOf trap_fd)
            op_sim(&HEC) = New opfunc(AddressOf trap_fd) : op_sim(&HED) = New opfunc(AddressOf trap_fd) : op_sim(&HEE) = New opfunc(AddressOf trap_fd) : op_sim(&HEF) = New opfunc(AddressOf trap_fd)

            op_sim(&HF0) = New opfunc(AddressOf trap_fd) : op_sim(&HF1) = New opfunc(AddressOf trap_fd) : op_sim(&HF2) = New opfunc(AddressOf trap_fd) : op_sim(&HF3) = New opfunc(AddressOf trap_fd)
            op_sim(&HF4) = New opfunc(AddressOf trap_fd) : op_sim(&HF5) = New opfunc(AddressOf trap_fd) : op_sim(&HF6) = New opfunc(AddressOf trap_fd) : op_sim(&HF7) = New opfunc(AddressOf trap_fd)
            op_sim(&HF8) = New opfunc(AddressOf trap_fd) : op_sim(&HF9) = New opfunc(AddressOf op_ldspy) : op_sim(&HFA) = New opfunc(AddressOf trap_fd) : op_sim(&HFB) = New opfunc(AddressOf trap_fd)
            op_sim(&HFC) = New opfunc(AddressOf trap_fd) : op_sim(&HFD) = New opfunc(AddressOf trap_fd) : op_sim(&HFE) = New opfunc(AddressOf trap_fd) : op_sim(&HFF) = New opfunc(AddressOf trap_fd)

#If Z80_UNDOC0 = 1 Then
            op_sim(&H6F) = New opfunc(AddressOf op_undoc_ldiyl)
            op_sim(&HBD) = New opfunc(AddressOf op_undoc_cpiyl)
#End If
        End Sub ' New
    End Class ' op_fd

    Public op_fd1 As New op_fd

    '====================================
    ' This function traps all illegal opcodes following the initial 0xDD of a multi byte opcode.
    Private Function trap_fd() As Integer
        Call Haupt.cpuError(COMMON.OPTRAP2)
        Call Haupt.cpuState(COMMON.STOPPED)
        trap_fd = 0
    End Function ' trap_fd

#Region "ADD IY,xx"
    '------------------------------------
    Private Function op_addyb() As Integer                                      '&H09         'ADD IY,BC
        op_addyb = add(COMMON.vZ80cpu.B, COMMON.vZ80cpu.C)
    End Function '09    'op_addyb
    Private Function op_addyd() As Integer                                      '&H19         'ADD IY,DE
        op_addyd = add(COMMON.vZ80cpu.D, COMMON.vZ80cpu.E)
    End Function '19    'op_addyd
    Private Function op_addyy() As Integer                                      '&H29         'ADD IY,IY
        op_addyy = add((COMMON.vZ80cpu.IY And &HFF00) >> 8, COMMON.vZ80cpu.IY And &HFF)
    End Function '29    'op_addyy
    Private Function op_addys() As Integer                                      '&H39         'ADD IY,SP
        op_addys = add((COMMON.vZ80cpu.STACK And &HFF00) >> 8, COMMON.vZ80cpu.STACK And &HFF)
    End Function '39    'op_addys
    Private Function add(ByVal par1 As Byte, ByVal Par2 As Byte) As Integer
        Dim carry As Integer
        Dim iyh As Integer
        Dim iyl As Integer

        iyh = (COMMON.vZ80cpu.IX And &HFF00) >> 8
        iyl = COMMON.vZ80cpu.IX And &HFF
        If CInt(iyl) + CInt(Par2) > 255 Then carry = 1 Else carry = 0
        iyl = iyl + Par2
        Call COMMON.vZ80cpu.FlagHflag1((iyh And &HF) + (par1 And &HF) + carry > &HF)
        Call COMMON.vZ80cpu.FlagCflag1(iyh + par1 + carry > 255)
        iyh = iyh + par1 + carry
        COMMON.vZ80cpu.IX = ((iyh And &HFF) << 8) + (iyl And &HFF)
        Call COMMON.vZ80cpu.FlagNflag2()
        add = 15
    End Function ' add
#End Region
#Region "LD IY,nn  LD (nn),IY  INC IY"
    '------------------------------------
    Private Function op_ldiynn() As Integer                                     '&H21         'LD IY,nn
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        Call COMMON.vZ80cpu.PCplus1() : COMMON.vZ80cpu.IY = COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.PC)
        Call COMMON.vZ80cpu.PCplus1() : COMMON.vZ80cpu.IY = COMMON.vZ80cpu.IY + COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.PC) * 256
        op_ldiynn = 14
    End Function '21    'op_ldiynn
    Private Function op_ldiny() As Integer                                      '&H22         'LD (nn),IY
        Dim p As ULong
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_NONE)
        Call COMMON.vZ80cpu.PCplus1() : p = COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.PC)
        Call COMMON.vZ80cpu.PCplus1() : p = p + COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.PC) * 256
        COMMON.vZ80cpu.Speicher_schreiben_Byte(p, COMMON.vZ80cpu.IY And &HFF) : p = p + 1
        COMMON.vZ80cpu.Speicher_schreiben_Byte(p, COMMON.vZ80cpu.IY \ 256)
        op_ldiny = 20
    End Function '22    'op_ldiny
    Private Function op_inciy() As Integer                                      '&H23         'INC IY
        COMMON.vZ80cpu.IXYplus1(COMMON.vZ80cpu.IY)
        op_inciy = 10
    End Function '23    'op_inciy
#End Region
#Region "LD IY,(nn)  DEC IY"
    '------------------------------------
    Private Function op_ldiyinn() As Integer                                    '&H2A         'LD IY,(nn)
        Dim p As ULong
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        Call COMMON.vZ80cpu.PCplus1() : p = COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.PC)
        Call COMMON.vZ80cpu.PCplus1() : p = p + COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.PC) * 256
        COMMON.vZ80cpu.IY = COMMON.vZ80cpu.Speicher_lesen_Byte(p) : p = p + 1
        COMMON.vZ80cpu.IY = COMMON.vZ80cpu.IY + COMMON.vZ80cpu.Speicher_lesen_Byte(p) * 256
        op_ldiyinn = 20
    End Function '2A    'op_ldiyinn
    Private Function op_deciy() As Integer                                      '&H2B         'DEC IY
        COMMON.vZ80cpu.IXYminus1(COMMON.vZ80cpu.IY)
        op_deciy = 10
    End Function '2B    op_deciy
#End Region

#Region "INC (IY+d)  DEC (IY+d)  LD (IY+d),n"
    '------------------------------------
    Private Function op_incyd() As Integer                                      '&H34         'INC (IY+d)
        Dim p As Long
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        Call COMMON.vZ80cpu.PCplus1() : p = COMMON.vZ80cpu.IY + COMMON.Byte2SByte(COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.PC))
        Call COMMON.vZ80cpu.FlagHflag1((COMMON.vZ80cpu.Speicher_lesen_Byte(p) And &HF) + 1 > &HF)
        COMMON.vZ80cpu.Speicher_schreiben_Byte(p, COMMON.vZ80cpu.Speicher_lesen_Byte(p) + 1)
        Call COMMON.vZ80cpu.FlagPflag1(COMMON.vZ80cpu.Speicher_lesen_Byte(p) = 128)
        Call COMMON.vZ80cpu.FlagSflag1((COMMON.vZ80cpu.Speicher_lesen_Byte(p) And 128))
        Call COMMON.vZ80cpu.FlagZflag2((COMMON.vZ80cpu.Speicher_lesen_Byte(p)) <> 0)
        Call COMMON.vZ80cpu.FlagNflag2()
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_NONE)
        op_incyd = 23
    End Function '34    'op_incyd
    Private Function op_decyd() As Integer                                      '&H35         'DEC (IY+d)
        Dim p As Long
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        Call COMMON.vZ80cpu.PCplus1() : p = COMMON.vZ80cpu.IY + COMMON.Byte2SByte(COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.PC))
        Call COMMON.vZ80cpu.FlagHflag1((COMMON.vZ80cpu.Speicher_lesen_Byte(p) - 1 And &HF) = &HF)
        COMMON.vZ80cpu.Speicher_schreiben_Byte(p, COMMON.vZ80cpu.Speicher_lesen_Byte(p) - 1)
        Call COMMON.vZ80cpu.FlagPflag1(COMMON.vZ80cpu.Speicher_lesen_Byte(p) = 127)
        Call COMMON.vZ80cpu.FlagSflag1((COMMON.vZ80cpu.Speicher_lesen_Byte(p) And 128))
        Call COMMON.vZ80cpu.FlagZflag2((COMMON.vZ80cpu.Speicher_lesen_Byte(p)) <> 0)
        Call COMMON.vZ80cpu.FlagNflag1()
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_NONE)
        op_decyd = 23
    End Function '35    'op_decyd
    Private Function op_ldydn() As Integer                                      '&H36         'LD (IY+d),n
        Dim d As Integer
        Dim n As Integer
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        Call COMMON.vZ80cpu.PCplus1() : d = COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.PC)
        Call COMMON.vZ80cpu.PCplus1() : n = COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.PC)
        Call COMMON.vZ80cpu.Speicher_schreiben_Byte(COMMON.vZ80cpu.IY + d, n)
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_NONE)
        op_ldydn = 19
    End Function '36    'op_ldydn
#End Region

#Region "LD x,(IY+d)"
    '------------------------------------
    Private Function op_ldbyd() As Integer                                      '&H46         'LD B,(IY+d)
        op_ldbyd = ldiyd(COMMON.vZ80cpu.B)
    End Function '46    'op_ldbyd
    Private Function op_ldcyd() As Integer                                      '&H4E         'LD C,(IY+d)
        op_ldcyd = ldiyd(COMMON.vZ80cpu.C)
    End Function '4E    'op_ldcyd
    Private Function op_lddyd() As Integer                                      '&H56         'LD D,(IY+d)
        op_lddyd = ldiyd(COMMON.vZ80cpu.D)
    End Function '56    'op_lddyd
    Private Function op_ldeyd() As Integer                                      '&H5E         'LD E,(IY+d) 
        op_ldeyd = ldiyd(COMMON.vZ80cpu.E)
    End Function '5E    'op_ldeyd
    Private Function op_ldhyd() As Integer                                      '&H66         'LD H,(IY+d)
        op_ldhyd = ldiyd(COMMON.vZ80cpu.H)
    End Function '66    'op_ldhyd
    Private Function op_ldlyd() As Integer                                      '&H6E         'LD L,(IY+d)
        op_ldlyd = ldiyd(COMMON.vZ80cpu.L)
    End Function '6E    'op_ldlyd
    Private Function op_ldayd() As Integer                                      '&H7E         'LD A,(IY+d)
        op_ldayd = ldiyd(COMMON.vZ80cpu.A)
    End Function '7E    'op_ldayd
    Private Function ldiyd(ByRef par1 As Byte) As Integer
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        Call COMMON.vZ80cpu.PCplus1()
        par1 = COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.IY + COMMON.Byte2SByte(COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.PC)))
        ldiyd = 19
    End Function ' ldiyd
#End Region
#Region "LD (IY+d),x"
    '------------------------------------
    Private Function op_ldydb() As Integer                                      '&H70         'LD (IY+d),B
        op_ldydb = ldy(COMMON.vZ80cpu.B)
    End Function '70    'op_ldydb
    Private Function op_ldydc() As Integer                                      '&H71         'LD (IY+d),C
        op_ldydc = ldy(COMMON.vZ80cpu.C)
    End Function '71    'op_ldydc
    Private Function op_ldydd() As Integer                                      '&H72         'LD (IY+d),D
        op_ldydd = ldy(COMMON.vZ80cpu.D)
    End Function '72    'op_ldydd
    Private Function op_ldyde() As Integer                                      '&H73         'LD (IY+d),E
        op_ldyde = ldy(COMMON.vZ80cpu.E)
    End Function '73    'op_ldyde
    Private Function op_ldydh() As Integer                                      '&H74         'LD (IY+d),H
        op_ldydh = ldy(COMMON.vZ80cpu.H)
    End Function '74    'op_ldydh
    Private Function op_ldydl() As Integer                                      '&H75         'LD (IY+d),L
        op_ldydl = ldy(COMMON.vZ80cpu.L)
    End Function '75    'op_ldydl
    Private Function op_ldyda() As Integer                                      '&H77         'LD (IY+d),A
        op_ldyda = ldy(COMMON.vZ80cpu.A)
    End Function '77    'op_ldyda
    Private Function ldy(ByVal par1 As Byte) As Integer
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        Call COMMON.vZ80cpu.PCplus1() : COMMON.vZ80cpu.Speicher_schreiben_Byte(COMMON.vZ80cpu.IY + COMMON.Byte2SByte(COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.PC)), par1)
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_NONE)
        ldy = 19
    End Function ' ldy
#End Region

#Region "ADD ADC SUB SBC A,(IY+d)"
    '------------------------------------
    Private Function op_adayd() As Integer                                      '&H86         'ADD A,(IY+d) 
        Dim i As Integer
        Dim P As Byte
        Dim j As SByte
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        Call COMMON.vZ80cpu.PCplus1() : P = COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.IY + COMMON.Byte2SByte(COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.PC)))
        Call COMMON.vZ80cpu.FlagHflag1((COMMON.vZ80cpu.A And &HF) + (P And &HF) > &HF)
        Call COMMON.vZ80cpu.FlagCflag1(CInt(COMMON.vZ80cpu.A) + CInt(P) > 255)
        i = CInt(COMMON.vZ80cpu.A) + CInt(P)         'i = CInt(COMMON.Byte2SByte(COMMON.vZ80cpu.A)) + CInt(COMMON.Byte2SByte(P))
        j = COMMON.Byte2SByte(i)
        COMMON.vZ80cpu.A = i And &HFF
        Call COMMON.vZ80cpu.FlagPflag1((j < -128) Or (j > 127))
        Call COMMON.vZ80cpu.FlagSflag1((i And 128))
        Call COMMON.vZ80cpu.FlagZflag2(COMMON.vZ80cpu.A <> 0)
        Call COMMON.vZ80cpu.FlagNflag2()
        op_adayd = 19
    End Function '86    'op_adayd
    Private Function op_acayd() As Integer                                      '&H8E         'ADC A,(IY+d)
        Dim i, carry As Integer
        Dim P As Byte
        Dim j As SByte
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        If (COMMON.vZ80cpu.F And C_FLAG) = C_FLAG Then carry = 1 Else carry = 0
        Call COMMON.vZ80cpu.PCplus1() : P = COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.IY + COMMON.Byte2SByte(COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.PC)))
        Call COMMON.vZ80cpu.FlagHflag1((COMMON.vZ80cpu.A And &HF) + (P And &HF) + carry > &HF)
        Call COMMON.vZ80cpu.FlagCflag1(CInt(COMMON.vZ80cpu.A) + CInt(P) + carry > 255)
        i = CInt(COMMON.vZ80cpu.A) + CInt(P) + carry        'i = CInt(COMMON.Byte2SByte(COMMON.vZ80cpu.A)) + CInt(COMMON.Byte2SByte(P)) + carry
        j = COMMON.Byte2SByte(i)
        COMMON.vZ80cpu.A = i And &HFF
        Call COMMON.vZ80cpu.FlagPflag1((j < -128) Or (j > 127))
        Call COMMON.vZ80cpu.FlagSflag1((i And 128))
        Call COMMON.vZ80cpu.FlagZflag2(COMMON.vZ80cpu.A <> 0)
        Call COMMON.vZ80cpu.FlagNflag2()
        op_acayd = 19
    End Function '8E    'op_acayd
    Private Function op_suayd() As Integer                                      '&H96         'SUB A,(IY+d)
        Dim i As Integer
        Dim P As Byte
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        Call COMMON.vZ80cpu.PCplus1() : P = COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.IY + COMMON.Byte2SByte(COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.PC)))
        Call COMMON.vZ80cpu.FlagHflag1((P And &HF) > (COMMON.vZ80cpu.A And &HF))
        Call COMMON.vZ80cpu.FlagCflag1(P > COMMON.vZ80cpu.A)
        i = CInt(COMMON.vZ80cpu.A) - CInt(P)        'i = CInt(COMMON.Byte2SByte(COMMON.vZ80cpu.A)) - CInt(COMMON.Byte2SByte(P))
        COMMON.vZ80cpu.A = i And &HFF
        Call COMMON.vZ80cpu.FlagPflag1((i < -128) Or (i > 127))
        Call COMMON.vZ80cpu.FlagSflag1((i And 128))
        Call COMMON.vZ80cpu.FlagZflag2(COMMON.vZ80cpu.A <> 0)
        Call COMMON.vZ80cpu.FlagNflag1()
        op_suayd = 19
    End Function '96    'op_suayd
    Private Function op_scayd() As Integer                                      '&H9E         'SBC A,(IY+d)
        Dim i, carry As Integer
        Dim P As Byte
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        If (COMMON.vZ80cpu.F And C_FLAG) = C_FLAG Then carry = 1 Else carry = 0
        Call COMMON.vZ80cpu.PCplus1() : P = COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.IY + COMMON.Byte2SByte(COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.PC)))
        Call COMMON.vZ80cpu.FlagHflag1((P And &HF) + carry > (COMMON.vZ80cpu.A And &HF))
        Call COMMON.vZ80cpu.FlagCflag1(P + carry > COMMON.vZ80cpu.A)
        i = CInt(COMMON.vZ80cpu.A) - CInt(P) - carry      'i = CInt(COMMON.Byte2SByte(COMMON.vZ80cpu.A)) - CInt(COMMON.Byte2SByte(P)) - carry
        COMMON.vZ80cpu.A = i And &HFF
        Call COMMON.vZ80cpu.FlagPflag1((i < -128) Or (i > 127))
        Call COMMON.vZ80cpu.FlagSflag1((i And 128))
        Call COMMON.vZ80cpu.FlagZflag2(COMMON.vZ80cpu.A <> 0)
        Call COMMON.vZ80cpu.FlagNflag1()
        op_scayd = 19
    End Function '9E    'op_scayd
#End Region

#Region "AND XOR OR CP (IY+d)"
    '------------------------------------
    Private Function op_andyd() As Integer                                      '&HA6         'AND (IY+d)
        COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        Call COMMON.vZ80cpu.PCplus1() : COMMON.vZ80cpu.A = COMMON.vZ80cpu.A And COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.IY + COMMON.Byte2SByte(COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.PC)))
        Call COMMON.vZ80cpu.FlagSflag1((COMMON.vZ80cpu.A And 128))
        Call COMMON.vZ80cpu.FlagZflag2(COMMON.vZ80cpu.A <> 0)
        COMMON.vZ80cpu.F = COMMON.vZ80cpu.F Or COMMON.H_FLAG
        Call COMMON.vZ80cpu.FlagPflag2(COMMON.vZ80cpu.parrity(COMMON.vZ80cpu.A) = 1)
        COMMON.vZ80cpu.F = COMMON.vZ80cpu.F And Not (COMMON.N_FLAG Or COMMON.C_FLAG)
        op_andyd = 19
    End Function 'A6    'op_andyd
    Private Function op_xoryd() As Integer                                      '&HAE         'XOR (IY+d)
        COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        Call COMMON.vZ80cpu.PCplus1() : COMMON.vZ80cpu.A = COMMON.vZ80cpu.A Xor COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.IY + COMMON.Byte2SByte(COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.PC)))
        Call COMMON.vZ80cpu.FlagSflag1((COMMON.vZ80cpu.A And 128))
        Call COMMON.vZ80cpu.FlagZflag2(COMMON.vZ80cpu.A <> 0)
        Call COMMON.vZ80cpu.FlagPflag2(COMMON.vZ80cpu.parrity(COMMON.vZ80cpu.A) = 1)
        COMMON.vZ80cpu.F = COMMON.vZ80cpu.F And Not (COMMON.H_FLAG Or COMMON.N_FLAG Or COMMON.C_FLAG)
        op_xoryd = 19
    End Function 'AE    'op_xoryd
    Private Function op_oryd() As Integer                                       '&HB6         'OR (IY+d)
        COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        Call COMMON.vZ80cpu.PCplus1() : COMMON.vZ80cpu.A = COMMON.vZ80cpu.A Or COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.IY + COMMON.Byte2SByte(COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.PC)))
        Call COMMON.vZ80cpu.FlagSflag1((COMMON.vZ80cpu.A And 128))
        Call COMMON.vZ80cpu.FlagZflag2(COMMON.vZ80cpu.A <> 0)
        Call COMMON.vZ80cpu.FlagPflag2(COMMON.vZ80cpu.parrity(COMMON.vZ80cpu.A) = 1)
        COMMON.vZ80cpu.F = COMMON.vZ80cpu.F And Not (COMMON.H_FLAG Or COMMON.N_FLAG Or COMMON.C_FLAG)
        op_oryd = 19
    End Function 'B6    'op_oryd
    Private Function op_cpyd() As Integer                                       '&HBE         'CP (IY+d)
        Dim i As Integer
        Dim P As Byte
        COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        Call COMMON.vZ80cpu.PCplus1() : P = COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.IY + COMMON.Byte2SByte(COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.PC)))
        Call COMMON.vZ80cpu.FlagHflag1((P And &HF) > (COMMON.vZ80cpu.A And &HF))
        Call COMMON.vZ80cpu.FlagCflag1(P > COMMON.vZ80cpu.A)
        i = CInt(COMMON.vZ80cpu.A) - CInt(P)         'i = CInt(COMMON.Byte2SByte(COMMON.vZ80cpu.A)) - CInt(COMMON.Byte2SByte(P))
        Call COMMON.vZ80cpu.FlagPflag1((i < -128) Or (i > 127))
        Call COMMON.vZ80cpu.FlagSflag1((i And 128))
        Call COMMON.vZ80cpu.FlagZflag2(i <> 0)
        Call COMMON.vZ80cpu.FlagNflag1()
        op_cpyd = 19
    End Function 'BE    'op_cpyd
#End Region

#Region "POP IY  EX (SP),IY  PUSH IY  JP (IY)  LD SP,IY"
    '------------------------------------
    Private Function op_popiy() As Integer                                      '&HE1         'POP IY
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_STACK Or COMMON.CPU_MEMR)
        COMMON.vZ80cpu.IY = COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.STACK)
        Call COMMON.vZ80cpu.SPplus1()
        COMMON.vZ80cpu.IY = COMMON.vZ80cpu.IY + (COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.STACK) * 256)
        Call COMMON.vZ80cpu.SPplus1()
        op_popiy = 14
    End Function 'E1    'op_popiy
    Private Function op_exspy() As Integer                                      '&HE3         'EX (SP),IY
        Dim i As Integer
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_STACK Or COMMON.CPU_MEMR)
        i = COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.STACK) + COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.STACK + 1) * 256
        COMMON.vZ80cpu.Speicher_schreiben_Byte(COMMON.vZ80cpu.STACK, COMMON.vZ80cpu.IY And &HFF)
        COMMON.vZ80cpu.Speicher_schreiben_Byte(COMMON.vZ80cpu.STACK + 1, (COMMON.vZ80cpu.IY >> 8) And &HFF)
        COMMON.vZ80cpu.IY = i
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_STACK)
        op_exspy = 23
    End Function 'E3    'op_exspy
    Private Function op_pusiy() As Integer                                      '&HE5         'PUSH IY
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_STACK)
        Call COMMON.vZ80cpu.SPminus1()
        COMMON.vZ80cpu.Speicher_schreiben_Byte(COMMON.vZ80cpu.STACK, COMMON.vZ80cpu.IY \ 256)
        Call COMMON.vZ80cpu.SPminus1()
        COMMON.vZ80cpu.Speicher_schreiben_Byte(COMMON.vZ80cpu.STACK, COMMON.vZ80cpu.IY And &HFF)
        op_pusiy = 15
    End Function 'E5    'op_pusiy
    Private Function op_jpiy() As Integer                                       '&HE9         'JP (IY)
        COMMON.vZ80cpu.PC = COMMON.vZ80cpu.IY
        COMMON.vZ80cpu.PCminus1()
        op_jpiy = 8
    End Function 'E9    'op_jpiy
    Private Function op_ldspy() As Integer                                      '&HF9         'LD SP,IY
        COMMON.vZ80cpu.STACK = COMMON.vZ80cpu.IY
        op_ldspy = 10
        If Haupt.BufferAnzeigenVis.Checked Then Call AnzeigeBuffer.AnzeigeBuffer2()
    End Function 'F9    'op_ldspy
#End Region

#Region "undocumented Z80 instructions: LD IYL,A  CP IYL"
    'BMK undocumented Z80 instructions
    '=================================
#If Z80_UNDOC0 = 1 Then
    Private Function op_undoc_ldiyl() As Integer                                '&H6F         'LD IYL,A
        If (COMMON.vZ80cpu.F And COMMON.Z_FLAG) = COMMON.Z_FLAG Then
            op_undoc_ldiyl = trap_fd()
        Else
            COMMON.vZ80cpu.IY = (COMMON.vZ80cpu.IX And &HFF00) Or COMMON.vZ80cpu.A
            op_undoc_ldiyl = 9
        End If
    End Function '6F    'op_undoc_ldiyl
    Private Function op_undoc_cpiyl() As Integer                                '&HBD         'CP IYL
        Dim i As Integer
        Dim P As Byte

        If (COMMON.vZ80cpu.F And COMMON.Z_FLAG) = COMMON.Z_FLAG Then
            op_undoc_cpiyl = trap_fd()
        Else
            P = COMMON.vZ80cpu.IY And &HFF
            Call COMMON.vZ80cpu.FlagHflag1((P And &HF) > (COMMON.vZ80cpu.A And &HF))
            Call COMMON.vZ80cpu.FlagCflag1(P > COMMON.vZ80cpu.A)
            i = CInt(COMMON.Byte2SByte(COMMON.vZ80cpu.A)) - CInt(COMMON.Byte2SByte(P))
            Call COMMON.vZ80cpu.FlagPflag1(i < -128 Or i > 127)
            Call COMMON.vZ80cpu.FlagSflag1((i And 128))
            Call COMMON.vZ80cpu.FlagZflag2(i <> 0)
            Call COMMON.vZ80cpu.FlagNflag1()
            op_undoc_cpiyl = 9
        End If
    End Function 'BD    'op_undoc_cpiyl
#End If
#End Region

    '====================================
    Public Function op_fd_handel() As Integer
        Call COMMON.vZ80cpu.PCplus1()
        op_fd_handel = op_fd1.op_sim(COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.PC)).Invoke()
    End Function ' op_fd_handel
End Module ' FD
