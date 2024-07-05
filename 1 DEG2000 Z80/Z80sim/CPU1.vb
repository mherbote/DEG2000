Imports System.Windows.Data
Imports DEG2000.Z80cpu

Public Class CPU1

    Private op_sim(0 To 255) As opfunc

    Public Sub New()
        op_sim(&H0) = New opfunc(AddressOf op_nop) : op_sim(&H1) = New opfunc(AddressOf op_ldbcnn) : op_sim(&H2) = New opfunc(AddressOf op_ldbca) : op_sim(&H3) = New opfunc(AddressOf op_incbc)
        op_sim(&H4) = New opfunc(AddressOf op_incb) : op_sim(&H5) = New opfunc(AddressOf op_decb) : op_sim(&H6) = New opfunc(AddressOf op_ldbn) : op_sim(&H7) = New opfunc(AddressOf op_rlca)
        op_sim(&H8) = New opfunc(AddressOf op_exafaf) : op_sim(&H9) = New opfunc(AddressOf op_adhlbc) : op_sim(&HA) = New opfunc(AddressOf op_ldabc) : op_sim(&HB) = New opfunc(AddressOf op_decbc)
        op_sim(&HC) = New opfunc(AddressOf op_incc) : op_sim(&HD) = New opfunc(AddressOf op_decc) : op_sim(&HE) = New opfunc(AddressOf op_ldcn) : op_sim(&HF) = New opfunc(AddressOf op_rrca)

        op_sim(&H10) = New opfunc(AddressOf op_djnz) : op_sim(&H11) = New opfunc(AddressOf op_lddenn) : op_sim(&H12) = New opfunc(AddressOf op_lddea) : op_sim(&H13) = New opfunc(AddressOf op_incde)
        op_sim(&H14) = New opfunc(AddressOf op_incd) : op_sim(&H15) = New opfunc(AddressOf op_decd) : op_sim(&H16) = New opfunc(AddressOf op_lddn) : op_sim(&H17) = New opfunc(AddressOf op_rla)
        op_sim(&H18) = New opfunc(AddressOf op_jr) : op_sim(&H19) = New opfunc(AddressOf op_adhlde) : op_sim(&H1A) = New opfunc(AddressOf op_ldade) : op_sim(&H1B) = New opfunc(AddressOf op_decde)
        op_sim(&H1C) = New opfunc(AddressOf op_ince) : op_sim(&H1D) = New opfunc(AddressOf op_dece) : op_sim(&H1E) = New opfunc(AddressOf op_lden) : op_sim(&H1F) = New opfunc(AddressOf op_rra)

        op_sim(&H20) = New opfunc(AddressOf op_jrnz) : op_sim(&H21) = New opfunc(AddressOf op_ldhlnn) : op_sim(&H22) = New opfunc(AddressOf op_ldinhl) : op_sim(&H23) = New opfunc(AddressOf op_inchl)
        op_sim(&H24) = New opfunc(AddressOf op_inch) : op_sim(&H25) = New opfunc(AddressOf op_dech) : op_sim(&H26) = New opfunc(AddressOf op_ldhn) : op_sim(&H27) = New opfunc(AddressOf op_daa)
        op_sim(&H28) = New opfunc(AddressOf op_jrz) : op_sim(&H29) = New opfunc(AddressOf op_adhlhl) : op_sim(&H2A) = New opfunc(AddressOf op_ldhlin) : op_sim(&H2B) = New opfunc(AddressOf op_dechl)
        op_sim(&H2C) = New opfunc(AddressOf op_incl) : op_sim(&H2D) = New opfunc(AddressOf op_decl) : op_sim(&H2E) = New opfunc(AddressOf op_ldln) : op_sim(&H2F) = New opfunc(AddressOf op_cpl)

        op_sim(&H30) = New opfunc(AddressOf op_jrnc) : op_sim(&H31) = New opfunc(AddressOf op_ldspnn) : op_sim(&H32) = New opfunc(AddressOf op_ldnna) : op_sim(&H33) = New opfunc(AddressOf op_incsp)
        op_sim(&H34) = New opfunc(AddressOf op_incihl) : op_sim(&H35) = New opfunc(AddressOf op_decihl) : op_sim(&H36) = New opfunc(AddressOf op_ldhln) : op_sim(&H37) = New opfunc(AddressOf op_scf)
        op_sim(&H38) = New opfunc(AddressOf op_jrc) : op_sim(&H39) = New opfunc(AddressOf op_adhlsp) : op_sim(&H3A) = New opfunc(AddressOf op_ldann) : op_sim(&H3B) = New opfunc(AddressOf op_decsp)
        op_sim(&H3C) = New opfunc(AddressOf op_inca) : op_sim(&H3D) = New opfunc(AddressOf op_deca) : op_sim(&H3E) = New opfunc(AddressOf op_ldan) : op_sim(&H3F) = New opfunc(AddressOf op_ccf)

        op_sim(&H40) = New opfunc(AddressOf op_ldbb) : op_sim(&H41) = New opfunc(AddressOf op_ldbc) : op_sim(&H42) = New opfunc(AddressOf op_ldbd) : op_sim(&H43) = New opfunc(AddressOf op_ldbe)
        op_sim(&H44) = New opfunc(AddressOf op_ldbh) : op_sim(&H45) = New opfunc(AddressOf op_ldbl) : op_sim(&H46) = New opfunc(AddressOf op_ldbhl) : op_sim(&H47) = New opfunc(AddressOf op_ldba)
        op_sim(&H48) = New opfunc(AddressOf op_ldcb) : op_sim(&H49) = New opfunc(AddressOf op_ldcc) : op_sim(&H4A) = New opfunc(AddressOf op_ldcd) : op_sim(&H4B) = New opfunc(AddressOf op_ldce)
        op_sim(&H4C) = New opfunc(AddressOf op_ldch) : op_sim(&H4D) = New opfunc(AddressOf op_ldcl) : op_sim(&H4E) = New opfunc(AddressOf op_ldchl) : op_sim(&H4F) = New opfunc(AddressOf op_ldca)

        op_sim(&H50) = New opfunc(AddressOf op_lddb) : op_sim(&H51) = New opfunc(AddressOf op_lddc) : op_sim(&H52) = New opfunc(AddressOf op_lddd) : op_sim(&H53) = New opfunc(AddressOf op_ldde)
        op_sim(&H54) = New opfunc(AddressOf op_lddh) : op_sim(&H55) = New opfunc(AddressOf op_lddl) : op_sim(&H56) = New opfunc(AddressOf op_lddhl) : op_sim(&H57) = New opfunc(AddressOf op_ldda)
        op_sim(&H58) = New opfunc(AddressOf op_ldeb) : op_sim(&H59) = New opfunc(AddressOf op_ldec) : op_sim(&H5A) = New opfunc(AddressOf op_lded) : op_sim(&H5B) = New opfunc(AddressOf op_ldee)
        op_sim(&H5C) = New opfunc(AddressOf op_ldeh) : op_sim(&H5D) = New opfunc(AddressOf op_ldel) : op_sim(&H5E) = New opfunc(AddressOf op_ldehl) : op_sim(&H5F) = New opfunc(AddressOf op_ldea)

        op_sim(&H60) = New opfunc(AddressOf op_ldhb) : op_sim(&H61) = New opfunc(AddressOf op_ldhc) : op_sim(&H62) = New opfunc(AddressOf op_ldhd) : op_sim(&H63) = New opfunc(AddressOf op_ldhe)
        op_sim(&H64) = New opfunc(AddressOf op_ldhh) : op_sim(&H65) = New opfunc(AddressOf op_ldhl) : op_sim(&H66) = New opfunc(AddressOf op_ldhhl) : op_sim(&H67) = New opfunc(AddressOf op_ldha)
        op_sim(&H68) = New opfunc(AddressOf op_ldlb) : op_sim(&H69) = New opfunc(AddressOf op_ldlc) : op_sim(&H6A) = New opfunc(AddressOf op_ldld) : op_sim(&H6B) = New opfunc(AddressOf op_ldle)
        op_sim(&H6C) = New opfunc(AddressOf op_ldlh) : op_sim(&H6D) = New opfunc(AddressOf op_ldll) : op_sim(&H6E) = New opfunc(AddressOf op_ldlhl) : op_sim(&H6F) = New opfunc(AddressOf op_ldla)

        op_sim(&H70) = New opfunc(AddressOf op_ldhlb) : op_sim(&H71) = New opfunc(AddressOf op_ldhlc) : op_sim(&H72) = New opfunc(AddressOf op_ldhld) : op_sim(&H73) = New opfunc(AddressOf op_ldhle)
        op_sim(&H74) = New opfunc(AddressOf op_ldhlh) : op_sim(&H75) = New opfunc(AddressOf op_ldhll) : op_sim(&H76) = New opfunc(AddressOf op_halt) : op_sim(&H77) = New opfunc(AddressOf op_ldhla)
        op_sim(&H78) = New opfunc(AddressOf op_ldab) : op_sim(&H79) = New opfunc(AddressOf op_ldac) : op_sim(&H7A) = New opfunc(AddressOf op_ldad) : op_sim(&H7B) = New opfunc(AddressOf op_ldae)
        op_sim(&H7C) = New opfunc(AddressOf op_ldah) : op_sim(&H7D) = New opfunc(AddressOf op_ldal) : op_sim(&H7E) = New opfunc(AddressOf op_ldahl) : op_sim(&H7F) = New opfunc(AddressOf op_ldaa)

        op_sim(&H80) = New opfunc(AddressOf op_addb) : op_sim(&H81) = New opfunc(AddressOf op_addc) : op_sim(&H82) = New opfunc(AddressOf op_addd) : op_sim(&H83) = New opfunc(AddressOf op_adde)
        op_sim(&H84) = New opfunc(AddressOf op_addh) : op_sim(&H85) = New opfunc(AddressOf op_addl) : op_sim(&H86) = New opfunc(AddressOf op_addhl) : op_sim(&H87) = New opfunc(AddressOf op_adda)
        op_sim(&H88) = New opfunc(AddressOf op_adcb) : op_sim(&H89) = New opfunc(AddressOf op_adcc) : op_sim(&H8A) = New opfunc(AddressOf op_adcd) : op_sim(&H8B) = New opfunc(AddressOf op_adce)
        op_sim(&H8C) = New opfunc(AddressOf op_adch) : op_sim(&H8D) = New opfunc(AddressOf op_adcl) : op_sim(&H8E) = New opfunc(AddressOf op_adchl) : op_sim(&H8F) = New opfunc(AddressOf op_adca)

        op_sim(&H90) = New opfunc(AddressOf op_subb) : op_sim(&H91) = New opfunc(AddressOf op_subc) : op_sim(&H92) = New opfunc(AddressOf op_subd) : op_sim(&H93) = New opfunc(AddressOf op_sube)
        op_sim(&H94) = New opfunc(AddressOf op_subh) : op_sim(&H95) = New opfunc(AddressOf op_subl) : op_sim(&H96) = New opfunc(AddressOf op_subhl) : op_sim(&H97) = New opfunc(AddressOf op_suba)
        op_sim(&H98) = New opfunc(AddressOf op_sbcb) : op_sim(&H99) = New opfunc(AddressOf op_sbcc) : op_sim(&H9A) = New opfunc(AddressOf op_sbcd) : op_sim(&H9B) = New opfunc(AddressOf op_sbce)
        op_sim(&H9C) = New opfunc(AddressOf op_sbch) : op_sim(&H9D) = New opfunc(AddressOf op_sbcl) : op_sim(&H9E) = New opfunc(AddressOf op_sbchl) : op_sim(&H9F) = New opfunc(AddressOf op_sbca)

        op_sim(&HA0) = New opfunc(AddressOf op_andb) : op_sim(&HA1) = New opfunc(AddressOf op_andc) : op_sim(&HA2) = New opfunc(AddressOf op_andd) : op_sim(&HA3) = New opfunc(AddressOf op_ande)
        op_sim(&HA4) = New opfunc(AddressOf op_andh) : op_sim(&HA5) = New opfunc(AddressOf op_andl) : op_sim(&HA6) = New opfunc(AddressOf op_andhl) : op_sim(&HA7) = New opfunc(AddressOf op_anda)
        op_sim(&HA8) = New opfunc(AddressOf op_xorb) : op_sim(&HA9) = New opfunc(AddressOf op_xorc) : op_sim(&HAA) = New opfunc(AddressOf op_xord) : op_sim(&HAB) = New opfunc(AddressOf op_xore)
        op_sim(&HAC) = New opfunc(AddressOf op_xorh) : op_sim(&HAD) = New opfunc(AddressOf op_xorl) : op_sim(&HAE) = New opfunc(AddressOf op_xorhl) : op_sim(&HAF) = New opfunc(AddressOf op_xora)

        op_sim(&HB0) = New opfunc(AddressOf op_orb) : op_sim(&HB1) = New opfunc(AddressOf op_orc) : op_sim(&HB2) = New opfunc(AddressOf op_ord) : op_sim(&HB3) = New opfunc(AddressOf op_ore)
        op_sim(&HB4) = New opfunc(AddressOf op_orh) : op_sim(&HB5) = New opfunc(AddressOf op_orl) : op_sim(&HB6) = New opfunc(AddressOf op_orhl) : op_sim(&HB7) = New opfunc(AddressOf op_ora)
        op_sim(&HB8) = New opfunc(AddressOf op_cpb) : op_sim(&HB9) = New opfunc(AddressOf op_cpc) : op_sim(&HBA) = New opfunc(AddressOf op_cpd) : op_sim(&HBB) = New opfunc(AddressOf op_cpe)
        op_sim(&HBC) = New opfunc(AddressOf op_cph) : op_sim(&HBD) = New opfunc(AddressOf op_cplr) : op_sim(&HBE) = New opfunc(AddressOf op_cphl) : op_sim(&HBF) = New opfunc(AddressOf op_cpa)

        op_sim(&HC0) = New opfunc(AddressOf op_retnz) : op_sim(&HC1) = New opfunc(AddressOf op_popbc) : op_sim(&HC2) = New opfunc(AddressOf op_jpnz) : op_sim(&HC3) = New opfunc(AddressOf op_jp)
        op_sim(&HC4) = New opfunc(AddressOf op_calnz) : op_sim(&HC5) = New opfunc(AddressOf op_pushbc) : op_sim(&HC6) = New opfunc(AddressOf op_addn) : op_sim(&HC7) = New opfunc(AddressOf op_rst00)
        op_sim(&HC8) = New opfunc(AddressOf op_retz) : op_sim(&HC9) = New opfunc(AddressOf op_ret) : op_sim(&HCA) = New opfunc(AddressOf op_jpz) : op_sim(&HCB) = New opfunc(AddressOf CB.op_cb_handel)
        op_sim(&HCC) = New opfunc(AddressOf op_calz) : op_sim(&HCD) = New opfunc(AddressOf op_call) : op_sim(&HCE) = New opfunc(AddressOf op_adcn) : op_sim(&HCF) = New opfunc(AddressOf op_rst08)

        op_sim(&HD0) = New opfunc(AddressOf op_retnc) : op_sim(&HD1) = New opfunc(AddressOf op_popde) : op_sim(&HD2) = New opfunc(AddressOf op_jpnc) : op_sim(&HD3) = New opfunc(AddressOf op_out)
        op_sim(&HD4) = New opfunc(AddressOf op_calnc) : op_sim(&HD5) = New opfunc(AddressOf op_pushde) : op_sim(&HD6) = New opfunc(AddressOf op_subn) : op_sim(&HD7) = New opfunc(AddressOf op_rst10)
        op_sim(&HD8) = New opfunc(AddressOf op_retc) : op_sim(&HD9) = New opfunc(AddressOf op_exx) : op_sim(&HDA) = New opfunc(AddressOf op_jpc) : op_sim(&HDB) = New opfunc(AddressOf op_in)
        op_sim(&HDC) = New opfunc(AddressOf op_calc) : op_sim(&HDD) = New opfunc(AddressOf op_dd_handel) : op_sim(&HDE) = New opfunc(AddressOf op_sbcn) : op_sim(&HDF) = New opfunc(AddressOf op_rst18)

        op_sim(&HE0) = New opfunc(AddressOf op_retpo) : op_sim(&HE1) = New opfunc(AddressOf op_pophl) : op_sim(&HE2) = New opfunc(AddressOf op_jppo) : op_sim(&HE3) = New opfunc(AddressOf op_exsphl)
        op_sim(&HE4) = New opfunc(AddressOf op_calpo) : op_sim(&HE5) = New opfunc(AddressOf op_pushhl) : op_sim(&HE6) = New opfunc(AddressOf op_andn) : op_sim(&HE7) = New opfunc(AddressOf op_rst20)
        op_sim(&HE8) = New opfunc(AddressOf op_retpe) : op_sim(&HE9) = New opfunc(AddressOf op_jphl) : op_sim(&HEA) = New opfunc(AddressOf op_jppe) : op_sim(&HEB) = New opfunc(AddressOf op_exdehl)
        op_sim(&HEC) = New opfunc(AddressOf op_calpe) : op_sim(&HED) = New opfunc(AddressOf op_ed_handel) : op_sim(&HEE) = New opfunc(AddressOf op_xorn) : op_sim(&HEF) = New opfunc(AddressOf op_rst28)

        op_sim(&HF0) = New opfunc(AddressOf op_retp) : op_sim(&HF1) = New opfunc(AddressOf op_popaf) : op_sim(&HF2) = New opfunc(AddressOf op_jpp) : op_sim(&HF3) = New opfunc(AddressOf op_di)
        op_sim(&HF4) = New opfunc(AddressOf op_calp) : op_sim(&HF5) = New opfunc(AddressOf op_pushaf) : op_sim(&HF6) = New opfunc(AddressOf op_orn) : op_sim(&HF7) = New opfunc(AddressOf op_rst30)
        op_sim(&HF8) = New opfunc(AddressOf op_retm) : op_sim(&HF9) = New opfunc(AddressOf op_ldsphl) : op_sim(&HFA) = New opfunc(AddressOf op_jpm) : op_sim(&HFB) = New opfunc(AddressOf op_ei)
        op_sim(&HFC) = New opfunc(AddressOf op_calm) : op_sim(&HFD) = New opfunc(AddressOf op_fd_handel) : op_sim(&HFE) = New opfunc(AddressOf op_cpn) : op_sim(&HFF) = New opfunc(AddressOf op_rst38)
    End Sub ' New

#Region "notimpl"
    'Trap not implemented opcodes. This function may be usefull later to trap some wanted opcodes.
    Private Function op_notimpl() As Integer
        Call Haupt.cpuError(COMMON.OPTRAP1)
        Call Haupt.cpuState(COMMON.STOPPED)
        op_notimpl = 0
    End Function ' op_notimpl
#End Region
#Region "NOP"
    Private Function op_nop() As Integer                                        ' NOP                       '00
        op_nop = 4
    End Function '00    'op_nop 
#End Region
#Region "HALT"
    Private Function op_halt() As Integer                                       ' HALT                      '76
        '#	extern int busy_loop_cnt[];
        '#	struct timespec timer;
        Try
#If BUS_8080 = 1 Then
            COMMON.vZ80cpu.cpu_bus = COMMON.CPU_WO Or COMMON.CPU_HLTA Or COMMON.CPU_MEMR
#End If
#If FRONTPANEL0 = 1 Then
            'If COMMON.vZ80cpu.IFF = 0 Then
            Call Haupt.cpuError(COMMON.OPHALT)
            Call Haupt.cpuState(COMMON.STOPPED)
            'End If
#End If

            While (COMMON.vZ80cpu.int_type = COMMON.INT_NONE And COMMON.vZ80cpu.cpu_state = COMMON.CONTIN_RUN)            '# COMMON.vZ80cpu.int_type
#If FRONTPANEL0 = 1 Then
                '#            fp_clock = fp_clock + 4
                '#            Call fp_sampleData()
#End If
                '#            Timer.tv_sec = 0
                '#            Timer.tv_nsec =1000000L;
                '#            nanosleep(&timer, NULL);
                COMMON.vZ80cpu.R = COMMON.vZ80cpu.R + 9999
            End While

        Catch ex As Exception
            MsgBox("CPU1.op_halt: " + ex.Message)
        End Try

        op_halt = 0
    End Function '76   'op_halt
#End Region

#Region "SCF_CCF_CPL_DAA"
    Private Function op_scf() As Integer                                       ' SCF                        '37
        COMMON.vZ80cpu.F = COMMON.vZ80cpu.F Or COMMON.C_FLAG
        COMMON.vZ80cpu.F = COMMON.vZ80cpu.F And Not (COMMON.N_FLAG Or COMMON.H_FLAG)
        op_scf = 4
    End Function '37    'op_scf
    Private Function op_ccf() As Integer                                       ' CCF                        '3F
        If (COMMON.vZ80cpu.F And COMMON.C_FLAG) = COMMON.C_FLAG Then
            COMMON.vZ80cpu.F = COMMON.vZ80cpu.F Or COMMON.H_FLAG : COMMON.vZ80cpu.F = COMMON.vZ80cpu.F And Not COMMON.C_FLAG
        Else
            COMMON.vZ80cpu.F = COMMON.vZ80cpu.F And Not COMMON.H_FLAG : COMMON.vZ80cpu.F = COMMON.vZ80cpu.F Or COMMON.C_FLAG
        End If
        COMMON.vZ80cpu.F = COMMON.vZ80cpu.F And Not COMMON.N_FLAG
        op_ccf = 4
    End Function '3F    'op_ccf
    Private Function op_cpl() As Integer                                       ' CPL                        '2F
        COMMON.vZ80cpu.A = Not COMMON.vZ80cpu.A
        COMMON.vZ80cpu.F = COMMON.vZ80cpu.F Or COMMON.H_FLAG Or COMMON.N_FLAG
        op_cpl = 4
    End Function '2F    'op_cpl
    Private Function op_daa() As Integer                                       ' DAA                        '27
        Dim old_a As Byte
        Dim v As Integer

        old_a = COMMON.vZ80cpu.A
        If (COMMON.vZ80cpu.F And COMMON.N_FLAG) = COMMON.N_FLAG Then
            '                                                                   ' subtractions
            If (((COMMON.vZ80cpu.A And &HF) > 9) Or ((COMMON.vZ80cpu.F And COMMON.H_FLAG) = COMMON.H_FLAG)) Then
                If (((old_a And &HF) - 6) < 0) Then
                    COMMON.vZ80cpu.F = COMMON.vZ80cpu.F Or COMMON.H_FLAG
                Else
                    COMMON.vZ80cpu.F = COMMON.vZ80cpu.F And Not COMMON.H_FLAG
                End If
                old_a = old_a - 6
                COMMON.vZ80cpu.A = old_a
            End If
            If (((COMMON.vZ80cpu.A And &HF0) > &H90) Or ((COMMON.vZ80cpu.F And COMMON.C_FLAG) = COMMON.C_FLAG)) Then
                v = old_a - &H60
                COMMON.vZ80cpu.A = v And &HFF
                If old_a - &H60 < 0 Then
                    COMMON.vZ80cpu.F = COMMON.vZ80cpu.F Or COMMON.C_FLAG
                End If
            End If
        Else
            '                                                                   ' additions
            If (((COMMON.vZ80cpu.A And &HF) > 9) Or ((COMMON.vZ80cpu.F And COMMON.H_FLAG) = COMMON.H_FLAG)) Then
                If (((old_a And &HF) + 6) > &HF) Then
                    COMMON.vZ80cpu.F = COMMON.vZ80cpu.F Or COMMON.H_FLAG
                Else
                    COMMON.vZ80cpu.F = COMMON.vZ80cpu.F And Not COMMON.H_FLAG
                End If
                old_a = old_a + 6
                COMMON.vZ80cpu.A = old_a
            End If
            If (((COMMON.vZ80cpu.A And &HF0) > &H90) Or ((COMMON.vZ80cpu.F And COMMON.C_FLAG) = COMMON.C_FLAG)) Then
                v = old_a + &H60
                COMMON.vZ80cpu.A = v And &HFF
                If v > 255 Then
                    COMMON.vZ80cpu.F = COMMON.vZ80cpu.F Or COMMON.C_FLAG
                End If
            End If
        End If
        Call COMMON.vZ80cpu.FlagZflag2(COMMON.vZ80cpu.A <> 0)
        Call COMMON.vZ80cpu.FlagSflag1((COMMON.vZ80cpu.A And 128))
        Call COMMON.vZ80cpu.FlagPflag2(COMMON.vZ80cpu.parrity(COMMON.vZ80cpu.A) = 1)
        op_daa = 4
    End Function '27    'op_daa
#End Region

#Region "EI_DI"
    Private Function op_ei() As Integer                                       ' EI                          'FB
        COMMON.vZ80cpu.IFF = 3
        op_ei = 4
    End Function 'FB    'op_ei
    Private Function op_di() As Integer                                       ' DI                          'F3
        COMMON.vZ80cpu.IFF = 0
        op_di = 4
    End Function 'F3    'op_di
#End Region
#Region "IN_OUT"
    Private Function op_in() As Integer                                       ' IN A,(n)                    'DB
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_INP)
        Call COMMON.vZ80cpu.PCplus1()
        'Byte io_in()
        COMMON.vZ80cpu.A = Haupt.IOsim.io_in(COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.PC))
        op_in = 11
    End Function 'DB    'op_in
    Private Function op_out() As Integer                                       ' OUT (n),A                  'D3
        'Byte io_out()
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_OUT)
        Call COMMON.vZ80cpu.PCplus1()
        Haupt.IOsim.io_out(COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.PC), COMMON.vZ80cpu.A)
        op_out = 11
    End Function 'D3    'op_out
#End Region

#Region "LD"
#Region "LD_._n"
    '------------------------------------     '06 0E 16 1E 26 2E 36 3E
    Private Function op_ldbn() As Integer                                       ' LD B,n                    '06
        Call ldn(COMMON.vZ80cpu.B)
        op_ldbn = 7
    End Function '06    'op_ldbn
    Private Function op_ldcn() As Integer                                       ' LD C,n                    '0E
        Call ldn(COMMON.vZ80cpu.C)
        op_ldcn = 7
    End Function '0E    'op_ldcn
    Private Function op_lddn() As Integer                                       ' LD D,n                    '16
        Call ldn(COMMON.vZ80cpu.D)
        op_lddn = 7
    End Function '16    'op_lddn
    Private Function op_lden() As Integer                                       ' LD E,n                    '1E
        Call ldn(COMMON.vZ80cpu.E)
        op_lden = 7
    End Function '1E    'op_lden
    Private Function op_ldhn() As Integer                                       ' LD H,n                    '26
        Call ldn(COMMON.vZ80cpu.H)
        op_ldhn = 7
    End Function '26    'op_ldhn
    Private Function op_ldln() As Integer                                       ' LD L,n                    '2E
        Call ldn(COMMON.vZ80cpu.L)
        op_ldln = 7
    End Function '2E    'op_ldln
    Private Function op_ldhln() As Integer                                      ' LD (HL),n                 '36
        Call COMMON.vZ80cpu.PCplus1()
        COMMON.vZ80cpu.Speicher_schreiben_Byte((COMMON.vZ80cpu.H * 256) + COMMON.vZ80cpu.L, COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.PC))
        op_ldhln = 10
    End Function '36    'op_ldhln
    Private Function op_ldan() As Integer                                       ' LD A,n                    '3E
        Call ldn(COMMON.vZ80cpu.A)
        op_ldan = 7
    End Function '3E    'op_ldan
    Private Sub ldn(ByRef par1 As Byte)
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        Call COMMON.vZ80cpu.PCplus1()
        par1 = COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.PC)
    End Sub ' ldn
#End Region
#Region "LD_.._a"
    '------------------------------------     '02 12 32
    Private Function op_ldbca() As Integer                                      ' LD (BC),A                 '02
        Call COMMON.vZ80cpu.busfront(0)
        COMMON.vZ80cpu.Speicher_schreiben_Byte((COMMON.vZ80cpu.B * 256) + COMMON.vZ80cpu.C, COMMON.vZ80cpu.A)
        op_ldbca = 7
    End Function '02    'op_ldbca
    Private Function op_lddea() As Integer                                      ' LD (DE),A                 '12
        Call COMMON.vZ80cpu.busfront(0)
        COMMON.vZ80cpu.Speicher_schreiben_Byte((COMMON.vZ80cpu.D * 256) + COMMON.vZ80cpu.E, COMMON.vZ80cpu.A)
        op_lddea = 7
    End Function '12    'op_lddea
    Private Function op_ldnna() As Integer                                       ' LD (nn),A                '32
        Dim i As Integer

        Call COMMON.vZ80cpu.busfront(0)
        Call COMMON.vZ80cpu.PCplus1() : i = COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.PC)
        Call COMMON.vZ80cpu.PCplus1() : i = i + COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.PC) * 256
        COMMON.vZ80cpu.Speicher_schreiben_Byte(i, COMMON.vZ80cpu.A)
        op_ldnna = 13
    End Function '32    'op_ldnna
#End Region
#Region "LD_a_.."
    '------------------------------------     '0A 1A 3A
    Private Function op_ldabc() As Integer                                       ' LD A,(BC)                '0A
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        COMMON.vZ80cpu.A = COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.B * 256 + COMMON.vZ80cpu.C)
        op_ldabc = 7
    End Function '0A    'op_ldabc
    Private Function op_ldade() As Integer                                       ' LD A,(DE)                '1A
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        COMMON.vZ80cpu.A = COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.D * 256 + COMMON.vZ80cpu.E)
        op_ldade = 7
    End Function '1A    'op_ldade
    Private Function op_ldann() As Integer                                       ' LD A,(nn)                '3A
        Dim i As Integer

        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        Call COMMON.vZ80cpu.PCplus1() : i = COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.PC)
        Call COMMON.vZ80cpu.PCplus1() : i = i + COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.PC) * 256
        COMMON.vZ80cpu.A = COMMON.vZ80cpu.Speicher_lesen_Byte(i)
        op_ldann = 13
    End Function '3A    'op_ldann
#End Region
#Region "40"
#Region "40"
    '------------------------------------     '40
    Private Function op_ldbb() As Integer                                       ' LD B,B                    '40
        op_ldbb = 4
    End Function '40    'op_ldbb
    Private Function op_ldbc() As Integer                                       ' LD B,C                    '41
        COMMON.vZ80cpu.B = COMMON.vZ80cpu.C
        op_ldbc = 4
    End Function '41    'op_ldbc
    Private Function op_ldbd() As Integer                                       ' LD B,D                    '42
        COMMON.vZ80cpu.B = COMMON.vZ80cpu.D
        op_ldbd = 4
    End Function '42    'op_ldbd
    Private Function op_ldbe() As Integer                                       ' LD B,E                    '43
        COMMON.vZ80cpu.B = COMMON.vZ80cpu.E
        op_ldbe = 4
    End Function '43    'op_ldbe
    Private Function op_ldbh() As Integer                                       ' LD B,H                    '44
        COMMON.vZ80cpu.B = COMMON.vZ80cpu.H
        op_ldbh = 4
    End Function '44    'op_ldbh
    Private Function op_ldbl() As Integer                                       ' LD B,L                    '45
        COMMON.vZ80cpu.B = COMMON.vZ80cpu.L
        op_ldbl = 4
    End Function '45    'op_ldbl
    Private Function op_ldbhl() As Integer                                      ' LD B,(HL)                 '46
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        COMMON.vZ80cpu.B = COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.H * 256 + COMMON.vZ80cpu.L)
        op_ldbhl = 7
    End Function '46    'op_ldbhl
    Private Function op_ldba() As Integer                                       ' LD B,A                    '47
        COMMON.vZ80cpu.B = COMMON.vZ80cpu.A
        op_ldba = 4
    End Function '47    'op_ldba
#End Region
#Region "48"
    '------------------------------------     '48
    Private Function op_ldcb() As Integer                                      ' LD C,B                     '48
        COMMON.vZ80cpu.C = COMMON.vZ80cpu.B
        op_ldcb = 4
    End Function '48    'op_ldcb
    Private Function op_ldcc() As Integer                                      ' LD C,C                     '49
        op_ldcc = 4
    End Function '49    'op_ldcc
    Private Function op_ldcd() As Integer                                      ' LD C,D                     '4A
        COMMON.vZ80cpu.C = COMMON.vZ80cpu.D
        op_ldcd = 4
    End Function '4A    'op_ldcd
    Private Function op_ldce() As Integer                                      ' LD C,E                     '4B
        COMMON.vZ80cpu.C = COMMON.vZ80cpu.E
        op_ldce = 4
    End Function '4B    'op_ldce
    Private Function op_ldch() As Integer                                      ' LD C,H                     '4C
        COMMON.vZ80cpu.C = COMMON.vZ80cpu.H
        op_ldch = 4
    End Function '4C    'op_ldch
    Private Function op_ldcl() As Integer                                      ' LD C,L                     '4D
        COMMON.vZ80cpu.C = COMMON.vZ80cpu.L
        op_ldcl = 4
    End Function '4D    'op_ldcl
    Private Function op_ldchl() As Integer                                      ' LD C,(HL)                 '4E
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        COMMON.vZ80cpu.C = COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.H * 256 + COMMON.vZ80cpu.L)
        op_ldchl = 7
    End Function '4E    'op_ldchl
    Private Function op_ldca() As Integer                                      ' LD C,A                     '4F
        COMMON.vZ80cpu.C = COMMON.vZ80cpu.A
        op_ldca = 4
    End Function '4F    'op_ldca
#End Region
#End Region
#Region "50"
#Region "50"
    '------------------------------------     '50
    Private Function op_lddb() As Integer                                      ' LD D,B                     '50
        COMMON.vZ80cpu.D = COMMON.vZ80cpu.B
        op_lddb = 4
    End Function '50    'op_lddb
    Private Function op_lddc() As Integer                                      ' LD D,C                     '51
        COMMON.vZ80cpu.D = COMMON.vZ80cpu.C
        op_lddc = 4
    End Function '51    'op_lddc
    Private Function op_lddd() As Integer                                      ' LD D,D                     '52
        op_lddd = 4
    End Function '52    'op_lddd
    Private Function op_ldde() As Integer                                      ' LD D,E                     '53
        COMMON.vZ80cpu.D = COMMON.vZ80cpu.E
        op_ldde = 4
    End Function '53    'op_ldde
    Private Function op_lddh() As Integer                                      ' LD D,H                     '54
        COMMON.vZ80cpu.D = COMMON.vZ80cpu.H
        op_lddh = 4
    End Function '54    'op_lddh
    Private Function op_lddl() As Integer                                      ' LD D,L                     '55
        COMMON.vZ80cpu.D = COMMON.vZ80cpu.L
        op_lddl = 4
    End Function '55    'op_lddl
    Private Function op_lddhl() As Integer                                      ' LD D,(HL)                 '56
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        COMMON.vZ80cpu.D = COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.H * 256 + COMMON.vZ80cpu.L)
        op_lddhl = 7
    End Function '56    'op_lddhl
    Private Function op_ldda() As Integer                                      ' LD D,A                     '57
        COMMON.vZ80cpu.D = COMMON.vZ80cpu.A
        op_ldda = 4
    End Function '57    'op_ldda
#End Region
#Region "58"
    '------------------------------------     '58
    Private Function op_ldeb() As Integer                                      ' LD E,B                     '58
        COMMON.vZ80cpu.E = COMMON.vZ80cpu.B
        op_ldeb = 4
    End Function '58    'op_ldeb
    Private Function op_ldec() As Integer                                      ' LD E,C                     '59
        COMMON.vZ80cpu.E = COMMON.vZ80cpu.C
        op_ldec = 4
    End Function '59    'op_ldec
    Private Function op_lded() As Integer                                      ' LD E,D                     '5A
        COMMON.vZ80cpu.E = COMMON.vZ80cpu.D
        op_lded = 4
    End Function '5A    'op_lded
    Private Function op_ldee() As Integer                                      ' LD E,E                     '5B
        op_ldee = 4
    End Function '5B    'op_ldee
    Private Function op_ldeh() As Integer                                      ' LD E,H                     '5C
        COMMON.vZ80cpu.E = COMMON.vZ80cpu.H
        op_ldeh = 4
    End Function '5C    'op_ldeh
    Private Function op_ldel() As Integer                                      ' LD E,L                     '5D
        COMMON.vZ80cpu.E = COMMON.vZ80cpu.L
        op_ldel = 4
    End Function '5D    'op_ldel
    Private Function op_ldehl() As Integer                                      ' LD E,(HL)                 '5E
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        COMMON.vZ80cpu.E = COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.H * 256 + COMMON.vZ80cpu.L)
        op_ldehl = 7
    End Function '5E    'op_ldehl
    Private Function op_ldea() As Integer                                      ' LD E,A                     '5F
        COMMON.vZ80cpu.E = COMMON.vZ80cpu.A
        op_ldea = 4
    End Function '5F    'op_ldea
#End Region
#End Region
#Region "60"
#Region "60"
    '------------------------------------     '60
    Private Function op_ldhb() As Integer                                       ' LD H,B                    '60
        COMMON.vZ80cpu.H = COMMON.vZ80cpu.B
        op_ldhb = 4
    End Function '60    'op_ldhb
    Private Function op_ldhc() As Integer                                       ' LD H,C                    '61
        COMMON.vZ80cpu.H = COMMON.vZ80cpu.C
        op_ldhc = 4
    End Function '61    'op_ldhc
    Private Function op_ldhd() As Integer                                       ' LD H,D                    '62
        COMMON.vZ80cpu.H = COMMON.vZ80cpu.D
        op_ldhd = 4
    End Function '62    'op_ldhd
    Private Function op_ldhe() As Integer                                       ' LD H,E                    '63
        COMMON.vZ80cpu.H = COMMON.vZ80cpu.E
        op_ldhe = 4
    End Function '63    'op_ldhe
    Private Function op_ldhh() As Integer                                       ' LD H,H                    '64
        op_ldhh = 4
    End Function '64    'op_ldhh
    Private Function op_ldhl() As Integer                                       ' LD H,L                    '65
        COMMON.vZ80cpu.H = COMMON.vZ80cpu.L
        op_ldhl = 4
    End Function '65    'op_ldhl
    Private Function op_ldhhl() As Integer                                      ' LD H,(HL)                 '66
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        COMMON.vZ80cpu.H = COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.H * 256 + COMMON.vZ80cpu.L)
        op_ldhhl = 7
    End Function '66    'op_ldhhl
    Private Function op_ldha() As Integer                                       ' LD H,A                    '67
        COMMON.vZ80cpu.H = COMMON.vZ80cpu.A
        op_ldha = 4
    End Function '67    'op_ldha
#End Region
#Region "68"
    '------------------------------------     '68
    Private Function op_ldlb() As Integer                                       ' LD L,B                    '68
        COMMON.vZ80cpu.L = COMMON.vZ80cpu.B
        op_ldlb = 4
    End Function '68    'op_ldlb
    Private Function op_ldlc() As Integer                                       ' LD L,C                    '69
        COMMON.vZ80cpu.L = COMMON.vZ80cpu.C
        op_ldlc = 4
    End Function '69    'op_ldlc
    Private Function op_ldld() As Integer                                       ' LD L,D                    '6A
        COMMON.vZ80cpu.L = COMMON.vZ80cpu.D
        op_ldld = 4
    End Function '6A    'op_ldld
    Private Function op_ldle() As Integer                                       ' LD L,E                    '6B
        COMMON.vZ80cpu.L = COMMON.vZ80cpu.E
        op_ldle = 4
    End Function '6B    'op_ldle
    Private Function op_ldlh() As Integer                                       ' LD L,H                    '6C
        COMMON.vZ80cpu.L = COMMON.vZ80cpu.H
        op_ldlh = 4
    End Function '6C    'op_ldlh
    Private Function op_ldll() As Integer                                       ' LD L,L                    '6D
        op_ldll = 4
    End Function '6D    'op_ldll
    Private Function op_ldlhl() As Integer                                      ' LD L,(HL)                 '6E
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        COMMON.vZ80cpu.L = COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.H * 256 + COMMON.vZ80cpu.L)
        op_ldlhl = 7
    End Function '6E    'op_ldlhl
    Private Function op_ldla() As Integer                                       ' LD L,A                    '6F
        COMMON.vZ80cpu.L = COMMON.vZ80cpu.A
        op_ldla = 4
    End Function '6F    'op_ldla
#End Region
#End Region
#Region "70"
#Region "70"
    '------------------------------------     '70
    Private Function op_ldhlb() As Integer                                      ' LD (HL),B                 '70
        Call COMMON.vZ80cpu.busfront(0)
        COMMON.vZ80cpu.Speicher_schreiben_Byte((COMMON.vZ80cpu.H * 256) + COMMON.vZ80cpu.L, COMMON.vZ80cpu.B)
        op_ldhlb = 7
    End Function '70    'op_ldhlb
    Private Function op_ldhlc() As Integer                                      ' LD (HL),C                 '71
        Call COMMON.vZ80cpu.busfront(0)
        COMMON.vZ80cpu.Speicher_schreiben_Byte((COMMON.vZ80cpu.H * 256) + COMMON.vZ80cpu.L, COMMON.vZ80cpu.C)
        op_ldhlc = 7
    End Function '71    'op_ldhlc
    Private Function op_ldhld() As Integer                                      ' LD (HL),D                 '72
        Call COMMON.vZ80cpu.busfront(0)
        COMMON.vZ80cpu.Speicher_schreiben_Byte((COMMON.vZ80cpu.H * 256) + COMMON.vZ80cpu.L, COMMON.vZ80cpu.D)
        op_ldhld = 7
    End Function '72    'op_ldhld
    Private Function op_ldhle() As Integer                                      ' LD (HL),E                 '73
        Call COMMON.vZ80cpu.busfront(0)
        COMMON.vZ80cpu.Speicher_schreiben_Byte((COMMON.vZ80cpu.H * 256) + COMMON.vZ80cpu.L, COMMON.vZ80cpu.E)
        op_ldhle = 7
    End Function '73    'op_ldhle
    Private Function op_ldhlh() As Integer                                      ' LD (HL),H                 '74
        Call COMMON.vZ80cpu.busfront(0)
        COMMON.vZ80cpu.Speicher_schreiben_Byte((COMMON.vZ80cpu.H * 256) + COMMON.vZ80cpu.L, COMMON.vZ80cpu.H)
        op_ldhlh = 7
    End Function '74    'op_ldhlh
    Private Function op_ldhll() As Integer                                      ' LD (HL),L                 '75
        Call COMMON.vZ80cpu.busfront(0)
        COMMON.vZ80cpu.Speicher_schreiben_Byte((COMMON.vZ80cpu.H * 256) + COMMON.vZ80cpu.L, COMMON.vZ80cpu.L)
        op_ldhll = 7
    End Function '75    'op_ldhll
    Private Function op_ldhla() As Integer                                      ' LD (HL),A                 '77
        Call COMMON.vZ80cpu.busfront(0)
        COMMON.vZ80cpu.Speicher_schreiben_Byte((COMMON.vZ80cpu.H * 256) + COMMON.vZ80cpu.L, COMMON.vZ80cpu.A)
        op_ldhla = 7
    End Function '77    'op_ldhla
#End Region
#Region "78"
    '------------------------------------     '78
    Private Function op_ldab() As Integer                                      ' LD A,B                     '78
        COMMON.vZ80cpu.A = COMMON.vZ80cpu.B
        op_ldab = 4
    End Function '78    'op_ldab
    Private Function op_ldac() As Integer                                      ' LD A,C                     '79
        COMMON.vZ80cpu.A = COMMON.vZ80cpu.C
        op_ldac = 4
    End Function '79    'op_ldac
    Private Function op_ldad() As Integer                                      ' LD A,D                     '7A
        COMMON.vZ80cpu.A = COMMON.vZ80cpu.D
        op_ldad = 4
    End Function '7A    'op_ldad
    Private Function op_ldae() As Integer                                      ' LD A,E                     '7B
        COMMON.vZ80cpu.A = COMMON.vZ80cpu.E
        op_ldae = 4
    End Function '7B    'op_ldae
    Private Function op_ldah() As Integer                                      ' LD A,H                     '7C
        COMMON.vZ80cpu.A = COMMON.vZ80cpu.H
        op_ldah = 4
    End Function '7C    'op_ldah
    Private Function op_ldal() As Integer                                      ' LD A,L                     '7D
        COMMON.vZ80cpu.A = COMMON.vZ80cpu.L
        op_ldal = 4
    End Function '7D    'op_ldal
    Private Function op_ldahl() As Integer                                      ' LD A,(HL)                 '7E
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        COMMON.vZ80cpu.A = COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.H * 256 + COMMON.vZ80cpu.L)
        op_ldahl = 7
    End Function '7E    'op_ldahl
    Private Function op_ldaa() As Integer                                      ' LD A,A                     '7F
        op_ldaa = 4
    End Function '7F    'op_ldaa
#End Region
#End Region

#Region "LD.."
    '------------------------------------     '01 11 21 31
    Private Function op_ldbcnn() As Integer                                     ' LD BC,nn                  '01
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        Call COMMON.vZ80cpu.PCplus1() : COMMON.vZ80cpu.C = COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.PC)
        Call COMMON.vZ80cpu.PCplus1() : COMMON.vZ80cpu.B = COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.PC)
        op_ldbcnn = 10
    End Function '01    'op_ldbcnn
    Private Function op_lddenn() As Integer                                     ' LD DE,nn                  '11
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        Call COMMON.vZ80cpu.PCplus1() : COMMON.vZ80cpu.E = COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.PC)
        Call COMMON.vZ80cpu.PCplus1() : COMMON.vZ80cpu.D = COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.PC)
        op_lddenn = 10
    End Function '11    'op_lddenn
    Private Function op_ldhlnn() As Integer                                     ' LD HL,nn                  '21
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        Call COMMON.vZ80cpu.PCplus1() : COMMON.vZ80cpu.L = COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.PC)
        Call COMMON.vZ80cpu.PCplus1() : COMMON.vZ80cpu.H = COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.PC)
        op_ldhlnn = 10
    End Function '21    'op_ldhlnn
    Private Function op_ldspnn() As Integer                                     ' LD SP,nn                  '31
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        Call COMMON.vZ80cpu.PCplus1() : COMMON.vZ80cpu.STACK = COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.PC)
        Call COMMON.vZ80cpu.PCplus1() : COMMON.vZ80cpu.STACK = COMMON.vZ80cpu.STACK + COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.PC) * 256
        op_ldspnn = 10
    End Function '31    'op_ldspnn

    '------------------------------------     '2A 22 F9
    Private Function op_ldhlin() As Integer                                     ' LD HL,(nn)                '2A
        Dim i As Integer

        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        Call COMMON.vZ80cpu.PCplus1() : i = COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.PC)
        Call COMMON.vZ80cpu.PCplus1() : i = i + COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.PC) * 256
        COMMON.vZ80cpu.L = COMMON.vZ80cpu.Speicher_lesen_Byte(i)
        COMMON.vZ80cpu.H = COMMON.vZ80cpu.Speicher_lesen_Byte(i + 1)
        op_ldhlin = 16
    End Function '2A    'op_ldhlin
    Private Function op_ldinhl() As Integer                                     ' LD (nn),HL                '22
        Dim i As Integer

        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        Call COMMON.vZ80cpu.PCplus1() : i = COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.PC)
        Call COMMON.vZ80cpu.PCplus1() : i = i + COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.PC) * 256
        COMMON.vZ80cpu.Speicher_schreiben_Byte(i, COMMON.vZ80cpu.L)
        COMMON.vZ80cpu.Speicher_schreiben_Byte(i + 1, COMMON.vZ80cpu.H)
        op_ldinhl = 16
    End Function '22    'op_ldinhl
    Private Function op_ldsphl() As Integer                                     ' LD SP,HL                  'F9
        COMMON.vZ80cpu.STACK = COMMON.vZ80cpu.H * 256 + COMMON.vZ80cpu.L
        op_ldsphl = 6
    End Function 'F9    'op_ldsphl
#End Region
#End Region

#Region "INC.."
    '------------------------------------     '03 13 23 33
    Private Function op_incbc() As Integer                                      ' INC BC                    '03
        If COMMON.vZ80cpu.C = 255 Then
            COMMON.vZ80cpu.C = 0
            If COMMON.vZ80cpu.B = 255 Then
                COMMON.vZ80cpu.B = 0
            Else
                COMMON.vZ80cpu.B = COMMON.vZ80cpu.B + 1
            End If
        Else
            COMMON.vZ80cpu.C = COMMON.vZ80cpu.C + 1
        End If
        op_incbc = 6
    End Function '03    'op_incbc
    Private Function op_incde() As Integer                                      ' INC DE                    '13
        If COMMON.vZ80cpu.E = 255 Then
            COMMON.vZ80cpu.E = 0
            If COMMON.vZ80cpu.D = 255 Then
                COMMON.vZ80cpu.D = 0
            Else
                COMMON.vZ80cpu.D = COMMON.vZ80cpu.D + 1
            End If
        Else
            COMMON.vZ80cpu.E = COMMON.vZ80cpu.E + 1
        End If
        op_incde = 6
    End Function '13    'op_incde
    Private Function op_inchl() As Integer                                      ' INC HL                    '23
        If COMMON.vZ80cpu.L = 255 Then
            COMMON.vZ80cpu.L = 0
            If COMMON.vZ80cpu.H = 255 Then
                COMMON.vZ80cpu.H = 0
            Else
                COMMON.vZ80cpu.H = COMMON.vZ80cpu.H + 1
            End If
        Else
            COMMON.vZ80cpu.L = COMMON.vZ80cpu.L + 1
        End If
        op_inchl = 6
    End Function '23    'op_inchl
    Private Function op_incsp() As Integer                                      ' INC SP                    '33
        COMMON.vZ80cpu.STACK = COMMON.vZ80cpu.STACK + 1
#If WANT_SPC0 = 1 Then
        If COMMON.vZ80cpu.STACK > 65535 Then
            COMMON.vZ80cpu.STACK = 0
        End If
#End If
        op_incsp = 6
    End Function '33    'op_incsp
#End Region
#Region "DEC.."
    '------------------------------------     '0B 1B 2B 3B
    Private Function op_decbc() As Integer                                      ' DEC BC                    '0B
        If COMMON.vZ80cpu.C = 0 Then
            COMMON.vZ80cpu.C = 255
            If COMMON.vZ80cpu.B = 0 Then
                COMMON.vZ80cpu.B = 255
            Else
                COMMON.vZ80cpu.B = COMMON.vZ80cpu.B - 1
            End If
        Else
            COMMON.vZ80cpu.C = COMMON.vZ80cpu.C - 1
        End If
        op_decbc = 6
    End Function '0B    'op_decbc
    Private Function op_decde() As Integer                                      ' DEC DE                    '1B
        If COMMON.vZ80cpu.E = 0 Then
            COMMON.vZ80cpu.E = 255
            If COMMON.vZ80cpu.D = 0 Then
                COMMON.vZ80cpu.D = 255
            Else
                COMMON.vZ80cpu.D = COMMON.vZ80cpu.D - 1
            End If
        Else
            COMMON.vZ80cpu.E = COMMON.vZ80cpu.E - 1
        End If
        op_decde = 6
    End Function '1B    'op_decde
    Private Function op_dechl() As Integer                                      ' DEC HL                    '2B
        If COMMON.vZ80cpu.L = 0 Then
            COMMON.vZ80cpu.L = 255
            If COMMON.vZ80cpu.H = 0 Then
                COMMON.vZ80cpu.H = 255
            Else
                COMMON.vZ80cpu.H = COMMON.vZ80cpu.H - 1
            End If
        Else
            COMMON.vZ80cpu.L = COMMON.vZ80cpu.L - 1
        End If
        op_dechl = 6
    End Function '2B    'op_dechl
    Private Function op_decsp() As Integer                                      ' DEC SP                    '3B
        Dim Stack1 As Long
        Stack1 = COMMON.vZ80cpu.STACK - 1
#If WANT_SPC0 = 1 Then
        If Stack1 < 0 Then
            Stack1 = 65535
        End If
#End If
        COMMON.vZ80cpu.STACK = Stack1
        op_decsp = 6
    End Function '3B    'op_decsp
#End Region

#Region "ADHL.."
    '------------------------------------
    Private Function op_adhlbc() As Integer                                     ' ADD HL,BC                 '09         '#
        Call adhl(COMMON.vZ80cpu.B, COMMON.vZ80cpu.C)
        op_adhlbc = 11
    End Function '09    'op_adhlbc
    Private Function op_adhlde() As Integer                                     ' ADD HL,DE                 '19
        Call adhl(COMMON.vZ80cpu.D, COMMON.vZ80cpu.E)
        op_adhlde = 11
    End Function '19    'op_adhlde
    Private Function op_adhlhl() As Integer                                     ' ADD HL,HL                 '29
        Call adhl(COMMON.vZ80cpu.H, COMMON.vZ80cpu.L)
        op_adhlhl = 11
    End Function '29    'op_adhlhl
    Private Function op_adhlsp() As Integer                                     ' ADD HL,SP                 '39
        Dim sph As Byte
        Dim spl As Byte

        sph = (COMMON.vZ80cpu.STACK And &HFF00) \ 256
        spl = COMMON.vZ80cpu.STACK And &HFF
        Call adhl(sph, spl)
        op_adhlsp = 11
    End Function '39    'op_adhlsp
    Private Sub adhl(ByVal sph As Byte, ByVal spl As Byte)
        Dim carry As Byte

        If (CInt(COMMON.vZ80cpu.L) + CInt(spl)) > 255 Then carry = 1 Else carry = 0
        COMMON.vZ80cpu.L = (CInt(COMMON.vZ80cpu.L) + CInt(spl)) And &HFF
        Call COMMON.vZ80cpu.FlagHflag1((COMMON.vZ80cpu.H And &HF) + (sph And &HF) + carry > &HF)
        Call COMMON.vZ80cpu.FlagCflag1(CInt(COMMON.vZ80cpu.H) + CInt(sph) + carry > 255)
        COMMON.vZ80cpu.H = (CInt(COMMON.vZ80cpu.H) + CInt(sph) + carry) And &HFF
        Call COMMON.vZ80cpu.FlagNflag2()
    End Sub ' adhl
#End Region

#Region "AND"
    '------------------------------------
    Private Function op_andb() As Integer                                       ' AND B                     'A0
        Call and1(COMMON.vZ80cpu.B)
        op_andb = 4
    End Function 'A0    'op_andb
    Private Function op_andc() As Integer                                       ' AND C                     'A1
        Call and1(COMMON.vZ80cpu.C)
        op_andc = 4
    End Function 'A1    'op_andc
    Private Function op_andd() As Integer                                       ' AND D                     'A2
        Call and1(COMMON.vZ80cpu.D)
        op_andd = 4
    End Function 'A2    'op_andd
    Private Function op_ande() As Integer                                       ' AND E                     'A3
        Call and1(COMMON.vZ80cpu.E)
        op_ande = 4
    End Function 'A3    'op_ande
    Private Function op_andh() As Integer                                       ' AND H                     'A4
        Call and1(COMMON.vZ80cpu.H)
        op_andh = 4
    End Function 'A4    'op_andh
    Private Function op_andl() As Integer                                       ' AND L                     'A5
        Call and1(COMMON.vZ80cpu.L)
        op_andl = 4
    End Function 'A5     'op_andl
    Private Function op_andhl() As Integer                                       ' AND (HL)                 'A6
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        Call and1(COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.H * 256 + COMMON.vZ80cpu.L))
        op_andhl = 7
    End Function 'A6    'op_andhl
    Private Function op_anda() As Integer                                       ' AND A                     'A7
        Call and1(COMMON.vZ80cpu.A)
        op_anda = 4
    End Function 'A7    'op_anda
    Private Function op_andn() As Integer                                       ' AND n                     'E6
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        Call COMMON.vZ80cpu.PCplus1()
        Call and1(COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.PC))
        op_andn = 7
    End Function 'E6    'op_andn
    Private Sub and1(ByVal par1 As Byte)
        COMMON.vZ80cpu.A = COMMON.vZ80cpu.A And par1
        Call COMMON.vZ80cpu.FlagSflag1((COMMON.vZ80cpu.A And &H80))
        Call COMMON.vZ80cpu.FlagZflag2(COMMON.vZ80cpu.A <> 0)
        Call COMMON.vZ80cpu.FlagPflag2(COMMON.vZ80cpu.parrity(COMMON.vZ80cpu.A) = 1)
        COMMON.vZ80cpu.F = COMMON.vZ80cpu.F Or H_FLAG
        COMMON.vZ80cpu.F = COMMON.vZ80cpu.F And Not (N_FLAG Or C_FLAG)
    End Sub ' and
#End Region
#Region "OR"
    '------------------------------------
    Private Function op_orb() As Integer                                       ' OR B                       'B0
        Call or1(COMMON.vZ80cpu.B)
        op_orb = 4
    End Function 'B0    'op_orb
    Private Function op_orc() As Integer                                       ' OR C                       'B1
        Call or1(COMMON.vZ80cpu.C)
        op_orc = 4
    End Function 'B1    'op_orc
    Private Function op_ord() As Integer                                       ' OR D                       'B2
        Call or1(COMMON.vZ80cpu.D)
        op_ord = 4
    End Function 'B2    'op_ord
    Private Function op_ore() As Integer                                       ' OR E                       'B3
        Call or1(COMMON.vZ80cpu.E)
        op_ore = 4
    End Function 'B3    'op_ore
    Private Function op_orh() As Integer                                       ' OR H                       'B4
        Call or1(COMMON.vZ80cpu.H)
        op_orh = 4
    End Function 'B4    'op_orh
    Private Function op_orl() As Integer                                       ' OR L                       'B5
        Call or1(COMMON.vZ80cpu.L)
        op_orl = 4
    End Function 'B5    'op_orl
    Private Function op_orhl() As Integer                                       ' OR (HL)                   'B6
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        Call or1(COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.H * 256 + COMMON.vZ80cpu.L))
        op_orhl = 7
    End Function 'B6    'op_orhl
    Private Function op_ora() As Integer                                       ' OR A                       'B7
        Call or1(COMMON.vZ80cpu.A)
        op_ora = 4
    End Function 'B7    'op_ora
    Private Function op_orn() As Integer                                       ' OR n                       'F6
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        Call COMMON.vZ80cpu.PCplus1()
        Call or1(COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.PC))
        op_orn = 7
    End Function 'F6    'op_orn
    Private Sub or1(ByVal par1 As Byte)
        COMMON.vZ80cpu.A = COMMON.vZ80cpu.A Or par1
        Call COMMON.vZ80cpu.FlagSflag1((COMMON.vZ80cpu.A And &H80))
        Call COMMON.vZ80cpu.FlagZflag2(COMMON.vZ80cpu.A <> 0)
        Call COMMON.vZ80cpu.FlagPflag2(COMMON.vZ80cpu.parrity(COMMON.vZ80cpu.A) = 1)
        COMMON.vZ80cpu.F = COMMON.vZ80cpu.F And Not (COMMON.H_FLAG Or COMMON.N_FLAG Or COMMON.C_FLAG)
    End Sub ' or1
#End Region
#Region "XOR"
    '------------------------------------
    Private Function op_xorb() As Integer                                       ' XOR B                     'A8
        Call xor1(COMMON.vZ80cpu.B)
        op_xorb = 4
    End Function 'A8    'op_xorb
    Private Function op_xorc() As Integer                                       ' XOR C                     'A9
        Call xor1(COMMON.vZ80cpu.C)
        op_xorc = 4
    End Function 'A9    'op_xorc
    Private Function op_xord() As Integer                                       ' XOR D                     'AA
        Call xor1(COMMON.vZ80cpu.D)
        op_xord = 4
    End Function 'AA    'op_xord
    Private Function op_xore() As Integer                                       ' XOR E                     'AB
        Call xor1(COMMON.vZ80cpu.E)
        op_xore = 4
    End Function 'AB    'op_xore
    Private Function op_xorh() As Integer                                       ' XOR H                     'AC
        Call xor1(COMMON.vZ80cpu.H)
        op_xorh = 4
    End Function 'AC    'op_xorh
    Private Function op_xorl() As Integer                                       ' XOR L                     'AD
        Call xor1(COMMON.vZ80cpu.L)
        op_xorl = 4
    End Function 'AD    'op_xorl
    Private Function op_xorhl() As Integer                                       ' XOR (HL)                 'AE
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        Call xor1(COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.H * 256 + COMMON.vZ80cpu.L))
        op_xorhl = 7
    End Function 'AE    'op_xorhl
    Private Function op_xora() As Integer                                       ' XOR A                     'AF
        Call xor1(COMMON.vZ80cpu.A)
        op_xora = 4
    End Function 'AF    'op_xora
    Private Function op_xorn() As Integer                                       ' XOR n                    'EE
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        Call COMMON.vZ80cpu.PCplus1()
        Call xor1(COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.PC))
        op_xorn = 7
    End Function 'EE    'op_xorn
    Private Sub xor1(ByVal par1 As Byte)
        COMMON.vZ80cpu.A = COMMON.vZ80cpu.A Xor par1
        Call COMMON.vZ80cpu.FlagSflag1((COMMON.vZ80cpu.A And &H80))
        Call COMMON.vZ80cpu.FlagZflag2(COMMON.vZ80cpu.A <> 0)
        Call COMMON.vZ80cpu.FlagPflag2(COMMON.vZ80cpu.parrity(COMMON.vZ80cpu.A) = 1)
        COMMON.vZ80cpu.F = COMMON.vZ80cpu.F And Not (COMMON.H_FLAG Or COMMON.N_FLAG Or COMMON.C_FLAG)
    End Sub ' xor1
#End Region

#Region "ADD"
    '------------------------------------
    Private Function op_addb() As Integer                                       ' ADD A,B                   '80
        Call add(COMMON.vZ80cpu.B)
        op_addb = 4
    End Function '80    'op_addb
    Private Function op_addc() As Integer                                       ' ADD A,C                   '81
        Call add(COMMON.vZ80cpu.C)
        op_addc = 4
    End Function '81    'op_addc
    Private Function op_addd() As Integer                                       ' ADD A,D                   '82
        Call add(COMMON.vZ80cpu.D)
        op_addd = 4
    End Function '82    'op_addd
    Private Function op_adde() As Integer                                       ' ADD A,E                   '83
        Call add(COMMON.vZ80cpu.E)
        op_adde = 4
    End Function '83    'op_adde
    Private Function op_addh() As Integer                                       ' ADD A,H                   '84
        Call add(COMMON.vZ80cpu.H)
        op_addh = 4
    End Function '84    'op_addh
    Private Function op_addl() As Integer                                       ' ADD A,L                   '85
        Call add(COMMON.vZ80cpu.L)
        op_addl = 4
    End Function '85    'op_addl
    Private Function op_addhl() As Integer                                       ' ADD A,(HL)               '86
        Dim P As Byte
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        P = COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.H * 256 + COMMON.vZ80cpu.L)
        Call add(P)
        op_addhl = 7
    End Function '86    'op_addhl
    Private Function op_adda() As Integer                                       ' ADD A,A                   '87
        Call add(COMMON.vZ80cpu.A)
        op_adda = 4
    End Function '87    'op_adda
    Private Function op_addn() As Integer                                       ' ADD A,n                   'C6
        Dim P As Byte
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        Call COMMON.vZ80cpu.PCplus1() : P = COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.PC)
        Call add(P)
        op_addn = 7
    End Function 'C6    'op_addn
    Private Sub add(ByVal par1 As Byte)
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
#End Region
#Region "ADC"
    '------------------------------------
    Private Function op_adcb() As Integer                                       ' ADC A,B                   '88
        Call adc(COMMON.vZ80cpu.B)
        op_adcb = 4
    End Function '88    'op_adcb
    Private Function op_adcc() As Integer                                       ' ADC A,C                   '89
        Call adc(COMMON.vZ80cpu.C)
        op_adcc = 4
    End Function '89    'op_adcc
    Private Function op_adcd() As Integer                                       ' ADC A,D                   '8A
        Call adc(COMMON.vZ80cpu.D)
        op_adcd = 4
    End Function '8A    'op_adcd
    Private Function op_adce() As Integer                                       ' ADC A,E                   '8B
        Call adc(COMMON.vZ80cpu.E)
        op_adce = 4
    End Function '8B    'op_adce
    Private Function op_adch() As Integer                                       ' ADC A,H                   '8C
        Call adc(COMMON.vZ80cpu.H)
        op_adch = 4
    End Function '8C    'op_adch
    Private Function op_adcl() As Integer                                       ' ADC A,L                   '8D
        Call adc(COMMON.vZ80cpu.L)
        op_adcl = 4
    End Function '8D    'op_adcl
    Private Function op_adchl() As Integer                                      ' ADC A,(HL)                '8E
        Dim P As Byte
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        P = COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.H * 256 + COMMON.vZ80cpu.L)
        Call adc(P)
        op_adchl = 7
    End Function '8E    'op_adchl
    Private Function op_adca() As Integer                                       ' ADC A,A                   '8F
        Call adc(COMMON.vZ80cpu.A)
        op_adca = 4
    End Function '8F    'op_adca
    Private Function op_adcn() As Integer                                       ' ADC A,n                   'CE
        Dim P As Byte
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        Call COMMON.vZ80cpu.PCplus1() : P = COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.PC)
        Call adc(P)
        op_adcn = 7
    End Function 'CE    'op_adcn
    Private Sub adc(ByVal par1 As Byte)
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
#End Region
#Region "SUB"
    '------------------------------------
    Private Function op_subb() As Integer                                       ' SUB A,B                   '90
        Call sub1(COMMON.vZ80cpu.B)
        op_subb = 4
    End Function '90    'op_subb
    Private Function op_subc() As Integer                                       ' SUB A,C                   '91
        Call sub1(COMMON.vZ80cpu.C)
        op_subc = 4
    End Function '91    'op_subc
    Private Function op_subd() As Integer                                       ' SUB A,D                   '92
        Call sub1(COMMON.vZ80cpu.D)
        op_subd = 4
    End Function '92    'op_subd
    Private Function op_sube() As Integer                                       ' SUB A,E                   '93
        Call sub1(COMMON.vZ80cpu.E)
        op_sube = 4
    End Function '93    'op_sube
    Private Function op_subh() As Integer                                       ' SUB A,H                   '94
        Call sub1(COMMON.vZ80cpu.H)
        op_subh = 4
    End Function '94    'op_subh
    Private Function op_subl() As Integer                                       ' SUB A,L                   '95
        Call sub1(COMMON.vZ80cpu.L)
        op_subl = 4
    End Function '95    'op_subl
    Private Function op_subhl() As Integer                                      ' SUB A,(HL)                '96
        Dim P As Byte
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        P = COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.H * 256 + COMMON.vZ80cpu.L)
        Call sub1(P)
        op_subhl = 7
    End Function '96    'op_subhl
    Private Function op_suba() As Integer                                       ' SUB A,A                   '97
        Call sub1(COMMON.vZ80cpu.A)
        op_suba = 4
    End Function '97    'op_suba
    Private Function op_subn() As Integer                                       ' SUB A,n                   'D6
        Dim P As Byte
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        Call COMMON.vZ80cpu.PCplus1() : P = COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.PC)
        Call sub1(P)
        op_subn = 7
    End Function 'D6    'op_subn
    Private Sub sub1(ByVal par1 As Byte)
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
#End Region
#Region "SBC"
    '------------------------------------
    Private Function op_sbcb() As Integer                                       ' SBC A,B                   '98
        Call sbc(COMMON.vZ80cpu.B)
        op_sbcb = 4
    End Function '98    'op_sbcb
    Private Function op_sbcc() As Integer                                       ' SBC A,C                   '99
        Call sbc(COMMON.vZ80cpu.C)
        op_sbcc = 4
    End Function '99    'op_sbcc
    Private Function op_sbcd() As Integer                                       ' SBC A,D                   '9A
        Call sbc(COMMON.vZ80cpu.D)
        op_sbcd = 4
    End Function '9A    'op_sbcd
    Private Function op_sbce() As Integer                                       ' SBC A,E                   '9B
        Call sbc(COMMON.vZ80cpu.E)
        op_sbce = 4
    End Function '9B    'op_sbce
    Private Function op_sbch() As Integer                                       ' SBC A,H                   '9C
        Call sbc(COMMON.vZ80cpu.H)
        op_sbch = 4
    End Function '9C    'op_sbch
    Private Function op_sbcl() As Integer                                       ' SBC A,L                   '9D
        Call sbc(COMMON.vZ80cpu.L)
        op_sbcl = 4
    End Function '9D    'op_sbcl
    Private Function op_sbchl() As Integer                                      ' SBC A,(HL)                '9E
        Dim P As Byte
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        P = COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.H * 256 + COMMON.vZ80cpu.L)
        Call sbc(P)
        op_sbchl = 7
    End Function '9E    'op_sbchl
    Private Function op_sbca() As Integer                                       ' SBC A,A                   '9F
        Call sbc(COMMON.vZ80cpu.A)
        op_sbca = 4
    End Function '9F    'op_sbca
    Private Function op_sbcn() As Integer                                       ' SBC A,n                   'DE
        Dim P As Byte
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        Call COMMON.vZ80cpu.PCplus1() : P = COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.PC)
        Call sbc(P)
        op_sbcn = 7
    End Function 'DE    'op_sbcn
    Private Sub sbc(ByVal par1 As Byte)
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
#End Region
#Region "CP"
    '------------------------------------
    Private Function op_cpb() As Integer                                        ' CP B                      'B8
        Call cp(COMMON.vZ80cpu.B)
        op_cpb = 4
    End Function 'B8    'op_cpb
    Private Function op_cpc() As Integer                                        ' CP C                      'B9
        Call cp(COMMON.vZ80cpu.C)
        op_cpc = 4
    End Function 'B9    'op_cpc
    Private Function op_cpd() As Integer                                        ' CP D                      'BA
        Call cp(COMMON.vZ80cpu.D)
        op_cpd = 4
    End Function 'BA    'op_cpd
    Private Function op_cpe() As Integer                                        ' CP E                      'BB
        Call cp(COMMON.vZ80cpu.E)
        op_cpe = 4
    End Function 'BB    'op_cpe
    Private Function op_cph() As Integer                                        ' CP H                      'BC
        Call cp(COMMON.vZ80cpu.H)
        op_cph = 4
    End Function 'BC    'op_cph
    Private Function op_cplr() As Integer                                       ' CP L                      'BD
        Call cp(COMMON.vZ80cpu.L)
        op_cplr = 4
    End Function 'BD    'op_cplr
    Private Function op_cphl() As Integer                                       ' CP (HL)                   'BE
        Dim P As Byte
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        P = COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.H * 256 + COMMON.vZ80cpu.L)
        Call cp(P)
        op_cphl = 7
    End Function 'BE    'op_cphl
    Private Function op_cpa() As Integer                                        ' CP A                      'BF
        Call cp(COMMON.vZ80cpu.A)
        op_cpa = 4
    End Function 'BF    'op_cpa
    Private Function op_cpn() As Integer                                        ' CP n                      'FE
        Dim P As Byte
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        Call COMMON.vZ80cpu.PCplus1() : P = COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.PC)
        Call cp(P)
        op_cpn = 7
    End Function 'FE    'op_cpn
    Private Sub cp(ByVal par1 As Byte)  '# sbyte
        Dim i As Integer

        Call COMMON.vZ80cpu.FlagHflag1((par1 And &HF) > (COMMON.vZ80cpu.A And &HF))
        Call COMMON.vZ80cpu.FlagCflag1(par1 > COMMON.vZ80cpu.A)
        i = CInt(COMMON.vZ80cpu.A) - CInt(par1)                 'i = CInt(COMMON.Byte2SByte(COMMON.vZ80cpu.A)) - CInt(COMMON.Byte2SByte(par1))
        Call COMMON.vZ80cpu.FlagPflag1((i < -128) Or (i > 127))
        Call COMMON.vZ80cpu.FlagSflag1((i And &H80))
        Call COMMON.vZ80cpu.FlagZflag2(i <> 0)
        Call COMMON.vZ80cpu.FlagNflag1()
    End Sub ' cp
#End Region
#Region "INC"
    '------------------------------------     '04 0C 14 1C 24 2C 34 3C
    Private Function op_incb() As Integer                                       ' INC B                     '04
        Call inc(COMMON.vZ80cpu.B)
        op_incb = 4
    End Function '04    'op_incb
    Private Function op_incc() As Integer                                       ' INC C                     '0C
        Call inc(COMMON.vZ80cpu.C)
        op_incc = 4
    End Function '0C    'op_incc
    Private Function op_incd() As Integer                                       ' INC D                     '14
        Call inc(COMMON.vZ80cpu.D)
        op_incd = 4
    End Function '14    'op_incd
    Private Function op_ince() As Integer                                       ' INC E                     '1C
        Call inc(COMMON.vZ80cpu.E)
        op_ince = 4
    End Function '1C    'op_ince
    Private Function op_inch() As Integer                                       ' INC H                     '24
        Call inc(COMMON.vZ80cpu.H)
        op_inch = 4
    End Function '24    'op_inch
    Private Function op_incl() As Integer                                       ' INC L                     '2C
        Call inc(COMMON.vZ80cpu.L)
        op_incl = 4
    End Function '2C    'op_incl
    Private Function op_incihl() As Integer                                     ' INC (HL)                  '34
        Dim p, b As Integer
        Try
            Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
            p = COMMON.vZ80cpu.H * 256 + COMMON.vZ80cpu.L
            b = (COMMON.vZ80cpu.Speicher_lesen_Byte(p) And &HFF) + 1
            Call COMMON.vZ80cpu.FlagHflag1(b > &HFF)
            b = b And &HFF
            COMMON.vZ80cpu.Speicher_schreiben_Byte(p, b)
            Call COMMON.vZ80cpu.FlagPflag1(COMMON.vZ80cpu.Speicher_lesen_Byte(p) = &H80)
            Call COMMON.vZ80cpu.FlagSflag1((COMMON.vZ80cpu.Speicher_lesen_Byte(p) And &H80))
            Call COMMON.vZ80cpu.FlagZflag2(COMMON.vZ80cpu.Speicher_lesen_Byte(p) <> 0)
            Call COMMON.vZ80cpu.FlagNflag2()
        Catch ex As Exception
            MsgBox("CPU1.op_incihl: " + ex.Message & vbCrLf &
                   "PC=" + COMMON.HexAnzeige_WordByte(COMMON.vZ80cpu.PC, "B ") & vbCrLf &
                   "HL=" + COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.H) + COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.L) & vbCrLf &
                   "DE=" + COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.D) + COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.E) & vbCrLf &
                   "BC=" + COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.B) + COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.C)
                  )
        End Try
        op_incihl = 11
    End Function '34    'op_incihl
    Private Function op_inca() As Integer                                       ' INC A                     '3C
        Call inc(COMMON.vZ80cpu.A)
        op_inca = 4
    End Function '3C    'op_inca
    Private Sub inc(ByRef par1 As Byte)
        Call COMMON.vZ80cpu.FlagHflag1((par1 And &HF) + 1 > &HF)
        Call COMMON.vZ80cpu.RegPlus1(par1)

        Call COMMON.vZ80cpu.FlagPflag1(par1 = &H80)
        Call COMMON.vZ80cpu.FlagSflag1((par1 And &H80))
        Call COMMON.vZ80cpu.FlagZflag2(par1 <> 0)
        Call COMMON.vZ80cpu.FlagNflag2()
    End Sub ' inc
#End Region
#Region "DEC"
    '------------------------------------     '05 0D 15 1D 25 2D 35 3D
    Private Function op_decb() As Integer                                       ' DEC B                     '05
        Call dec(COMMON.vZ80cpu.B)
        op_decb = 4
    End Function '05    'op_decb
    Private Function op_decc() As Integer                                       ' DEC C                     '0D
        Call dec(COMMON.vZ80cpu.C)
        op_decc = 4
    End Function '0D    'op_decc
    Private Function op_decd() As Integer                                       ' DEC D                     '15
        Call dec(COMMON.vZ80cpu.D)
        op_decd = 4
    End Function '15    'op_decd
    Private Function op_dece() As Integer                                       ' DEC E                     '1D
        Call dec(COMMON.vZ80cpu.E)
        op_dece = 4
    End Function '1D    'op_dece
    Private Function op_dech() As Integer                                       ' DEC H                     '25
        Call dec(COMMON.vZ80cpu.H)
        op_dech = 4
    End Function '25    'op_dech
    Private Function op_decl() As Integer                                       ' DEC L                     '2D
        Call dec(COMMON.vZ80cpu.L)
        op_decl = 4
    End Function '2D    'op_decl
    Private Function op_decihl() As Integer                                     ' DEC (HL)                  '35
        Dim p, bb As Integer
        Try
            Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
            p = COMMON.vZ80cpu.H * 256 + COMMON.vZ80cpu.L
            'Call COMMON.vZ80cpu.FlagHflag1((COMMON.vZ80cpu.Speicher_lesen_Byte(p) - 1) And &HF)
            bb = COMMON.vZ80cpu.Speicher_lesen_Byte(p)
            If bb = 0 Then
                bb = &HFF
            Else
                bb = bb - 1
            End If
            COMMON.vZ80cpu.Speicher_schreiben_Byte(p, bb)
            Call COMMON.vZ80cpu.FlagHflag1(COMMON.vZ80cpu.Speicher_lesen_Byte(p) And &HF)
            Call COMMON.vZ80cpu.FlagPflag1(COMMON.vZ80cpu.Speicher_lesen_Byte(p) = &H7F)
            Call COMMON.vZ80cpu.FlagSflag1((COMMON.vZ80cpu.Speicher_lesen_Byte(p) And &H80))
            Call COMMON.vZ80cpu.FlagZflag2(COMMON.vZ80cpu.Speicher_lesen_Byte(p) <> 0)
            Call COMMON.vZ80cpu.FlagNflag1()
        Catch ex As Exception
            MsgBox("CPU1.op_decihl: " + ex.Message & vbCrLf &
                   "PC=" + COMMON.HexAnzeige_WordByte(COMMON.vZ80cpu.PC, "B ") & vbCrLf &
                   "HL=" + COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.H) + COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.L) & vbCrLf &
                   "DE=" + COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.D) + COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.E) & vbCrLf &
                   "BC=" + COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.B) + COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.C & vbCrLf &
                   "bb=" & bb & vbCrLf &
                   "p =" & p)
                  )
        End Try
        op_decihl = 11
    End Function '35    'op_decihl
    Private Function op_deca() As Integer                                       ' DEC A                     '3D
        Call dec(COMMON.vZ80cpu.A)
        op_deca = 4
    End Function '3D    'op_deca
    Private Sub dec(ByRef par1 As Byte)
        'Call COMMON.vZ80cpu.FlagHflag1(((CInt(par1) - 1) And &HF))
        par1 = (CInt(par1) - 1) And &HFF
        Call COMMON.vZ80cpu.FlagHflag1(par1 And &HF)
        Call COMMON.vZ80cpu.FlagPflag1(par1 = &H7F)
        Call COMMON.vZ80cpu.FlagSflag1(par1 And &H80)
        Call COMMON.vZ80cpu.FlagZflag2(par1 <> 0)
        Call COMMON.vZ80cpu.FlagNflag1()
    End Sub ' dec
#End Region
#Region "RL_RR"
    '------------------------------------
    Private Function op_rlca() As Integer                                       ' RLCA                      '07
        Dim i As Integer
        If (COMMON.vZ80cpu.A And &H80) = &H80 Then i = 1 Else i = 0
        Call COMMON.vZ80cpu.FlagCflag1(i <> 0)
        COMMON.vZ80cpu.F = COMMON.vZ80cpu.F And Not (COMMON.H_FLAG Or COMMON.N_FLAG)
        COMMON.vZ80cpu.A = COMMON.vZ80cpu.A << 1    'shl
        COMMON.vZ80cpu.A = COMMON.vZ80cpu.A Or i
        op_rlca = 4
    End Function '07    'op_rlca
    Private Function op_rrca() As Integer                                       ' RRCA                      '0F
        Dim i As Integer
        i = COMMON.vZ80cpu.A And 1
        Call COMMON.vZ80cpu.FlagCflag1(i <> 0)
        COMMON.vZ80cpu.F = COMMON.vZ80cpu.F And Not (COMMON.H_FLAG Or COMMON.N_FLAG)
        COMMON.vZ80cpu.A = COMMON.vZ80cpu.A >> 1   'shr
        If COMMON.vZ80cpu.A = 0 Then COMMON.vZ80cpu.A = COMMON.vZ80cpu.A Or &H80
        op_rrca = 4
    End Function '0F    'op_rrca
    Private Function op_rla() As Integer                                        ' RLA                       '17
        Dim old_c_flag As Integer
        old_c_flag = COMMON.vZ80cpu.F And COMMON.C_FLAG
        Call COMMON.vZ80cpu.FlagCflag1((COMMON.vZ80cpu.A And &H80))
        COMMON.vZ80cpu.F = COMMON.vZ80cpu.F And Not (COMMON.H_FLAG Or COMMON.N_FLAG)
        COMMON.vZ80cpu.A = COMMON.vZ80cpu.A << 1   'shl
        If old_c_flag = COMMON.C_FLAG Then COMMON.vZ80cpu.A = COMMON.vZ80cpu.A Or 1
        op_rla = 4
    End Function '17    'op_rla
    Private Function op_rra() As Integer                                        ' RRA                       '1F
        Dim i As Integer
        Dim old_c_flag As Integer
        old_c_flag = COMMON.vZ80cpu.F And COMMON.C_FLAG
        i = COMMON.vZ80cpu.A And 1
        Call COMMON.vZ80cpu.FlagCflag1(i <> 0)
        COMMON.vZ80cpu.F = COMMON.vZ80cpu.F And Not (COMMON.H_FLAG Or COMMON.N_FLAG)
        COMMON.vZ80cpu.A = COMMON.vZ80cpu.A >> 1    'shr
        If old_c_flag = COMMON.C_FLAG Then COMMON.vZ80cpu.A = COMMON.vZ80cpu.A Or &H80
        op_rra = 4
    End Function '1F    'op_rra
#End Region
#Region "EX.."
    '------------------------------------
    Private Function op_exafaf() As Integer                                     ' EXAF                      '08
        Dim i As Byte
        i = COMMON.vZ80cpu.A : COMMON.vZ80cpu.A = COMMON.vZ80cpu.A_ : COMMON.vZ80cpu.A_ = i
        i = COMMON.vZ80cpu.F : COMMON.vZ80cpu.F = COMMON.vZ80cpu.F_ : COMMON.vZ80cpu.F_ = i
        op_exafaf = 4
    End Function '08    'op_exafaf
    Private Function op_exx() As Integer                                        ' EXX                       'D9
        Dim i As Byte
        i = COMMON.vZ80cpu.B : COMMON.vZ80cpu.B = COMMON.vZ80cpu.B_ : COMMON.vZ80cpu.B_ = i
        i = COMMON.vZ80cpu.C : COMMON.vZ80cpu.C = COMMON.vZ80cpu.C_ : COMMON.vZ80cpu.C_ = i

        i = COMMON.vZ80cpu.D : COMMON.vZ80cpu.D = COMMON.vZ80cpu.D_ : COMMON.vZ80cpu.D_ = i
        i = COMMON.vZ80cpu.E : COMMON.vZ80cpu.E = COMMON.vZ80cpu.E_ : COMMON.vZ80cpu.E_ = i

        i = COMMON.vZ80cpu.H : COMMON.vZ80cpu.H = COMMON.vZ80cpu.H_ : COMMON.vZ80cpu.H_ = i
        i = COMMON.vZ80cpu.L : COMMON.vZ80cpu.L = COMMON.vZ80cpu.L_ : COMMON.vZ80cpu.L_ = i
        op_exx = 4
    End Function 'D9    'op_exx
    Private Function op_exsphl() As Integer                                     ' EX (SP),HL                'E3
        Dim i As Byte
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        i = COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.STACK) : COMMON.vZ80cpu.Speicher_schreiben_Byte(COMMON.vZ80cpu.STACK, COMMON.vZ80cpu.L) : COMMON.vZ80cpu.L = i
        i = COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.STACK + 1) : COMMON.vZ80cpu.Speicher_schreiben_Byte(COMMON.vZ80cpu.STACK + 1, COMMON.vZ80cpu.H) : COMMON.vZ80cpu.H = i
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_STACK)
        op_exsphl = 19
    End Function 'E3    'op_exsphl
    Private Function op_exdehl() As Integer                                     ' EX DE,HL                  'EB
        Dim i As Byte
        i = COMMON.vZ80cpu.D : COMMON.vZ80cpu.D = COMMON.vZ80cpu.H : COMMON.vZ80cpu.H = i
        i = COMMON.vZ80cpu.E : COMMON.vZ80cpu.E = COMMON.vZ80cpu.L : COMMON.vZ80cpu.L = i
        op_exdehl = 4
    End Function 'EB    'op_exdehl
#End Region
#Region "PUSH"
    '------------------------------------
    Private Function op_pushbc() As Integer                                     ' PUSH BC                   'C5
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_STACK)
        Call COMMON.vZ80cpu.SPminus1()
        COMMON.vZ80cpu.Speicher_schreiben_Byte(COMMON.vZ80cpu.STACK, COMMON.vZ80cpu.B)
        Call COMMON.vZ80cpu.SPminus1()
        COMMON.vZ80cpu.Speicher_schreiben_Byte(COMMON.vZ80cpu.STACK, COMMON.vZ80cpu.C)
        op_pushbc = 11
    End Function 'C5    'op_pushbc
    Private Function op_pushde() As Integer                                     ' PUSH DE                   'D5
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_STACK)
        Call COMMON.vZ80cpu.SPminus1()
        COMMON.vZ80cpu.Speicher_schreiben_Byte(COMMON.vZ80cpu.STACK, COMMON.vZ80cpu.D)
        Call COMMON.vZ80cpu.SPminus1()
        COMMON.vZ80cpu.Speicher_schreiben_Byte(COMMON.vZ80cpu.STACK, COMMON.vZ80cpu.E)
        op_pushde = 11
    End Function 'D5    'op_pushde
    Private Function op_pushhl() As Integer                                     ' PUSH HL                   'E5
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_STACK)
        Call COMMON.vZ80cpu.SPminus1()
        COMMON.vZ80cpu.Speicher_schreiben_Byte(COMMON.vZ80cpu.STACK, COMMON.vZ80cpu.H)
        Call COMMON.vZ80cpu.SPminus1()
        COMMON.vZ80cpu.Speicher_schreiben_Byte(COMMON.vZ80cpu.STACK, COMMON.vZ80cpu.L)
        op_pushhl = 11
    End Function 'E5    'op_pushhl
    Private Function op_pushaf() As Integer                                     ' PUSH AF                   'F5
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_STACK)
        Call COMMON.vZ80cpu.SPminus1()
        COMMON.vZ80cpu.Speicher_schreiben_Byte(COMMON.vZ80cpu.STACK, COMMON.vZ80cpu.A)
        Call COMMON.vZ80cpu.SPminus1()
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_STACK)
        COMMON.vZ80cpu.Speicher_schreiben_Byte(COMMON.vZ80cpu.STACK, COMMON.vZ80cpu.F)
        op_pushaf = 11
    End Function 'F5    'op_pushaf
#End Region
#Region "POP"
    '------------------------------------
    Private Function op_popbc() As Integer                                      ' POP BC                    'C1
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_STACK Or COMMON.CPU_MEMR)
        COMMON.vZ80cpu.C = COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.STACK)
        Call COMMON.vZ80cpu.SPplus1()
        COMMON.vZ80cpu.B = COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.STACK)
        Call COMMON.vZ80cpu.SPplus1()
        op_popbc = 10
    End Function 'C1    'op_popbc
    Private Function op_popde() As Integer                                      ' POP DE                    'D1
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_STACK Or COMMON.CPU_MEMR)
        COMMON.vZ80cpu.E = COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.STACK)
        Call COMMON.vZ80cpu.SPplus1()
        COMMON.vZ80cpu.D = COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.STACK)
        Call COMMON.vZ80cpu.SPplus1()
        op_popde = 10
    End Function 'D1    'op_popde
    Private Function op_pophl() As Integer                                      ' POP HL                    'E1
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_STACK Or COMMON.CPU_MEMR)
        COMMON.vZ80cpu.L = COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.STACK)
        Call COMMON.vZ80cpu.SPplus1()
        COMMON.vZ80cpu.H = COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.STACK)
        Call COMMON.vZ80cpu.SPplus1()
        op_pophl = 10
    End Function 'E1    'op_pophl
    Private Function op_popaf() As Integer                                      ' POP AF                    'F1
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_STACK Or COMMON.CPU_MEMR)
        COMMON.vZ80cpu.F = COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.STACK)
        Call COMMON.vZ80cpu.SPplus1()
        COMMON.vZ80cpu.A = COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.STACK)
        Call COMMON.vZ80cpu.SPplus1()
        op_popaf = 10
    End Function 'F1    'op_popaf
#End Region

#Region "JP_JP(HL)_DJNZ"
    '------------------------------------
    Private Function op_jp() As Integer                                         ' JP                        'C3
        Dim i As Integer
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        Call COMMON.vZ80cpu.PCplus1() : i = COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.PC)
        Call COMMON.vZ80cpu.PCplus1() : i = i + COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.PC) * 256
        COMMON.vZ80cpu.PC = i
        Call COMMON.vZ80cpu.PCminus1()
        op_jp = 10
    End Function 'C3    'op_jp
    Private Function op_jphl() As Integer                                       ' JP (HL)                   'E9
        COMMON.vZ80cpu.PC = COMMON.vZ80cpu.H * 256 + COMMON.vZ80cpu.L
        Call COMMON.vZ80cpu.PCminus1()
        op_jphl = 4
    End Function 'E9    'op_jphl

    Private Function op_djnz() As Integer                                       ' DJNZ                      '10
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        If COMMON.vZ80cpu.B = 0 Then
            COMMON.vZ80cpu.B = &HFF
            Call djnz()
#If WANT_TIM0 = 1 Then
            op_djnz = 13
#End If
        Else
            COMMON.vZ80cpu.B = COMMON.vZ80cpu.B - 1
            If COMMON.vZ80cpu.B = 0 Then
                Call COMMON.vZ80cpu.PCplus1()
#If WANT_TIM0 = 1 Then
                op_djnz = 8
#End If
            Else
                Call djnz()
#If WANT_TIM0 = 1 Then
                op_djnz = 13
#End If
            End If
        End If
    End Function '10    'op_djnz
    Private Sub djnz()
        Dim i As SByte
        Call COMMON.vZ80cpu.PCplus1()
        i = COMMON.Byte2SByte(COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.PC))
        Call COMMON.vZ80cpu.PCplusI(i)
    End Sub ' djnz
#End Region
#Region "JP"
    Private Function op_jpnz() As Integer                                       ' JP NZ,nn                  'C2
        If Not (COMMON.vZ80cpu.F And COMMON.Z_FLAG) = COMMON.Z_FLAG Then
            Call jp()
            Call COMMON.vZ80cpu.PCminus1()
        Else
            Call COMMON.vZ80cpu.PCplus1()
            Call COMMON.vZ80cpu.PCplus1()
        End If
        op_jpnz = 10
    End Function 'C2    'op_jpnz
    Private Function op_jpz() As Integer                                        ' JP Z,nn                   'CA
        If (COMMON.vZ80cpu.F And COMMON.Z_FLAG) = COMMON.Z_FLAG Then
            Call jp()
            Call COMMON.vZ80cpu.PCminus1()
        Else
            Call COMMON.vZ80cpu.PCplus1()
            Call COMMON.vZ80cpu.PCplus1()
        End If
        op_jpz = 10
        'COMMON.JPoperation = True
    End Function 'CA    'op_jpz
    Private Function op_jpnc() As Integer                                       ' JP NC,nn                  'D2
        If Not (COMMON.vZ80cpu.F And COMMON.C_FLAG) = COMMON.C_FLAG Then
            Call jp()
            Call COMMON.vZ80cpu.PCminus1()
        Else
            Call COMMON.vZ80cpu.PCplus1()
            Call COMMON.vZ80cpu.PCplus1()
        End If
        op_jpnc = 10
    End Function 'D2    'op_jpnc
    Private Function op_jpc() As Integer                                        ' JP C,nn                   'DA
        If (COMMON.vZ80cpu.F And COMMON.C_FLAG) = COMMON.C_FLAG Then
            Call jp()
            Call COMMON.vZ80cpu.PCminus1()
        Else
            Call COMMON.vZ80cpu.PCplus1()
            Call COMMON.vZ80cpu.PCplus1()
        End If
        op_jpc = 10
    End Function 'DA    'op_jpc
    Private Function op_jppo() As Integer                                       ' JP PO,nn                  'E2
        If Not (COMMON.vZ80cpu.F And COMMON.P_FLAG) = COMMON.P_FLAG Then
            Call jp()
            Call COMMON.vZ80cpu.PCminus1()
        Else
            Call COMMON.vZ80cpu.PCplus1()
            Call COMMON.vZ80cpu.PCplus1()
        End If
        op_jppo = 10
    End Function 'E2    'op_jppo
    Private Function op_jppe() As Integer                                       ' JP PE,nn                  'EA
        If (COMMON.vZ80cpu.F And COMMON.P_FLAG) = COMMON.P_FLAG Then
            Call jp()
            Call COMMON.vZ80cpu.PCminus1()
        Else
            Call COMMON.vZ80cpu.PCplus1()
            Call COMMON.vZ80cpu.PCplus1()
        End If
        op_jppe = 10
    End Function 'EA    'op_jppe
    Private Function op_jpp() As Integer                                        ' JP P,nn                   'F2
        If Not (COMMON.vZ80cpu.F And COMMON.S_FLAG) = COMMON.S_FLAG Then
            Call jp()
            Call COMMON.vZ80cpu.PCminus1()
        Else
            Call COMMON.vZ80cpu.PCplus1()
            Call COMMON.vZ80cpu.PCplus1()
        End If
        op_jpp = 10
    End Function 'F2    'op_jpp
    Private Function op_jpm() As Integer                                        ' JP M,nn                   'FA
        If (COMMON.vZ80cpu.F And COMMON.S_FLAG) = COMMON.S_FLAG Then
            Call jp()
            Call COMMON.vZ80cpu.PCminus1()
        Else
            Call COMMON.vZ80cpu.PCplus1()
            Call COMMON.vZ80cpu.PCplus1()
        End If
        op_jpm = 10
    End Function 'FA    'op_jpm
    Private Sub jp()
        Dim i As Integer

        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        Call COMMON.vZ80cpu.PCplus1() : i = COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.PC)
        Call COMMON.vZ80cpu.PCplus1() : i = i + COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.PC) * 256
        COMMON.vZ80cpu.PC = i
    End Sub ' jp
#End Region
#Region "JR"
    Private Function op_jr() As Integer                                         ' JR                        '18
        Call jr()
        op_jr = 12
    End Function '18    'op_jr
    Private Function op_jrz() As Integer                                        ' JR Z,n                    '28
        If (COMMON.vZ80cpu.F And COMMON.Z_FLAG) = COMMON.Z_FLAG Then
            Call jr()
            op_jrz = 12
        Else
            Call COMMON.vZ80cpu.PCplus1()
            op_jrz = 7
        End If
    End Function '28    'op_jrz
    Private Function op_jrnz() As Integer                                       ' JR NZ,n                   '20
        If Not (COMMON.vZ80cpu.F And COMMON.Z_FLAG) = COMMON.Z_FLAG Then
            Call jr()
            op_jrnz = 12
        Else
            Call COMMON.vZ80cpu.PCplus1()
            op_jrnz = 7
        End If
    End Function '20    'op_jrnz
    Private Function op_jrc() As Integer                                        ' JR C,n                    '38
        If (COMMON.vZ80cpu.F And COMMON.C_FLAG) = COMMON.C_FLAG Then
            Call jr()
            op_jrc = 12
        Else
            Call COMMON.vZ80cpu.PCplus1()
            op_jrc = 7
        End If
    End Function '38    'op_jrc
    Private Function op_jrnc() As Integer                                       ' JR NC,n                   '30
        If Not (COMMON.vZ80cpu.F And COMMON.C_FLAG) = COMMON.C_FLAG Then
            Call jr()
            op_jrnc = 12
        Else
            Call COMMON.vZ80cpu.PCplus1()
            op_jrnc = 7
        End If
    End Function '30    'op_jrnc
    Private Sub jr()
        Dim i As SByte
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        Call COMMON.vZ80cpu.PCplus1()
        i = COMMON.Byte2SByte(COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.PC))
        Call COMMON.vZ80cpu.PCplusI(i)
        '        Call COMMON.vZ80cpu.PCplus1()
    End Sub ' jr
#End Region
#Region "CALL"
    '------------------------------------
    Private Function op_calnz() As Integer                                      ' CALL NZ,nn                'C4
        If Not (COMMON.vZ80cpu.F And COMMON.Z_FLAG) = COMMON.Z_FLAG Then
            Call call1()
            op_calnz = 17
        Else
            Call COMMON.vZ80cpu.PCplus1()
            Call COMMON.vZ80cpu.PCplus1()
            op_calnz = 10
        End If
    End Function 'C4    'op_calnz
    Private Function op_calz() As Integer                                       ' CALL Z,nn                 'CC
        If (COMMON.vZ80cpu.F And COMMON.Z_FLAG) = COMMON.Z_FLAG Then
            Call call1()
            op_calz = 17
        Else
            Call COMMON.vZ80cpu.PCplus1()
            Call COMMON.vZ80cpu.PCplus1()
            op_calz = 10
        End If
    End Function 'CC    'op_calz
    Private Function op_call() As Integer                                       ' CALL                      'CD
        Call call1()
        op_call = 17
    End Function 'CD    'op_call
    Private Function op_calnc() As Integer                                      ' CALL NC,nn                'D4
        If Not (COMMON.vZ80cpu.F And COMMON.C_FLAG) = COMMON.C_FLAG Then
            Call call1()
            op_calnc = 17
        Else
            Call COMMON.vZ80cpu.PCplus1()
            Call COMMON.vZ80cpu.PCplus1()
            op_calnc = 10
        End If
    End Function 'D4    'op_calnc
    Private Function op_calc() As Integer                                       ' CALL C,nn                 'DC
        If (COMMON.vZ80cpu.F And COMMON.C_FLAG) = COMMON.C_FLAG Then
            Call call1()
            op_calc = 17
        Else
            Call COMMON.vZ80cpu.PCplus1()
            Call COMMON.vZ80cpu.PCplus1()
            op_calc = 10
        End If
    End Function 'DC    'op_calc
    Private Function op_calpo() As Integer                                      ' CALL PO,nn                'E4
        If Not (COMMON.vZ80cpu.F And COMMON.P_FLAG) = COMMON.P_FLAG Then
            Call call1()
            op_calpo = 17
        Else
            Call COMMON.vZ80cpu.PCplus1()
            Call COMMON.vZ80cpu.PCplus1()
            op_calpo = 10
        End If
    End Function 'E4    'op_calpo
    Private Function op_calpe() As Integer                                      ' CALL PE,nn                'EC
        If (COMMON.vZ80cpu.F And COMMON.P_FLAG) = COMMON.P_FLAG Then
            Call call1()
            op_calpe = 17
        Else
            Call COMMON.vZ80cpu.PCplus1()
            Call COMMON.vZ80cpu.PCplus1()
            op_calpe = 10
        End If
    End Function 'EC    'op_calpe
    Private Function op_calp() As Integer                                       ' CALL P,nn                 'F4
        If Not (COMMON.vZ80cpu.F And COMMON.S_FLAG) = COMMON.S_FLAG Then
            Call call1()
            op_calp = 17
        Else
            Call COMMON.vZ80cpu.PCplus1()
            Call COMMON.vZ80cpu.PCplus1()
            op_calp = 10
        End If
    End Function 'F4    'op_calp
    Private Function op_calm() As Integer                                       ' CALL M,nn                 'FC
        If (COMMON.vZ80cpu.F And COMMON.S_FLAG) = COMMON.S_FLAG Then
            Call call1()
            op_calm = 17
        Else
            Call COMMON.vZ80cpu.PCplus1()
            Call COMMON.vZ80cpu.PCplus1()
            op_calm = 10
        End If
    End Function 'FC    'op_calm
    Private Sub call1()
        Dim i As Integer

        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        Call COMMON.vZ80cpu.PCplus1() : i = COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.PC)
        Call COMMON.vZ80cpu.PCplus1() : i = i + COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.PC) * 256
        Call COMMON.vZ80cpu.PCplus1()
#If WANT_SPC0 = 1 Then
        If COMMON.vZ80cpu.STACK <= 0 Then COMMON.vZ80cpu.STACK = 65536
#End If
        COMMON.vZ80cpu.STACK = COMMON.vZ80cpu.STACK - 1
        COMMON.vZ80cpu.Speicher_schreiben_Byte(COMMON.vZ80cpu.STACK, COMMON.vZ80cpu.PC >> 8)  'shr
#If WANT_SPC0 = 1 Then
        If COMMON.vZ80cpu.STACK <= 0 Then COMMON.vZ80cpu.STACK = 65536
#End If
        COMMON.vZ80cpu.STACK = COMMON.vZ80cpu.STACK - 1
        COMMON.vZ80cpu.Speicher_schreiben_Byte(COMMON.vZ80cpu.STACK, COMMON.vZ80cpu.PC And &HFF)
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_STACK)
        COMMON.vZ80cpu.PC = i - 1
    End Sub ' call1
#End Region
#Region "RET"
    '------------------------------------
    Private Function op_retnz() As Integer                                      ' RET NZ                    'C0
        If Not (COMMON.vZ80cpu.F And COMMON.Z_FLAG) = COMMON.Z_FLAG Then
            Call ret1()
            op_retnz = 11
        Else
            op_retnz = 5
        End If
    End Function 'C0    'op_retnz
    Private Function op_retz() As Integer                                       ' RET Z                     'C8
        If (COMMON.vZ80cpu.F And COMMON.Z_FLAG) = COMMON.Z_FLAG Then
            Call ret1()
            op_retz = 11
        Else
            op_retz = 5
        End If
    End Function 'C8    'op_retz
    Private Function op_ret() As Integer                                        ' RET                       'C9
        Call ret1()
        op_ret = 10
    End Function 'C9    'op_ret
    Private Function op_retnc() As Integer                                      ' RET NC                    'D0
        If Not (COMMON.vZ80cpu.F And COMMON.C_FLAG) = COMMON.C_FLAG Then
            Call ret1()
            op_retnc = 11
        Else
            op_retnc = 5
        End If
    End Function 'D0    'op_retnc
    Private Function op_retc() As Integer                                       ' RET C                     'D8
        If (COMMON.vZ80cpu.F And COMMON.C_FLAG) = COMMON.C_FLAG Then
            Call ret1()
            op_retc = 11
        Else
            op_retc = 5
        End If
    End Function 'D8    'op_retc
    Private Function op_retpo() As Integer                                      ' RET PO                    'E0
        If Not (COMMON.vZ80cpu.F And COMMON.P_FLAG) = COMMON.P_FLAG Then
            Call ret1()
            op_retpo = 11
        Else
            op_retpo = 5
        End If
    End Function 'E0    'op_retpo
    Private Function op_retpe() As Integer                                      ' RET PE                    'E8
        If (COMMON.vZ80cpu.F And COMMON.P_FLAG) = COMMON.P_FLAG Then
            Call ret1()
            op_retpe = 11
        Else
            op_retpe = 5
        End If
    End Function 'E8    'op_retpe
    Private Function op_retp() As Integer                                       ' RET P                     'F0
        If Not (COMMON.vZ80cpu.F And COMMON.S_FLAG) = COMMON.S_FLAG Then
            Call ret1()
            op_retp = 11
        Else
            op_retp = 5
        End If
    End Function 'F0    'op_retp
    Private Function op_retm() As Integer                                       ' RET M                     'F8
        If (COMMON.vZ80cpu.F And COMMON.S_FLAG) = COMMON.S_FLAG Then
            Call ret1()
            op_retm = 11
        Else
            op_retm = 5
        End If
    End Function 'F8    'op_retm
    Private Sub ret1()
        Dim i As Integer

        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_STACK Or COMMON.CPU_MEMR)
        i = COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.STACK) : COMMON.vZ80cpu.STACK = COMMON.vZ80cpu.STACK + 1
#If WANT_SPC0 = 1 Then
        If COMMON.vZ80cpu.STACK >= 65536 Then COMMON.vZ80cpu.STACK = 0
#End If
        i = i + COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.STACK) * 256 : COMMON.vZ80cpu.STACK = COMMON.vZ80cpu.STACK + 1
        i = i - 1
#If WANT_SPC0 = 1 Then
        If COMMON.vZ80cpu.STACK >= 65536 Then COMMON.vZ80cpu.STACK = 0
#End If
        COMMON.vZ80cpu.PC = i
    End Sub ' ret1
#End Region
#Region "RST"
    '------------------------------------     'C7 CF D7 DF E7 EF F7 FF
    Private Function op_rst00() As Integer                                      ' RST 00                    'C7
        Call rst(&H0)
        op_rst00 = 11
    End Function 'C7    'op_rst00
    Private Function op_rst08() As Integer                                      ' RST 08                    'CF
        Call rst(&H8)
        op_rst08 = 11
    End Function 'CF    'op_rst08
    Private Function op_rst10() As Integer                                      ' RST 10                    'D7
        Call rst(&H10)
        op_rst10 = 11
    End Function 'D7    'op_rst10
    Private Function op_rst18() As Integer                                      ' RST 18                    'DF
        Call rst(&H18)
        op_rst18 = 11
    End Function 'DF    'op_rst18
    Private Function op_rst20() As Integer                                      ' RST 20                    'E7
        Call rst(&H20)
        op_rst20 = 11
    End Function 'E7    'op_rst20
    Private Function op_rst28() As Integer                                      ' RST 28                    'EF
        Call rst(&H28)
        op_rst28 = 11
    End Function 'EF    'op_rst28
    Private Function op_rst30() As Integer                                      ' RST 30                    'F7
        Call rst(&H30)
        op_rst30 = 11
    End Function 'F7    'op_rst30
    Private Function op_rst38() As Integer                                      ' RST 38                    'FF
        Call rst(&H38)
        op_rst38 = 11
    End Function 'FF    'op_rst38
    Private Sub rst(ByVal par1 As Byte)
#If WANT_SPC0 = 1 Then
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_STACK)
        If COMMON.vZ80cpu.STACK <= 0 Then
            COMMON.vZ80cpu.STACK = 65536
        End If
#End If
        COMMON.vZ80cpu.STACK = COMMON.vZ80cpu.STACK - 1
        COMMON.vZ80cpu.Speicher_schreiben_Byte(COMMON.vZ80cpu.STACK, COMMON.vZ80cpu.PC >> 8)    'shr
#If WANT_SPC0 = 1 Then
        If COMMON.vZ80cpu.STACK <= 0 Then
            COMMON.vZ80cpu.STACK = 65536
        End If
#End If
        COMMON.vZ80cpu.STACK = COMMON.vZ80cpu.STACK - 1
        COMMON.vZ80cpu.Speicher_schreiben_Byte(COMMON.vZ80cpu.STACK, COMMON.vZ80cpu.PC And &HFF)
        COMMON.vZ80cpu.PC = par1 - 1
    End Sub ' rst
#End Region

#Region "cpu"
    '==============
    Public Sub cpu()
        Dim op_f As ULong
#If WANT_TIM0 = 1 Then
        Dim t As ULong
#End If

        Try
            Do
#If FRONTPANEL0 = 1 Then
                '#                fp_led_address = PC - ram;
                '#                fp_led_data = *PC;
                '#                fp_sampleData();
#End If

#If BUS_8080 = 1 Then
                COMMON.vZ80cpu.cpu_bus = COMMON.CPU_WO Or COMMON.CPU_M1 Or COMMON.CPU_MEMR
#End If
#If FRONTPANEL0 = 1 Then
                '#                fp_clock += 7;
                '#                fp_sampleLightGroup(0,0);
#End If

#If HISIZE0 = 1 Then                                                            ' Write History
                Try
                    COMMON.vZ80cpu.his(COMMON.vZ80cpu.h_next).h_adr = COMMON.vZ80cpu.PC
                    COMMON.vZ80cpu.his(COMMON.vZ80cpu.h_next).h_af = (COMMON.vZ80cpu.A * 256) + COMMON.vZ80cpu.F
                    COMMON.vZ80cpu.his(COMMON.vZ80cpu.h_next).h_bc = (COMMON.vZ80cpu.B * 256) + COMMON.vZ80cpu.C
                    COMMON.vZ80cpu.his(COMMON.vZ80cpu.h_next).h_de = (COMMON.vZ80cpu.D * 256) + COMMON.vZ80cpu.E
                    COMMON.vZ80cpu.his(COMMON.vZ80cpu.h_next).h_hl = (COMMON.vZ80cpu.H * 256) + COMMON.vZ80cpu.L
                    COMMON.vZ80cpu.his(COMMON.vZ80cpu.h_next).h_ix = COMMON.vZ80cpu.IX
                    COMMON.vZ80cpu.his(COMMON.vZ80cpu.h_next).h_iy = COMMON.vZ80cpu.IY
                    COMMON.vZ80cpu.his(COMMON.vZ80cpu.h_next).h_sp = COMMON.vZ80cpu.STACK
                    COMMON.vZ80cpu.h_next = COMMON.vZ80cpu.h_next + 1
                    If COMMON.vZ80cpu.h_next = COMMON.HISIZE Then
                        COMMON.vZ80cpu.h_flag = 1
                        COMMON.vZ80cpu.h_next = 0
                    End If
                Catch ex As Exception
                    MsgBox("CPU1.CPU (vZ80cpu.h_next): " + ex.Message)
                End Try
#End If

#If WANT_TIM0 = 1 Then
                If COMMON.vZ80cpu.PC = COMMON.vZ80cpu.t_start And Not COMMON.vZ80cpu.t_flag Then
                    COMMON.vZ80cpu.t_flag = 1                                   ' switch measurement on
                    COMMON.vZ80cpu.t_states = 0                                 ' initialize counted T-states
                End If
#End If

#If WANT_INT = 1 Then                                                           ' CPU interrupt handling
                If COMMON.vZ80cpu.int_type Then                                         '# COMMON.vZ80cpu.int_type
                    Select Case COMMON.vZ80cpu.int_type                                 '# COMMON.vZ80cpu.int_type
                        Case INT_NMI                                            '       non maskerable interrupt
                            COMMON.vZ80cpu.int_type = COMMON.INT_NONE                   '# COMMON.vZ80cpu.int_type
                            COMMON.vZ80cpu.IFF = COMMON.vZ80cpu.IFF << 1
#If WANT_SPC0 = 1 Then
                            If COMMON.vZ80cpu.STACK <= 0 Then COMMON.vZ80cpu.STACK = 65536
#End If
                            COMMON.vZ80cpu.STACK = COMMON.vZ80cpu.STACK - 1
                            COMMON.vZ80cpu.Speicher_schreiben_Byte(COMMON.vZ80cpu.STACK, COMMON.vZ80cpu.PC >> 8)  'shr
#If WANT_SPC0 = 1 Then
                            If COMMON.vZ80cpu.STACK <= 0 Then COMMON.vZ80cpu.STACK = 65536
#End If
                            COMMON.vZ80cpu.STACK = COMMON.vZ80cpu.STACK - 1
                            COMMON.vZ80cpu.Speicher_schreiben_Byte(COMMON.vZ80cpu.STACK, COMMON.vZ80cpu.PC And &HFF)
                            COMMON.vZ80cpu.PC = &H66

                        Case INT_INT                                            '       maskerable interrupt
                            If (COMMON.vZ80cpu.IFF <> 3) Then
                            Else
                                COMMON.vZ80cpu.IFF = 0
                                Select Case COMMON.vZ80cpu.int_mode
                                    Case COMMON.INT_NONE
                                    Case COMMON.INT_NMI
                                        Haupt.intMode(COMMON.INT_NONE)
#If WANT_SPC0 = 1 Then
                                        If COMMON.vZ80cpu.STACK <= 0 Then COMMON.vZ80cpu.STACK = 65536
#End If
                                        COMMON.vZ80cpu.STACK = COMMON.vZ80cpu.STACK - 1
                                        COMMON.vZ80cpu.Speicher_schreiben_Byte(COMMON.vZ80cpu.STACK, COMMON.vZ80cpu.PC >> 8)  'shr
#If WANT_SPC0 = 1 Then
                                        If COMMON.vZ80cpu.STACK <= 0 Then COMMON.vZ80cpu.STACK = 65536
#End If
                                        COMMON.vZ80cpu.STACK = COMMON.vZ80cpu.STACK - 1
                                        COMMON.vZ80cpu.Speicher_schreiben_Byte(COMMON.vZ80cpu.STACK, COMMON.vZ80cpu.PC And &HFF)
                                        COMMON.vZ80cpu.PC = &H38
                                    Case COMMON.INT_INT
                                End Select
                            End If
                    End Select
                End If
#End If

#If WANT_TIM0 = 1 Then
                Try
                    'BMK next opcode                                                                ' ====================
                    op_f = op_sim(COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.PC)).Invoke     ' Next opcode execute!
                    '                                                                               ' ====================
                Catch ex As Exception
                    MsgBox("CPU1.CPU (op_sim(" + COMMON.vZ80cpu.PC + ")): " + ex.Message)
                End Try

                Try
                    Call COMMON.vZ80cpu.PCplus1()
                Catch ex As Exception
                    MsgBox("CPU1.CPU (vZ80cpu.PCplus1): " + ex.Message)
                End Try

                t = op_f

                'If Haupt.RegisterAnzeigen.Checked = True Then
                Call Haupt.PrintRegAkt()
                'End If

                '#		states = (*op_sim[*PC++]) ();	/* execute next opcode */
                '#		t += states;
#If FRONTPANEL0 = 1 Then
                '#		fp_clock += states;
#Else
'#		t += (*op_sim[*PC++]) ();
#End If
                '#		if (f_flag) then		/* adjust CPU speed */
                '#			if (t > tmax) then
                '#				timer.tv_sec = 0;
                '#				timer.tv_nsec = 10000000;
                '#				nanosleep(&timer, NULL);
                '#				t = 0;
                '#			endif
                '#		endif
#Else
                op_f
#End If

#If WANT_PCC0 = 1 Then                                                          ' check for PC overrun
                If COMMON.vZ80cpu.PC > 65535 Then COMMON.vZ80cpu.PC = 0
#End If
                Try
                    COMMON.vZ80cpu.R = COMMON.vZ80cpu.R + 1                     ' increment refresh register
                Catch ex As Exception
                    MsgBox("CPU1.CPU (vZ80cpu.R): " + ex.Message)
                End Try

#If WANT_TIM0 = 1 Then
                If COMMON.vZ80cpu.t_flag = 1 Then
                    Try
                        COMMON.vZ80cpu.t_states = COMMON.vZ80cpu.t_states + t   ' add T-states for this opcode
                    Catch ex As Exception
                        MsgBox("CPU1.CPU (vZ80cpu.t_states): " + ex.Message)
                    End Try

                    If COMMON.vZ80cpu.PC = COMMON.vZ80cpu.t_end Then            ' check for end address
                        COMMON.vZ80cpu.t_flag = 0                               ' if reached, switch measurement off
                    End If
                End If
#End If


#If WANT_GUI = 1 Then
                check_gui_break();
#End If

                Call System.Windows.Forms.Application.DoEvents()
            Loop While COMMON.vZ80cpu.cpu_state = COMMON.CONTIN_RUN

#If BUS_8080 = 1 Then
            COMMON.vZ80cpu.cpu_bus = COMMON.CPU_WO Or COMMON.CPU_M1 Or COMMON.CPU_MEMR
#End If

        Catch ex As Exception
            MsgBox("CPU1.CPU: " + ex.Message & vbCrLf &
                   "PC=" + COMMON.HexAnzeige_WordByte(COMMON.vZ80cpu.PC, "B") & vbCrLf &
                   "HL=" + COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.H) + COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.L) & vbCrLf &
                   "DE=" + COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.D) + COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.E) & vbCrLf &
                   "BC=" + COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.B) + COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.C)
                  )
        End Try
    End Sub ' cpu
#End Region

End Class ' CPU1
