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
            op_sim(&H24) = New opfunc(AddressOf op_undoc_inciyh)
            op_sim(&H25) = New opfunc(AddressOf op_undoc_deciyh)
            op_sim(&H2C) = New opfunc(AddressOf op_undoc_inciyl)
            op_sim(&H2D) = New opfunc(AddressOf op_undoc_deciyl)
            op_sim(&H44) = New opfunc(AddressOf op_undoc_biyh)
            op_sim(&H45) = New opfunc(AddressOf op_undoc_biyl)
            op_sim(&H4C) = New opfunc(AddressOf op_undoc_ciyh)
            op_sim(&H4D) = New opfunc(AddressOf op_undoc_ciyl)
            op_sim(&H54) = New opfunc(AddressOf op_undoc_diyh)
            op_sim(&H55) = New opfunc(AddressOf op_undoc_diyl)
            op_sim(&H5C) = New opfunc(AddressOf op_undoc_eiyh)
            op_sim(&H5D) = New opfunc(AddressOf op_undoc_eiyl)

            op_sim(&H60) = New opfunc(AddressOf op_undoc_iyhb)
            op_sim(&H61) = New opfunc(AddressOf op_undoc_iyhc)
            op_sim(&H62) = New opfunc(AddressOf op_undoc_iyhd)
            op_sim(&H63) = New opfunc(AddressOf op_undoc_iyhe)
            op_sim(&H64) = New opfunc(AddressOf op_undoc_iyhiyh)
            op_sim(&H65) = New opfunc(AddressOf op_undoc_iyhiyl)
            op_sim(&H67) = New opfunc(AddressOf op_undoc_iyha)

            op_sim(&H68) = New opfunc(AddressOf op_undoc_iylb)
            op_sim(&H69) = New opfunc(AddressOf op_undoc_iylc)
            op_sim(&H6A) = New opfunc(AddressOf op_undoc_iyld)
            op_sim(&H6B) = New opfunc(AddressOf op_undoc_iyle)
            op_sim(&H6C) = New opfunc(AddressOf op_undoc_iyliyh)
            op_sim(&H6D) = New opfunc(AddressOf op_undoc_iyliyl)
            op_sim(&H6F) = New opfunc(AddressOf op_undoc_iyla)

            op_sim(&H7C) = New opfunc(AddressOf op_undoc_aiyh)
            op_sim(&H7D) = New opfunc(AddressOf op_undoc_aiyl)

            op_sim(&H84) = New opfunc(AddressOf op_undoc_add_aiyh)
            op_sim(&H85) = New opfunc(AddressOf op_undoc_add_aiyl)
            op_sim(&H8C) = New opfunc(AddressOf op_undoc_adc_aiyh)
            op_sim(&H8D) = New opfunc(AddressOf op_undoc_adc_aiyl)

            op_sim(&H94) = New opfunc(AddressOf op_undoc_sub_aiyh)
            op_sim(&H95) = New opfunc(AddressOf op_undoc_sub_aiyl)
            op_sim(&H9C) = New opfunc(AddressOf op_undoc_sbc_aiyh)
            op_sim(&H9D) = New opfunc(AddressOf op_undoc_sbc_aiyl)

            op_sim(&HA4) = New opfunc(AddressOf op_undoc_and_aiyh)
            op_sim(&HA5) = New opfunc(AddressOf op_undoc_and_aiyl)
            op_sim(&HAC) = New opfunc(AddressOf op_undoc_xor_aiyh)
            op_sim(&HAD) = New opfunc(AddressOf op_undoc_xor_aiyl)
            op_sim(&HB4) = New opfunc(AddressOf op_undoc_or_aiyh)
            op_sim(&HB5) = New opfunc(AddressOf op_undoc_or_aiyl)

            op_sim(&HBC) = New opfunc(AddressOf op_undoc_cp_aiyh)
            op_sim(&HBD) = New opfunc(AddressOf op_undoc_cp_aiyl)
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
        op_addyb = fadd(COMMON.vZ80cpu.B, COMMON.vZ80cpu.C)
    End Function '09    'op_addyb
    Private Function op_addyd() As Integer                                      '&H19         'ADD IY,DE
        op_addyd = fadd(COMMON.vZ80cpu.D, COMMON.vZ80cpu.E)
    End Function '19    'op_addyd
    Private Function op_addyy() As Integer                                      '&H29         'ADD IY,IY
        op_addyy = fadd((COMMON.vZ80cpu.IY And &HFF00) >> 8, COMMON.vZ80cpu.IY And &HFF)
    End Function '29    'op_addyy
    Private Function op_addys() As Integer                                      '&H39         'ADD IY,SP
        op_addys = fadd((COMMON.vZ80cpu.STACK And &HFF00) >> 8, COMMON.vZ80cpu.STACK And &HFF)
    End Function '39    'op_addys
    Private Function fadd(ByVal par1 As Byte, ByVal Par2 As Byte) As Integer
        Dim carry As Integer
        Dim iyh As Integer
        Dim iyl As Integer

        iyh = (COMMON.vZ80cpu.IY And &HFF00) >> 8
        iyl = COMMON.vZ80cpu.IY And &HFF
        If CInt(iyl) + CInt(Par2) > 255 Then carry = 1 Else carry = 0
        iyl = iyl + Par2
        Call COMMON.vZ80cpu.FlagHflag1((iyh And &HF) + (par1 And &HF) + carry > &HF)
        Call COMMON.vZ80cpu.FlagCflag1(iyh + par1 + carry > 255)
        iyh = iyh + par1 + carry
        COMMON.vZ80cpu.IY = ((iyh And &HFF) << 8) + (iyl And &HFF)
        Call COMMON.vZ80cpu.FlagNflag2()
        fadd = 15
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
        Call COMMON.vZ80cpu.PCplus1() : d = COMMON.Byte2SByte(COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.PC))
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

#If Z80_UNDOC0 = 1 Then
#Region "undocumented Z80 instructions"
    '        =============================
#Region "INC  IY."
    Private Function op_undoc_inciyh() As Integer                               '&H24         'INC  IYH
        Dim x, y As Byte
        If Z80_UNDOC0 = 0 Then
            op_undoc_inciyh = trap_fd()

        Else
            x = (COMMON.vZ80cpu.IY And &HFF00) >> 8
            y = 1
            Call inc(x, y)
            COMMON.vZ80cpu.IX = y * 256 + (COMMON.vZ80cpu.IY And &HFF)
            op_undoc_inciyh = 4
        End If
    End Function
    Private Function op_undoc_inciyl() As Integer                               '&H2C         'INC  IYL
        Dim x, y As Byte
        If Z80_UNDOC0 = 0 Then
            op_undoc_inciyl = trap_fd()
        Else
            x = (COMMON.vZ80cpu.IY And &HFF)
            y = 1
            Call inc(x, y)
            COMMON.vZ80cpu.IY = (COMMON.vZ80cpu.IY And &HFF00) + y
            op_undoc_inciyl = 4
        End If
    End Function
#End Region
#Region "DEC  IY."
    Private Function op_undoc_deciyh() As Integer                               '&H25         'DEC  IYH
        Dim x, y As Byte
        If Z80_UNDOC0 = 0 Then
            op_undoc_deciyh = trap_fd()
        Else
            x = (COMMON.vZ80cpu.IY And &HFF00) >> 8
            y = 1
            Call dec(x, y)
            COMMON.vZ80cpu.IY = y * 256 + (COMMON.vZ80cpu.IY And &HFF)
            op_undoc_deciyh = 4
        End If
    End Function
    Private Function op_undoc_deciyl() As Integer                               '&H2D         'DEC  IYL
        Dim x, y As Byte
        If Z80_UNDOC0 = 0 Then
            op_undoc_deciyl = trap_fd()
        Else
            x = (COMMON.vZ80cpu.IY And &HFF)
            y = 1
            Call dec(x, y)
            COMMON.vZ80cpu.IY = (COMMON.vZ80cpu.IY And &HFF00) + y
            op_undoc_deciyl = 4
        End If
    End Function
#End Region

#Region "LD   B,IY."
    Private Function op_undoc_biyh() As Integer                                 '&H44         'LD   B,IYH
        If Z80_UNDOC0 = 0 Then
            op_undoc_biyh = trap_fd()
        Else
            COMMON.vZ80cpu.B = (COMMON.vZ80cpu.IY And &HFF00) >> 8
            op_undoc_biyh = 9
        End If
    End Function
    Private Function op_undoc_biyl() As Integer                                 '&H45         'LD   B,IYL
        If Z80_UNDOC0 = 0 Then
            op_undoc_biyl = trap_fd()
        Else
            COMMON.vZ80cpu.B = (COMMON.vZ80cpu.IY And &HFF) >> 8
            op_undoc_biyl = 9
        End If
    End Function
#End Region
#Region "LD   C,IY."
    Private Function op_undoc_ciyh() As Integer                                 '&H4C         'LD   C,IYH
        If Z80_UNDOC0 = 0 Then
            op_undoc_ciyh = trap_fd()
        Else
            COMMON.vZ80cpu.C = (COMMON.vZ80cpu.IY And &HFF00) >> 8
            op_undoc_ciyh = 9
        End If
    End Function
    Private Function op_undoc_ciyl() As Integer                                 '&H4D         'LD   C,IYL
        If Z80_UNDOC0 = 0 Then
            op_undoc_ciyl = trap_fd()
        Else
            COMMON.vZ80cpu.C = (COMMON.vZ80cpu.IY And &HFF) >> 8
            op_undoc_ciyl = 9
        End If
    End Function
#End Region
#Region "LD   D,IY."
    Private Function op_undoc_diyh() As Integer                                 '&H54         'LD   D,IYH
        If Z80_UNDOC0 = 0 Then
            op_undoc_diyh = trap_fd()
        Else
            COMMON.vZ80cpu.D = (COMMON.vZ80cpu.IY And &HFF00) >> 8
            op_undoc_diyh = 9
        End If
    End Function
    Private Function op_undoc_diyl() As Integer                                 '&H55         'LD   D,IYL
        If Z80_UNDOC0 = 0 Then
            op_undoc_diyl = trap_fd()
        Else
            COMMON.vZ80cpu.D = (COMMON.vZ80cpu.IY And &HFF) >> 8
            op_undoc_diyl = 9
        End If
    End Function
#End Region
#Region "LD   E,IY."
    Private Function op_undoc_eiyh() As Integer                                 '&H5C         'LD   E,IYH
        If Z80_UNDOC0 = 0 Then
            op_undoc_eiyh = trap_fd()
        Else
            COMMON.vZ80cpu.E = (COMMON.vZ80cpu.IY And &HFF00) >> 8
            op_undoc_eiyh = 9
        End If
    End Function
    Private Function op_undoc_eiyl() As Integer                                 '&H5D         'LD   E,IYL
        If Z80_UNDOC0 = 0 Then
            op_undoc_eiyl = trap_fd()
        Else
            COMMON.vZ80cpu.E = (COMMON.vZ80cpu.IY And &HFF) >> 8
            op_undoc_eiyl = 9
        End If
    End Function
#End Region

#Region "LD   IYH,reg"
    Private Function op_undoc_iyhb() As Integer                                 '&H60         'LD   IYH,B
        If Z80_UNDOC0 = 0 Then
            op_undoc_iyhb = trap_fd()
        Else
            COMMON.vZ80cpu.IY = COMMON.vZ80cpu.B * 256 + (COMMON.vZ80cpu.IY And &HFF)
            op_undoc_iyhb = 9
        End If
    End Function
    Private Function op_undoc_iyhc() As Integer                                 '&H61         'LD   IYH,C
        If Z80_UNDOC0 = 0 Then
            op_undoc_iyhc = trap_fd()
        Else
            COMMON.vZ80cpu.IY = COMMON.vZ80cpu.C * 256 + (COMMON.vZ80cpu.IY And &HFF)
            op_undoc_iyhc = 9
        End If
    End Function
    Private Function op_undoc_iyhd() As Integer                                 '&H62         'LD   IYH,D
        If Z80_UNDOC0 = 0 Then
            op_undoc_iyhd = trap_fd()
        Else
            COMMON.vZ80cpu.IY = COMMON.vZ80cpu.D * 256 + (COMMON.vZ80cpu.IY And &HFF)
            op_undoc_iyhd = 9
        End If
    End Function
    Private Function op_undoc_iyhe() As Integer                                 '&H63         'LD   IYH,E
        If Z80_UNDOC0 = 0 Then
            op_undoc_iyhe = trap_fd()
        Else
            COMMON.vZ80cpu.IY = COMMON.vZ80cpu.E * 256 + (COMMON.vZ80cpu.IY And &HFF)
            op_undoc_iyhe = 9
        End If
    End Function
    Private Function op_undoc_iyhiyh() As Integer                               '&H64         'LD   IYH,IYH
        If Z80_UNDOC0 = 0 Then
            op_undoc_iyhiyh = trap_fd()
        Else
            op_undoc_iyhiyh = 9
        End If
    End Function
    Private Function op_undoc_iyhiyl() As Integer                               '&H65         'LD   IYH,IYL
        If Z80_UNDOC0 = 0 Then
            op_undoc_iyhiyl = trap_fd()
        Else
            COMMON.vZ80cpu.IY = ((COMMON.vZ80cpu.IY And &HFF) << 8) + (COMMON.vZ80cpu.IY And &HFF)
            op_undoc_iyhiyl = 9
        End If
    End Function
    Private Function op_undoc_iyha() As Integer                                 '&H67         'LD   IYH,A
        If Z80_UNDOC0 = 0 Then
            op_undoc_iyha = trap_fd()
        Else
            COMMON.vZ80cpu.IY = COMMON.vZ80cpu.A * 256 + (COMMON.vZ80cpu.IY And &HFF)
            op_undoc_iyha = 9
        End If
    End Function
#End Region
#Region "LD   IXL,reg"
    Private Function op_undoc_iylb() As Integer                                 '&H68         'LD   IYL,B
        If Z80_UNDOC0 = 0 Then
            op_undoc_iylb = trap_fd()
        Else
            COMMON.vZ80cpu.IY = (COMMON.vZ80cpu.IY And &HFF00) + COMMON.vZ80cpu.B
            op_undoc_iylb = 9
        End If
    End Function
    Private Function op_undoc_iylc() As Integer                                 '&H69         'LD   IYL,C
        If Z80_UNDOC0 = 0 Then
            op_undoc_iylc = trap_fd()
        Else
            COMMON.vZ80cpu.IY = (COMMON.vZ80cpu.IY And &HFF00) + COMMON.vZ80cpu.C
            op_undoc_iylc = 9
        End If
    End Function
    Private Function op_undoc_iyld() As Integer                                 '&H6A         'LD   IYL,D
        If Z80_UNDOC0 = 0 Then
            op_undoc_iyld = trap_fd()
        Else
            COMMON.vZ80cpu.IY = (COMMON.vZ80cpu.IY And &HFF00) + COMMON.vZ80cpu.D
            op_undoc_iyld = 9
        End If
    End Function
    Private Function op_undoc_iyle() As Integer                                 '&H6B         'LD   IYL,E
        If Z80_UNDOC0 = 0 Then
            op_undoc_iyle = trap_fd()
        Else
            COMMON.vZ80cpu.IY = (COMMON.vZ80cpu.IY And &HFF00) + COMMON.vZ80cpu.E
            op_undoc_iyle = 9
        End If
    End Function
    Private Function op_undoc_iyliyh() As Integer                               '&H6C         'LD   IYL,IYH
        If Z80_UNDOC0 = 0 Then
            op_undoc_iyliyh = trap_fd()
        Else
            COMMON.vZ80cpu.IY = (COMMON.vZ80cpu.IY And &HFF00) + ((COMMON.vZ80cpu.IY And &HFF00) >> 8)
            op_undoc_iyliyh = 9
        End If
    End Function
    Private Function op_undoc_iyliyl() As Integer                               '&H6C         'LD   IYL,IYL
        If Z80_UNDOC0 = 0 Then
            op_undoc_iyliyl = trap_fd()
        Else
            op_undoc_iyliyl = 9
        End If
    End Function
    Private Function op_undoc_iyla() As Integer                                 '&H6F         'LD   IYL,A
        If Z80_UNDOC0 = 0 Then
            op_undoc_iyla = trap_fd()
        Else
            COMMON.vZ80cpu.IY = (COMMON.vZ80cpu.IY And &HFF00) Or COMMON.vZ80cpu.A
            op_undoc_iyla = 9
        End If
    End Function '6F    'op_undoc_ldixl



#End Region

#Region "LD   A,IY."
    Private Function op_undoc_aiyh() As Integer                                 '&H7C         'LD   A,IYH
        If Z80_UNDOC0 = 0 Then
            op_undoc_aiyh = trap_fd()
        Else
            COMMON.vZ80cpu.A = (COMMON.vZ80cpu.IY And &HFF00) >> 8
            op_undoc_aiyh = 9
        End If
    End Function '6F    'op_undoc_ldixl
    Private Function op_undoc_aiyl() As Integer                                 '&H7D         'LD   A,IYL
        If Z80_UNDOC0 = 0 Then
            op_undoc_aiyl = trap_fd()
        Else
            COMMON.vZ80cpu.A = (COMMON.vZ80cpu.IY And &HFF)
            op_undoc_aiyl = 9
        End If
    End Function '6F    'op_undoc_ldixl
#End Region
#Region "ADD   A,IY."
    Private Function op_undoc_add_aiyh() As Integer                             '&H84         'ADD  A,IYH
        Dim par1 As Byte
        If Z80_UNDOC0 = 0 Then
            op_undoc_add_aiyh = trap_fd()
        Else
            par1 = (COMMON.vZ80cpu.IY And &HFF00) >> 8
            Call add(par1)
            op_undoc_add_aiyh = 4
        End If
    End Function
    Private Function op_undoc_add_aiyl() As Integer                             '&H85         'ADD  A,IYL
        Dim par1 As Byte
        If Z80_UNDOC0 = 0 Then
            op_undoc_add_aiyl = trap_fd()
        Else
            par1 = (COMMON.vZ80cpu.IX And &HFF)
            Call add(par1)
            op_undoc_add_aiyl = 4
        End If
    End Function
#End Region
#Region "ADC   A,IY."
    Private Function op_undoc_adc_aiyh() As Integer                             '&H8C         'ADC  A,IYH
        Dim par1 As Byte
        If Z80_UNDOC0 = 0 Then
            op_undoc_adc_aiyh = trap_fd()
        Else
            par1 = (COMMON.vZ80cpu.IY And &HFF00) >> 8
            Call adc(par1)
            op_undoc_adc_aiyh = 4
        End If
    End Function
    Private Function op_undoc_adc_aiyl() As Integer                             '&H8D         'ADC  A,IYL
        Dim par1 As Byte
        If Z80_UNDOC0 = 0 Then
            op_undoc_adc_aiyl = trap_fd()
        Else
            par1 = (COMMON.vZ80cpu.IY And &HFF)
            Call adc(par1)
            op_undoc_adc_aiyl = 4
        End If
    End Function
#End Region
#Region "SUB  A,IY."
    Private Function op_undoc_sub_aiyh() As Integer                             '&H94         'SUB  IYH
        Dim par1 As Byte
        If Z80_UNDOC0 = 0 Then
            op_undoc_sub_aiyh = trap_fd()
        Else
            par1 = (COMMON.vZ80cpu.IY And &HFF00) >> 8
            Call sub1(par1)
            op_undoc_sub_aiyh = 4
        End If
    End Function
    Private Function op_undoc_sub_aiyl() As Integer                             '&H95         'SUB  IYL
        Dim par1 As Byte
        If Z80_UNDOC0 = 0 Then
            op_undoc_sub_aiyl = trap_fd()
        Else
            par1 = (COMMON.vZ80cpu.IY And &HFF)
            Call sub1(par1)
            op_undoc_sub_aiyl = 4
        End If
    End Function
#End Region
#Region "SUB  A,IY."
    Private Function op_undoc_sbc_aiyh() As Integer                             '&H9C         'SBC  A,IYH
        Dim par1 As Byte
        If Z80_UNDOC0 = 0 Then
            op_undoc_sbc_aiyh = trap_fd()
        Else
            par1 = (COMMON.vZ80cpu.IY And &HFF00) >> 8
            Call sbc(par1)
            op_undoc_sbc_aiyh = 4
        End If
    End Function
    Private Function op_undoc_sbc_aiyl() As Integer                             '&H9D         'SBC  A,IYL
        Dim par1 As Byte
        If Z80_UNDOC0 = 0 Then
            op_undoc_sbc_aiyl = trap_fd()
        Else
            par1 = (COMMON.vZ80cpu.IY And &HFF)
            Call sbc(par1)
            op_undoc_sbc_aiyl = 4
        End If
    End Function
#End Region

#Region "AND  A,IY."
    Private Function op_undoc_and_aiyh() As Integer                             '&HA4         'AND  A,IYH
        Dim par1 As Byte
        If Z80_UNDOC0 = 0 Then
            op_undoc_and_aiyh = trap_fd()
        Else
            par1 = (COMMON.vZ80cpu.IY And &HFF00) >> 8
            Call and1(par1)
            op_undoc_and_aiyh = 4
        End If
    End Function
    Private Function op_undoc_and_aiyl() As Integer                             '&HA5         'AND  A,IYL
        Dim par1 As Byte
        If Z80_UNDOC0 = 0 Then
            op_undoc_and_aiyl = trap_fd()
        Else
            par1 = (COMMON.vZ80cpu.IY And &HFF)
            Call and1(par1)
            op_undoc_and_aiyl = 4
        End If
    End Function
#End Region
#Region "XOR  A,IY."
    Private Function op_undoc_xor_aiyh() As Integer                             '&HAC         'XOR  A,IYH
        Dim par1 As Byte
        If Z80_UNDOC0 = 0 Then
            op_undoc_xor_aiyh = trap_fd()
        Else
            par1 = (COMMON.vZ80cpu.IY And &HFF00) >> 8
            Call xor1(par1)
            op_undoc_xor_aiyh = 4
        End If
    End Function
    Private Function op_undoc_xor_aiyl() As Integer                             '&HAD         'XOR  A,IYL
        Dim par1 As Byte
        If Z80_UNDOC0 = 0 Then
            op_undoc_xor_aiyl = trap_fd()
        Else
            par1 = (COMMON.vZ80cpu.IX And &HFF)
            Call xor1(par1)
            op_undoc_xor_aiyl = 4
        End If
    End Function
#End Region
#Region "OR   A,IY."
    Private Function op_undoc_or_aiyh() As Integer                             '&HB4         'OR   A,IYH
        Dim par1 As Byte
        If Z80_UNDOC0 = 0 Then
            op_undoc_or_aiyh = trap_fd()
        Else
            par1 = (COMMON.vZ80cpu.IY And &HFF00) >> 8
            Call or1(par1)
            op_undoc_or_aiyh = 4
        End If
    End Function
    Private Function op_undoc_or_aiyl() As Integer                             '&HB5         'OR   A,IYL
        Dim par1 As Byte
        If Z80_UNDOC0 = 0 Then
            op_undoc_or_aiyl = trap_fd()
        Else
            par1 = (COMMON.vZ80cpu.IY And &HFF)
            Call or1(par1)
            op_undoc_or_aiyl = 4
        End If
    End Function
#End Region

#Region "CP   IY."
    Private Function op_undoc_cp_aiyh() As Integer                              '&HBC         'CP IYH
        Dim i As Integer
        Dim P As Byte

        If Z80_UNDOC0 = 0 Then
            op_undoc_cp_aiyh = trap_fd()
        Else
            P = (COMMON.vZ80cpu.IY And &HFF00) >> 8
            Call COMMON.vZ80cpu.FlagHflag1((P And &HF) > (COMMON.vZ80cpu.A And &HF))
            Call COMMON.vZ80cpu.FlagCflag1(P > COMMON.vZ80cpu.A)
            i = CInt(COMMON.Byte2SByte(COMMON.vZ80cpu.A)) - CInt(COMMON.Byte2SByte(P))
            Call COMMON.vZ80cpu.FlagPflag1(i < -128 Or i > 127)
            Call COMMON.vZ80cpu.FlagSflag1((i And 128))
            Call COMMON.vZ80cpu.FlagZflag2(i <> 0)
            Call COMMON.vZ80cpu.FlagNflag1()
            op_undoc_cp_aiyh = 9
        End If
    End Function 'BD    'op_undoc_cpixl
    Private Function op_undoc_cp_aiyl() As Integer                              '&HBD         'CP IYL
        Dim i As Integer
        Dim P As Byte

        If Z80_UNDOC0 = 0 Then
            op_undoc_cp_aiyl = trap_fd()
        Else
            P = COMMON.vZ80cpu.IY And &HFF
            Call COMMON.vZ80cpu.FlagHflag1((P And &HF) > (COMMON.vZ80cpu.A And &HF))
            Call COMMON.vZ80cpu.FlagCflag1(P > COMMON.vZ80cpu.A)
            i = CInt(COMMON.Byte2SByte(COMMON.vZ80cpu.A)) - CInt(COMMON.Byte2SByte(P))
            Call COMMON.vZ80cpu.FlagPflag1(i < -128 Or i > 127)
            Call COMMON.vZ80cpu.FlagSflag1((i And 128))
            Call COMMON.vZ80cpu.FlagZflag2(i <> 0)
            Call COMMON.vZ80cpu.FlagNflag1()
            op_undoc_cp_aiyl = 9
        End If
    End Function 'BD    'op_undoc_cpixl
#End Region

#End Region
#End If

    '====================================
    Public Function op_fd_handel() As Integer
        Call COMMON.vZ80cpu.PCplus1()
        op_fd_handel = op_fd1.op_sim(COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.PC)).Invoke()
    End Function ' op_fd_handel
End Module ' FD
