﻿Imports DEG2000.Z80cpu

Module DD
    ' Like the function "cpu()" this one emulates multi byte opcodes starting with 0xDD

    Public Class op_dd
        Public op_sim(0 To 255) As opfunc

        Public Sub New()
            op_sim(&H0) = New opfunc(AddressOf trap_dd) : op_sim(&H1) = New opfunc(AddressOf trap_dd) : op_sim(&H2) = New opfunc(AddressOf trap_dd) : op_sim(&H3) = New opfunc(AddressOf trap_dd)
            op_sim(&H4) = New opfunc(AddressOf trap_dd) : op_sim(&H5) = New opfunc(AddressOf trap_dd) : op_sim(&H6) = New opfunc(AddressOf trap_dd) : op_sim(&H7) = New opfunc(AddressOf trap_dd)
            op_sim(&H8) = New opfunc(AddressOf trap_dd) : op_sim(&H9) = New opfunc(AddressOf op_addxb) : op_sim(&HA) = New opfunc(AddressOf trap_dd) : op_sim(&HB) = New opfunc(AddressOf trap_dd)
            op_sim(&HC) = New opfunc(AddressOf trap_dd) : op_sim(&HD) = New opfunc(AddressOf trap_dd) : op_sim(&HE) = New opfunc(AddressOf trap_dd) : op_sim(&HF) = New opfunc(AddressOf trap_dd)

            op_sim(&H10) = New opfunc(AddressOf trap_dd) : op_sim(&H11) = New opfunc(AddressOf trap_dd) : op_sim(&H12) = New opfunc(AddressOf trap_dd) : op_sim(&H13) = New opfunc(AddressOf trap_dd)
            op_sim(&H14) = New opfunc(AddressOf trap_dd) : op_sim(&H15) = New opfunc(AddressOf trap_dd) : op_sim(&H16) = New opfunc(AddressOf trap_dd) : op_sim(&H17) = New opfunc(AddressOf trap_dd)
            op_sim(&H18) = New opfunc(AddressOf trap_dd) : op_sim(&H19) = New opfunc(AddressOf op_addxd) : op_sim(&H1A) = New opfunc(AddressOf trap_dd) : op_sim(&H1B) = New opfunc(AddressOf trap_dd)
            op_sim(&H1C) = New opfunc(AddressOf trap_dd) : op_sim(&H1D) = New opfunc(AddressOf trap_dd) : op_sim(&H1E) = New opfunc(AddressOf trap_dd) : op_sim(&H1F) = New opfunc(AddressOf trap_dd)

            op_sim(&H20) = New opfunc(AddressOf trap_dd) : op_sim(&H21) = New opfunc(AddressOf op_ldixnn) : op_sim(&H22) = New opfunc(AddressOf op_ldinx) : op_sim(&H23) = New opfunc(AddressOf op_incix)
            op_sim(&H24) = New opfunc(AddressOf trap_dd) : op_sim(&H25) = New opfunc(AddressOf trap_dd) : op_sim(&H26) = New opfunc(AddressOf trap_dd) : op_sim(&H27) = New opfunc(AddressOf trap_dd)
            op_sim(&H28) = New opfunc(AddressOf trap_dd) : op_sim(&H29) = New opfunc(AddressOf op_addxx) : op_sim(&H2A) = New opfunc(AddressOf op_ldixinn) : op_sim(&H2B) = New opfunc(AddressOf op_decix)
            op_sim(&H2C) = New opfunc(AddressOf trap_dd) : op_sim(&H2D) = New opfunc(AddressOf trap_dd) : op_sim(&H2E) = New opfunc(AddressOf trap_dd) : op_sim(&H2F) = New opfunc(AddressOf trap_dd)

            op_sim(&H30) = New opfunc(AddressOf trap_dd) : op_sim(&H31) = New opfunc(AddressOf trap_dd) : op_sim(&H32) = New opfunc(AddressOf trap_dd) : op_sim(&H33) = New opfunc(AddressOf trap_dd)
            op_sim(&H34) = New opfunc(AddressOf op_incxd) : op_sim(&H35) = New opfunc(AddressOf op_decxd) : op_sim(&H36) = New opfunc(AddressOf op_ldxdn) : op_sim(&H37) = New opfunc(AddressOf trap_dd)
            op_sim(&H38) = New opfunc(AddressOf trap_dd) : op_sim(&H39) = New opfunc(AddressOf op_addxs) : op_sim(&H3A) = New opfunc(AddressOf trap_dd) : op_sim(&H3B) = New opfunc(AddressOf trap_dd)
            op_sim(&H3C) = New opfunc(AddressOf trap_dd) : op_sim(&H3D) = New opfunc(AddressOf trap_dd) : op_sim(&H3E) = New opfunc(AddressOf trap_dd) : op_sim(&H3F) = New opfunc(AddressOf trap_dd)

            op_sim(&H40) = New opfunc(AddressOf trap_dd) : op_sim(&H41) = New opfunc(AddressOf trap_dd) : op_sim(&H42) = New opfunc(AddressOf trap_dd) : op_sim(&H43) = New opfunc(AddressOf trap_dd)
            op_sim(&H44) = New opfunc(AddressOf trap_dd) : op_sim(&H45) = New opfunc(AddressOf trap_dd) : op_sim(&H46) = New opfunc(AddressOf op_ldbxd) : op_sim(&H47) = New opfunc(AddressOf trap_dd)
            op_sim(&H48) = New opfunc(AddressOf trap_dd) : op_sim(&H49) = New opfunc(AddressOf trap_dd) : op_sim(&H4A) = New opfunc(AddressOf trap_dd) : op_sim(&H4B) = New opfunc(AddressOf trap_dd)
            op_sim(&H4C) = New opfunc(AddressOf trap_dd) : op_sim(&H4D) = New opfunc(AddressOf trap_dd) : op_sim(&H4E) = New opfunc(AddressOf op_ldcxd) : op_sim(&H4F) = New opfunc(AddressOf trap_dd)

            op_sim(&H50) = New opfunc(AddressOf trap_dd) : op_sim(&H51) = New opfunc(AddressOf trap_dd) : op_sim(&H52) = New opfunc(AddressOf trap_dd) : op_sim(&H53) = New opfunc(AddressOf trap_dd)
            op_sim(&H54) = New opfunc(AddressOf trap_dd) : op_sim(&H55) = New opfunc(AddressOf trap_dd) : op_sim(&H56) = New opfunc(AddressOf op_lddxd) : op_sim(&H57) = New opfunc(AddressOf trap_dd)
            op_sim(&H58) = New opfunc(AddressOf trap_dd) : op_sim(&H59) = New opfunc(AddressOf trap_dd) : op_sim(&H5A) = New opfunc(AddressOf trap_dd) : op_sim(&H5B) = New opfunc(AddressOf trap_dd)
            op_sim(&H5C) = New opfunc(AddressOf trap_dd) : op_sim(&H5D) = New opfunc(AddressOf trap_dd) : op_sim(&H5E) = New opfunc(AddressOf op_ldexd) : op_sim(&H5F) = New opfunc(AddressOf trap_dd)

            op_sim(&H60) = New opfunc(AddressOf trap_dd) : op_sim(&H61) = New opfunc(AddressOf trap_dd) : op_sim(&H62) = New opfunc(AddressOf trap_dd) : op_sim(&H63) = New opfunc(AddressOf trap_dd)
            op_sim(&H64) = New opfunc(AddressOf trap_dd) : op_sim(&H65) = New opfunc(AddressOf trap_dd) : op_sim(&H66) = New opfunc(AddressOf op_ldhxd) : op_sim(&H67) = New opfunc(AddressOf trap_dd)
            op_sim(&H68) = New opfunc(AddressOf trap_dd) : op_sim(&H69) = New opfunc(AddressOf trap_dd) : op_sim(&H6A) = New opfunc(AddressOf trap_dd) : op_sim(&H6B) = New opfunc(AddressOf trap_dd)
            op_sim(&H6C) = New opfunc(AddressOf trap_dd) : op_sim(&H6D) = New opfunc(AddressOf trap_dd) : op_sim(&H6E) = New opfunc(AddressOf op_ldlxd) : op_sim(&H6F) = New opfunc(AddressOf trap_dd)

            op_sim(&H70) = New opfunc(AddressOf op_ldxdb) : op_sim(&H71) = New opfunc(AddressOf op_ldxdc) : op_sim(&H72) = New opfunc(AddressOf op_ldxdd) : op_sim(&H73) = New opfunc(AddressOf op_ldxde)
            op_sim(&H74) = New opfunc(AddressOf op_ldxdh) : op_sim(&H75) = New opfunc(AddressOf op_ldxdl) : op_sim(&H76) = New opfunc(AddressOf trap_dd) : op_sim(&H77) = New opfunc(AddressOf op_ldxda)
            op_sim(&H78) = New opfunc(AddressOf trap_dd) : op_sim(&H79) = New opfunc(AddressOf trap_dd) : op_sim(&H7A) = New opfunc(AddressOf trap_dd) : op_sim(&H7B) = New opfunc(AddressOf trap_dd)
            op_sim(&H7C) = New opfunc(AddressOf trap_dd) : op_sim(&H7D) = New opfunc(AddressOf trap_dd) : op_sim(&H7E) = New opfunc(AddressOf op_ldaxd) : op_sim(&H7F) = New opfunc(AddressOf trap_dd)

            op_sim(&H80) = New opfunc(AddressOf trap_dd) : op_sim(&H81) = New opfunc(AddressOf trap_dd) : op_sim(&H82) = New opfunc(AddressOf trap_dd) : op_sim(&H83) = New opfunc(AddressOf trap_dd)
            op_sim(&H84) = New opfunc(AddressOf trap_dd) : op_sim(&H85) = New opfunc(AddressOf trap_dd) : op_sim(&H86) = New opfunc(AddressOf op_adaxd) : op_sim(&H87) = New opfunc(AddressOf trap_dd)
            op_sim(&H88) = New opfunc(AddressOf trap_dd) : op_sim(&H89) = New opfunc(AddressOf trap_dd) : op_sim(&H8A) = New opfunc(AddressOf trap_dd) : op_sim(&H8B) = New opfunc(AddressOf trap_dd)
            op_sim(&H8C) = New opfunc(AddressOf trap_dd) : op_sim(&H8D) = New opfunc(AddressOf trap_dd) : op_sim(&H8E) = New opfunc(AddressOf op_acaxd) : op_sim(&H8F) = New opfunc(AddressOf trap_dd)

            op_sim(&H90) = New opfunc(AddressOf trap_dd) : op_sim(&H91) = New opfunc(AddressOf trap_dd) : op_sim(&H92) = New opfunc(AddressOf trap_dd) : op_sim(&H93) = New opfunc(AddressOf trap_dd)
            op_sim(&H94) = New opfunc(AddressOf trap_dd) : op_sim(&H95) = New opfunc(AddressOf trap_dd) : op_sim(&H96) = New opfunc(AddressOf op_suaxd) : op_sim(&H97) = New opfunc(AddressOf trap_dd)
            op_sim(&H98) = New opfunc(AddressOf trap_dd) : op_sim(&H99) = New opfunc(AddressOf trap_dd) : op_sim(&H9A) = New opfunc(AddressOf trap_dd) : op_sim(&H9B) = New opfunc(AddressOf trap_dd)
            op_sim(&H9C) = New opfunc(AddressOf trap_dd) : op_sim(&H9D) = New opfunc(AddressOf trap_dd) : op_sim(&H9E) = New opfunc(AddressOf op_scaxd) : op_sim(&H9F) = New opfunc(AddressOf trap_dd)

            op_sim(&HA0) = New opfunc(AddressOf trap_dd) : op_sim(&HA1) = New opfunc(AddressOf trap_dd) : op_sim(&HA2) = New opfunc(AddressOf trap_dd) : op_sim(&HA3) = New opfunc(AddressOf trap_dd)
            op_sim(&HA4) = New opfunc(AddressOf trap_dd) : op_sim(&HA5) = New opfunc(AddressOf trap_dd) : op_sim(&HA6) = New opfunc(AddressOf op_andxd) : op_sim(&HA7) = New opfunc(AddressOf trap_dd)
            op_sim(&HA8) = New opfunc(AddressOf trap_dd) : op_sim(&HA9) = New opfunc(AddressOf trap_dd) : op_sim(&HAA) = New opfunc(AddressOf trap_dd) : op_sim(&HAB) = New opfunc(AddressOf trap_dd)
            op_sim(&HAC) = New opfunc(AddressOf trap_dd) : op_sim(&HAD) = New opfunc(AddressOf trap_dd) : op_sim(&HAE) = New opfunc(AddressOf op_xorxd) : op_sim(&HAF) = New opfunc(AddressOf trap_dd)

            op_sim(&HB0) = New opfunc(AddressOf trap_dd) : op_sim(&HB1) = New opfunc(AddressOf trap_dd) : op_sim(&HB2) = New opfunc(AddressOf trap_dd) : op_sim(&HB3) = New opfunc(AddressOf trap_dd)
            op_sim(&HB4) = New opfunc(AddressOf trap_dd) : op_sim(&HB5) = New opfunc(AddressOf trap_dd) : op_sim(&HB6) = New opfunc(AddressOf op_orxd) : op_sim(&HB7) = New opfunc(AddressOf trap_dd)
            op_sim(&HB8) = New opfunc(AddressOf trap_dd) : op_sim(&HB9) = New opfunc(AddressOf trap_dd) : op_sim(&HBA) = New opfunc(AddressOf trap_dd) : op_sim(&HBB) = New opfunc(AddressOf trap_dd)
            op_sim(&HBC) = New opfunc(AddressOf trap_dd) : op_sim(&HBD) = New opfunc(AddressOf trap_dd) : op_sim(&HBE) = New opfunc(AddressOf op_cpxd) : op_sim(&HBF) = New opfunc(AddressOf trap_dd)

            op_sim(&HC0) = New opfunc(AddressOf trap_dd) : op_sim(&HC1) = New opfunc(AddressOf trap_dd) : op_sim(&HC2) = New opfunc(AddressOf trap_dd) : op_sim(&HC3) = New opfunc(AddressOf trap_dd)
            op_sim(&HC4) = New opfunc(AddressOf trap_dd) : op_sim(&HC5) = New opfunc(AddressOf trap_dd) : op_sim(&HC6) = New opfunc(AddressOf trap_dd) : op_sim(&HC7) = New opfunc(AddressOf trap_dd)
            op_sim(&HC8) = New opfunc(AddressOf trap_dd) : op_sim(&HC9) = New opfunc(AddressOf trap_dd) : op_sim(&HCA) = New opfunc(AddressOf trap_dd) : op_sim(&HCB) = New opfunc(AddressOf op_ddcb_handel)
            op_sim(&HCC) = New opfunc(AddressOf trap_dd) : op_sim(&HCD) = New opfunc(AddressOf trap_dd) : op_sim(&HCE) = New opfunc(AddressOf trap_dd) : op_sim(&HCF) = New opfunc(AddressOf trap_dd)

            op_sim(&HD0) = New opfunc(AddressOf trap_dd) : op_sim(&HD1) = New opfunc(AddressOf trap_dd) : op_sim(&HD2) = New opfunc(AddressOf trap_dd) : op_sim(&HD3) = New opfunc(AddressOf trap_dd)
            op_sim(&HD4) = New opfunc(AddressOf trap_dd) : op_sim(&HD5) = New opfunc(AddressOf trap_dd) : op_sim(&HD6) = New opfunc(AddressOf trap_dd) : op_sim(&HD7) = New opfunc(AddressOf trap_dd)
            op_sim(&HD8) = New opfunc(AddressOf trap_dd) : op_sim(&HD9) = New opfunc(AddressOf trap_dd) : op_sim(&HDA) = New opfunc(AddressOf trap_dd) : op_sim(&HDB) = New opfunc(AddressOf trap_dd)
            op_sim(&HDC) = New opfunc(AddressOf trap_dd) : op_sim(&HDD) = New opfunc(AddressOf trap_dd) : op_sim(&HDE) = New opfunc(AddressOf trap_dd) : op_sim(&HDF) = New opfunc(AddressOf trap_dd)

            op_sim(&HE0) = New opfunc(AddressOf trap_dd) : op_sim(&HE1) = New opfunc(AddressOf op_popix) : op_sim(&HE2) = New opfunc(AddressOf trap_dd) : op_sim(&HE3) = New opfunc(AddressOf op_exspx)
            op_sim(&HE4) = New opfunc(AddressOf trap_dd) : op_sim(&HE5) = New opfunc(AddressOf op_pusix) : op_sim(&HE6) = New opfunc(AddressOf trap_dd) : op_sim(&HE7) = New opfunc(AddressOf trap_dd)
            op_sim(&HE8) = New opfunc(AddressOf trap_dd) : op_sim(&HE9) = New opfunc(AddressOf op_jpix) : op_sim(&HEA) = New opfunc(AddressOf trap_dd) : op_sim(&HEB) = New opfunc(AddressOf trap_dd)
            op_sim(&HEC) = New opfunc(AddressOf trap_dd) : op_sim(&HED) = New opfunc(AddressOf trap_dd) : op_sim(&HEE) = New opfunc(AddressOf trap_dd) : op_sim(&HEF) = New opfunc(AddressOf trap_dd)

            op_sim(&HF0) = New opfunc(AddressOf trap_dd) : op_sim(&HF1) = New opfunc(AddressOf trap_dd) : op_sim(&HF2) = New opfunc(AddressOf trap_dd) : op_sim(&HF3) = New opfunc(AddressOf trap_dd)
            op_sim(&HF4) = New opfunc(AddressOf trap_dd) : op_sim(&HF5) = New opfunc(AddressOf trap_dd) : op_sim(&HF6) = New opfunc(AddressOf trap_dd) : op_sim(&HF7) = New opfunc(AddressOf trap_dd)
            op_sim(&HF8) = New opfunc(AddressOf trap_dd) : op_sim(&HF9) = New opfunc(AddressOf op_ldspx) : op_sim(&HFA) = New opfunc(AddressOf trap_dd) : op_sim(&HFB) = New opfunc(AddressOf trap_dd)
            op_sim(&HFC) = New opfunc(AddressOf trap_dd) : op_sim(&HFD) = New opfunc(AddressOf trap_dd) : op_sim(&HFE) = New opfunc(AddressOf trap_dd) : op_sim(&HFF) = New opfunc(AddressOf trap_dd)

#If Z80_UNDOC0 = 1 Then
            op_sim(&H6F) = New opfunc(AddressOf op_undoc_ldixl)
            op_sim(&HBD) = New opfunc(AddressOf op_undoc_cpixl)
#End If
        End Sub ' New
    End Class ' op_dd

    Public op_dd1 As New op_dd

    '====================================
    ' This function traps all illegal opcodes following the initial 0xDD of a multi byte opcode.
    Private Function trap_dd() As Integer
        Call Haupt.cpuError(COMMON.OPTRAP2)
        Call Haupt.cpuState(COMMON.STOPPED)
        trap_dd = 0
    End Function ' trap_dd

#Region "ADD IX,xx"
    '------------------------------------
    Private Function op_addxb() As Integer                                      '&H09         'ADD IX,BC
        op_addxb = add(COMMON.vZ80cpu.B, COMMON.vZ80cpu.C)
    End Function '09    'op_addxb
    Private Function op_addxd() As Integer                                      '&H19         'ADD IX,DE
        op_addxd = add(COMMON.vZ80cpu.D, COMMON.vZ80cpu.E)
    End Function '19    'op_addxd
    Private Function op_addxx() As Integer                                      '&H29         'ADD IX,IX
        op_addxx = add((COMMON.vZ80cpu.IX And &HFF00) >> 8, COMMON.vZ80cpu.IX And &HFF)
    End Function '29    'op_addxx
    Private Function op_addxs() As Integer                                      '&H39         'ADD IX,SP
        op_addxs = add((COMMON.vZ80cpu.STACK And &HFF00) >> 8, COMMON.vZ80cpu.STACK And &HFF)
    End Function '39    'op_addxs
    Private Function add(ByVal par1 As Byte, ByVal par2 As Byte) As Integer
        Dim carry As Integer
        Dim ixh As Integer
        Dim ixl As Integer

        ixh = (COMMON.vZ80cpu.IX And &HFF00) >> 8
        ixl = COMMON.vZ80cpu.IX And &HFF
        If CInt(ixl) + CInt(Par2) > 255 Then carry = 1 Else carry = 0
        ixl = ixl + par2
        Call COMMON.vZ80cpu.FlagHflag1((ixh And &HF) + (par1 And &HF) + carry > &HF)
        Call COMMON.vZ80cpu.FlagCflag1(ixh + par1 + carry > 255)
        ixh = ixh + par1 + carry
        COMMON.vZ80cpu.IX = ((ixh And &HFF) << 8) + (ixl And &HFF)
        Call COMMON.vZ80cpu.FlagNflag2()
        add = 15
    End Function ' add
#End Region
#Region "LD IX,nn  LD (nn),IX  INC IX"
    '------------------------------------
    Private Function op_ldixnn() As Integer                                     '&H21         'LD IX,nn
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        Call COMMON.vZ80cpu.PCplus1() : COMMON.vZ80cpu.IX = COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.PC)
        Call COMMON.vZ80cpu.PCplus1() : COMMON.vZ80cpu.IX = COMMON.vZ80cpu.IX + COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.PC) * 256
        op_ldixnn = 14
    End Function '21    'op_ldixnn
    Private Function op_ldinx() As Integer                                      '&H22         'LD (nn),IX
        Dim p As ULong
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_NONE)
        Call COMMON.vZ80cpu.PCplus1() : p = COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.PC)
        Call COMMON.vZ80cpu.PCplus1() : p = p + COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.PC) * 256
        COMMON.vZ80cpu.Speicher_schreiben_Byte(p, COMMON.vZ80cpu.IX And &HFF) : p = p + 1
        COMMON.vZ80cpu.Speicher_schreiben_Byte(p, COMMON.vZ80cpu.IX \ 256)
        op_ldinx = 20
    End Function '22    'op_ldinx
    Private Function op_incix() As Integer                                      '&H23         'INC IX
        Call COMMON.vZ80cpu.IXYplus1(COMMON.vZ80cpu.IX)
        op_incix = 10
    End Function '23    'op_incix
#End Region
#Region "LD IX,(nn)  DEC IX"
    '------------------------------------
    Private Function op_ldixinn() As Integer                                    '&H2A         'LD IX,(nn)
        Dim p As ULong
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        Call COMMON.vZ80cpu.PCplus1() : p = COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.PC)
        Call COMMON.vZ80cpu.PCplus1() : p = p + COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.PC) * 256
        COMMON.vZ80cpu.IX = COMMON.vZ80cpu.Speicher_lesen_Byte(p) : p = p + 1
        COMMON.vZ80cpu.IX = COMMON.vZ80cpu.IX + COMMON.vZ80cpu.Speicher_lesen_Byte(p) * 256
        op_ldixinn = 20
    End Function '2A    'op_ldixinn
    Private Function op_decix() As Integer                                      '&H2B         'DEC IX
        Call COMMON.vZ80cpu.IXYminus1(COMMON.vZ80cpu.IX)
        op_decix = 10
    End Function '2B    'op_decix
#End Region

#Region "INC (IX+d)  DEC (IX+d)  LD (IX+d),n"
    '------------------------------------
    Private Function op_incxd() As Integer                                      '&H34         'INC (IX+d)
        Dim p As ULong
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        Call COMMON.vZ80cpu.PCplus1() : p = COMMON.vZ80cpu.IX + COMMON.Byte2SByte(COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.PC))
        Call COMMON.vZ80cpu.FlagHflag1((COMMON.vZ80cpu.Speicher_lesen_Byte(p) And &HF) + 1 > &HF)
        COMMON.vZ80cpu.Speicher_schreiben_Byte(p, COMMON.vZ80cpu.Speicher_lesen_Byte(p) + 1)
        Call COMMON.vZ80cpu.FlagPflag1(COMMON.vZ80cpu.Speicher_lesen_Byte(p) = 128)
        Call COMMON.vZ80cpu.FlagSflag1((COMMON.vZ80cpu.Speicher_lesen_Byte(p) And 128))
        Call COMMON.vZ80cpu.FlagZflag2((COMMON.vZ80cpu.Speicher_lesen_Byte(p)) <> 0)
        Call COMMON.vZ80cpu.FlagNflag2()
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_NONE)
        op_incxd = 23
    End Function '34    'op_incxd
    Private Function op_decxd() As Integer                                      '&H35         'DEC (IX+d)
        Dim p As ULong
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        Call COMMON.vZ80cpu.PCplus1() : p = COMMON.vZ80cpu.IX + COMMON.Byte2SByte(COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.PC))
        Call COMMON.vZ80cpu.FlagHflag1((COMMON.vZ80cpu.Speicher_lesen_Byte(p) - 1 And &HF) = &HF)
        COMMON.vZ80cpu.Speicher_schreiben_Byte(p, COMMON.vZ80cpu.Speicher_lesen_Byte(p) - 1)
        Call COMMON.vZ80cpu.FlagPflag1(COMMON.vZ80cpu.Speicher_lesen_Byte(p) = 127)
        Call COMMON.vZ80cpu.FlagSflag1((COMMON.vZ80cpu.Speicher_lesen_Byte(p) And 128))
        Call COMMON.vZ80cpu.FlagZflag2((COMMON.vZ80cpu.Speicher_lesen_Byte(p)) <> 0)
        Call COMMON.vZ80cpu.FlagNflag1()
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_NONE)
        op_decxd = 23
    End Function '35    'op_decxd
    Private Function op_ldxdn() As Integer                                      '&H36         'LD (IX+d),n
        Dim d As Integer
        Dim n As Integer
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        Call COMMON.vZ80cpu.PCplus1() : d = COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.PC)
        Call COMMON.vZ80cpu.PCplus1() : n = COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.PC)
        Call COMMON.vZ80cpu.Speicher_schreiben_Byte(COMMON.vZ80cpu.IX + d, n)
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_NONE)
        op_ldxdn = 19
    End Function '36    'op_ldxdn
#End Region

#Region "LD x,(IX+d)"
    '------------------------------------
    Private Function op_ldbxd() As Integer                                      '&H46         'LD B,(IX+d)
        op_ldbxd = ldixd(COMMON.vZ80cpu.B)
    End Function '46    'op_ldbxd
    Private Function op_ldcxd() As Integer                                      '&H4E         'LD C,(IX+d)
        op_ldcxd = ldixd(COMMON.vZ80cpu.C)
    End Function '4E    'op_ldcxd
    Private Function op_lddxd() As Integer                                      '&H56         'LD D,(IX+d)
        op_lddxd = ldixd(COMMON.vZ80cpu.D)
    End Function '56    'op_lddxd
    Private Function op_ldexd() As Integer                                      '&H5E         'LD E,(IX+d) 
        op_ldexd = ldixd(COMMON.vZ80cpu.E)
    End Function '5E    'op_ldexd
    Private Function op_ldhxd() As Integer                                      '&H66         'LD H,(IX+d)
        op_ldhxd = ldixd(COMMON.vZ80cpu.H)
    End Function '66    'op_ldhxd
    Private Function op_ldlxd() As Integer                                      '&H6E         'LD L,(IX+d)
        op_ldlxd = ldixd(COMMON.vZ80cpu.L)
    End Function '6E    'op_ldlxd
    Private Function op_ldaxd() As Integer                                      '&H7E         'LD A,(IX+d)
        op_ldaxd = ldixd(COMMON.vZ80cpu.A)
    End Function '7E    'op_ldaxd
    Private Function ldixd(ByRef par1 As Byte) As Integer
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        Call COMMON.vZ80cpu.PCplus1()
        par1 = COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.IX + COMMON.Byte2SByte(COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.PC)))
        ldixd = 19
    End Function ' ldixd
#End Region
#Region "LD (IX+d),x"
    '------------------------------------
    Private Function op_ldxdb() As Integer                                      '&H70         'LD (IX+d),B
        op_ldxdb = ldx(COMMON.vZ80cpu.B)
    End Function '70    'op_ldxdb
    Private Function op_ldxdc() As Integer                                      '&H71         'LD (IX+d),C
        op_ldxdc = ldx(COMMON.vZ80cpu.C)
    End Function '71    'op_ldxdc
    Private Function op_ldxdd() As Integer                                      '&H72         'LD (IX+d),D
        op_ldxdd = ldx(COMMON.vZ80cpu.D)
    End Function '72    'op_ldxdd
    Private Function op_ldxde() As Integer                                      '&H73         'LD (IX+d),E
        op_ldxde = ldx(COMMON.vZ80cpu.E)
    End Function '73    'op_ldxde
    Private Function op_ldxdh() As Integer                                      '&H74         'LD (IX+d),H
        op_ldxdh = ldx(COMMON.vZ80cpu.H)
    End Function '74    'op_ldxdh
    Private Function op_ldxdl() As Integer                                      '&H75         'LD (IX+d),L
        op_ldxdl = ldx(COMMON.vZ80cpu.L)
    End Function '75    'op_ldxdl
    Private Function op_ldxda() As Integer                                      '&H77         'LD (IX+d),A
        op_ldxda = ldx(COMMON.vZ80cpu.A)
    End Function '77    'op_ldxda
    Private Function ldx(ByVal par1 As Byte) As Integer
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        Call COMMON.vZ80cpu.PCplus1() : COMMON.vZ80cpu.Speicher_schreiben_Byte(COMMON.vZ80cpu.IX + COMMON.Byte2SByte(COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.PC)), par1)
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_NONE)
        ldx = 19
    End Function ' ldx
#End Region

#Region "ADD ADC SUB SBC A,(IX+d)"
    '------------------------------------
    Private Function op_adaxd() As Integer                                      '&H86         'ADD A,(IX+d)
        Dim i As Integer
        Dim P As Byte
        Dim j As SByte
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        Call COMMON.vZ80cpu.PCplus1() : P = COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.IX + COMMON.Byte2SByte(COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.PC)))
        Call COMMON.vZ80cpu.FlagHflag1((COMMON.vZ80cpu.A And &HF) + (P And &HF) > &HF)
        Call COMMON.vZ80cpu.FlagCflag1(CInt(COMMON.vZ80cpu.A) + CInt(P) > 255)
        i = CInt(COMMON.vZ80cpu.A) + CInt(P)         'i = CInt(COMMON.Byte2SByte(COMMON.vZ80cpu.A)) + CInt(COMMON.Byte2SByte(P))
        j = COMMON.Byte2SByte(i)
        COMMON.vZ80cpu.A = i And &HFF
        Call COMMON.vZ80cpu.FlagPflag1((j < -128) Or (j > 127))
        Call COMMON.vZ80cpu.FlagSflag1((i And 128))
        Call COMMON.vZ80cpu.FlagZflag2(COMMON.vZ80cpu.A <> 0)
        Call COMMON.vZ80cpu.FlagNflag2()
        op_adaxd = 19
    End Function '86    'op_adaxd
    Private Function op_acaxd() As Integer                                      '&H8E         'ADC A,(IX+d)
        Dim i, carry As Integer
        Dim P As Byte
        Dim j As SByte
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        If (COMMON.vZ80cpu.F And C_FLAG) = C_FLAG Then carry = 1 Else carry = 0
        Call COMMON.vZ80cpu.PCplus1() : P = COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.IX + COMMON.Byte2SByte(COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.PC)))
        Call COMMON.vZ80cpu.FlagHflag1((COMMON.vZ80cpu.A And &HF) + (P And &HF) + carry > &HF)
        Call COMMON.vZ80cpu.FlagCflag1(CInt(COMMON.vZ80cpu.A) + CInt(P) + carry > 255)
        i = CInt(COMMON.vZ80cpu.A) + CInt(P) + carry        'i = CInt(COMMON.Byte2SByte(COMMON.vZ80cpu.A)) + CInt(COMMON.Byte2SByte(P)) + carry
        j = COMMON.Byte2SByte(i)
        COMMON.vZ80cpu.A = i And &HFF
        Call COMMON.vZ80cpu.FlagPflag1((j < -128) Or (j > 127))
        Call COMMON.vZ80cpu.FlagSflag1((i And 128))
        Call COMMON.vZ80cpu.FlagZflag2(COMMON.vZ80cpu.A <> 0)
        Call COMMON.vZ80cpu.FlagNflag2()
        op_acaxd = 19
    End Function '8E    'op_acaxd
    Private Function op_suaxd() As Integer                                      '&H96         'SUB A,(IX+d)
        Dim i As Integer
        Dim P As Byte
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        Call COMMON.vZ80cpu.PCplus1() : P = COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.IX + COMMON.Byte2SByte(COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.PC)))
        Call COMMON.vZ80cpu.FlagHflag1((P And &HF) > (COMMON.vZ80cpu.A And &HF))
        Call COMMON.vZ80cpu.FlagCflag1(P > COMMON.vZ80cpu.A)
        i = CInt(COMMON.vZ80cpu.A) - CInt(P)        'i = CInt(COMMON.Byte2SByte(COMMON.vZ80cpu.A)) - CInt(COMMON.Byte2SByte(P))
        COMMON.vZ80cpu.A = i And &HFF
        Call COMMON.vZ80cpu.FlagPflag1((i < -128) Or (i > 127))
        Call COMMON.vZ80cpu.FlagSflag1((i And 128))
        Call COMMON.vZ80cpu.FlagZflag2(COMMON.vZ80cpu.A <> 0)
        Call COMMON.vZ80cpu.FlagNflag1()
        op_suaxd = 19
    End Function '96    'op_suaxd
    Private Function op_scaxd() As Integer                                      '&H9E         'SBC A,(IX+d)
        Dim i, carry As Integer
        Dim P As Byte
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        If (COMMON.vZ80cpu.F And C_FLAG) = C_FLAG Then carry = 1 Else carry = 0
        Call COMMON.vZ80cpu.PCplus1() : P = COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.IX + COMMON.Byte2SByte(COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.PC)))
        Call COMMON.vZ80cpu.FlagHflag1((P And &HF) + carry > (COMMON.vZ80cpu.A And &HF))
        Call COMMON.vZ80cpu.FlagCflag1(P + carry > COMMON.vZ80cpu.A)
        i = CInt(COMMON.vZ80cpu.A) - CInt(P) - carry      'i = CInt(COMMON.Byte2SByte(COMMON.vZ80cpu.A)) - CInt(COMMON.Byte2SByte(P)) - carry
        COMMON.vZ80cpu.A = i And &HFF
        Call COMMON.vZ80cpu.FlagPflag1((i < -128) Or (i > 127))
        Call COMMON.vZ80cpu.FlagSflag1((i And 128))
        Call COMMON.vZ80cpu.FlagZflag2(COMMON.vZ80cpu.A <> 0)
        Call COMMON.vZ80cpu.FlagNflag1()
        op_scaxd = 19
    End Function '9E    'op_scaxd
#End Region

#Region "AND XOR OR CP (IX+d)"
    '------------------------------------
    Private Function op_andxd() As Integer                                      '&HA6         'AND (IX+d)
        COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        Call COMMON.vZ80cpu.PCplus1() : COMMON.vZ80cpu.A = COMMON.vZ80cpu.A And COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.IX + COMMON.Byte2SByte(COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.PC)))
        Call COMMON.vZ80cpu.FlagSflag1((COMMON.vZ80cpu.A And 128))
        Call COMMON.vZ80cpu.FlagZflag2(COMMON.vZ80cpu.A <> 0)
        COMMON.vZ80cpu.F = COMMON.vZ80cpu.F Or COMMON.H_FLAG
        Call COMMON.vZ80cpu.FlagPflag2(COMMON.vZ80cpu.parrity(COMMON.vZ80cpu.A) = 1)
        COMMON.vZ80cpu.F = COMMON.vZ80cpu.F And Not (COMMON.N_FLAG Or COMMON.C_FLAG)
        op_andxd = 19
    End Function 'A6    'op_andxd
    Private Function op_xorxd() As Integer                                      '&HAE         'XOR (IX+d)
        COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        Call COMMON.vZ80cpu.PCplus1() : COMMON.vZ80cpu.A = COMMON.vZ80cpu.A Xor COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.IX + COMMON.Byte2SByte(COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.PC)))
        Call COMMON.vZ80cpu.FlagSflag1((COMMON.vZ80cpu.A And 128))
        Call COMMON.vZ80cpu.FlagZflag2(COMMON.vZ80cpu.A <> 0)
        Call COMMON.vZ80cpu.FlagPflag2(COMMON.vZ80cpu.parrity(COMMON.vZ80cpu.A) = 1)
        COMMON.vZ80cpu.F = COMMON.vZ80cpu.F And Not (COMMON.H_FLAG Or COMMON.N_FLAG Or COMMON.C_FLAG)
        op_xorxd = 19
    End Function 'AE    'op_xorxd
    Private Function op_orxd() As Integer                                       '&HB6         'OR (IX+d)
        COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        Call COMMON.vZ80cpu.PCplus1() : COMMON.vZ80cpu.A = COMMON.vZ80cpu.A Or COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.IX + COMMON.Byte2SByte(COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.PC)))
        Call COMMON.vZ80cpu.FlagSflag1((COMMON.vZ80cpu.A And 128))
        Call COMMON.vZ80cpu.FlagZflag2(COMMON.vZ80cpu.A <> 0)
        Call COMMON.vZ80cpu.FlagPflag2(COMMON.vZ80cpu.parrity(COMMON.vZ80cpu.A) = 1)
        COMMON.vZ80cpu.F = COMMON.vZ80cpu.F And Not (COMMON.H_FLAG Or COMMON.N_FLAG Or COMMON.C_FLAG)
        op_orxd = 19
    End Function 'B6    'op_orxd
    Private Function op_cpxd() As Integer                                       '&HBE         'CP (IX+d)
        Dim i As Integer
        Dim P As Byte
        COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        Call COMMON.vZ80cpu.PCplus1() : P = COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.IX + COMMON.Byte2SByte(COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.PC)))
        Call COMMON.vZ80cpu.FlagHflag1((P And &HF) > (COMMON.vZ80cpu.A And &HF))
        Call COMMON.vZ80cpu.FlagCflag1(P > COMMON.vZ80cpu.A)
        i = CInt(COMMON.vZ80cpu.A) - CInt(P)         'i = CInt(COMMON.Byte2SByte(COMMON.vZ80cpu.A)) - CInt(COMMON.Byte2SByte(P))
        Call COMMON.vZ80cpu.FlagPflag1((i < -128) Or (i > 127))
        Call COMMON.vZ80cpu.FlagSflag1((i And 128))
        Call COMMON.vZ80cpu.FlagZflag2(i <> 0)
        Call COMMON.vZ80cpu.FlagNflag1()
        op_cpxd = 19
    End Function 'BE    'op_cpxd
#End Region

#Region "POP IX  EX (SP),IX  PUSH IX  JP (IX)  LD SP,IX"
    '------------------------------------
    Private Function op_popix() As Integer                                      '&HE1         'POP IX
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_STACK Or COMMON.CPU_MEMR)
        COMMON.vZ80cpu.IX = COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.STACK)
        Call COMMON.vZ80cpu.SPplus1()
        COMMON.vZ80cpu.IX = COMMON.vZ80cpu.IX + (COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.STACK) * 256)
        Call COMMON.vZ80cpu.SPplus1()
        op_popix = 14
    End Function 'E1    'op_popix
    Private Function op_exspx() As Integer                                      '&HE3         'EX (SP),IX
        Dim i As Integer
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_STACK Or COMMON.CPU_MEMR)
        i = COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.STACK) + COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.STACK + 1) * 256
        COMMON.vZ80cpu.Speicher_schreiben_Byte(COMMON.vZ80cpu.STACK, COMMON.vZ80cpu.IX And &HFF)
        COMMON.vZ80cpu.Speicher_schreiben_Byte(COMMON.vZ80cpu.STACK + 1, (COMMON.vZ80cpu.IX >> 8) And &HFF)
        COMMON.vZ80cpu.IX = i
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_STACK)
        op_exspx = 23
    End Function 'E3    'op_exspx
    Private Function op_pusix() As Integer                                      '&HE5         'PUSH IX
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_STACK)
        COMMON.vZ80cpu.SPminus1()
        COMMON.vZ80cpu.Speicher_schreiben_Byte(COMMON.vZ80cpu.STACK, COMMON.vZ80cpu.IX \ 256)
        COMMON.vZ80cpu.SPminus1()
        COMMON.vZ80cpu.Speicher_schreiben_Byte(COMMON.vZ80cpu.STACK, COMMON.vZ80cpu.IX And &HFF)
        op_pusix = 15
    End Function 'E5    'op_pusix
    Private Function op_jpix() As Integer                                       '&HE9         'JP (IX)
        COMMON.vZ80cpu.PC = COMMON.vZ80cpu.IX
        COMMON.vZ80cpu.PCminus1()
        op_jpix = 8
    End Function 'E9    'op_jpix
    Private Function op_ldspx() As Integer                                      '&HF9         'LD SP,IX
        COMMON.vZ80cpu.STACK = COMMON.vZ80cpu.IX
        op_ldspx = 10
        If Haupt.BufferAnzeigenVis.Checked Then Call AnzeigeBuffer.AnzeigeBuffer2()
    End Function 'F9    'op_ldspx
#End Region

#Region "undocumented Z80 instructions: LD IXL,A  CP IXL"
    'BMK undocumented Z80 instructions
    '=================================
#If Z80_UNDOC0 = 1 Then
    Private Function op_undoc_ldixl() As Integer                                '&H6F         'LD IXL,A
        If COMMON.vZ80cpu.F And COMMON.Z_FLAG = COMMON.Z_FLAG Then
            op_undoc_ldixl = trap_dd()
        Else
            COMMON.vZ80cpu.IX = (COMMON.vZ80cpu.IX And &HFF00) Or COMMON.vZ80cpu.A
            op_undoc_ldixl = 9
        End If
    End Function '6F    'op_undoc_ldixl
    Private Function op_undoc_cpixl() As Integer                                '&HBD         'CP IXL
        Dim i As Integer
        Dim P As Byte

        If COMMON.vZ80cpu.F And COMMON.Z_FLAG = COMMON.Z_FLAG Then
            op_undoc_cpixl = trap_dd()
        Else
            P = COMMON.vZ80cpu.IX And &HFF
            Call COMMON.vZ80cpu.FlagHflag1((P And &HF) > (COMMON.vZ80cpu.A And &HF))
            Call COMMON.vZ80cpu.FlagCflag1(P > COMMON.vZ80cpu.A)
            i = CInt(COMMON.Byte2SByte(COMMON.vZ80cpu.A)) - CInt(COMMON.Byte2SByte(P))
            Call COMMON.vZ80cpu.FlagPflag1(i < -128 Or i > 127)
            Call COMMON.vZ80cpu.FlagSflag1((i And 128))
            Call COMMON.vZ80cpu.FlagZflag2(i <> 0)
            Call COMMON.vZ80cpu.FlagNflag1()
            op_undoc_cpixl = 9
        End If
    End Function 'BD    'op_undoc_cpixl
#End If
#End Region

    '====================================
    Public Function op_dd_handel() As Integer
        Call COMMON.vZ80cpu.PCplus1()
        op_dd_handel = op_dd1.op_sim(COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.PC)).Invoke()
    End Function ' op_dd_handel
End Module
