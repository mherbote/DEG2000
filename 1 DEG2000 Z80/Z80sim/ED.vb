Imports DEG2000.Z80cpu

Module ED
    ' Like the function "cpu()" this one emulates multi byte opcodes starting with 0xED

    Public Class op_ed

        Public op_sim(0 To 255) As opfunc

        Public Sub New()
            op_sim(&H0) = New opfunc(AddressOf trap_ed) : op_sim(&H1) = New opfunc(AddressOf trap_ed) : op_sim(&H2) = New opfunc(AddressOf trap_ed) : op_sim(&H3) = New opfunc(AddressOf trap_ed)
            op_sim(&H4) = New opfunc(AddressOf trap_ed) : op_sim(&H5) = New opfunc(AddressOf trap_ed) : op_sim(&H6) = New opfunc(AddressOf trap_ed) : op_sim(&H7) = New opfunc(AddressOf trap_ed)
            op_sim(&H8) = New opfunc(AddressOf trap_ed) : op_sim(&H9) = New opfunc(AddressOf trap_ed) : op_sim(&HA) = New opfunc(AddressOf trap_ed) : op_sim(&HB) = New opfunc(AddressOf trap_ed)
            op_sim(&HC) = New opfunc(AddressOf trap_ed) : op_sim(&HD) = New opfunc(AddressOf trap_ed) : op_sim(&HE) = New opfunc(AddressOf trap_ed) : op_sim(&HF) = New opfunc(AddressOf trap_ed)

            op_sim(&H10) = New opfunc(AddressOf trap_ed) : op_sim(&H11) = New opfunc(AddressOf trap_ed) : op_sim(&H12) = New opfunc(AddressOf trap_ed) : op_sim(&H13) = New opfunc(AddressOf trap_ed)
            op_sim(&H14) = New opfunc(AddressOf trap_ed) : op_sim(&H15) = New opfunc(AddressOf trap_ed) : op_sim(&H16) = New opfunc(AddressOf trap_ed) : op_sim(&H17) = New opfunc(AddressOf trap_ed)
            op_sim(&H18) = New opfunc(AddressOf trap_ed) : op_sim(&H19) = New opfunc(AddressOf trap_ed) : op_sim(&H1A) = New opfunc(AddressOf trap_ed) : op_sim(&H1B) = New opfunc(AddressOf trap_ed)
            op_sim(&H1C) = New opfunc(AddressOf trap_ed) : op_sim(&H1D) = New opfunc(AddressOf trap_ed) : op_sim(&H1E) = New opfunc(AddressOf trap_ed) : op_sim(&H1F) = New opfunc(AddressOf trap_ed)

            op_sim(&H20) = New opfunc(AddressOf trap_ed) : op_sim(&H21) = New opfunc(AddressOf trap_ed) : op_sim(&H22) = New opfunc(AddressOf trap_ed) : op_sim(&H23) = New opfunc(AddressOf trap_ed)
            op_sim(&H24) = New opfunc(AddressOf trap_ed) : op_sim(&H25) = New opfunc(AddressOf trap_ed) : op_sim(&H26) = New opfunc(AddressOf trap_ed) : op_sim(&H27) = New opfunc(AddressOf trap_ed)
            op_sim(&H28) = New opfunc(AddressOf trap_ed) : op_sim(&H29) = New opfunc(AddressOf trap_ed) : op_sim(&H2A) = New opfunc(AddressOf trap_ed) : op_sim(&H2B) = New opfunc(AddressOf trap_ed)
            op_sim(&H2C) = New opfunc(AddressOf trap_ed) : op_sim(&H2D) = New opfunc(AddressOf trap_ed) : op_sim(&H2E) = New opfunc(AddressOf trap_ed) : op_sim(&H2F) = New opfunc(AddressOf trap_ed)

            op_sim(&H30) = New opfunc(AddressOf trap_ed) : op_sim(&H31) = New opfunc(AddressOf trap_ed) : op_sim(&H32) = New opfunc(AddressOf trap_ed) : op_sim(&H33) = New opfunc(AddressOf trap_ed)
            op_sim(&H34) = New opfunc(AddressOf trap_ed) : op_sim(&H35) = New opfunc(AddressOf trap_ed) : op_sim(&H36) = New opfunc(AddressOf trap_ed) : op_sim(&H37) = New opfunc(AddressOf trap_ed)
            op_sim(&H38) = New opfunc(AddressOf trap_ed) : op_sim(&H39) = New opfunc(AddressOf trap_ed) : op_sim(&H3A) = New opfunc(AddressOf trap_ed) : op_sim(&H3B) = New opfunc(AddressOf trap_ed)
            op_sim(&H3C) = New opfunc(AddressOf trap_ed) : op_sim(&H3D) = New opfunc(AddressOf trap_ed) : op_sim(&H3E) = New opfunc(AddressOf trap_ed) : op_sim(&H3F) = New opfunc(AddressOf trap_ed)

            op_sim(&H40) = New opfunc(AddressOf op_inbic) : op_sim(&H41) = New opfunc(AddressOf op_outcb) : op_sim(&H42) = New opfunc(AddressOf op_sbchb) : op_sim(&H43) = New opfunc(AddressOf op_ldinbc)
            op_sim(&H44) = New opfunc(AddressOf op_neg) : op_sim(&H45) = New opfunc(AddressOf op_retn) : op_sim(&H46) = New opfunc(AddressOf op_im0) : op_sim(&H47) = New opfunc(AddressOf op_ldia)
            op_sim(&H48) = New opfunc(AddressOf op_incic) : op_sim(&H49) = New opfunc(AddressOf op_outcc) : op_sim(&H4A) = New opfunc(AddressOf op_adchb) : op_sim(&H4B) = New opfunc(AddressOf op_ldbcinn)
            op_sim(&H4C) = New opfunc(AddressOf trap_ed) : op_sim(&H4D) = New opfunc(AddressOf op_reti) : op_sim(&H4E) = New opfunc(AddressOf trap_ed) : op_sim(&H4F) = New opfunc(AddressOf op_ldra)

            op_sim(&H50) = New opfunc(AddressOf op_indic) : op_sim(&H51) = New opfunc(AddressOf op_outcd) : op_sim(&H52) = New opfunc(AddressOf op_sbchd) : op_sim(&H53) = New opfunc(AddressOf op_ldinde)
            op_sim(&H54) = New opfunc(AddressOf trap_ed) : op_sim(&H55) = New opfunc(AddressOf trap_ed) : op_sim(&H56) = New opfunc(AddressOf op_im1) : op_sim(&H57) = New opfunc(AddressOf op_ldai)
            op_sim(&H58) = New opfunc(AddressOf op_ineic) : op_sim(&H59) = New opfunc(AddressOf op_outce) : op_sim(&H5A) = New opfunc(AddressOf op_adchd) : op_sim(&H5B) = New opfunc(AddressOf op_lddeinn)
            op_sim(&H5C) = New opfunc(AddressOf trap_ed) : op_sim(&H5D) = New opfunc(AddressOf trap_ed) : op_sim(&H5E) = New opfunc(AddressOf op_im2) : op_sim(&H5F) = New opfunc(AddressOf op_ldar)

            op_sim(&H60) = New opfunc(AddressOf op_inhic) : op_sim(&H61) = New opfunc(AddressOf op_outch) : op_sim(&H62) = New opfunc(AddressOf op_sbchh) : op_sim(&H63) = New opfunc(AddressOf trap_ed)
            op_sim(&H64) = New opfunc(AddressOf trap_ed) : op_sim(&H65) = New opfunc(AddressOf trap_ed) : op_sim(&H66) = New opfunc(AddressOf trap_ed) : op_sim(&H67) = New opfunc(AddressOf op_oprrd)
            op_sim(&H68) = New opfunc(AddressOf op_inlic) : op_sim(&H69) = New opfunc(AddressOf op_outcl) : op_sim(&H6A) = New opfunc(AddressOf op_adchh) : op_sim(&H6B) = New opfunc(AddressOf trap_ed)
            op_sim(&H6C) = New opfunc(AddressOf trap_ed) : op_sim(&H6D) = New opfunc(AddressOf trap_ed) : op_sim(&H6E) = New opfunc(AddressOf trap_ed) : op_sim(&H6F) = New opfunc(AddressOf op_oprld)

            op_sim(&H70) = New opfunc(AddressOf trap_ed) : op_sim(&H71) = New opfunc(AddressOf trap_ed) : op_sim(&H72) = New opfunc(AddressOf op_sbchs) : op_sim(&H73) = New opfunc(AddressOf op_ldinsp)
            op_sim(&H74) = New opfunc(AddressOf trap_ed) : op_sim(&H75) = New opfunc(AddressOf trap_ed) : op_sim(&H76) = New opfunc(AddressOf trap_ed) : op_sim(&H77) = New opfunc(AddressOf trap_ed)
            op_sim(&H78) = New opfunc(AddressOf op_inaic) : op_sim(&H79) = New opfunc(AddressOf op_outca) : op_sim(&H7A) = New opfunc(AddressOf op_adchs) : op_sim(&H7B) = New opfunc(AddressOf op_ldspinn)
            op_sim(&H7C) = New opfunc(AddressOf trap_ed) : op_sim(&H7D) = New opfunc(AddressOf trap_ed) : op_sim(&H7E) = New opfunc(AddressOf trap_ed) : op_sim(&H7F) = New opfunc(AddressOf trap_ed)

            op_sim(&H80) = New opfunc(AddressOf trap_ed) : op_sim(&H81) = New opfunc(AddressOf trap_ed) : op_sim(&H82) = New opfunc(AddressOf trap_ed) : op_sim(&H83) = New opfunc(AddressOf trap_ed)
            op_sim(&H84) = New opfunc(AddressOf trap_ed) : op_sim(&H85) = New opfunc(AddressOf trap_ed) : op_sim(&H86) = New opfunc(AddressOf trap_ed) : op_sim(&H87) = New opfunc(AddressOf trap_ed)
            op_sim(&H88) = New opfunc(AddressOf trap_ed) : op_sim(&H89) = New opfunc(AddressOf trap_ed) : op_sim(&H8A) = New opfunc(AddressOf trap_ed) : op_sim(&H8B) = New opfunc(AddressOf trap_ed)
            op_sim(&H8C) = New opfunc(AddressOf trap_ed) : op_sim(&H8D) = New opfunc(AddressOf trap_ed) : op_sim(&H8E) = New opfunc(AddressOf trap_ed) : op_sim(&H8F) = New opfunc(AddressOf trap_ed)

            op_sim(&H90) = New opfunc(AddressOf trap_ed) : op_sim(&H91) = New opfunc(AddressOf trap_ed) : op_sim(&H92) = New opfunc(AddressOf trap_ed) : op_sim(&H93) = New opfunc(AddressOf trap_ed)
            op_sim(&H94) = New opfunc(AddressOf trap_ed) : op_sim(&H95) = New opfunc(AddressOf trap_ed) : op_sim(&H96) = New opfunc(AddressOf trap_ed) : op_sim(&H97) = New opfunc(AddressOf trap_ed)
            op_sim(&H98) = New opfunc(AddressOf trap_ed) : op_sim(&H99) = New opfunc(AddressOf trap_ed) : op_sim(&H9A) = New opfunc(AddressOf trap_ed) : op_sim(&H9B) = New opfunc(AddressOf trap_ed)
            op_sim(&H9C) = New opfunc(AddressOf trap_ed) : op_sim(&H9D) = New opfunc(AddressOf trap_ed) : op_sim(&H9E) = New opfunc(AddressOf trap_ed) : op_sim(&H9F) = New opfunc(AddressOf trap_ed)

            op_sim(&HA0) = New opfunc(AddressOf op_ldi) : op_sim(&HA1) = New opfunc(AddressOf op_cpi) : op_sim(&HA2) = New opfunc(AddressOf op_ini) : op_sim(&HA3) = New opfunc(AddressOf op_outi)
            op_sim(&HA4) = New opfunc(AddressOf trap_ed) : op_sim(&HA5) = New opfunc(AddressOf trap_ed) : op_sim(&HA6) = New opfunc(AddressOf trap_ed) : op_sim(&HA7) = New opfunc(AddressOf trap_ed)
            op_sim(&HA8) = New opfunc(AddressOf op_ldd) : op_sim(&HA9) = New opfunc(AddressOf op_cpdop) : op_sim(&HAA) = New opfunc(AddressOf op_ind) : op_sim(&HAB) = New opfunc(AddressOf op_outd)
            op_sim(&HAC) = New opfunc(AddressOf trap_ed) : op_sim(&HAD) = New opfunc(AddressOf trap_ed) : op_sim(&HAE) = New opfunc(AddressOf trap_ed) : op_sim(&HAF) = New opfunc(AddressOf trap_ed)

            op_sim(&HB0) = New opfunc(AddressOf op_ldir) : op_sim(&HB1) = New opfunc(AddressOf op_cpir) : op_sim(&HB2) = New opfunc(AddressOf op_inir) : op_sim(&HB3) = New opfunc(AddressOf op_otir)
            op_sim(&HB4) = New opfunc(AddressOf trap_ed) : op_sim(&HB5) = New opfunc(AddressOf trap_ed) : op_sim(&HB6) = New opfunc(AddressOf trap_ed) : op_sim(&HB7) = New opfunc(AddressOf trap_ed)
            op_sim(&HB8) = New opfunc(AddressOf op_lddr) : op_sim(&HB9) = New opfunc(AddressOf op_cpdr) : op_sim(&HBA) = New opfunc(AddressOf op_indr) : op_sim(&HBB) = New opfunc(AddressOf op_otdr)
            op_sim(&HBC) = New opfunc(AddressOf trap_ed) : op_sim(&HBD) = New opfunc(AddressOf trap_ed) : op_sim(&HBE) = New opfunc(AddressOf trap_ed) : op_sim(&HBF) = New opfunc(AddressOf trap_ed)

            op_sim(&HC0) = New opfunc(AddressOf trap_ed) : op_sim(&HC1) = New opfunc(AddressOf trap_ed) : op_sim(&HC2) = New opfunc(AddressOf trap_ed) : op_sim(&HC3) = New opfunc(AddressOf trap_ed)
            op_sim(&HC4) = New opfunc(AddressOf trap_ed) : op_sim(&HC5) = New opfunc(AddressOf trap_ed) : op_sim(&HC6) = New opfunc(AddressOf trap_ed) : op_sim(&HC7) = New opfunc(AddressOf trap_ed)
            op_sim(&HC8) = New opfunc(AddressOf trap_ed) : op_sim(&HC9) = New opfunc(AddressOf trap_ed) : op_sim(&HCA) = New opfunc(AddressOf trap_ed) : op_sim(&HCB) = New opfunc(AddressOf trap_ed)
            op_sim(&HCC) = New opfunc(AddressOf trap_ed) : op_sim(&HCD) = New opfunc(AddressOf trap_ed) : op_sim(&HCE) = New opfunc(AddressOf trap_ed) : op_sim(&HCF) = New opfunc(AddressOf trap_ed)

            op_sim(&HD0) = New opfunc(AddressOf trap_ed) : op_sim(&HD1) = New opfunc(AddressOf trap_ed) : op_sim(&HD2) = New opfunc(AddressOf trap_ed) : op_sim(&HD3) = New opfunc(AddressOf trap_ed)
            op_sim(&HD4) = New opfunc(AddressOf trap_ed) : op_sim(&HD5) = New opfunc(AddressOf trap_ed) : op_sim(&HD6) = New opfunc(AddressOf trap_ed) : op_sim(&HD7) = New opfunc(AddressOf trap_ed)
            op_sim(&HD8) = New opfunc(AddressOf trap_ed) : op_sim(&HD9) = New opfunc(AddressOf trap_ed) : op_sim(&HDA) = New opfunc(AddressOf trap_ed) : op_sim(&HDB) = New opfunc(AddressOf trap_ed)
            op_sim(&HDC) = New opfunc(AddressOf trap_ed) : op_sim(&HDD) = New opfunc(AddressOf trap_ed) : op_sim(&HDE) = New opfunc(AddressOf trap_ed) : op_sim(&HDF) = New opfunc(AddressOf trap_ed)

            op_sim(&HE0) = New opfunc(AddressOf trap_ed) : op_sim(&HE1) = New opfunc(AddressOf trap_ed) : op_sim(&HE2) = New opfunc(AddressOf trap_ed) : op_sim(&HE3) = New opfunc(AddressOf trap_ed)
            op_sim(&HE4) = New opfunc(AddressOf trap_ed) : op_sim(&HE5) = New opfunc(AddressOf trap_ed) : op_sim(&HE6) = New opfunc(AddressOf trap_ed) : op_sim(&HE7) = New opfunc(AddressOf trap_ed)
            op_sim(&HE8) = New opfunc(AddressOf trap_ed) : op_sim(&HE9) = New opfunc(AddressOf trap_ed) : op_sim(&HEA) = New opfunc(AddressOf trap_ed) : op_sim(&HEB) = New opfunc(AddressOf trap_ed)
            op_sim(&HEC) = New opfunc(AddressOf trap_ed) : op_sim(&HED) = New opfunc(AddressOf trap_ed) : op_sim(&HEE) = New opfunc(AddressOf trap_ed) : op_sim(&HEF) = New opfunc(AddressOf trap_ed)

            op_sim(&HF0) = New opfunc(AddressOf trap_ed) : op_sim(&HF1) = New opfunc(AddressOf trap_ed) : op_sim(&HF2) = New opfunc(AddressOf trap_ed) : op_sim(&HF3) = New opfunc(AddressOf trap_ed)
            op_sim(&HF4) = New opfunc(AddressOf trap_ed) : op_sim(&HF5) = New opfunc(AddressOf trap_ed) : op_sim(&HF6) = New opfunc(AddressOf trap_ed) : op_sim(&HF7) = New opfunc(AddressOf trap_ed)
            op_sim(&HF8) = New opfunc(AddressOf trap_ed) : op_sim(&HF9) = New opfunc(AddressOf trap_ed) : op_sim(&HFA) = New opfunc(AddressOf trap_ed) : op_sim(&HFB) = New opfunc(AddressOf trap_ed)
            op_sim(&HFC) = New opfunc(AddressOf trap_ed) : op_sim(&HFD) = New opfunc(AddressOf trap_ed) : op_sim(&HFE) = New opfunc(AddressOf trap_ed) : op_sim(&HFF) = New opfunc(AddressOf trap_ed)
        End Sub ' New
    End Class ' op_ed

    Public op_ed1 As New op_ed

    '====================================
    ' This function traps all illegal opcodes following the initial 0xDD of a multi byte opcode.
    Private Function trap_ed() As Integer
        Call Haupt.cpuError(COMMON.OPTRAP2)
        Call Haupt.cpuState(COMMON.STOPPED)
        trap_ed = 0
    End Function ' trap_ed

#Region "IN x,(C)"
    '------------------------------------
    Private Function op_inbic() As Integer                                      '&H40         'IN B,(C)
        op_inbic = ina(COMMON.vZ80cpu.B)
    End Function '40    'op_inbic
    Private Function op_incic() As Integer                                      '&H48         'IN C,(C)
        op_incic = ina(COMMON.vZ80cpu.C)
    End Function '48    'op_incic
    Private Function op_indic() As Integer                                      '&H50         'IN D,(C)
        op_indic = ina(COMMON.vZ80cpu.D)
    End Function '50    'op_indic
    Private Function op_ineic() As Integer                                      '&H58         'IN E,(C)
        op_ineic = ina(COMMON.vZ80cpu.E)
    End Function '58    'op_ineic
    Private Function op_inhic() As Integer                                      '&H60         'IN H,(C)
        op_inhic = ina(COMMON.vZ80cpu.H)
    End Function '60    'op_inhic
    Private Function op_inlic() As Integer                                      '&68          'IN L,(C)
        op_inlic = ina(COMMON.vZ80cpu.L)
    End Function '68    'op_inlic
    Private Function op_inaic() As Integer                                      '&H78         'IN A,(C)
        op_inaic = ina(COMMON.vZ80cpu.A)
    End Function '78    'op_inaic
    Private Function ina(ByRef par1 As Byte) As Integer
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_INP)
        par1 = Haupt.IOsim.io_in(COMMON.vZ80cpu.C)
        COMMON.vZ80cpu.F = COMMON.vZ80cpu.F And Not (N_FLAG Or H_FLAG)
        Call COMMON.vZ80cpu.FlagZflag2(par1 <> 0)
        Call COMMON.vZ80cpu.FlagSflag1((par1 And &H80))
        Call COMMON.vZ80cpu.FlagPflag2(COMMON.vZ80cpu.parrity(par1) = 1)
        ina = 12
    End Function ' ina
#End Region
#Region "OUT (C),x"
    '------------------------------------
    Private Function op_outcb() As Integer                                      '&H41         'OUT (C),B
        op_outcb = out(COMMON.vZ80cpu.B)
    End Function '41    'op_outcb
    Private Function op_outcc() As Integer                                      '&H49         'OUT (C),C
        op_outcc = out(COMMON.vZ80cpu.C)
    End Function '49    'op_outcc
    Private Function op_outcd() As Integer                                      '&H51         'OUT (C),D
        op_outcd = out(COMMON.vZ80cpu.D)
    End Function '51    'op_outcd
    Private Function op_outce() As Integer                                      '&H59         'OUT (C),E
        op_outce = out(COMMON.vZ80cpu.E)
    End Function '59    'op_outce
    Private Function op_outch() As Integer                                      '&H61         'OUT (C),H
        op_outch = out(COMMON.vZ80cpu.H)
    End Function '61    'op_outch
    Private Function op_outcl() As Integer                                      '&H69         'OUT (C),L
        op_outcl = out(COMMON.vZ80cpu.L)
    End Function '69    'op_outcl
    Private Function op_outca() As Integer                                      '&H79         'OUT (C),A
        op_outca = out(COMMON.vZ80cpu.A)
    End Function '79    'op_outca
    Private Function out(ByVal par1 As Byte) As Integer
        Try
            Call COMMON.vZ80cpu.busfront(COMMON.CPU_OUT)
            Call Haupt.IOsim.io_out(COMMON.vZ80cpu.C, par1)
        Catch ex As Exception
            MsgBox("ED.out: " + ex.Message & vbCrLf &
                   "PC=" + COMMON.HexAnzeige_WordByte(COMMON.vZ80cpu.PC, "B") & vbCrLf &
                   "HL=" + COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.H) + COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.L) & vbCrLf &
                   "DE=" + COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.D) + COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.E) & vbCrLf &
                   "BC=" + COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.B) + COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.C)
                  )
        End Try
        out = 12
    End Function ' out
#End Region

#Region "SBC HL,xx"
    '------------------------------------
    Private Function op_sbchb() As Integer                                      '&H42         'SBC HL,BC
        op_sbchb = sbc(COMMON.vZ80cpu.B, COMMON.vZ80cpu.C)
    End Function '42    'op_sbchb
    Private Function op_sbchd() As Integer                                      '&H52         'SBC HL,DE
        op_sbchd = sbc(COMMON.vZ80cpu.D, COMMON.vZ80cpu.E)
    End Function '52    'op_sbchd
    Private Function op_sbchh() As Integer                                      '&H62         'SBC HL,HL
        op_sbchh = sbc(COMMON.vZ80cpu.H, COMMON.vZ80cpu.L)
    End Function '62    'op_sbchh
    Private Function op_sbchs() As Integer                                      '&H72         'SBC HL,SP
        op_sbchs = sbc((COMMON.vZ80cpu.STACK And &HFF00) >> 8, COMMON.vZ80cpu.STACK And &HFF)
    End Function '72    'op_sbchs
    Private Function sbc(ByVal ParH As ULong, ByVal ParL As ULong) As Integer
        's Is set if result Is negative; reset otherwise
        'Z Is set if result Is zero; reset otherwise
        'H Is set if a borrow from bit 12; reset otherwise
        'P/ V Is set if overflow; reset otherwise
        'N Is set
        'C Is set if borrow; reset otherwise

        Dim carry As Byte
        Dim hl, par As ULong
        Dim shl, spar As Long

        hl = COMMON.vZ80cpu.H * 256 + COMMON.vZ80cpu.L
        par = ParH * 256 + ParL
        shl = hl
        spar = par
        If (COMMON.vZ80cpu.F And COMMON.C_FLAG) = COMMON.C_FLAG Then carry = 1 Else carry = 0
        Call COMMON.vZ80cpu.FlagHflag1((par And &HFFF) + carry > (hl And &HFFF))

        shl = shl - spar - carry
        Call COMMON.vZ80cpu.FlagPflag1((shl > 32767) Or (shl < -32768))
        Call COMMON.vZ80cpu.FlagCflag1(par + carry > hl)
        shl = shl And &HFFFF
        Call COMMON.vZ80cpu.FlagZflag2((shl And &HFFFF))
        Call COMMON.vZ80cpu.FlagSflag1((shl And &H8000))
        COMMON.vZ80cpu.H = (shl >> 8) And &HFF
        COMMON.vZ80cpu.L = shl And &HFF
        Call COMMON.vZ80cpu.FlagNflag1()
        sbc = 15
    End Function ' sbc
#End Region

#Region "LD (nn),xx"
    '------------------------------------
    Private Function op_ldinbc() As Integer                                     '&H43         'LD (nn),BC
        Dim p As ULong
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_NONE)
        COMMON.vZ80cpu.PC = COMMON.vZ80cpu.PC + 1 : p = COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.PC)
        COMMON.vZ80cpu.PC = COMMON.vZ80cpu.PC + 1 : p = p + COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.PC) * 256
        COMMON.vZ80cpu.Speicher_schreiben_Byte(p, COMMON.vZ80cpu.C) : p = p + 1
        COMMON.vZ80cpu.Speicher_schreiben_Byte(p, COMMON.vZ80cpu.B)
        op_ldinbc = 20
    End Function '43    'op_ldinbc
    Private Function op_ldinde() As Integer                                     '&H53         'LD (nn),DE
        Dim p As ULong
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_NONE)
        COMMON.vZ80cpu.PC = COMMON.vZ80cpu.PC + 1 : p = COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.PC)
        COMMON.vZ80cpu.PC = COMMON.vZ80cpu.PC + 1 : p = p + COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.PC) * 256
        COMMON.vZ80cpu.Speicher_schreiben_Byte(p, COMMON.vZ80cpu.E) : p = p + 1
        COMMON.vZ80cpu.Speicher_schreiben_Byte(p, COMMON.vZ80cpu.D)
        op_ldinde = 20
    End Function '53    'op_ldinde
    Private Function op_ldinsp() As Integer                                     '&H73         'LD (nn),SP
        Dim p As ULong
        Dim i As Integer
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_NONE)
        COMMON.vZ80cpu.PCplus1() : p = COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.PC)
        COMMON.vZ80cpu.PCplus1() : p = p + COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.PC) * 256
        i = COMMON.vZ80cpu.STACK
        COMMON.vZ80cpu.Speicher_schreiben_Byte(p, i And &HFF) : p = p + 1
        COMMON.vZ80cpu.Speicher_schreiben_Byte(p, i \ 256)
        op_ldinsp = 20
    End Function '73    'op_ldinsp
#End Region

#Region "NEG"
    '------------------------------------
    Private Function op_neg() As Integer                                        '&H44         'NEG
        Call COMMON.vZ80cpu.FlagCflag1(COMMON.vZ80cpu.A <> 0)
        Call COMMON.vZ80cpu.FlagPflag1(COMMON.vZ80cpu.A = &H80)
        Call COMMON.vZ80cpu.FlagHflag1(0 - (COMMON.Byte2SByte(COMMON.vZ80cpu.A) And &HF) < 0)
        COMMON.vZ80cpu.A = (0 - COMMON.vZ80cpu.A) And &HFF
        Call COMMON.vZ80cpu.FlagNflag1()
        Call COMMON.vZ80cpu.FlagZflag2(COMMON.vZ80cpu.A <> 0)
        Call COMMON.vZ80cpu.FlagSflag1((COMMON.vZ80cpu.A And &H80))
        op_neg = 8
    End Function '44    'op_neg
#End Region

#Region "RETN, RETI"
    '------------------------------------
    Private Function op_retn() As Integer                                       '&H45         'RETN
        Dim i As Integer
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_STACK Or COMMON.CPU_MEMR)
        i = COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.STACK) : Call COMMON.vZ80cpu.SPplus1()
        i = i + COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.STACK) * 256 : Call COMMON.vZ80cpu.SPplus1()
        COMMON.vZ80cpu.PC = i
        If (COMMON.vZ80cpu.IFF And 2) = 2 Then COMMON.vZ80cpu.IFF = COMMON.vZ80cpu.IFF Or 1
        op_retn = 14
    End Function '45    'op_retn
    Private Function op_reti() As Integer                                       '&H4D         'RETI
        Dim i As Integer
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_STACK Or COMMON.CPU_MEMR)
        i = COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.STACK) : Call COMMON.vZ80cpu.SPplus1()
        i = i + COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.STACK) * 256 : Call COMMON.vZ80cpu.SPplus1()
        COMMON.vZ80cpu.PC = i
        op_reti = 14
    End Function '4D    'op_reti
#End Region

#Region "IM x"
    '------------------------------------
    Private Function op_im0() As Integer                                        '&H46         'IM 0
        Call Haupt.intMode(COMMON.INT_NONE)
        op_im0 = 8
    End Function '46    'op_im0
    Private Function op_im1() As Integer                                        '&H56         'IM 1 
        Call Haupt.intMode(COMMON.INT_NMI)
        op_im1 = 8
    End Function '56    'op_im1
    Private Function op_im2() As Integer                                        '&H5E         'IM 2
        Call Haupt.intMode(COMMON.INT_INT)
        op_im2 = 8
    End Function '5E    'op_im2
#End Region

#Region "LD I,A  LD A,I   RRD (HL)"
    '------------------------------------
    Private Function op_ldia() As Integer                                       '&H47         'LD I,A 
        COMMON.vZ80cpu.III = COMMON.vZ80cpu.A
        op_ldia = 9
    End Function '47    'op_ldia
    Private Function op_ldai() As Integer                                       '&H57         'LD A,I
        COMMON.vZ80cpu.A = COMMON.vZ80cpu.III
        COMMON.vZ80cpu.F = COMMON.vZ80cpu.F And Not (N_FLAG Or H_FLAG)
        Call COMMON.vZ80cpu.FlagPflag1((COMMON.vZ80cpu.IFF And 2))
        Call COMMON.vZ80cpu.FlagZflag2(COMMON.vZ80cpu.A <> 0)
        Call COMMON.vZ80cpu.FlagSflag1((COMMON.vZ80cpu.A And &H80))
        op_ldai = 9
    End Function '57    'op_ldai
    Private Function op_oprrd() As Integer                                      '&H67         'RRD (HL)
        Dim i, j As Integer
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        i = COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.H * 256 + COMMON.vZ80cpu.L)
        j = COMMON.vZ80cpu.A And &HF
        COMMON.vZ80cpu.A = (COMMON.vZ80cpu.A And &HF0) Or (i And &HF)
        i = (i >> 4) Or (j << 4) And &HFF
        COMMON.vZ80cpu.Speicher_schreiben_Byte(COMMON.vZ80cpu.H * 256 + COMMON.vZ80cpu.L, i)
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_NONE)

        COMMON.vZ80cpu.F = COMMON.vZ80cpu.F And Not (H_FLAG Or N_FLAG)
        Call COMMON.vZ80cpu.FlagZflag2(COMMON.vZ80cpu.A <> 0)
        Call COMMON.vZ80cpu.FlagSflag1((COMMON.vZ80cpu.A And &H80))
        Call COMMON.vZ80cpu.FlagPflag2(COMMON.vZ80cpu.parrity(COMMON.vZ80cpu.A) = 1)
        op_oprrd = 18
    End Function '67    'op_oprrd
#End Region

#Region "ADC HL,xx"
    '------------------------------------
    Private Function op_adchb() As Integer                                      '&H4A         'ADC HL,BC
        op_adchb = adc(COMMON.vZ80cpu.B, COMMON.vZ80cpu.C)
    End Function '4A    'op_adchb
    Private Function op_adchd() As Integer                                      '&H5A         'ADC HL,DE
        op_adchd = adc(COMMON.vZ80cpu.D, COMMON.vZ80cpu.E)
    End Function '5A    'op_adchd
    Private Function op_adchh() As Integer                                      '&H6A         'ADC HL,HL
        op_adchh = adc(COMMON.vZ80cpu.H, COMMON.vZ80cpu.L)
    End Function '6A    'op_adchh
    Private Function op_adchs() As Integer                                      '&H7A         'ADC HL,SP
        op_adchs = adc((COMMON.vZ80cpu.STACK And &HFF00) >> 8, COMMON.vZ80cpu.STACK And &HFF)
    End Function '7A    'op_adchs
    Private Function adc(ByVal ParH As ULong, ByVal ParL As ULong) As Integer
        's Is set if result Is negative; reset otherwise
        'Z Is set if result Is zero; reset otherwise
        'H Is set if carry out of bit 11;. reset otherwise
        'P/ V Is set if overflow; reset otherwise
        'N Is Reset
        'C Is set if carry from bit 15; reset otherwise

        Dim carry As Byte
        Dim hl, par As ULong
        Dim shl, spar As Long 'Integer 'SWORD        

        hl = (COMMON.vZ80cpu.H << 8) + COMMON.vZ80cpu.L
        par = (ParH << 8) + ParL
        shl = hl
        spar = par
        If (COMMON.vZ80cpu.F And COMMON.C_FLAG) = COMMON.C_FLAG Then carry = 1 Else carry = 0
        Call COMMON.vZ80cpu.FlagHflag1(((hl And &HFFF) + (ParH And &HFFF) + carry) > &HFFF)

        shl = shl + spar + carry
        Call COMMON.vZ80cpu.FlagPflag1((shl > 32767) Or (shl < -32768))
        Call COMMON.vZ80cpu.FlagCflag1(hl + par + carry > &HFFFF)
        shl = shl And &HFFFF
        Call COMMON.vZ80cpu.FlagZflag2((shl And &HFFFF)) '???
        Call COMMON.vZ80cpu.FlagSflag1((shl And &H8000))
        COMMON.vZ80cpu.H = (shl >> 8) And &HFF
        COMMON.vZ80cpu.L = shl And &HFF
        Call COMMON.vZ80cpu.FlagNflag2()
        adc = 15
    End Function ' adc
#End Region

#Region "LD xx,(nn)"
    '------------------------------------
    Private Function op_ldbcinn() As Integer                                    '&H4B         'LD BC,(nn)
        Dim p As ULong
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        Call COMMON.vZ80cpu.PCplus1() : p = COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.PC)
        Call COMMON.vZ80cpu.PCplus1() : p = p + COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.PC) * 256
        COMMON.vZ80cpu.C = COMMON.vZ80cpu.Speicher_lesen_Byte(p) : p = p + 1
        COMMON.vZ80cpu.B = COMMON.vZ80cpu.Speicher_lesen_Byte(p)
        op_ldbcinn = 20
    End Function '4B    'op_ldbcinn
    Private Function op_lddeinn() As Integer                                    '&H5B         'LD DE,(nn)
        Dim p As ULong
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        Call COMMON.vZ80cpu.PCplus1() : p = COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.PC)
        Call COMMON.vZ80cpu.PCplus1() : p = p + COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.PC) * 256
        COMMON.vZ80cpu.E = COMMON.vZ80cpu.Speicher_lesen_Byte(p) : p = p + 1
        COMMON.vZ80cpu.D = COMMON.vZ80cpu.Speicher_lesen_Byte(p)
        op_lddeinn = 20
    End Function '5B    'op_lddeinn
    Private Function op_ldspinn() As Integer                                    '&H7B         'LD SP,(nn)
        Dim p As ULong
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        Call COMMON.vZ80cpu.PCplus1() : p = COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.PC)
        Call COMMON.vZ80cpu.PCplus1() : p = p + COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.PC) * 256
        'Call COMMON.vZ80cpu.PCplus1()
        COMMON.vZ80cpu.STACK = COMMON.vZ80cpu.Speicher_lesen_Byte(p) : p = p + 1
        COMMON.vZ80cpu.STACK = COMMON.vZ80cpu.STACK + COMMON.vZ80cpu.Speicher_lesen_Byte(p) * 256
        op_ldspinn = 20
        If Haupt.BufferAnzeigenVis.Checked Then Call AnzeigeBuffer.AnzeigeBuffer()
    End Function '7B    'op_ldspinn
#End Region
#Region "LD R,A  LD A,R  RLD (HL)"
    '------------------------------------
    Private Function op_ldra() As Integer                                       '&H4F         'LD R,A
        COMMON.vZ80cpu.R = COMMON.vZ80cpu.A
        op_ldra = 9
    End Function '4F    'op_ldra
    Private Function op_ldar() As Integer                                       '&H5F         'LD A,R
        COMMON.vZ80cpu.A = COMMON.vZ80cpu.R
        COMMON.vZ80cpu.F = COMMON.vZ80cpu.F And Not (N_FLAG Or H_FLAG)
        Call COMMON.vZ80cpu.FlagPflag1((COMMON.vZ80cpu.IFF And 2))
        Call COMMON.vZ80cpu.FlagZflag2(COMMON.vZ80cpu.A <> 0)
        Call COMMON.vZ80cpu.FlagSflag1((COMMON.vZ80cpu.A And &H80))
        op_ldar = 9
    End Function '5F    'op_ldar
    Private Function op_oprld() As Integer                                      '&H6F         'RLD (HL)
        Dim i, j As Integer
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        i = COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.H * 256 + COMMON.vZ80cpu.L)
        j = COMMON.vZ80cpu.A And &HF
        COMMON.vZ80cpu.A = (COMMON.vZ80cpu.A And &HF0) Or (i >> 4)
        i = ((i << 4) Or j) And &HFF
        COMMON.vZ80cpu.Speicher_schreiben_Byte(COMMON.vZ80cpu.H * 256 + COMMON.vZ80cpu.L, i)
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_NONE)
        COMMON.vZ80cpu.F = COMMON.vZ80cpu.F And Not (H_FLAG Or N_FLAG)
        Call COMMON.vZ80cpu.FlagZflag2(COMMON.vZ80cpu.A <> 0)
        Call COMMON.vZ80cpu.FlagSflag1((COMMON.vZ80cpu.A And &H80))
        Call COMMON.vZ80cpu.FlagPflag2(COMMON.vZ80cpu.parrity(COMMON.vZ80cpu.A) = 1)
        op_oprld = 18
    End Function '6F    'op_oprld
#End Region

#Region "LDI ---  OUTD"
    '------------------------------------
    Private Function op_ldi() As Integer                                        '&HA0         'LDI
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        COMMON.vZ80cpu.Speicher_schreiben_Byte(COMMON.vZ80cpu.D * 256 + COMMON.vZ80cpu.E, COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.H * 256 + COMMON.vZ80cpu.L))
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_NONE)
        If COMMON.vZ80cpu.RegPlus1(COMMON.vZ80cpu.E) Then COMMON.vZ80cpu.RegPlus1(COMMON.vZ80cpu.D)
        If COMMON.vZ80cpu.RegPlus1(COMMON.vZ80cpu.L) Then COMMON.vZ80cpu.RegPlus1(COMMON.vZ80cpu.H)
        If COMMON.vZ80cpu.RegMinus1(COMMON.vZ80cpu.C) Then COMMON.vZ80cpu.RegMinus1(COMMON.vZ80cpu.B)
        Call COMMON.vZ80cpu.FlagPflag1((COMMON.vZ80cpu.B <> 0) Or (COMMON.vZ80cpu.C <> 0))
        COMMON.vZ80cpu.F = COMMON.vZ80cpu.F And Not (N_FLAG Or H_FLAG)
        op_ldi = 16
    End Function 'A0    'op_ldi
    Private Function op_cpi() As Integer                                        '&HA1         'CPI
        Dim i As Integer
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        i = COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.H * 256 + COMMON.vZ80cpu.L)
        Call COMMON.vZ80cpu.FlagHflag1((i And &HF) > (COMMON.vZ80cpu.A And &HF))
        i = COMMON.vZ80cpu.A - i
        If COMMON.vZ80cpu.RegPlus1(COMMON.vZ80cpu.L) Then COMMON.vZ80cpu.RegPlus1(COMMON.vZ80cpu.H)
        If COMMON.vZ80cpu.RegMinus1(COMMON.vZ80cpu.C) Then COMMON.vZ80cpu.RegMinus1(COMMON.vZ80cpu.B)
        COMMON.vZ80cpu.F = COMMON.vZ80cpu.F Or N_FLAG
        Call COMMON.vZ80cpu.FlagPflag1((COMMON.vZ80cpu.B <> 0) Or (COMMON.vZ80cpu.C <> 0))
        Call COMMON.vZ80cpu.FlagZflag2(i <> 0)
        Call COMMON.vZ80cpu.FlagSflag1((i And &H80))
        op_cpi = 16
    End Function 'A1    'op_cpi
    Private Function op_ini() As Integer                                        '&HA2         'INI
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_INP)
        COMMON.vZ80cpu.Speicher_schreiben_Byte(COMMON.vZ80cpu.H * 256 + COMMON.vZ80cpu.L, Haupt.IOsim.io_in(COMMON.vZ80cpu.C))
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_NONE)
        If COMMON.vZ80cpu.RegPlus1(COMMON.vZ80cpu.L) Then COMMON.vZ80cpu.RegPlus1(COMMON.vZ80cpu.H)
        COMMON.vZ80cpu.RegMinus1(COMMON.vZ80cpu.B)
        Call COMMON.vZ80cpu.FlagNflag1()
        Call COMMON.vZ80cpu.FlagZflag2(COMMON.vZ80cpu.B <> 0)
        op_ini = 16
    End Function 'A2    'op_ini
    Private Function op_outi() As Integer                                       '&HA3         'OUTI
        'Dim i As Integer
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        Haupt.IOsim.io_out(COMMON.vZ80cpu.C, COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.H * 256 + COMMON.vZ80cpu.L))
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_OUT)
        If COMMON.vZ80cpu.RegPlus1(COMMON.vZ80cpu.L) Then COMMON.vZ80cpu.RegPlus1(COMMON.vZ80cpu.H)
        COMMON.vZ80cpu.RegMinus1(COMMON.vZ80cpu.B)
        Call COMMON.vZ80cpu.FlagNflag1()
        Call COMMON.vZ80cpu.FlagZflag2(COMMON.vZ80cpu.B <> 0)
        op_outi = 16
    End Function 'A3    'op_outi
    Private Function op_ldd() As Integer                                        '&HA8         'LDD
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        COMMON.vZ80cpu.Speicher_schreiben_Byte(COMMON.vZ80cpu.D * 256 + COMMON.vZ80cpu.E, COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.H * 256 + COMMON.vZ80cpu.L))
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_NONE)
        If COMMON.vZ80cpu.RegMinus1(COMMON.vZ80cpu.E) Then COMMON.vZ80cpu.RegMinus1(COMMON.vZ80cpu.D)
        If COMMON.vZ80cpu.RegMinus1(COMMON.vZ80cpu.L) Then COMMON.vZ80cpu.RegMinus1(COMMON.vZ80cpu.H)
        If COMMON.vZ80cpu.RegMinus1(COMMON.vZ80cpu.C) Then COMMON.vZ80cpu.RegMinus1(COMMON.vZ80cpu.B)
        Call COMMON.vZ80cpu.FlagPflag1((COMMON.vZ80cpu.B <> 0) Or (COMMON.vZ80cpu.C <> 0))
        COMMON.vZ80cpu.F = COMMON.vZ80cpu.F And Not (N_FLAG Or H_FLAG)
        op_ldd = 16
    End Function 'A8    'op_ldd
    Private Function op_cpdop() As Integer                                      '&HA9         'CPD
        Dim i As Integer
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        i = COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.H * 256 + COMMON.vZ80cpu.L)
        Call COMMON.vZ80cpu.FlagHflag1((i And &HF) > (COMMON.vZ80cpu.A And &HF))
        i = (COMMON.vZ80cpu.A - i) And &HFF
        If COMMON.vZ80cpu.RegMinus1(COMMON.vZ80cpu.L) Then COMMON.vZ80cpu.RegMinus1(COMMON.vZ80cpu.H)
        If COMMON.vZ80cpu.RegMinus1(COMMON.vZ80cpu.C) Then COMMON.vZ80cpu.RegMinus1(COMMON.vZ80cpu.B)
        Call COMMON.vZ80cpu.FlagNflag1()
        Call COMMON.vZ80cpu.FlagPflag1((COMMON.vZ80cpu.B <> 0) Or (COMMON.vZ80cpu.C <> 0))
        Call COMMON.vZ80cpu.FlagZflag2(i <> 0)
        Call COMMON.vZ80cpu.FlagSflag1((i And &H80))
        op_cpdop = 16
    End Function 'A9    'op_cpdop
    Private Function op_ind() As Integer                                        '&HAA         'IND
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_INP)
        COMMON.vZ80cpu.Speicher_schreiben_Byte(COMMON.vZ80cpu.H * 256 + COMMON.vZ80cpu.L, Haupt.IOsim.io_in(COMMON.vZ80cpu.C))
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_NONE)
        If COMMON.vZ80cpu.RegMinus1(COMMON.vZ80cpu.L) Then COMMON.vZ80cpu.RegMinus1(COMMON.vZ80cpu.H)
        COMMON.vZ80cpu.RegMinus1(COMMON.vZ80cpu.B)
        Call COMMON.vZ80cpu.FlagNflag1()
        Call COMMON.vZ80cpu.FlagZflag2(COMMON.vZ80cpu.B <> 0)
        op_ind = 16
    End Function 'AA    'op_ind
    Private Function op_outd() As Integer                                       '&HAB         'OUTD
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        Haupt.IOsim.io_out(COMMON.vZ80cpu.C, COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.H * 256 + COMMON.vZ80cpu.L))
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_OUT)
        If COMMON.vZ80cpu.RegMinus1(COMMON.vZ80cpu.L) Then COMMON.vZ80cpu.RegMinus1(COMMON.vZ80cpu.H)
        COMMON.vZ80cpu.RegMinus1(COMMON.vZ80cpu.B)
        Call COMMON.vZ80cpu.FlagNflag1()
        Call COMMON.vZ80cpu.FlagZflag2(COMMON.vZ80cpu.B <> 0)
        op_outd = 16
    End Function 'AB    'op_outd
#End Region

#Region "LDIR  CPIR"
    '------------------------------------
    Private Function op_ldir() As Integer                                       '&HB0         'LDIR
        Dim i As Long
        Dim s, p As Long
        Dim t As Integer
        t = -21
        i = COMMON.vZ80cpu.B * 256 + COMMON.vZ80cpu.C
        p = COMMON.vZ80cpu.D * 256 + COMMON.vZ80cpu.E
        s = COMMON.vZ80cpu.H * 256 + COMMON.vZ80cpu.L
        Try
            Do
                Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
                COMMON.vZ80cpu.Speicher_schreiben_Byte(p, COMMON.vZ80cpu.Speicher_lesen_Byte(s))
                p = p + 1 : If p > &HFFFF Then p = 0
                s = s + 1 : If s > &HFFFF Then s = 0
                Call COMMON.vZ80cpu.busfront(COMMON.CPU_NONE)
                t = t + 21
                i = i - 1
            Loop While (i > 0)
        Catch ex As Exception
            MsgBox("ED.op_ldir: " + ex.Message & vbCrLf &
                   "PC=" + COMMON.HexAnzeige_WordByte(COMMON.vZ80cpu.PC, "B ") & vbCrLf &
                   "HL=" + COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.H) + COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.L) & vbCrLf &
                   "DE=" + COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.D) + COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.E) & vbCrLf &
                   "BC=" + COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.B) + COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.C)
                  )
        End Try
        COMMON.vZ80cpu.B = 0
        COMMON.vZ80cpu.C = 0
        COMMON.vZ80cpu.D = (p >> 8) And &HFF
        COMMON.vZ80cpu.E = p And &HFF
        COMMON.vZ80cpu.H = (s >> 8) And &HFF
        COMMON.vZ80cpu.L = s And &HFF
        COMMON.vZ80cpu.F = COMMON.vZ80cpu.F And Not (N_FLAG Or P_FLAG Or H_FLAG)
        op_ldir = t + 16
    End Function 'B0    'op_ldir
    Private Function op_cpir() As Integer                                       '&HB1         'CPIR
        '                                                                       'H Flag not set!!!
        Dim i As Long
        Dim s As Long
        Dim d1 As Integer
        Dim d2 As Integer
        Dim t As Integer
        t = -21
        i = COMMON.vZ80cpu.B * 256 + COMMON.vZ80cpu.C
        s = COMMON.vZ80cpu.H * 256 + COMMON.vZ80cpu.L
        Do
            Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
            d1 = COMMON.vZ80cpu.A
            d2 = COMMON.vZ80cpu.Speicher_lesen_Byte(s)
            d1 = d1 - d2
            d1 = d1 And &HFF
            'D = (COMMON.vZ80cpu.A - COMMON.vZ80cpu.Speicher_lesen_Byte(s))
            s = s + 1
            t = t + 21
            i = i - 1
        Loop Until (i = 0) Or (d1 = 0)
        COMMON.vZ80cpu.F = COMMON.vZ80cpu.F Or N_FLAG
        COMMON.vZ80cpu.B = (i >> 8) And &HFF
        COMMON.vZ80cpu.C = i And &HFF
        COMMON.vZ80cpu.H = (s >> 8) And &HFF
        COMMON.vZ80cpu.L = s And &HFF

        Call COMMON.vZ80cpu.FlagPflag1(i <> 0)
        Call COMMON.vZ80cpu.FlagZflag2(d1 <> 0)
        Call COMMON.vZ80cpu.FlagSflag1((d1 And &H80))
        op_cpir = t + 16
    End Function 'B1    'op_cpir
#End Region

#Region "INIR  OTIR"
    '------------------------------------
    Private Function op_inir() As Integer                                       '&HB2         'INIR
        Dim d As Long
        Dim t As Integer
        t = -21
        d = COMMON.vZ80cpu.H * 256 + COMMON.vZ80cpu.L
        Do
            Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_INP)
            COMMON.vZ80cpu.Speicher_schreiben_Byte(d, Haupt.IOsim.io_in(COMMON.vZ80cpu.C)) : d = d + 1
            Call COMMON.vZ80cpu.busfront(COMMON.CPU_NONE)
            COMMON.vZ80cpu.RegMinus1(COMMON.vZ80cpu.B)            
            t = t + 21
        Loop While (COMMON.vZ80cpu.B > 0)
        COMMON.vZ80cpu.H = (d >> 8) And &HFF
        COMMON.vZ80cpu.L = d And &HFF
        COMMON.vZ80cpu.F = COMMON.vZ80cpu.F Or COMMON.N_FLAG Or COMMON.Z_FLAG
        op_inir = t + 16
    End Function 'B2    'op_inir
    Private Function op_otir() As Integer                                       '&HB3         'OTIR
        Dim d As Long
        Dim t As Integer
        t = -21
        d = COMMON.vZ80cpu.H * 256 + COMMON.vZ80cpu.L
        Do
            Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
            Call Haupt.IOsim.io_out(COMMON.vZ80cpu.C, COMMON.vZ80cpu.Speicher_lesen_Byte(d)) : d = d + 1
            Call COMMON.vZ80cpu.busfront(COMMON.CPU_OUT)
            COMMON.vZ80cpu.RegMinus1(COMMON.vZ80cpu.B)
            t = t + 21
        Loop While (COMMON.vZ80cpu.B > 0)
        COMMON.vZ80cpu.H = (d >> 8) And &HFF
        COMMON.vZ80cpu.L = d And &HFF
        COMMON.vZ80cpu.F = COMMON.vZ80cpu.F Or N_FLAG Or Z_FLAG
        op_otir = t + 16
    End Function 'B3    'op_otir
#End Region

#Region "LDDR  CPDR"
    '------------------------------------
    Private Function op_lddr() As Integer                                       '&HB8         'LDDR
        Dim i As Long
        Dim s, d As Long
        Dim t As Integer
        t = -21
        i = COMMON.vZ80cpu.B * 256 + COMMON.vZ80cpu.C
        d = COMMON.vZ80cpu.D * 256 + COMMON.vZ80cpu.E
        s = COMMON.vZ80cpu.H * 256 + COMMON.vZ80cpu.L
        Do
            Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
            COMMON.vZ80cpu.Speicher_schreiben_Byte(d, COMMON.vZ80cpu.Speicher_lesen_Byte(s))
            d = d - 1 : If d < 0 Then d = &HFFFF
            s = s - 1 : If s < 0 Then s = &HFFFF
            Call COMMON.vZ80cpu.busfront(COMMON.CPU_NONE)
            t = t + 21
            i = i - 1
        Loop While (i > 0)
        COMMON.vZ80cpu.B = 0
        COMMON.vZ80cpu.C = 0
        COMMON.vZ80cpu.D = (d >> 8) And &HFF
        COMMON.vZ80cpu.E = d And &HFF
        COMMON.vZ80cpu.H = (s >> 8) And &HFF
        COMMON.vZ80cpu.L = s And &HFF
        COMMON.vZ80cpu.F = COMMON.vZ80cpu.F And Not (N_FLAG Or P_FLAG Or H_FLAG)
#If WANT_TIM0 = 1 Then
        op_lddr = t + 16
#End If
    End Function 'B8    'op_lddr
    Private Function op_cpdr() As Integer                                       '&HB9         'CPDR
        Dim i As Long                                                          ' H flag not set !!! 
        Dim s As Long
        Dim d1 As Integer
        Dim d2 As Integer
        Dim t As Integer
        t = -21
        i = COMMON.vZ80cpu.B * 256 + COMMON.vZ80cpu.C
        s = COMMON.vZ80cpu.H * 256 + COMMON.vZ80cpu.L
        Do
            Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
            d1 = COMMON.vZ80cpu.A
            d2 = COMMON.vZ80cpu.Speicher_lesen_Byte(s)
            d1 = d1 - d2
            d1 = d1 And &HFF
            'D = COMMON.vZ80cpu.A - COMMON.vZ80cpu.Speicher_lesen_Byte(s)
            s = s - 1
            t = t + 21
            i = i - 1
        Loop Until (i = 0) Or (d1 = 0)
        COMMON.vZ80cpu.F = COMMON.vZ80cpu.F Or N_FLAG
        COMMON.vZ80cpu.B = (i >> 8) And &HFF
        COMMON.vZ80cpu.C = i And &HFF
        COMMON.vZ80cpu.H = (s >> 8) And &HFF
        COMMON.vZ80cpu.L = s And &HFF

        Call COMMON.vZ80cpu.FlagPflag1(i <> 0)
        Call COMMON.vZ80cpu.FlagZflag2(d1 <> 0)
        Call COMMON.vZ80cpu.FlagSflag1((d1 And &H80))
        op_cpdr = t + 16
    End Function 'B9    'op_cpdr
#End Region

#Region "INDR  OTDR"
    '------------------------------------
    Private Function op_indr() As Integer                                       '&HBA         'INDR
        Dim d As Long
        Dim t As Integer
        t = -21
        d = COMMON.vZ80cpu.H * 256 + COMMON.vZ80cpu.L
        Do
            Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_INP)
            COMMON.vZ80cpu.Speicher_schreiben_Byte(d, Haupt.IOsim.io_in(COMMON.vZ80cpu.C)) : d = d - 1
            Call COMMON.vZ80cpu.busfront(COMMON.CPU_NONE)
            COMMON.vZ80cpu.RegMinus1(COMMON.vZ80cpu.B)
            t = t + 21
        Loop While (COMMON.vZ80cpu.B > 0)
        COMMON.vZ80cpu.H = (d >> 8) And &HFF
        COMMON.vZ80cpu.L = d And &HFF
        COMMON.vZ80cpu.F = COMMON.vZ80cpu.F Or N_FLAG Or Z_FLAG
        op_indr = t + 16
    End Function 'BA    'op_indr
    Private Function op_otdr() As Integer                                       '&HBB         'OTDR
        Dim d As Long
        Dim t As Integer
        t = -21
        d = COMMON.vZ80cpu.H * 256 + COMMON.vZ80cpu.L
        Do
            Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
            Call Haupt.IOsim.io_out(COMMON.vZ80cpu.C, COMMON.vZ80cpu.Speicher_lesen_Byte(d))
            d = d - 1
            Call COMMON.vZ80cpu.busfront(COMMON.CPU_OUT)
            COMMON.vZ80cpu.RegMinus1(COMMON.vZ80cpu.B)
            t = t + 21
        Loop While (COMMON.vZ80cpu.B > 0)
        COMMON.vZ80cpu.H = (d >> 8) And &HFF
        COMMON.vZ80cpu.L = d And &HFF
        COMMON.vZ80cpu.F = COMMON.vZ80cpu.F Or N_FLAG Or Z_FLAG
        op_otdr = t + 16
    End Function 'BB    'op_otdr
#End Region

    '====================================
    Public Function op_ed_handel() As Integer
        Call COMMON.vZ80cpu.PCplus1()
        op_ed_handel = op_ed1.op_sim(COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.PC)).Invoke()
    End Function ' op_ed_handel

End Module
