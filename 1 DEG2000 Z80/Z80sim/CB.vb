Imports DEG2000.Z80cpu

Module CB
    ' This function traps all illegal opcodes following the initial 0xCB of a multi byte opcode.

    Public Class op_cb
        Public ReadOnly op_sim(0 To 255) As opfunc

        Public Sub New()
            op_sim(&H0) = New opfunc(AddressOf op_rlcb) : op_sim(&H1) = New opfunc(AddressOf op_rlcc) : op_sim(&H2) = New opfunc(AddressOf op_rlcd) : op_sim(&H3) = New opfunc(AddressOf op_rlce)
            op_sim(&H4) = New opfunc(AddressOf op_rlch) : op_sim(&H5) = New opfunc(AddressOf op_rlcl) : op_sim(&H6) = New opfunc(AddressOf op_rlchl) : op_sim(&H7) = New opfunc(AddressOf op_rlca)
            op_sim(&H8) = New opfunc(AddressOf op_rrcb) : op_sim(&H9) = New opfunc(AddressOf op_rrcc) : op_sim(&HA) = New opfunc(AddressOf op_rrcd) : op_sim(&HB) = New opfunc(AddressOf op_rrce)
            op_sim(&HC) = New opfunc(AddressOf op_rrch) : op_sim(&HD) = New opfunc(AddressOf op_rrcl) : op_sim(&HE) = New opfunc(AddressOf op_rrchl) : op_sim(&HF) = New opfunc(AddressOf op_rrca)

            op_sim(&H10) = New opfunc(AddressOf op_rlb) : op_sim(&H11) = New opfunc(AddressOf op_rlc) : op_sim(&H12) = New opfunc(AddressOf op_rld) : op_sim(&H13) = New opfunc(AddressOf op_rle)
            op_sim(&H14) = New opfunc(AddressOf op_rlh) : op_sim(&H15) = New opfunc(AddressOf op_rll) : op_sim(&H16) = New opfunc(AddressOf op_rlhl) : op_sim(&H17) = New opfunc(AddressOf op_rla)
            op_sim(&H18) = New opfunc(AddressOf op_rrb) : op_sim(&H19) = New opfunc(AddressOf op_rrc) : op_sim(&H1A) = New opfunc(AddressOf op_rrd) : op_sim(&H1B) = New opfunc(AddressOf op_rre)
            op_sim(&H1C) = New opfunc(AddressOf op_rrh) : op_sim(&H1D) = New opfunc(AddressOf op_rrl) : op_sim(&H1E) = New opfunc(AddressOf op_rrhl) : op_sim(&H1F) = New opfunc(AddressOf op_rra)

            op_sim(&H20) = New opfunc(AddressOf op_slab) : op_sim(&H21) = New opfunc(AddressOf op_slac) : op_sim(&H22) = New opfunc(AddressOf op_slad) : op_sim(&H23) = New opfunc(AddressOf op_slae)
            op_sim(&H24) = New opfunc(AddressOf op_slah) : op_sim(&H25) = New opfunc(AddressOf op_slal) : op_sim(&H26) = New opfunc(AddressOf op_slahl) : op_sim(&H27) = New opfunc(AddressOf op_slaa)
            op_sim(&H28) = New opfunc(AddressOf op_srab) : op_sim(&H29) = New opfunc(AddressOf op_srac) : op_sim(&H2A) = New opfunc(AddressOf op_srad) : op_sim(&H2B) = New opfunc(AddressOf op_srae)
            op_sim(&H2C) = New opfunc(AddressOf op_srah) : op_sim(&H2D) = New opfunc(AddressOf op_sral) : op_sim(&H2E) = New opfunc(AddressOf op_srahl) : op_sim(&H2F) = New opfunc(AddressOf op_sraa)

            op_sim(&H30) = New opfunc(AddressOf trap_cb) : op_sim(&H31) = New opfunc(AddressOf trap_cb) : op_sim(&H32) = New opfunc(AddressOf trap_cb) : op_sim(&H33) = New opfunc(AddressOf trap_cb)
            op_sim(&H34) = New opfunc(AddressOf trap_cb) : op_sim(&H35) = New opfunc(AddressOf trap_cb) : op_sim(&H36) = New opfunc(AddressOf trap_cb) : op_sim(&H37) = New opfunc(AddressOf trap_cb)
            op_sim(&H38) = New opfunc(AddressOf op_srlb) : op_sim(&H39) = New opfunc(AddressOf op_srlc) : op_sim(&H3A) = New opfunc(AddressOf op_srld) : op_sim(&H3B) = New opfunc(AddressOf op_srle)
            op_sim(&H3C) = New opfunc(AddressOf op_srlh) : op_sim(&H3D) = New opfunc(AddressOf op_srll) : op_sim(&H3E) = New opfunc(AddressOf op_srlhl) : op_sim(&H3F) = New opfunc(AddressOf op_srla)

            op_sim(&H40) = New opfunc(AddressOf op_tb0b) : op_sim(&H41) = New opfunc(AddressOf op_tb0c) : op_sim(&H42) = New opfunc(AddressOf op_tb0d) : op_sim(&H43) = New opfunc(AddressOf op_tb0e)
            op_sim(&H44) = New opfunc(AddressOf op_tb0h) : op_sim(&H45) = New opfunc(AddressOf op_tb0l) : op_sim(&H46) = New opfunc(AddressOf op_tb0hl) : op_sim(&H47) = New opfunc(AddressOf op_tb0a)
            op_sim(&H48) = New opfunc(AddressOf op_tb1b) : op_sim(&H49) = New opfunc(AddressOf op_tb1c) : op_sim(&H4A) = New opfunc(AddressOf op_tb1d) : op_sim(&H4B) = New opfunc(AddressOf op_tb1e)
            op_sim(&H4C) = New opfunc(AddressOf op_tb1h) : op_sim(&H4D) = New opfunc(AddressOf op_tb1l) : op_sim(&H4E) = New opfunc(AddressOf op_tb1hl) : op_sim(&H4F) = New opfunc(AddressOf op_tb1a)

            op_sim(&H50) = New opfunc(AddressOf op_tb2b) : op_sim(&H51) = New opfunc(AddressOf op_tb2c) : op_sim(&H52) = New opfunc(AddressOf op_tb2d) : op_sim(&H53) = New opfunc(AddressOf op_tb2e)
            op_sim(&H54) = New opfunc(AddressOf op_tb2h) : op_sim(&H55) = New opfunc(AddressOf op_tb2l) : op_sim(&H56) = New opfunc(AddressOf op_tb2hl) : op_sim(&H57) = New opfunc(AddressOf op_tb2a)
            op_sim(&H58) = New opfunc(AddressOf op_tb3b) : op_sim(&H59) = New opfunc(AddressOf op_tb3c) : op_sim(&H5A) = New opfunc(AddressOf op_tb3d) : op_sim(&H5B) = New opfunc(AddressOf op_tb3e)
            op_sim(&H5C) = New opfunc(AddressOf op_tb3h) : op_sim(&H5D) = New opfunc(AddressOf op_tb3l) : op_sim(&H5E) = New opfunc(AddressOf op_tb3hl) : op_sim(&H5F) = New opfunc(AddressOf op_tb3a)

            op_sim(&H60) = New opfunc(AddressOf op_tb4b) : op_sim(&H61) = New opfunc(AddressOf op_tb4c) : op_sim(&H62) = New opfunc(AddressOf op_tb4d) : op_sim(&H63) = New opfunc(AddressOf op_tb4e)
            op_sim(&H64) = New opfunc(AddressOf op_tb4h) : op_sim(&H65) = New opfunc(AddressOf op_tb4l) : op_sim(&H66) = New opfunc(AddressOf op_tb4hl) : op_sim(&H67) = New opfunc(AddressOf op_tb4a)
            op_sim(&H68) = New opfunc(AddressOf op_tb5b) : op_sim(&H69) = New opfunc(AddressOf op_tb5c) : op_sim(&H6A) = New opfunc(AddressOf op_tb5d) : op_sim(&H6B) = New opfunc(AddressOf op_tb5e)
            op_sim(&H6C) = New opfunc(AddressOf op_tb5h) : op_sim(&H6D) = New opfunc(AddressOf op_tb5l) : op_sim(&H6E) = New opfunc(AddressOf op_tb5hl) : op_sim(&H6F) = New opfunc(AddressOf op_tb5a)

            op_sim(&H70) = New opfunc(AddressOf op_tb6b) : op_sim(&H71) = New opfunc(AddressOf op_tb6c) : op_sim(&H72) = New opfunc(AddressOf op_tb6d) : op_sim(&H73) = New opfunc(AddressOf op_tb6e)
            op_sim(&H74) = New opfunc(AddressOf op_tb6h) : op_sim(&H75) = New opfunc(AddressOf op_tb6l) : op_sim(&H76) = New opfunc(AddressOf op_tb6hl) : op_sim(&H77) = New opfunc(AddressOf op_tb6a)
            op_sim(&H78) = New opfunc(AddressOf op_tb7b) : op_sim(&H79) = New opfunc(AddressOf op_tb7c) : op_sim(&H7A) = New opfunc(AddressOf op_tb7d) : op_sim(&H7B) = New opfunc(AddressOf op_tb7e)
            op_sim(&H7C) = New opfunc(AddressOf op_tb7h) : op_sim(&H7D) = New opfunc(AddressOf op_tb7l) : op_sim(&H7E) = New opfunc(AddressOf op_tb7hl) : op_sim(&H7F) = New opfunc(AddressOf op_tb7a)

            op_sim(&H80) = New opfunc(AddressOf op_rb0b) : op_sim(&H81) = New opfunc(AddressOf op_rb0c) : op_sim(&H82) = New opfunc(AddressOf op_rb0d) : op_sim(&H83) = New opfunc(AddressOf op_rb0e)
            op_sim(&H84) = New opfunc(AddressOf op_rb0h) : op_sim(&H85) = New opfunc(AddressOf op_rb0l) : op_sim(&H86) = New opfunc(AddressOf op_rb0hl) : op_sim(&H87) = New opfunc(AddressOf op_rb0a)
            op_sim(&H88) = New opfunc(AddressOf op_rb1b) : op_sim(&H89) = New opfunc(AddressOf op_rb1c) : op_sim(&H8A) = New opfunc(AddressOf op_rb1d) : op_sim(&H8B) = New opfunc(AddressOf op_rb1e)
            op_sim(&H8C) = New opfunc(AddressOf op_rb1h) : op_sim(&H8D) = New opfunc(AddressOf op_rb1l) : op_sim(&H8E) = New opfunc(AddressOf op_rb1hl) : op_sim(&H8F) = New opfunc(AddressOf op_rb1a)

            op_sim(&H90) = New opfunc(AddressOf op_rb2b) : op_sim(&H91) = New opfunc(AddressOf op_rb2c) : op_sim(&H92) = New opfunc(AddressOf op_rb2d) : op_sim(&H93) = New opfunc(AddressOf op_rb2e)
            op_sim(&H94) = New opfunc(AddressOf op_rb2h) : op_sim(&H95) = New opfunc(AddressOf op_rb2l) : op_sim(&H96) = New opfunc(AddressOf op_rb2hl) : op_sim(&H97) = New opfunc(AddressOf op_rb2a)
            op_sim(&H98) = New opfunc(AddressOf op_rb3b) : op_sim(&H99) = New opfunc(AddressOf op_rb3c) : op_sim(&H9A) = New opfunc(AddressOf op_rb3d) : op_sim(&H9B) = New opfunc(AddressOf op_rb3e)
            op_sim(&H9C) = New opfunc(AddressOf op_rb3h) : op_sim(&H9D) = New opfunc(AddressOf op_rb3l) : op_sim(&H9E) = New opfunc(AddressOf op_rb3hl) : op_sim(&H9F) = New opfunc(AddressOf op_rb3a)

            op_sim(&HA0) = New opfunc(AddressOf op_rb4b) : op_sim(&HA1) = New opfunc(AddressOf op_rb4c) : op_sim(&HA2) = New opfunc(AddressOf op_rb4d) : op_sim(&HA3) = New opfunc(AddressOf op_rb4e)
            op_sim(&HA4) = New opfunc(AddressOf op_rb4h) : op_sim(&HA5) = New opfunc(AddressOf op_rb4l) : op_sim(&HA6) = New opfunc(AddressOf op_rb4hl) : op_sim(&HA7) = New opfunc(AddressOf op_rb4a)
            op_sim(&HA8) = New opfunc(AddressOf op_rb5b) : op_sim(&HA9) = New opfunc(AddressOf op_rb5c) : op_sim(&HAA) = New opfunc(AddressOf op_rb5d) : op_sim(&HAB) = New opfunc(AddressOf op_rb5e)
            op_sim(&HAC) = New opfunc(AddressOf op_rb5h) : op_sim(&HAD) = New opfunc(AddressOf op_rb5l) : op_sim(&HAE) = New opfunc(AddressOf op_rb5hl) : op_sim(&HAF) = New opfunc(AddressOf op_rb5a)

            op_sim(&HB0) = New opfunc(AddressOf op_rb6b) : op_sim(&HB1) = New opfunc(AddressOf op_rb6c) : op_sim(&HB2) = New opfunc(AddressOf op_rb6d) : op_sim(&HB3) = New opfunc(AddressOf op_rb6e)
            op_sim(&HB4) = New opfunc(AddressOf op_rb6h) : op_sim(&HB5) = New opfunc(AddressOf op_rb6l) : op_sim(&HB6) = New opfunc(AddressOf op_rb6hl) : op_sim(&HB7) = New opfunc(AddressOf op_rb6a)
            op_sim(&HB8) = New opfunc(AddressOf op_rb7b) : op_sim(&HB9) = New opfunc(AddressOf op_rb7c) : op_sim(&HBA) = New opfunc(AddressOf op_rb7d) : op_sim(&HBB) = New opfunc(AddressOf op_rb7e)
            op_sim(&HBC) = New opfunc(AddressOf op_rb7h) : op_sim(&HBD) = New opfunc(AddressOf op_rb7l) : op_sim(&HBE) = New opfunc(AddressOf op_rb7hl) : op_sim(&HBF) = New opfunc(AddressOf op_rb7a)

            op_sim(&HC0) = New opfunc(AddressOf op_sb0b) : op_sim(&HC1) = New opfunc(AddressOf op_sb0c) : op_sim(&HC2) = New opfunc(AddressOf op_sb0d) : op_sim(&HC3) = New opfunc(AddressOf op_sb0e)
            op_sim(&HC4) = New opfunc(AddressOf op_sb0h) : op_sim(&HC5) = New opfunc(AddressOf op_sb0l) : op_sim(&HC6) = New opfunc(AddressOf op_sb0hl) : op_sim(&HC7) = New opfunc(AddressOf op_sb0a)
            op_sim(&HC8) = New opfunc(AddressOf op_sb1b) : op_sim(&HC9) = New opfunc(AddressOf op_sb1c) : op_sim(&HCA) = New opfunc(AddressOf op_sb1d) : op_sim(&HCB) = New opfunc(AddressOf op_sb1e)
            op_sim(&HCC) = New opfunc(AddressOf op_sb1h) : op_sim(&HCD) = New opfunc(AddressOf op_sb1l) : op_sim(&HCE) = New opfunc(AddressOf op_sb1hl) : op_sim(&HCF) = New opfunc(AddressOf op_sb1a)

            op_sim(&HD0) = New opfunc(AddressOf op_sb2b) : op_sim(&HD1) = New opfunc(AddressOf op_sb2c) : op_sim(&HD2) = New opfunc(AddressOf op_sb2d) : op_sim(&HD3) = New opfunc(AddressOf op_sb2e)
            op_sim(&HD4) = New opfunc(AddressOf op_sb2h) : op_sim(&HD5) = New opfunc(AddressOf op_sb2l) : op_sim(&HD6) = New opfunc(AddressOf op_sb2hl) : op_sim(&HD7) = New opfunc(AddressOf op_sb2a)
            op_sim(&HD8) = New opfunc(AddressOf op_sb3b) : op_sim(&HD9) = New opfunc(AddressOf op_sb3c) : op_sim(&HDA) = New opfunc(AddressOf op_sb3d) : op_sim(&HDB) = New opfunc(AddressOf op_sb3e)
            op_sim(&HDC) = New opfunc(AddressOf op_sb3h) : op_sim(&HDD) = New opfunc(AddressOf op_sb3l) : op_sim(&HDE) = New opfunc(AddressOf op_sb3hl) : op_sim(&HDF) = New opfunc(AddressOf op_sb3a)

            op_sim(&HE0) = New opfunc(AddressOf op_sb4b) : op_sim(&HE1) = New opfunc(AddressOf op_sb4c) : op_sim(&HE2) = New opfunc(AddressOf op_sb4d) : op_sim(&HE3) = New opfunc(AddressOf op_sb4e)
            op_sim(&HE4) = New opfunc(AddressOf op_sb4h) : op_sim(&HE5) = New opfunc(AddressOf op_sb4l) : op_sim(&HE6) = New opfunc(AddressOf op_sb4hl) : op_sim(&HE7) = New opfunc(AddressOf op_sb4a)
            op_sim(&HE8) = New opfunc(AddressOf op_sb5b) : op_sim(&HE9) = New opfunc(AddressOf op_sb5c) : op_sim(&HEA) = New opfunc(AddressOf op_sb5d) : op_sim(&HEB) = New opfunc(AddressOf op_sb5e)
            op_sim(&HEC) = New opfunc(AddressOf op_sb5h) : op_sim(&HED) = New opfunc(AddressOf op_sb5l) : op_sim(&HEE) = New opfunc(AddressOf op_sb5hl) : op_sim(&HEF) = New opfunc(AddressOf op_sb5a)

            op_sim(&HF0) = New opfunc(AddressOf op_sb6b) : op_sim(&HF1) = New opfunc(AddressOf op_sb6c) : op_sim(&HF2) = New opfunc(AddressOf op_sb6d) : op_sim(&HF3) = New opfunc(AddressOf op_sb6e)
            op_sim(&HF4) = New opfunc(AddressOf op_sb6h) : op_sim(&HF5) = New opfunc(AddressOf op_sb6l) : op_sim(&HF6) = New opfunc(AddressOf op_sb6hl) : op_sim(&HF7) = New opfunc(AddressOf op_sb6a)
            op_sim(&HF8) = New opfunc(AddressOf op_sb7b) : op_sim(&HF9) = New opfunc(AddressOf op_sb7c) : op_sim(&HFA) = New opfunc(AddressOf op_sb7d) : op_sim(&HFB) = New opfunc(AddressOf op_sb7e)
            op_sim(&HFC) = New opfunc(AddressOf op_sb7h) : op_sim(&HFD) = New opfunc(AddressOf op_sb7l) : op_sim(&HFE) = New opfunc(AddressOf op_sb7hl) : op_sim(&HFF) = New opfunc(AddressOf op_sb7a)
        End Sub ' New
    End Class ' op_cb

    Public ReadOnly op_cb1 As New op_cb

    '====================================
    ' This function traps all illegal opcodes following the initial 0xCB of a multi byte opcode.
    Private Function trap_cb() As Integer
        Call Haupt.cpuError(COMMON.OPTRAP2)
        Call Haupt.cpuState(COMMON.STOPPED)
        trap_cb = 0
    End Function

#Region "RLC x"
    '------------------------------------
    Private Function op_rlcb() As Integer                                       '&H00         'RLC B               
        op_rlcb = rlc(COMMON.vZ80cpu.B)
    End Function '00    'op_rlcb
    Private Function op_rlcc() As Integer                                       '&H01         'RLC C        
        op_rlcc = rlc(COMMON.vZ80cpu.C)
    End Function '01    'op_rlcc
    Private Function op_rlcd() As Integer                                       '&H02         'RLC D
        op_rlcd = rlc(COMMON.vZ80cpu.D)
    End Function '02    'op_rlcd
    Private Function op_rlce() As Integer                                       '&H03         'RLC E        
        op_rlce = rlc(COMMON.vZ80cpu.E)
    End Function '03    'op_rlce
    Private Function op_rlch() As Integer                                       '&H04         'RLC H
        op_rlch = rlc(COMMON.vZ80cpu.H)
    End Function '04    'op_rlch
    Private Function op_rlcl() As Integer                                       '&H05         'RLC L
        op_rlcl = rlc(COMMON.vZ80cpu.L)
    End Function '05    'op_rlcl
    Private Function op_rlchl() As Integer                                      '&H06         'RLC (HL)
        Dim p As Long
        Dim i As Integer
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        p = COMMON.vZ80cpu.H * 256 + COMMON.vZ80cpu.L
        i = COMMON.vZ80cpu.Speicher_lesen_Byte(p)
        Call rlc(i)
        COMMON.vZ80cpu.Speicher_schreiben_Byte(p, i)
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_NONE)
        op_rlchl = 15
    End Function '06    'op_rlchl
    Private Function op_rlca() As Integer                                       '&H07         'RLC A        
        op_rlca = rlc(COMMON.vZ80cpu.A)
    End Function '07    'op_rlca
    Private Function rlc(ByRef par1 As Byte) As Integer
        Dim i As Integer
        If (par1 And &H80) = &H80 Then i = 1 Else i = 0
        Call COMMON.vZ80cpu.FlagCflag1(i <> 0)
        COMMON.vZ80cpu.F = COMMON.vZ80cpu.F And Not (H_FLAG Or N_FLAG)
        par1 = par1 << 1
        par1 = par1 Or i

        Call COMMON.vZ80cpu.FlagZflag2(par1 <> 0)
        Call COMMON.vZ80cpu.FlagSflag1((par1 And &H80))
        Call COMMON.vZ80cpu.FlagPflag2(COMMON.vZ80cpu.parrity(par1) = 1)

        rlc = 8
    End Function ' rlc
#End Region
#Region "RRC x"
    '------------------------------------
    Private Function op_rrcb() As Integer                                       '&H08         'RRC B
        op_rrcb = rrc(COMMON.vZ80cpu.B)
    End Function '08    'op_rrcb
    Private Function op_rrcc() As Integer                                       '&H09         'RRC C
        op_rrcc = rrc(COMMON.vZ80cpu.C)
    End Function '09    'op_rrcc
    Private Function op_rrcd() As Integer                                       '&H0A         'RRC D
        op_rrcd = rrc(COMMON.vZ80cpu.D)
    End Function '0A    'op_rrcd
    Private Function op_rrce() As Integer                                       '&H0B         'RRC E
        op_rrce = rrc(COMMON.vZ80cpu.E)
    End Function '0B    'op_rrce
    Private Function op_rrch() As Integer                                       '&H0C         'RRC H
        op_rrch = rrc(COMMON.vZ80cpu.H)
    End Function '0C    'op_rrch
    Private Function op_rrcl() As Integer                                       '&H0D         'RRC L
        op_rrcl = rrc(COMMON.vZ80cpu.L)
    End Function '0D    'op_rrcl
    Private Function op_rrchl() As Integer                                      '&H0E         'RRC (HL)
        Dim p As Long
        Dim i As Integer
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        p = COMMON.vZ80cpu.H * 256 + COMMON.vZ80cpu.L
        i = COMMON.vZ80cpu.Speicher_lesen_Byte(p)
        Call rrc(i)
        COMMON.vZ80cpu.Speicher_schreiben_Byte(p, i)
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_NONE)
        op_rrchl = 15
    End Function '0E    'op_rrchl
    Private Function op_rrca() As Integer                                       '&H0F         'RRC A
        op_rrca = rrc(COMMON.vZ80cpu.A)
    End Function '0F    'op_rrca
    Private Function rrc(ByRef par1 As Byte) As Integer
        Dim i As Integer
        If (par1 And &H1) = &H1 Then i = 1 Else i = 0
        Call COMMON.vZ80cpu.FlagCflag1(i <> 0)
        COMMON.vZ80cpu.F = COMMON.vZ80cpu.F And Not (H_FLAG Or N_FLAG)
        par1 = par1 >> 1
        If (i = 1) Then par1 = par1 Or &H80

        Call COMMON.vZ80cpu.FlagZflag2(par1 <> 0)
        Call COMMON.vZ80cpu.FlagSflag1((par1 And &H80))
        Call COMMON.vZ80cpu.FlagPflag2(COMMON.vZ80cpu.parrity(par1) = 1)

        rrc = 8
    End Function ' rrc
#End Region
#Region "RL x"
    '------------------------------------
    Private Function op_rlb() As Integer                                        '&H10           'RL B         
        op_rlb = rl(COMMON.vZ80cpu.B)
    End Function '10    'op_rlb
    Private Function op_rlc() As Integer                                        '&H11           'RL C         
        op_rlc = rl(COMMON.vZ80cpu.C)
    End Function '11    'op_rlc
    Private Function op_rld() As Integer                                        '&H12           'RL D         
        op_rld = rl(COMMON.vZ80cpu.D)
    End Function '12    'op_rld
    Private Function op_rle() As Integer                                        '&H13           'RL E         
        op_rle = rl(COMMON.vZ80cpu.E)
    End Function '13    'op_rle
    Private Function op_rlh() As Integer                                        '&H14           'RL H         
        op_rlh = rl(COMMON.vZ80cpu.H)
    End Function '14    'op_rlh
    Private Function op_rll() As Integer                                        '&H15           'RL L         
        op_rll = rl(COMMON.vZ80cpu.L)
    End Function '15    'op_rll
    Private Function op_rlhl() As Integer                                       '&H16           'RL (HL)
        Dim p As Long
        Dim i As Integer
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        p = COMMON.vZ80cpu.H * 256 + COMMON.vZ80cpu.L
        i = COMMON.vZ80cpu.Speicher_lesen_Byte(p)
        Call rl(i)
        COMMON.vZ80cpu.Speicher_schreiben_Byte(p, i)
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_NONE)
        op_rlhl = 15
    End Function '16    'op_rlhl
    Private Function op_rla() As Integer                                        '&H17           'RL A         
        op_rla = rl(COMMON.vZ80cpu.A)
    End Function '17    'op_rla
    Private Function rl(ByRef par1 As Byte) As Integer
        Dim old_c_flag As Integer
        Dim i As Integer
        old_c_flag = COMMON.vZ80cpu.F And COMMON.C_FLAG
        If (par1 And &H80) = &H80 Then i = 1 Else i = 0
        Call COMMON.vZ80cpu.FlagCflag1(i <> 0)
        par1 = par1 << 1
        If (old_c_flag = 1) Then par1 = par1 Or 1
        COMMON.vZ80cpu.F = COMMON.vZ80cpu.F And Not (H_FLAG Or N_FLAG)

        Call COMMON.vZ80cpu.FlagZflag2(par1 <> 0)
        Call COMMON.vZ80cpu.FlagSflag1((par1 And &H80))
        Call COMMON.vZ80cpu.FlagPflag2(COMMON.vZ80cpu.parrity(par1) = 1)

        rl = 8
    End Function ' rl
#End Region
#Region "RR x"
    '------------------------------------
    Private Function op_rrb() As Integer                                        '&H18           'RR B         
        op_rrb = rr(COMMON.vZ80cpu.B)
    End Function '18    'op_rrb
    Private Function op_rrc() As Integer                                        '&H19           'RR C         
        op_rrc = rr(COMMON.vZ80cpu.C)
    End Function '19    'op_rrc
    Private Function op_rrd() As Integer                                        '&H1A           'RR D         
        op_rrd = rr(COMMON.vZ80cpu.D)
    End Function '1A    'op_rrd
    Private Function op_rre() As Integer                                        '&H1B           'RR E         
        op_rre = rr(COMMON.vZ80cpu.E)
    End Function '1B    'op_rre
    Private Function op_rrh() As Integer                                        '&H1C           'RR H         
        op_rrh = rr(COMMON.vZ80cpu.H)
    End Function '1C    'op_rrh
    Private Function op_rrl() As Integer                                        '&H1D           'RR L         
        op_rrl = rr(COMMON.vZ80cpu.L)
    End Function '1D    'op_rrl
    Private Function op_rrhl() As Integer                                       '&H1E           'RR (HL)
        Dim p As Long
        Dim i As Integer
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        p = COMMON.vZ80cpu.H * 256 + COMMON.vZ80cpu.L
        i = COMMON.vZ80cpu.Speicher_lesen_Byte(p)
        Call rr(i)
        COMMON.vZ80cpu.Speicher_schreiben_Byte(p, i)
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_NONE)
        op_rrhl = 15
    End Function '1E    'op_rrhl
    Private Function op_rra() As Integer                                        '&H1F           'RR A         
        op_rra = rr(COMMON.vZ80cpu.A)
    End Function '1F    'op_rra
    Private Function rr(ByRef par1 As Byte) As Integer
        Dim i As Integer
        If (par1 And &H1) = &H1 Then i = 1 Else i = 0
        Call COMMON.vZ80cpu.FlagCflag1(i <> 0)
        par1 = par1 >> 1
        If i = 1 Then par1 = par1 Or &H80
        COMMON.vZ80cpu.F = COMMON.vZ80cpu.F And Not (H_FLAG Or N_FLAG)

        Call COMMON.vZ80cpu.FlagZflag2(par1 <> 0)
        Call COMMON.vZ80cpu.FlagSflag1((par1 And &H80))
        Call COMMON.vZ80cpu.FlagPflag2(COMMON.vZ80cpu.parrity(par1) = 1)

        rr = 8
    End Function ' rr
#End Region
#Region "SLA x"
    '------------------------------------
    Private Function op_slab() As Integer                                       '&H20           'SLA B
        op_slab = sla(COMMON.vZ80cpu.B)
    End Function '20    'op_slab
    Private Function op_slac() As Integer                                       '&H21           'SLA C
        op_slac = sla(COMMON.vZ80cpu.C)
    End Function '21    'op_slac
    Private Function op_slad() As Integer                                       '&H22           'SLA D
        op_slad = sla(COMMON.vZ80cpu.D)
    End Function '22    'op_slad
    Private Function op_slae() As Integer                                       '&H23           'SLA E
        op_slae = sla(COMMON.vZ80cpu.E)
    End Function '23    'op_slae
    Private Function op_slah() As Integer                                       '&H24           'SLA H
        op_slah = sla(COMMON.vZ80cpu.H)
    End Function '24    'op_slah
    Private Function op_slal() As Integer                                       '&H25           'SLA L
        op_slal = sla(COMMON.vZ80cpu.L)
    End Function '25    'op_slal
    Private Function op_slahl() As Integer                                      '&H26           'SLA (HL)
        Dim p As Long
        Dim i As Integer
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        p = COMMON.vZ80cpu.H * 256 + COMMON.vZ80cpu.L
        i = COMMON.vZ80cpu.Speicher_lesen_Byte(p)
        Call sla(i)
        COMMON.vZ80cpu.Speicher_schreiben_Byte(p, i)
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_NONE)
        op_slahl = 15
    End Function '26    'op_slahl
    Private Function op_slaa() As Integer                                       '&H27           'SLA A
        op_slaa = sla(COMMON.vZ80cpu.A)
    End Function '27    'op_slaa
    Private Function sla(ByRef par1 As Byte) As Integer
        Call COMMON.vZ80cpu.FlagCflag1((par1 And &H80))
        par1 = par1 << 1
        COMMON.vZ80cpu.F = COMMON.vZ80cpu.F And Not (H_FLAG Or N_FLAG)

        Call COMMON.vZ80cpu.FlagZflag2(par1 <> 0)
        Call COMMON.vZ80cpu.FlagSflag1((par1 And &H80))
        Call COMMON.vZ80cpu.FlagPflag2(COMMON.vZ80cpu.parrity(par1) = 1)

        sla = 8
    End Function ' sla
#End Region
#Region "SRA x"
    '------------------------------------
    Private Function op_srab() As Integer                                       '&H28           'SRA B
        op_srab = sra(COMMON.vZ80cpu.B)
    End Function '28    'op_srab
    Private Function op_srac() As Integer                                       '&H29           'SRA C
        op_srac = sra(COMMON.vZ80cpu.C)
    End Function '29    'op_srac
    Private Function op_srad() As Integer                                       '&H2A           'SRA D
        op_srad = sra(COMMON.vZ80cpu.D)
    End Function '2A    'op_srad
    Private Function op_srae() As Integer                                       '&H2B           'SRA E
        op_srae = sra(COMMON.vZ80cpu.E)
    End Function '2B    'op_srae
    Private Function op_srah() As Integer                                       '&H2C           'SRA H
        op_srah = sra(COMMON.vZ80cpu.H)
    End Function '2C    'op_srah
    Private Function op_sral() As Integer                                       '&H2D           'SRA L
        op_sral = sra(COMMON.vZ80cpu.L)
    End Function '2D    'op_sral
    Private Function op_srahl() As Integer                                      '&H2E           'SRA (HL)
        Dim p As Long
        Dim i As Integer
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        p = COMMON.vZ80cpu.H * 256 + COMMON.vZ80cpu.L
        i = COMMON.vZ80cpu.Speicher_lesen_Byte(p)
        Call sra(i)
        COMMON.vZ80cpu.Speicher_schreiben_Byte(p, i)
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_NONE)
        op_srahl = 15
    End Function '2E    'op_srahl
    Private Function op_sraa() As Integer                                       '&H2F           'SRA A
        op_sraa = sra(COMMON.vZ80cpu.A)
    End Function '2F    'op_sraa
    Private Function sra(ByRef par1 As Byte) As Integer
        Dim i As Integer
        i = par1 And &H80
        Call COMMON.vZ80cpu.FlagCflag1((par1 And &H1))
        par1 = par1 >> 1
        par1 = par1 Or i
        COMMON.vZ80cpu.F = COMMON.vZ80cpu.F And Not (H_FLAG Or N_FLAG)

        Call COMMON.vZ80cpu.FlagZflag2(par1 <> 0)
        Call COMMON.vZ80cpu.FlagSflag1((par1 And &H80))
        Call COMMON.vZ80cpu.FlagPflag2(COMMON.vZ80cpu.parrity(par1) = 1)

        sra = 8
    End Function ' sra
#End Region
#Region "SRL x"
    '------------------------------------
    Private Function op_srlb() As Integer                                       '&H38           'SRL B
        op_srlb = srl(COMMON.vZ80cpu.B)
    End Function '38    'op_srlb
    Private Function op_srlc() As Integer                                       '&H39           'SRL C
        op_srlc = srl(COMMON.vZ80cpu.C)
    End Function '39    'op_srlc
    Private Function op_srld() As Integer                                       '&H3A           'SRL D
        op_srld = srl(COMMON.vZ80cpu.D)
    End Function '3A    'op_srld
    Private Function op_srle() As Integer                                       '&H3B           'SRL E
        op_srle = srl(COMMON.vZ80cpu.E)
    End Function '3B    'op_srle
    Private Function op_srlh() As Integer                                       '&H3C           'SRL H
        op_srlh = srl(COMMON.vZ80cpu.H)
    End Function '3C    'op_srlh
    Private Function op_srll() As Integer                                       '&H3D           'SRL L
        op_srll = srl(COMMON.vZ80cpu.L)
    End Function '3D    'op_srll
    Private Function op_srlhl() As Integer                                      '&H3E           'SRL (HL)
        Dim p As Long
        Dim i As Integer
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        p = COMMON.vZ80cpu.H * 256 + COMMON.vZ80cpu.L
        i = COMMON.vZ80cpu.Speicher_lesen_Byte(p)
        Call srl(i)
        COMMON.vZ80cpu.Speicher_schreiben_Byte(p, i)
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_NONE)
        op_srlhl = 15
    End Function '3E    'op_srlhl
    Private Function op_srla() As Integer                                       '&H3F           'SRL A
        op_srla = srl(COMMON.vZ80cpu.A)
    End Function '3F    'op_srla
    Private Function srl(ByRef par1 As Byte) As Integer
        Call COMMON.vZ80cpu.FlagCflag1((par1 And 1))
        par1 = par1 >> 1
        COMMON.vZ80cpu.F = COMMON.vZ80cpu.F And Not (COMMON.H_FLAG Or COMMON.N_FLAG)

        Call COMMON.vZ80cpu.FlagZflag2(par1 <> 0)
        Call COMMON.vZ80cpu.FlagSflag1((par1 And &H80))
        Call COMMON.vZ80cpu.FlagPflag2(COMMON.vZ80cpu.parrity(par1) = 1)

        srl = 8
    End Function ' srl
#End Region

#Region "BIT i,x"
    '====================================
    Private Function op_tb0b() As Integer                                       '&H40           'BIT 0,B
        op_tb0b = tb(COMMON.vZ80cpu.B, 0)
    End Function '40    'tb0b
    Private Function op_tb0c() As Integer                                       '&H41           'BIT 0,C
        op_tb0c = tb(COMMON.vZ80cpu.C, 0)
    End Function '41    'tb0c
    Private Function op_tb0d() As Integer                                       '&H42           'BIT 0,D
        op_tb0d = tb(COMMON.vZ80cpu.D, 0)
    End Function '42    'tb0d
    Private Function op_tb0e() As Integer                                       '&H43           'BIT 0,E
        op_tb0e = tb(COMMON.vZ80cpu.E, 0)
    End Function '43    'tb0e
    Private Function op_tb0h() As Integer                                       '&H44           'BIT 0,H
        op_tb0h = tb(COMMON.vZ80cpu.H, 0)
    End Function '44    'tb0h
    Private Function op_tb0l() As Integer                                       '&H45           'BIT 0,L
        op_tb0l = tb(COMMON.vZ80cpu.L, 0)
    End Function '45    'tb0l
    Private Function op_tb0hl() As Integer                                      '&H46           'BIT 0,(HL)
        Dim p As Long
        Dim i As Integer
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        p = COMMON.vZ80cpu.H * 256 + COMMON.vZ80cpu.L
        i = COMMON.vZ80cpu.Speicher_lesen_Byte(p)
        Call tb(i, 0)
        op_tb0hl = 12
    End Function '46    'tb0hl
    Private Function op_tb0a() As Integer                                       '&H47           'BIT 0,A
        op_tb0a = tb(COMMON.vZ80cpu.A, 0)
    End Function '47    'tb0a
    '------------------------------------
    Private Function op_tb1b() As Integer                                       '&H48           'BIT 1,B
        op_tb1b = tb(COMMON.vZ80cpu.B, 1)
    End Function '48    'tb1b
    Private Function op_tb1c() As Integer                                       '&H49           'BIT 1,C
        op_tb1c = tb(COMMON.vZ80cpu.C, 1)
    End Function '49    'tb1c
    Private Function op_tb1d() As Integer                                       '&H4A           'BIT 1,D
        op_tb1d = tb(COMMON.vZ80cpu.D, 1)
    End Function '4A    'tb1d
    Private Function op_tb1e() As Integer                                       '&H4B           'BIT 1,E
        op_tb1e = tb(COMMON.vZ80cpu.E, 1)
    End Function '4B    'tb1e
    Private Function op_tb1h() As Integer                                       '&H4C           'BIT 1,H
        op_tb1h = tb(COMMON.vZ80cpu.H, 1)
    End Function '4C    'tb1h
    Private Function op_tb1l() As Integer                                       '&H4D           'BIT 1,L
        op_tb1l = tb(COMMON.vZ80cpu.L, 1)
    End Function '4D    'tb1l
    Private Function op_tb1hl() As Integer                                      '&H4E           'BIT 1,(HL)
        Dim p As Long
        Dim i As Integer
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        p = COMMON.vZ80cpu.H * 256 + COMMON.vZ80cpu.L
        i = COMMON.vZ80cpu.Speicher_lesen_Byte(p)
        Call tb(i, 1)
        op_tb1hl = 12
    End Function '4E    'tb1hl
    Private Function op_tb1a() As Integer                                       '&H4F           'BIT 1,A
        op_tb1a = tb(COMMON.vZ80cpu.A, 1)
    End Function '4F    'tb1a
    '------------------------------------
    Private Function op_tb2b() As Integer                                       '&H50           'BIT 2,B
        op_tb2b = tb(COMMON.vZ80cpu.B, 2)
    End Function '50    'tb2b
    Private Function op_tb2c() As Integer                                       '&H51           'BIT 2,C
        op_tb2c = tb(COMMON.vZ80cpu.C, 2)
    End Function '51    'tb2c
    Private Function op_tb2d() As Integer                                       '&H52           'BIT 2,D
        op_tb2d = tb(COMMON.vZ80cpu.D, 2)
    End Function '52    'tb2d
    Private Function op_tb2e() As Integer                                       '&H53           'BIT 2,E
        op_tb2e = tb(COMMON.vZ80cpu.E, 2)
    End Function '53    'tb2e
    Private Function op_tb2h() As Integer                                       '&H54           'BIT 2,H
        op_tb2h = tb(COMMON.vZ80cpu.H, 2)
    End Function '54    'tb2h
    Private Function op_tb2l() As Integer                                       '&H55           'BIT 2,L
        op_tb2l = tb(COMMON.vZ80cpu.L, 2)
    End Function '55    'tb2l
    Private Function op_tb2hl() As Integer                                      '&H56           'BIT 2,(HL)
        Dim p As Long
        Dim i As Integer
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        p = COMMON.vZ80cpu.H * 256 + COMMON.vZ80cpu.L
        i = COMMON.vZ80cpu.Speicher_lesen_Byte(p)
        Call tb(i, 2)
        op_tb2hl = 12
    End Function '56    'tb2hl
    Private Function op_tb2a() As Integer                                       '&H57           'BIT 2,A
        op_tb2a = tb(COMMON.vZ80cpu.A, 2)
    End Function '57    'tb2a
    '------------------------------------
    Private Function op_tb3b() As Integer                                       '&H58           'BIT 3,B
        op_tb3b = tb(COMMON.vZ80cpu.B, 3)
    End Function '58    'tb3b
    Private Function op_tb3c() As Integer                                       '&H59           'BIT 3,C
        op_tb3c = tb(COMMON.vZ80cpu.C, 3)
    End Function '59    'tb3c
    Private Function op_tb3d() As Integer                                       '&H5A           'BIT 3,D
        op_tb3d = tb(COMMON.vZ80cpu.D, 3)
    End Function '5A    'tb3d
    Private Function op_tb3e() As Integer                                       '&H5B           'BIT 3,E
        op_tb3e = tb(COMMON.vZ80cpu.E, 3)
    End Function '5B    'tb3e
    Private Function op_tb3h() As Integer                                       '&H5C           'BIT 3,H
        op_tb3h = tb(COMMON.vZ80cpu.H, 3)
    End Function '5C    'tb3h
    Private Function op_tb3l() As Integer                                       '&H5D           'BIT 3,L
        op_tb3l = tb(COMMON.vZ80cpu.L, 3)
    End Function '5D    'tb3l
    Private Function op_tb3hl() As Integer                                      '&H5E           'BIT 3,(HL)
        Dim p As Long
        Dim i As Integer
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        p = COMMON.vZ80cpu.H * 256 + COMMON.vZ80cpu.L
        i = COMMON.vZ80cpu.Speicher_lesen_Byte(p)
        Call tb(i, 3)

        op_tb3hl = 12
    End Function '5E    'tb3hl
    Private Function op_tb3a() As Integer                                       '&H5F           'BIT 3,A
        op_tb3a = tb(COMMON.vZ80cpu.A, 3)
    End Function '5F    'tb3a
    '------------------------------------
    Private Function op_tb4b() As Integer                                       '&H60           'BIT 4,B
        op_tb4b = tb(COMMON.vZ80cpu.B, 4)
    End Function '60    'tb4b
    Private Function op_tb4c() As Integer                                       '&H61           'BIT 4,C
        op_tb4c = tb(COMMON.vZ80cpu.C, 4)
    End Function '61    'tb4c
    Private Function op_tb4d() As Integer                                       '&H62           'BIT 4,D
        op_tb4d = tb(COMMON.vZ80cpu.D, 4)
    End Function '62    'tb4d
    Private Function op_tb4e() As Integer                                       '&H63           'BIT 4,E
        op_tb4e = tb(COMMON.vZ80cpu.E, 4)
    End Function '63    'tb4e
    Private Function op_tb4h() As Integer                                       '&H64           'BIT 4,H
        op_tb4h = tb(COMMON.vZ80cpu.H, 4)
    End Function '64    'tb4h
    Private Function op_tb4l() As Integer                                       '&H65           'BIT 4,L
        op_tb4l = tb(COMMON.vZ80cpu.L, 4)
    End Function '65    'tb4l
    Private Function op_tb4hl() As Integer                                      '&H66           'BIT 4,(HL)
        Dim p As Long
        Dim i As Integer
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        p = COMMON.vZ80cpu.H * 256 + COMMON.vZ80cpu.L
        i = COMMON.vZ80cpu.Speicher_lesen_Byte(p)
        Call tb(i, 4)
        op_tb4hl = 12
    End Function '66    'tb4hl
    Private Function op_tb4a() As Integer                                       '&H67           'BIT 4,A
        op_tb4a = tb(COMMON.vZ80cpu.A, 4)
    End Function '67    'tb4a
    '------------------------------------
    Private Function op_tb5b() As Integer                                       '&H68           'BIT 5,B
        op_tb5b = tb(COMMON.vZ80cpu.B, 5)
    End Function '68    'tb5b
    Private Function op_tb5c() As Integer                                       '&H69           'BIT 5,C
        op_tb5c = tb(COMMON.vZ80cpu.C, 5)
    End Function '69    'tb5c
    Private Function op_tb5d() As Integer                                       '&H6A           'BIT 5,D
        op_tb5d = tb(COMMON.vZ80cpu.D, 5)
    End Function '6A    'tb5d
    Private Function op_tb5e() As Integer                                       '&H6B           'BIT 5,E
        op_tb5e = tb(COMMON.vZ80cpu.E, 5)
    End Function '6B    'tb5e
    Private Function op_tb5h() As Integer                                       '&H6C           'BIT 5,H
        op_tb5h = tb(COMMON.vZ80cpu.H, 5)
    End Function '6C    'tb5h
    Private Function op_tb5l() As Integer                                       '&H6D           'BIT 5,L
        op_tb5l = tb(COMMON.vZ80cpu.L, 5)
    End Function '6D    'tb5l
    Private Function op_tb5hl() As Integer                                      '&H6E           'BIT 5,(HL)
        Dim p As Long
        Dim i As Integer
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        p = COMMON.vZ80cpu.H * 256 + COMMON.vZ80cpu.L
        i = COMMON.vZ80cpu.Speicher_lesen_Byte(p)
        Call tb(i, 5)
        op_tb5hl = 12
    End Function '6E    'tb5hl
    Private Function op_tb5a() As Integer                                       '&H6F           'BIT 5,A
        op_tb5a = tb(COMMON.vZ80cpu.A, 5)
    End Function '6F    'tb5a
    '------------------------------------
    Private Function op_tb6b() As Integer                                       '&H70           'BIT 6,B
        op_tb6b = tb(COMMON.vZ80cpu.B, 6)
    End Function '70    'tb6b
    Private Function op_tb6c() As Integer                                       '&H71           'BIT 6,C
        op_tb6c = tb(COMMON.vZ80cpu.C, 6)
    End Function '71    'tb6c
    Private Function op_tb6d() As Integer                                       '&H72           'BIT 6,D
        op_tb6d = tb(COMMON.vZ80cpu.D, 6)
    End Function '72    'tb6d
    Private Function op_tb6e() As Integer                                       '&H73           'BIT 6,E
        op_tb6e = tb(COMMON.vZ80cpu.E, 6)
    End Function '73    'tb6e
    Private Function op_tb6h() As Integer                                       '&H74           'BIT 6,H
        op_tb6h = tb(COMMON.vZ80cpu.H, 6)
    End Function '74    'tb6h
    Private Function op_tb6l() As Integer                                       '&H75           'BIT 6,L
        op_tb6l = tb(COMMON.vZ80cpu.L, 6)
    End Function '75    'tb6l
    Private Function op_tb6hl() As Integer                                      '&H76           'BIT 6,(HL)
        Dim p As Long
        Dim i As Integer
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        p = COMMON.vZ80cpu.H * 256 + COMMON.vZ80cpu.L
        i = COMMON.vZ80cpu.Speicher_lesen_Byte(p)
        Call tb(i, 6)
        op_tb6hl = 12
    End Function '76    'tb6hl
    Private Function op_tb6a() As Integer                                       '&H77           'BIT 6,A
        op_tb6a = tb(COMMON.vZ80cpu.A, 6)
    End Function '77    'tb6a
    '------------------------------------
    Private Function op_tb7b() As Integer                                       '&H78           'BIT 7,B
        op_tb7b = tb(COMMON.vZ80cpu.B, 7)
    End Function '78    'tb7b
    Private Function op_tb7c() As Integer                                       '&H79           'BIT 7,C
        op_tb7c = tb(COMMON.vZ80cpu.C, 7)
    End Function '79    'tb7c
    Private Function op_tb7d() As Integer                                       '&H7A           'BIT 7,D
        op_tb7d = tb(COMMON.vZ80cpu.D, 7)
    End Function '7A    'tb7d
    Private Function op_tb7e() As Integer                                       '&H7B           'BIT 7,E
        op_tb7e = tb(COMMON.vZ80cpu.E, 7)
    End Function '7B    'tb7e
    Private Function op_tb7h() As Integer                                       '&H7C           'BIT 7,H
        op_tb7h = tb(COMMON.vZ80cpu.H, 7)
    End Function '7C    'tb7h
    Private Function op_tb7l() As Integer                                       '&H7D           'BIT 7,L
        op_tb7l = tb(COMMON.vZ80cpu.L, 7)
    End Function '7D    'tb7l
    Private Function op_tb7hl() As Integer                                      '&H7E           'BIT 7,(HL)
        Dim p As Long
        Dim i As Integer
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        p = COMMON.vZ80cpu.H * 256 + COMMON.vZ80cpu.L
        i = COMMON.vZ80cpu.Speicher_lesen_Byte(p)
        Call tb(i, 7)
        op_tb7hl = 12
    End Function '7E    'tb7hl
    Private Function op_tb7a() As Integer                                       '&H7F           'BIT 7,A
        op_tb7a = tb(COMMON.vZ80cpu.A, 7)
    End Function '7F    'tb7a
    '------------------------------------
    Private Function tb(ByRef par1 As Byte, ByVal Pos As Integer) As Integer
        Dim i As Integer
        Try
            i = 2 ^ Pos

            COMMON.vZ80cpu.F = COMMON.vZ80cpu.F And Not (COMMON.N_FLAG Or COMMON.S_FLAG)
            COMMON.vZ80cpu.F = COMMON.vZ80cpu.F Or COMMON.H_FLAG
            Select Case Pos
                Case 7
                    COMMON.vZ80cpu.F = COMMON.vZ80cpu.F And Not (COMMON.Z_FLAG Or COMMON.P_FLAG)
                    COMMON.vZ80cpu.F = COMMON.vZ80cpu.F Or COMMON.S_FLAG
                Case Else
            End Select
            Call COMMON.vZ80cpu.FlagZPflag((par1 And i))

        Catch ex As Exception

        End Try

        tb = 8
    End Function ' tb
#End Region
#Region "RES i,x"
    '====================================
    Private Function op_rb0b() As Integer                                       '&H80           'RES 0,B
        op_rb0b = rb(COMMON.vZ80cpu.B, 0)
    End Function '80    'op_rb0b
    Private Function op_rb0c() As Integer                                       '&H81           'RES 0,C
        op_rb0c = rb(COMMON.vZ80cpu.C, 0)
    End Function '81    'op_rb0c
    Private Function op_rb0d() As Integer                                       '&H82           'RES 0,D
        op_rb0d = rb(COMMON.vZ80cpu.D, 0)
    End Function '82    'op_rb0d
    Private Function op_rb0e() As Integer                                       '&H83           'RES 0,E
        op_rb0e = rb(COMMON.vZ80cpu.E, 0)
    End Function '83    'op_rb0e
    Private Function op_rb0h() As Integer                                       '&H84           'RES 0,H
        op_rb0h = rb(COMMON.vZ80cpu.H, 0)
    End Function '84    'op_rb0h
    Private Function op_rb0l() As Integer                                       '&H85           'RES 0,L
        op_rb0l = rb(COMMON.vZ80cpu.L, 0)
    End Function '85    'op_rb0l
    Private Function op_rb0hl() As Integer                                      '&H86           'RES 0,(HL)
        Dim p As Long
        Dim i As Integer
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        p = COMMON.vZ80cpu.H * 256 + COMMON.vZ80cpu.L
        i = COMMON.vZ80cpu.Speicher_lesen_Byte(p)
        Call rb(i, 0)
        COMMON.vZ80cpu.Speicher_schreiben_Byte(p, i)
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_NONE)
        op_rb0hl = 15
    End Function '86    'op_rb0hl
    Private Function op_rb0a() As Integer                                       '&H87           'RES 0,A
        op_rb0a = rb(COMMON.vZ80cpu.A, 0)
    End Function '87    'op_rb0a
    '------------------------------------
    Private Function op_rb1b() As Integer                                       '&H88           'RES 1,B
        op_rb1b = rb(COMMON.vZ80cpu.B, 1)
    End Function '88    'op_rb1b
    Private Function op_rb1c() As Integer                                       '&H89           'RES 1,C
        op_rb1c = rb(COMMON.vZ80cpu.C, 1)
    End Function '89    'op_rb1c
    Private Function op_rb1d() As Integer                                       '&H8A           'RES 1,D
        op_rb1d = rb(COMMON.vZ80cpu.D, 1)
    End Function '8A    'op_rb1d
    Private Function op_rb1e() As Integer                                       '&H8B           'RES 1,E
        op_rb1e = rb(COMMON.vZ80cpu.E, 1)
    End Function '8B    'op_rb1e
    Private Function op_rb1h() As Integer                                       '&H8C           'RES 1,H
        op_rb1h = rb(COMMON.vZ80cpu.H, 1)
    End Function '8C    'op_rb1h
    Private Function op_rb1l() As Integer                                       '&H8D           'RES 1,L
        op_rb1l = rb(COMMON.vZ80cpu.L, 1)
    End Function '8D    'op_rb1l
    Private Function op_rb1hl() As Integer                                      '&H8E           'RES 1,(HL)
        Dim p As Long
        Dim i As Integer
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        p = COMMON.vZ80cpu.H * 256 + COMMON.vZ80cpu.L
        i = COMMON.vZ80cpu.Speicher_lesen_Byte(p)
        Call rb(i, 1)
        COMMON.vZ80cpu.Speicher_schreiben_Byte(p, i)
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_NONE)
        op_rb1hl = 15
    End Function '8E    'op_rb1hl
    Private Function op_rb1a() As Integer                                       '&H8F           'RES 1,A
        op_rb1a = rb(COMMON.vZ80cpu.A, 1)
    End Function '8F    'op_rb1a
    '------------------------------------
    Private Function op_rb2b() As Integer                                       '&H90           'RES 2,B
        op_rb2b = rb(COMMON.vZ80cpu.B, 2)
    End Function '90    'op_rb2b
    Private Function op_rb2c() As Integer                                       '&H91           'RES 2,C
        op_rb2c = rb(COMMON.vZ80cpu.C, 2)
    End Function '91    'op_rb2c
    Private Function op_rb2d() As Integer                                       '&H92           'RES 2,D
        op_rb2d = rb(COMMON.vZ80cpu.D, 2)
    End Function '92    'op_rb2d
    Private Function op_rb2e() As Integer                                       '&H93           'RES 2,E
        op_rb2e = rb(COMMON.vZ80cpu.E, 2)
    End Function '93    'op_rb2e
    Private Function op_rb2h() As Integer                                       '&H94           'RES 2,H
        op_rb2h = rb(COMMON.vZ80cpu.H, 2)
    End Function '94    'op_rb2h
    Private Function op_rb2l() As Integer                                       '&H95           'RES 2,L
        op_rb2l = rb(COMMON.vZ80cpu.L, 2)
    End Function '95    'op_rb2l
    Private Function op_rb2hl() As Integer                                       '&H96           'RES 2,(HL)
        Dim p As Long
        Dim i As Integer
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        p = COMMON.vZ80cpu.H * 256 + COMMON.vZ80cpu.L
        i = COMMON.vZ80cpu.Speicher_lesen_Byte(p)
        Call rb(i, 2)
        COMMON.vZ80cpu.Speicher_schreiben_Byte(p, i)
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_NONE)
        op_rb2hl = 15
    End Function '96    'op_rb2hl
    Private Function op_rb2a() As Integer                                       '&H97           'RES 2,A
        op_rb2a = rb(COMMON.vZ80cpu.A, 2)
    End Function '97    'op_rb2a
    '------------------------------------
    Private Function op_rb3b() As Integer                                       '&H98           'RES 3,B
        op_rb3b = rb(COMMON.vZ80cpu.B, 3)
    End Function '98    'op_rb3b
    Private Function op_rb3c() As Integer                                       '&H99           'RES 3,C
        op_rb3c = rb(COMMON.vZ80cpu.C, 3)
    End Function '99    'op_rb3c
    Private Function op_rb3d() As Integer                                       '&H9A           'RES 3,D
        op_rb3d = rb(COMMON.vZ80cpu.D, 3)
    End Function '9A    'op_rb3d
    Private Function op_rb3e() As Integer                                       '&H9B           'RES 3,E
        op_rb3e = rb(COMMON.vZ80cpu.E, 3)
    End Function '9B    'op_rb3e
    Private Function op_rb3h() As Integer                                       '&H9C           'RES 3,H
        op_rb3h = rb(COMMON.vZ80cpu.H, 3)
    End Function '9C    'op_rb3h
    Private Function op_rb3l() As Integer                                       '&H9D           'RES 3,L
        op_rb3l = rb(COMMON.vZ80cpu.L, 3)
    End Function '9D    'op_rb3l
    Private Function op_rb3hl() As Integer                                      '&H9E           'RES 3,(HL)
        Dim p As Long
        Dim i As Integer
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        p = COMMON.vZ80cpu.H * 256 + COMMON.vZ80cpu.L
        i = COMMON.vZ80cpu.Speicher_lesen_Byte(p)
        Call rb(i, 3)
        COMMON.vZ80cpu.Speicher_schreiben_Byte(p, i)
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_NONE)
        op_rb3hl = 15
    End Function '9E    'op_rb3hl
    Private Function op_rb3a() As Integer                                       '&H9F           'RES 3,A
        op_rb3a = rb(COMMON.vZ80cpu.A, 3)
    End Function '9F    'op_rb3a
    '------------------------------------
    Private Function op_rb4b() As Integer                                       '&HA0           'RES 4,B
        op_rb4b = rb(COMMON.vZ80cpu.B, 4)
    End Function 'A0    'op_rb4b
    Private Function op_rb4c() As Integer                                       '&HA1           'RES 4,C
        op_rb4c = rb(COMMON.vZ80cpu.C, 4)
    End Function 'A1    'op_rb4c
    Private Function op_rb4d() As Integer                                       '&HA2           'RES 4,D
        op_rb4d = rb(COMMON.vZ80cpu.D, 4)
    End Function 'A2    'op_rb4d
    Private Function op_rb4e() As Integer                                       '&HA3           'RES 4,E
        op_rb4e = rb(COMMON.vZ80cpu.E, 4)
    End Function 'A3    'op_rb4e
    Private Function op_rb4h() As Integer                                       '&HA4           'RES 4,H
        op_rb4h = rb(COMMON.vZ80cpu.H, 4)
    End Function 'A4    'op_rb4h
    Private Function op_rb4l() As Integer                                       '&HA5           'RES 4,L
        op_rb4l = rb(COMMON.vZ80cpu.L, 4)
    End Function 'A5    'op_rb4l
    Private Function op_rb4hl() As Integer                                       '&HA6           'RES 4,(HL)
        Dim p As Long
        Dim i As Integer
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        p = COMMON.vZ80cpu.H * 256 + COMMON.vZ80cpu.L
        i = COMMON.vZ80cpu.Speicher_lesen_Byte(p)
        Call rb(i, 4)
        COMMON.vZ80cpu.Speicher_schreiben_Byte(p, i)
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_NONE)
        op_rb4hl = 15
    End Function 'A6    'op_rb4hl
    Private Function op_rb4a() As Integer                                       '&HA7           'RES 4,A
        op_rb4a = rb(COMMON.vZ80cpu.A, 4)
    End Function 'A7    'op_rb4a
    '------------------------------------
    Private Function op_rb5b() As Integer                                       '&HA8           'RES 5,B
        op_rb5b = rb(COMMON.vZ80cpu.B, 5)
    End Function 'A8    'op_rb5b
    Private Function op_rb5c() As Integer                                       '&HA9           'RES 5,C
        op_rb5c = rb(COMMON.vZ80cpu.C, 5)
    End Function 'A9    'op_rb5c
    Private Function op_rb5d() As Integer                                       '&HAA           'RES 5,D
        op_rb5d = rb(COMMON.vZ80cpu.D, 5)
    End Function 'AA    'op_rb5d
    Private Function op_rb5e() As Integer                                       '&HAB           'RES 5,E
        op_rb5e = rb(COMMON.vZ80cpu.E, 5)
    End Function 'AB    'op_rb5e
    Private Function op_rb5h() As Integer                                       '&HAC           'RES 5,H
        op_rb5h = rb(COMMON.vZ80cpu.H, 5)
    End Function 'AC    'op_rb5h
    Private Function op_rb5l() As Integer                                       '&HAD           'RES 5,L
        op_rb5l = rb(COMMON.vZ80cpu.L, 5)
    End Function 'AD    'op_rb5l
    Private Function op_rb5hl() As Integer                                      '&HAE           'RES 5,(HL)
        Dim p As Long
        Dim i As Integer
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        p = COMMON.vZ80cpu.H * 256 + COMMON.vZ80cpu.L
        i = COMMON.vZ80cpu.Speicher_lesen_Byte(p)
        Call rb(i, 5)
        COMMON.vZ80cpu.Speicher_schreiben_Byte(p, i)
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_NONE)
        op_rb5hl = 15
    End Function 'AE    'op_rb5hl
    Private Function op_rb5a() As Integer                                       '&HAF           'RES 5,A
        op_rb5a = rb(COMMON.vZ80cpu.A, 5)
    End Function 'AF    'op_rb5a
    '------------------------------------
    Private Function op_rb6b() As Integer                                       '&HB0           'RES 6,B
        op_rb6b = rb(COMMON.vZ80cpu.B, 6)
    End Function 'B0    'op_rb6b
    Private Function op_rb6c() As Integer                                       '&HB1           'RES 6,C
        op_rb6c = rb(COMMON.vZ80cpu.C, 6)
    End Function 'B1    'op_rb6c
    Private Function op_rb6d() As Integer                                       '&HB2           'RES 6,D
        op_rb6d = rb(COMMON.vZ80cpu.D, 6)
    End Function 'B2    'op_rb6d
    Private Function op_rb6e() As Integer                                       '&HB3           'RES 6,E
        op_rb6e = rb(COMMON.vZ80cpu.E, 6)
    End Function 'B3    'op_rb6e
    Private Function op_rb6h() As Integer                                       '&HB4           'RES 6,H
        op_rb6h = rb(COMMON.vZ80cpu.H, 6)
    End Function 'B4    'op_rb6h
    Private Function op_rb6l() As Integer                                       '&HB5           'RES 6,L
        op_rb6l = rb(COMMON.vZ80cpu.L, 6)
    End Function 'B5    'op_rb6l
    Private Function op_rb6hl() As Integer                                      '&HB6           'RES 6,(HL)
        Dim p As Long
        Dim i As Integer
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        p = COMMON.vZ80cpu.H * 256 + COMMON.vZ80cpu.L
        i = COMMON.vZ80cpu.Speicher_lesen_Byte(p)
        Call rb(i, 6)
        COMMON.vZ80cpu.Speicher_schreiben_Byte(p, i)
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_NONE)
        op_rb6hl = 15
    End Function 'B6    'op_rb6hl
    Private Function op_rb6a() As Integer                                       '&HB7          'RES 6,A
        op_rb6a = rb(COMMON.vZ80cpu.A, 6)
    End Function 'B7    'op_rb6a
    '------------------------------------
    Private Function op_rb7b() As Integer                                       '&HB8           'RES 7,B
        op_rb7b = rb(COMMON.vZ80cpu.B, 7)
    End Function 'B8    'op_rb7b
    Private Function op_rb7c() As Integer                                       '&HB9           'RES 7,C
        op_rb7c = rb(COMMON.vZ80cpu.C, 7)
    End Function 'B9    'op_rb7c
    Private Function op_rb7d() As Integer                                       '&HBA           'RES 7,D
        op_rb7d = rb(COMMON.vZ80cpu.D, 7)
    End Function 'BA    'op_rb7d
    Private Function op_rb7e() As Integer                                       '&HBB           'RES 7,E
        op_rb7e = rb(COMMON.vZ80cpu.E, 7)
    End Function 'BB    'op_rb7e
    Private Function op_rb7h() As Integer                                       '&HBC           'RES 7,H
        op_rb7h = rb(COMMON.vZ80cpu.H, 7)
    End Function 'BC    'op_rb7h
    Private Function op_rb7l() As Integer                                       '&HBD           'RES 7,L
        op_rb7l = rb(COMMON.vZ80cpu.A, 7)
    End Function 'BD    'op_rb7l
    Private Function op_rb7hl() As Integer                                       '&HBE           'RES 7,(HL)
        Dim p As Long
        Dim i As Integer
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        p = COMMON.vZ80cpu.H * 256 + COMMON.vZ80cpu.L
        i = COMMON.vZ80cpu.Speicher_lesen_Byte(p)
        Call rb(i, 7)
        COMMON.vZ80cpu.Speicher_schreiben_Byte(p, i)
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_NONE)
        op_rb7hl = 15
    End Function 'BE    'op_rb7hl
    Private Function op_rb7a() As Integer                                       '&HBF           'RES 7,A
        op_rb7a = rb(COMMON.vZ80cpu.A, 7)
    End Function 'BF    'op_rb7a
    '------------------------------------
    Private Function rb(ByRef par1 As Byte, ByVal Pos As Integer) As Integer
        Dim i As Integer
        i = 2 ^ Pos
        par1 = par1 And Not i
        rb = 8
    End Function ' rb
#End Region
#Region "SET i,x"
    '====================================
    Private Function op_sb0b() As Integer                                       '&HC0           'SET 0,B
        op_sb0b = sb(COMMON.vZ80cpu.B, 0)
    End Function 'C0    'op_sb0b
    Private Function op_sb0c() As Integer                                       '&HC1           'SET 0,C
        op_sb0c = sb(COMMON.vZ80cpu.C, 0)
    End Function 'C1    'op_sb0c
    Private Function op_sb0d() As Integer                                       '&HC2           'SET 0,D
        op_sb0d = sb(COMMON.vZ80cpu.D, 0)
    End Function 'C2    'op_sb0d
    Private Function op_sb0e() As Integer                                       '&HC3           'SET 0,E
        op_sb0e = sb(COMMON.vZ80cpu.E, 0)
    End Function 'C3    'op_sb0e
    Private Function op_sb0h() As Integer                                       '&HC4           'SET 0,H
        op_sb0h = sb(COMMON.vZ80cpu.H, 0)
    End Function 'C4    'op_sb0h
    Private Function op_sb0l() As Integer                                       '&HC5           'SET 0,L
        op_sb0l = sb(COMMON.vZ80cpu.L, 0)
    End Function 'C5    'op_sb0l
    Private Function op_sb0hl() As Integer                                      '&HC6           'SET 0,(HL)
        Dim p As Long
        Dim i As Integer
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        p = COMMON.vZ80cpu.H * 256 + COMMON.vZ80cpu.L
        i = COMMON.vZ80cpu.Speicher_lesen_Byte(p)
        Call sb(i, 0)
        COMMON.vZ80cpu.Speicher_schreiben_Byte(p, i)
        op_sb0hl = 15
    End Function 'C6    'op_sb0hl
    Private Function op_sb0a() As Integer                                       '&HC7           'SET 0,A
        op_sb0a = sb(COMMON.vZ80cpu.A, 0)
    End Function 'C7    'op_sb0a
    '------------------------------------
    Private Function op_sb1b() As Integer                                       '&HC8           'SET 1,B
        op_sb1b = sb(COMMON.vZ80cpu.B, 1)
    End Function 'C8    'op_sb1b
    Private Function op_sb1c() As Integer                                       '&HC9           'SET 1,C
        op_sb1c = sb(COMMON.vZ80cpu.C, 1)
    End Function 'C9    'op_sb1c
    Private Function op_sb1d() As Integer                                       '&HCA           'SET 1,D
        op_sb1d = sb(COMMON.vZ80cpu.D, 1)
    End Function 'CA    'op_sb1d
    Private Function op_sb1e() As Integer                                       '&HCB           'SET 1,E
        op_sb1e = sb(COMMON.vZ80cpu.E, 1)
    End Function 'CB    'op_sb1e
    Private Function op_sb1h() As Integer                                       '&HCC           'SET 1,H
        op_sb1h = sb(COMMON.vZ80cpu.H, 1)
    End Function 'CC    'op_sb1h
    Private Function op_sb1l() As Integer                                       '&HCD           'SET 1,L
        op_sb1l = sb(COMMON.vZ80cpu.L, 1)
    End Function 'CD    'op_sb1l
    Private Function op_sb1hl() As Integer                                      '&HCE           'SET 1,(HL)
        Dim p As Long
        Dim i As Integer
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        p = COMMON.vZ80cpu.H * 256 + COMMON.vZ80cpu.L
        i = COMMON.vZ80cpu.Speicher_lesen_Byte(p)
        Call sb(i, 1)
        COMMON.vZ80cpu.Speicher_schreiben_Byte(p, i)
        op_sb1hl = 15
    End Function 'CE    'op_sb1hl
    Private Function op_sb1a() As Integer                                       '&HCF           'SET 1,A
        op_sb1a = sb(COMMON.vZ80cpu.A, 1)
    End Function 'CF    'op_sb1a
    '------------------------------------
    Private Function op_sb2b() As Integer                                       '&HD0           'SET 2,B
        op_sb2b = sb(COMMON.vZ80cpu.B, 2)
    End Function 'D0    'op_sb2b
    Private Function op_sb2c() As Integer                                       '&HD1           'SET 2,C
        op_sb2c = sb(COMMON.vZ80cpu.C, 2)
    End Function 'D1    'op_sb2c
    Private Function op_sb2d() As Integer                                       '&HD2           'SET 2,D
        op_sb2d = sb(COMMON.vZ80cpu.D, 2)
    End Function 'D2    'op_sb2d
    Private Function op_sb2e() As Integer                                       '&HD3           'SET 2,E
        op_sb2e = sb(COMMON.vZ80cpu.E, 2)
    End Function 'D3    'op_sb2e
    Private Function op_sb2h() As Integer                                       '&HD4           'SET 2,H
        op_sb2h = sb(COMMON.vZ80cpu.H, 2)
    End Function 'D4    'op_sb2h
    Private Function op_sb2l() As Integer                                       '&HD5           'SET 2,L
        op_sb2l = sb(COMMON.vZ80cpu.L, 2)
    End Function 'D5    'op_sb2l
    Private Function op_sb2hl() As Integer                                      '&HD6           'SET 2,(HL)
        Dim p As Long
        Dim i As Integer
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        p = COMMON.vZ80cpu.H * 256 + COMMON.vZ80cpu.L
        i = COMMON.vZ80cpu.Speicher_lesen_Byte(p)
        Call sb(i, 2)
        COMMON.vZ80cpu.Speicher_schreiben_Byte(p, i)
        op_sb2hl = 15
    End Function 'D6    'op_sb2hl
    Private Function op_sb2a() As Integer                                       '&HD7           'SET 2,A
        op_sb2a = sb(COMMON.vZ80cpu.A, 2)
    End Function 'D7    'op_sb2a
    '------------------------------------
    Private Function op_sb3b() As Integer                                       '&HD8           'SET 3,B
        op_sb3b = sb(COMMON.vZ80cpu.B, 3)
    End Function 'D8    'op_sb3b
    Private Function op_sb3c() As Integer                                       '&HD9           'SET 3,C
        op_sb3c = sb(COMMON.vZ80cpu.C, 3)
    End Function 'D9    'op_sb3c
    Private Function op_sb3d() As Integer                                       '&HDA           'SET 3,D
        op_sb3d = sb(COMMON.vZ80cpu.D, 3)
    End Function 'DA    'op_sb3d
    Private Function op_sb3e() As Integer                                       '&HDB           'SET 3,E
        op_sb3e = sb(COMMON.vZ80cpu.E, 3)
    End Function 'DB    'op_sb3e
    Private Function op_sb3h() As Integer                                       '&HDC           'SET 3,H
        op_sb3h = sb(COMMON.vZ80cpu.H, 3)
    End Function 'DC    'op_sb3h
    Private Function op_sb3l() As Integer                                       '&HDD           'SET 3,L
        op_sb3l = sb(COMMON.vZ80cpu.L, 3)
    End Function 'DD    'op_sb3b
    Private Function op_sb3hl() As Integer                                      '&HDE           'SET 3,(HL)
        Dim p As Long
        Dim i As Integer
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        p = COMMON.vZ80cpu.H * 256 + COMMON.vZ80cpu.L
        i = COMMON.vZ80cpu.Speicher_lesen_Byte(p)
        Call sb(i, 3)
        COMMON.vZ80cpu.Speicher_schreiben_Byte(p, i)
        op_sb3hl = 15
    End Function 'DE    'op_sb3hl
    Private Function op_sb3a() As Integer                                       '&HDF           'SET 3,A
        op_sb3a = sb(COMMON.vZ80cpu.A, 3)
    End Function 'DF    'op_sb3a
    '------------------------------------
    Private Function op_sb4b() As Integer                                       '&HE0           'SET 4,B
        op_sb4b = sb(COMMON.vZ80cpu.B, 4)
    End Function 'E0    'op_sb4b
    Private Function op_sb4c() As Integer                                       '&HE1           'SET 4,C
        op_sb4c = sb(COMMON.vZ80cpu.C, 4)
    End Function 'E1    'op_sb4c
    Private Function op_sb4d() As Integer                                       '&HE2           'SET 4,D
        op_sb4d = sb(COMMON.vZ80cpu.D, 4)
    End Function 'E2    'op_sb4d
    Private Function op_sb4e() As Integer                                       '&HE3           'SET 4,E
        op_sb4e = sb(COMMON.vZ80cpu.E, 4)
    End Function 'E3    'op_sb4e
    Private Function op_sb4h() As Integer                                       '&HE4           'SET 4,H
        op_sb4h = sb(COMMON.vZ80cpu.H, 4)
    End Function 'E4    'op_sb4h
    Private Function op_sb4l() As Integer                                       '&HE5           'SET 4,L
        op_sb4l = sb(COMMON.vZ80cpu.L, 4)
    End Function 'E5    'op_sb4l
    Private Function op_sb4hl() As Integer                                      '&HE6           'SET 4,(HL)
        Dim p As Long
        Dim i As Integer
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        p = COMMON.vZ80cpu.H * 256 + COMMON.vZ80cpu.L
        i = COMMON.vZ80cpu.Speicher_lesen_Byte(p)
        Call sb(i, 4)
        COMMON.vZ80cpu.Speicher_schreiben_Byte(p, i)
        op_sb4hl = 15
    End Function 'E6    'op_sb4hl
    Private Function op_sb4a() As Integer                                       '&HE7           'SET 4,A
        op_sb4a = sb(COMMON.vZ80cpu.A, 4)
    End Function 'E7    'op_sb4a
    '------------------------------------
    Private Function op_sb5b() As Integer                                       '&HE8           'SET 5,B
        op_sb5b = sb(COMMON.vZ80cpu.B, 5)
    End Function 'E8    'op_sb5b
    Private Function op_sb5c() As Integer                                       '&HE9           'SET 5,C
        op_sb5c = sb(COMMON.vZ80cpu.C, 5)
    End Function 'E9    'op_sb5c
    Private Function op_sb5d() As Integer                                       '&HEA           'SET 5,D
        op_sb5d = sb(COMMON.vZ80cpu.D, 5)
    End Function 'EA    'op_sb5d
    Private Function op_sb5e() As Integer                                       '&HEB           'SET 5,E
        op_sb5e = sb(COMMON.vZ80cpu.E, 5)
    End Function 'EB    'op_sb5e
    Private Function op_sb5h() As Integer                                       '&HEC           'SET 5,H
        op_sb5h = sb(COMMON.vZ80cpu.H, 5)
    End Function 'EC    'op_sb5h
    Private Function op_sb5l() As Integer                                       '&HED           'SET 5,L
        op_sb5l = sb(COMMON.vZ80cpu.L, 5)
    End Function 'ED    'op_sb5l
    Private Function op_sb5hl() As Integer                                      '&HEE           'SET 5,(HL)
        Dim p As Long
        Dim i As Integer
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        p = COMMON.vZ80cpu.H * 256 + COMMON.vZ80cpu.L
        i = COMMON.vZ80cpu.Speicher_lesen_Byte(p)
        Call sb(i, 5)
        COMMON.vZ80cpu.Speicher_schreiben_Byte(p, i)
        op_sb5hl = 15
    End Function 'EE    'op_sb5hl
    Private Function op_sb5a() As Integer                                       '&HEF           'SET 5,A
        op_sb5a = sb(COMMON.vZ80cpu.A, 5)
    End Function 'EF    'op_sb5a
    '------------------------------------
    Private Function op_sb6b() As Integer                                       '&HF0           'SET 6,B
        op_sb6b = sb(COMMON.vZ80cpu.B, 6)
    End Function 'F0    'op_sb6b
    Private Function op_sb6c() As Integer                                       '&HF1           'SET 6,C
        op_sb6c = sb(COMMON.vZ80cpu.C, 6)
    End Function 'F1    'op_sb6c
    Private Function op_sb6d() As Integer                                       '&HF2           'SET 6,D
        op_sb6d = sb(COMMON.vZ80cpu.D, 6)
    End Function 'F2    'op_sb6d
    Private Function op_sb6e() As Integer                                       '&HF3           'SET 6,E
        op_sb6e = sb(COMMON.vZ80cpu.E, 6)
    End Function 'F3    'op_sb6e
    Private Function op_sb6h() As Integer                                       '&HF4           'SET 6,H
        op_sb6h = sb(COMMON.vZ80cpu.H, 6)
    End Function 'F4    'op_sb6h
    Private Function op_sb6l() As Integer                                       '&HF5           'SET 6,L
        op_sb6l = sb(COMMON.vZ80cpu.L, 6)
    End Function 'F5    'op_sb6l
    Private Function op_sb6hl() As Integer                                      '&HF6           'SET 6,(HL)
        Dim p As Long
        Dim i As Integer
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        p = COMMON.vZ80cpu.H * 256 + COMMON.vZ80cpu.L
        i = COMMON.vZ80cpu.Speicher_lesen_Byte(p)
        Call sb(i, 6)
        COMMON.vZ80cpu.Speicher_schreiben_Byte(p, i)
        op_sb6hl = 15
    End Function 'F6    'op_sb6hl
    Private Function op_sb6a() As Integer                                       '&HF7           'SET 6,A
        op_sb6a = sb(COMMON.vZ80cpu.A, 6)
    End Function 'F7    'op_sb6a
    '------------------------------------
    Private Function op_sb7b() As Integer                                       '&HF8           'SET 7,B
        op_sb7b = sb(COMMON.vZ80cpu.B, 7)
    End Function 'F8    'op_sb7b
    Private Function op_sb7c() As Integer                                       '&HF9           'SET 7,C
        op_sb7c = sb(COMMON.vZ80cpu.C, 7)
    End Function 'F9    'op_sb7c
    Private Function op_sb7d() As Integer                                       '&HFA           'SET 7,D
        op_sb7d = sb(COMMON.vZ80cpu.D, 7)
    End Function 'FA    'op_sb7d
    Private Function op_sb7e() As Integer                                       '&HFB           'SET 7,E
        op_sb7e = sb(COMMON.vZ80cpu.E, 7)
    End Function 'FB    'op_sb7e
    Private Function op_sb7h() As Integer                                       '&HFC           'SET 7,H
        op_sb7h = sb(COMMON.vZ80cpu.H, 7)
    End Function 'FC    'op_sb7h
    Private Function op_sb7l() As Integer                                       '&HFD           'SET 7,L
        op_sb7l = sb(COMMON.vZ80cpu.L, 7)
    End Function 'FD    'op_sb7l
    Private Function op_sb7hl() As Integer                                      '&HFE           'SET 7,(HL)
        Dim p As Long
        Dim i As Integer
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        p = COMMON.vZ80cpu.H * 256 + COMMON.vZ80cpu.L
        i = COMMON.vZ80cpu.Speicher_lesen_Byte(p)
        Call sb(i, 7)
        COMMON.vZ80cpu.Speicher_schreiben_Byte(p, i)
        op_sb7hl = 15
    End Function 'FE    'op_sb7hl
    Private Function op_sb7a() As Integer                                       '&HFF           'SET 7,A
        COMMON.vZ80cpu.A = COMMON.vZ80cpu.A Or &H80
        op_sb7a = sb(COMMON.vZ80cpu.A, 7)
    End Function 'FF    'op_sb7a
    '------------------------------------
    Private Function sb(ByRef par1 As Byte, ByVal Pos As Integer) As Integer
        Dim i As Integer
        i = 2 ^ Pos
        par1 = par1 Or i
        sb = 8
    End Function ' sb
#End Region

    '====================================
    Public Function op_cb_handel() As Integer
        Call COMMON.vZ80cpu.PCplus1()
        op_cb_handel = op_cb1.op_sim(COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.PC)).Invoke()
    End Function ' op_cb_handel

End Module ' CB
