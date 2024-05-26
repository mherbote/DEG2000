Imports DEG2000.Z80cpu

Module FDCB
    ' Like the function "cpu()" this one emulates 4 byte opcodes starting with 0xFD 0xCB

    Public Class op_fdcb
        Public op_sim(0 To 255) As opfuncp

        Public Sub New()
            op_sim(&H0) = New opfuncp(AddressOf trap_fdcb) : op_sim(&H1) = New opfuncp(AddressOf trap_fdcb) : op_sim(&H2) = New opfuncp(AddressOf trap_fdcb) : op_sim(&H3) = New opfuncp(AddressOf trap_fdcb)
            op_sim(&H4) = New opfuncp(AddressOf trap_fdcb) : op_sim(&H5) = New opfuncp(AddressOf trap_fdcb) : op_sim(&H6) = New opfuncp(AddressOf op_rlciyd) : op_sim(&H7) = New opfuncp(AddressOf trap_fdcb)
            op_sim(&H8) = New opfuncp(AddressOf trap_fdcb) : op_sim(&H9) = New opfuncp(AddressOf trap_fdcb) : op_sim(&HA) = New opfuncp(AddressOf trap_fdcb) : op_sim(&HB) = New opfuncp(AddressOf trap_fdcb)
            op_sim(&HC) = New opfuncp(AddressOf trap_fdcb) : op_sim(&HD) = New opfuncp(AddressOf trap_fdcb) : op_sim(&HE) = New opfuncp(AddressOf op_rrciyd) : op_sim(&HF) = New opfuncp(AddressOf trap_fdcb)

            op_sim(&H10) = New opfuncp(AddressOf trap_fdcb) : op_sim(&H11) = New opfuncp(AddressOf trap_fdcb) : op_sim(&H12) = New opfuncp(AddressOf trap_fdcb) : op_sim(&H13) = New opfuncp(AddressOf trap_fdcb)
            op_sim(&H14) = New opfuncp(AddressOf trap_fdcb) : op_sim(&H15) = New opfuncp(AddressOf trap_fdcb) : op_sim(&H16) = New opfuncp(AddressOf op_rliyd) : op_sim(&H17) = New opfuncp(AddressOf trap_fdcb)
            op_sim(&H18) = New opfuncp(AddressOf trap_fdcb) : op_sim(&H19) = New opfuncp(AddressOf trap_fdcb) : op_sim(&H1A) = New opfuncp(AddressOf trap_fdcb) : op_sim(&H1B) = New opfuncp(AddressOf trap_fdcb)
            op_sim(&H1C) = New opfuncp(AddressOf trap_fdcb) : op_sim(&H1D) = New opfuncp(AddressOf trap_fdcb) : op_sim(&H1E) = New opfuncp(AddressOf op_rriyd) : op_sim(&H1F) = New opfuncp(AddressOf trap_fdcb)

            op_sim(&H20) = New opfuncp(AddressOf trap_fdcb) : op_sim(&H21) = New opfuncp(AddressOf trap_fdcb) : op_sim(&H22) = New opfuncp(AddressOf trap_fdcb) : op_sim(&H23) = New opfuncp(AddressOf trap_fdcb)
            op_sim(&H24) = New opfuncp(AddressOf trap_fdcb) : op_sim(&H25) = New opfuncp(AddressOf trap_fdcb) : op_sim(&H26) = New opfuncp(AddressOf op_slaiyd) : op_sim(&H27) = New opfuncp(AddressOf trap_fdcb)
            op_sim(&H28) = New opfuncp(AddressOf trap_fdcb) : op_sim(&H29) = New opfuncp(AddressOf trap_fdcb) : op_sim(&H2A) = New opfuncp(AddressOf trap_fdcb) : op_sim(&H2B) = New opfuncp(AddressOf trap_fdcb)
            op_sim(&H2C) = New opfuncp(AddressOf trap_fdcb) : op_sim(&H2D) = New opfuncp(AddressOf trap_fdcb) : op_sim(&H2E) = New opfuncp(AddressOf op_sraiyd) : op_sim(&H2F) = New opfuncp(AddressOf trap_fdcb)

            op_sim(&H30) = New opfuncp(AddressOf trap_fdcb) : op_sim(&H31) = New opfuncp(AddressOf trap_fdcb) : op_sim(&H32) = New opfuncp(AddressOf trap_fdcb) : op_sim(&H33) = New opfuncp(AddressOf trap_fdcb)
            op_sim(&H34) = New opfuncp(AddressOf trap_fdcb) : op_sim(&H35) = New opfuncp(AddressOf trap_fdcb) : op_sim(&H36) = New opfuncp(AddressOf trap_fdcb) : op_sim(&H37) = New opfuncp(AddressOf trap_fdcb)
            op_sim(&H38) = New opfuncp(AddressOf trap_fdcb) : op_sim(&H39) = New opfuncp(AddressOf trap_fdcb) : op_sim(&H3A) = New opfuncp(AddressOf trap_fdcb) : op_sim(&H3B) = New opfuncp(AddressOf trap_fdcb)
            op_sim(&H3C) = New opfuncp(AddressOf trap_fdcb) : op_sim(&H3D) = New opfuncp(AddressOf trap_fdcb) : op_sim(&H3E) = New opfuncp(AddressOf op_srliyd) : op_sim(&H3F) = New opfuncp(AddressOf trap_fdcb)

            op_sim(&H40) = New opfuncp(AddressOf trap_fdcb) : op_sim(&H41) = New opfuncp(AddressOf trap_fdcb) : op_sim(&H42) = New opfuncp(AddressOf trap_fdcb) : op_sim(&H43) = New opfuncp(AddressOf trap_fdcb)
            op_sim(&H44) = New opfuncp(AddressOf trap_fdcb) : op_sim(&H45) = New opfuncp(AddressOf trap_fdcb) : op_sim(&H46) = New opfuncp(AddressOf op_tb0iyd) : op_sim(&H47) = New opfuncp(AddressOf trap_fdcb)
            op_sim(&H48) = New opfuncp(AddressOf trap_fdcb) : op_sim(&H49) = New opfuncp(AddressOf trap_fdcb) : op_sim(&H4A) = New opfuncp(AddressOf trap_fdcb) : op_sim(&H4B) = New opfuncp(AddressOf trap_fdcb)
            op_sim(&H4C) = New opfuncp(AddressOf trap_fdcb) : op_sim(&H4D) = New opfuncp(AddressOf trap_fdcb) : op_sim(&H4E) = New opfuncp(AddressOf op_tb1iyd) : op_sim(&H4F) = New opfuncp(AddressOf trap_fdcb)

            op_sim(&H50) = New opfuncp(AddressOf trap_fdcb) : op_sim(&H51) = New opfuncp(AddressOf trap_fdcb) : op_sim(&H52) = New opfuncp(AddressOf trap_fdcb) : op_sim(&H53) = New opfuncp(AddressOf trap_fdcb)
            op_sim(&H54) = New opfuncp(AddressOf trap_fdcb) : op_sim(&H55) = New opfuncp(AddressOf trap_fdcb) : op_sim(&H56) = New opfuncp(AddressOf op_tb2iyd) : op_sim(&H57) = New opfuncp(AddressOf trap_fdcb)
            op_sim(&H58) = New opfuncp(AddressOf trap_fdcb) : op_sim(&H59) = New opfuncp(AddressOf trap_fdcb) : op_sim(&H5A) = New opfuncp(AddressOf trap_fdcb) : op_sim(&H5B) = New opfuncp(AddressOf trap_fdcb)
            op_sim(&H5C) = New opfuncp(AddressOf trap_fdcb) : op_sim(&H5D) = New opfuncp(AddressOf trap_fdcb) : op_sim(&H5E) = New opfuncp(AddressOf op_tb3iyd) : op_sim(&H5F) = New opfuncp(AddressOf trap_fdcb)

            op_sim(&H60) = New opfuncp(AddressOf trap_fdcb) : op_sim(&H61) = New opfuncp(AddressOf trap_fdcb) : op_sim(&H62) = New opfuncp(AddressOf trap_fdcb) : op_sim(&H63) = New opfuncp(AddressOf trap_fdcb)
            op_sim(&H64) = New opfuncp(AddressOf trap_fdcb) : op_sim(&H65) = New opfuncp(AddressOf trap_fdcb) : op_sim(&H66) = New opfuncp(AddressOf op_tb4iyd) : op_sim(&H67) = New opfuncp(AddressOf trap_fdcb)
            op_sim(&H68) = New opfuncp(AddressOf trap_fdcb) : op_sim(&H69) = New opfuncp(AddressOf trap_fdcb) : op_sim(&H6A) = New opfuncp(AddressOf trap_fdcb) : op_sim(&H6B) = New opfuncp(AddressOf trap_fdcb)
            op_sim(&H6C) = New opfuncp(AddressOf trap_fdcb) : op_sim(&H6D) = New opfuncp(AddressOf trap_fdcb) : op_sim(&H6E) = New opfuncp(AddressOf op_tb5iyd) : op_sim(&H6F) = New opfuncp(AddressOf trap_fdcb)

            op_sim(&H70) = New opfuncp(AddressOf trap_fdcb) : op_sim(&H71) = New opfuncp(AddressOf trap_fdcb) : op_sim(&H72) = New opfuncp(AddressOf trap_fdcb) : op_sim(&H73) = New opfuncp(AddressOf trap_fdcb)
            op_sim(&H74) = New opfuncp(AddressOf trap_fdcb) : op_sim(&H75) = New opfuncp(AddressOf trap_fdcb) : op_sim(&H76) = New opfuncp(AddressOf op_tb6iyd) : op_sim(&H77) = New opfuncp(AddressOf trap_fdcb)
            op_sim(&H78) = New opfuncp(AddressOf trap_fdcb) : op_sim(&H79) = New opfuncp(AddressOf trap_fdcb) : op_sim(&H7A) = New opfuncp(AddressOf trap_fdcb) : op_sim(&H7B) = New opfuncp(AddressOf trap_fdcb)
            op_sim(&H7C) = New opfuncp(AddressOf trap_fdcb) : op_sim(&H7D) = New opfuncp(AddressOf trap_fdcb) : op_sim(&H7E) = New opfuncp(AddressOf op_tb7iyd) : op_sim(&H7F) = New opfuncp(AddressOf trap_fdcb)

            op_sim(&H80) = New opfuncp(AddressOf trap_fdcb) : op_sim(&H81) = New opfuncp(AddressOf trap_fdcb) : op_sim(&H82) = New opfuncp(AddressOf trap_fdcb) : op_sim(&H83) = New opfuncp(AddressOf trap_fdcb)
            op_sim(&H84) = New opfuncp(AddressOf trap_fdcb) : op_sim(&H85) = New opfuncp(AddressOf trap_fdcb) : op_sim(&H86) = New opfuncp(AddressOf op_rb0iyd) : op_sim(&H87) = New opfuncp(AddressOf trap_fdcb)
            op_sim(&H88) = New opfuncp(AddressOf trap_fdcb) : op_sim(&H89) = New opfuncp(AddressOf trap_fdcb) : op_sim(&H8A) = New opfuncp(AddressOf trap_fdcb) : op_sim(&H8B) = New opfuncp(AddressOf trap_fdcb)
            op_sim(&H8C) = New opfuncp(AddressOf trap_fdcb) : op_sim(&H8D) = New opfuncp(AddressOf trap_fdcb) : op_sim(&H8E) = New opfuncp(AddressOf op_rb1iyd) : op_sim(&H8F) = New opfuncp(AddressOf trap_fdcb)

            op_sim(&H90) = New opfuncp(AddressOf trap_fdcb) : op_sim(&H91) = New opfuncp(AddressOf trap_fdcb) : op_sim(&H92) = New opfuncp(AddressOf trap_fdcb) : op_sim(&H93) = New opfuncp(AddressOf trap_fdcb)
            op_sim(&H94) = New opfuncp(AddressOf trap_fdcb) : op_sim(&H95) = New opfuncp(AddressOf trap_fdcb) : op_sim(&H96) = New opfuncp(AddressOf op_rb2iyd) : op_sim(&H97) = New opfuncp(AddressOf trap_fdcb)
            op_sim(&H98) = New opfuncp(AddressOf trap_fdcb) : op_sim(&H99) = New opfuncp(AddressOf trap_fdcb) : op_sim(&H9A) = New opfuncp(AddressOf trap_fdcb) : op_sim(&H9B) = New opfuncp(AddressOf trap_fdcb)
            op_sim(&H9C) = New opfuncp(AddressOf trap_fdcb) : op_sim(&H9D) = New opfuncp(AddressOf trap_fdcb) : op_sim(&H9E) = New opfuncp(AddressOf op_rb3iyd) : op_sim(&H9F) = New opfuncp(AddressOf trap_fdcb)

            op_sim(&HA0) = New opfuncp(AddressOf trap_fdcb) : op_sim(&HA1) = New opfuncp(AddressOf trap_fdcb) : op_sim(&HA2) = New opfuncp(AddressOf trap_fdcb) : op_sim(&HA3) = New opfuncp(AddressOf trap_fdcb)
            op_sim(&HA4) = New opfuncp(AddressOf trap_fdcb) : op_sim(&HA5) = New opfuncp(AddressOf trap_fdcb) : op_sim(&HA6) = New opfuncp(AddressOf op_rb4iyd) : op_sim(&HA7) = New opfuncp(AddressOf trap_fdcb)
            op_sim(&HA8) = New opfuncp(AddressOf trap_fdcb) : op_sim(&HA9) = New opfuncp(AddressOf trap_fdcb) : op_sim(&HAA) = New opfuncp(AddressOf trap_fdcb) : op_sim(&HAB) = New opfuncp(AddressOf trap_fdcb)
            op_sim(&HAC) = New opfuncp(AddressOf trap_fdcb) : op_sim(&HAD) = New opfuncp(AddressOf trap_fdcb) : op_sim(&HAE) = New opfuncp(AddressOf op_rb5iyd) : op_sim(&HAF) = New opfuncp(AddressOf trap_fdcb)

            op_sim(&HB0) = New opfuncp(AddressOf trap_fdcb) : op_sim(&HB1) = New opfuncp(AddressOf trap_fdcb) : op_sim(&HB2) = New opfuncp(AddressOf trap_fdcb) : op_sim(&HB3) = New opfuncp(AddressOf trap_fdcb)
            op_sim(&HB4) = New opfuncp(AddressOf trap_fdcb) : op_sim(&HB5) = New opfuncp(AddressOf trap_fdcb) : op_sim(&HB6) = New opfuncp(AddressOf op_rb6iyd) : op_sim(&HB7) = New opfuncp(AddressOf trap_fdcb)
            op_sim(&HB8) = New opfuncp(AddressOf trap_fdcb) : op_sim(&HB9) = New opfuncp(AddressOf trap_fdcb) : op_sim(&HBA) = New opfuncp(AddressOf trap_fdcb) : op_sim(&HBB) = New opfuncp(AddressOf trap_fdcb)
            op_sim(&HBC) = New opfuncp(AddressOf trap_fdcb) : op_sim(&HBD) = New opfuncp(AddressOf trap_fdcb) : op_sim(&HBE) = New opfuncp(AddressOf op_rb7iyd) : op_sim(&HBF) = New opfuncp(AddressOf trap_fdcb)

            op_sim(&HC0) = New opfuncp(AddressOf trap_fdcb) : op_sim(&HC1) = New opfuncp(AddressOf trap_fdcb) : op_sim(&HC2) = New opfuncp(AddressOf trap_fdcb) : op_sim(&HC3) = New opfuncp(AddressOf trap_fdcb)
            op_sim(&HC4) = New opfuncp(AddressOf trap_fdcb) : op_sim(&HC5) = New opfuncp(AddressOf trap_fdcb) : op_sim(&HC6) = New opfuncp(AddressOf op_sb0iyd) : op_sim(&HC7) = New opfuncp(AddressOf trap_fdcb)
            op_sim(&HC8) = New opfuncp(AddressOf trap_fdcb) : op_sim(&HC9) = New opfuncp(AddressOf trap_fdcb) : op_sim(&HCA) = New opfuncp(AddressOf trap_fdcb) : op_sim(&HCB) = New opfuncp(AddressOf trap_fdcb)
            op_sim(&HCC) = New opfuncp(AddressOf trap_fdcb) : op_sim(&HCD) = New opfuncp(AddressOf trap_fdcb) : op_sim(&HCE) = New opfuncp(AddressOf op_sb1iyd) : op_sim(&HCF) = New opfuncp(AddressOf trap_fdcb)

            op_sim(&HD0) = New opfuncp(AddressOf trap_fdcb) : op_sim(&HD1) = New opfuncp(AddressOf trap_fdcb) : op_sim(&HD2) = New opfuncp(AddressOf trap_fdcb) : op_sim(&HD3) = New opfuncp(AddressOf trap_fdcb)
            op_sim(&HD4) = New opfuncp(AddressOf trap_fdcb) : op_sim(&HD5) = New opfuncp(AddressOf trap_fdcb) : op_sim(&HD6) = New opfuncp(AddressOf op_sb2iyd) : op_sim(&HD7) = New opfuncp(AddressOf trap_fdcb)
            op_sim(&HD8) = New opfuncp(AddressOf trap_fdcb) : op_sim(&HD9) = New opfuncp(AddressOf trap_fdcb) : op_sim(&HDA) = New opfuncp(AddressOf trap_fdcb) : op_sim(&HDB) = New opfuncp(AddressOf trap_fdcb)
            op_sim(&HDC) = New opfuncp(AddressOf trap_fdcb) : op_sim(&HDD) = New opfuncp(AddressOf trap_fdcb) : op_sim(&HDE) = New opfuncp(AddressOf op_sb3iyd) : op_sim(&HDF) = New opfuncp(AddressOf trap_fdcb)

            op_sim(&HE0) = New opfuncp(AddressOf trap_fdcb) : op_sim(&HE1) = New opfuncp(AddressOf trap_fdcb) : op_sim(&HE2) = New opfuncp(AddressOf trap_fdcb) : op_sim(&HE3) = New opfuncp(AddressOf trap_fdcb)
            op_sim(&HE4) = New opfuncp(AddressOf trap_fdcb) : op_sim(&HE5) = New opfuncp(AddressOf trap_fdcb) : op_sim(&HE6) = New opfuncp(AddressOf op_sb4iyd) : op_sim(&HE7) = New opfuncp(AddressOf trap_fdcb)
            op_sim(&HE8) = New opfuncp(AddressOf trap_fdcb) : op_sim(&HE9) = New opfuncp(AddressOf trap_fdcb) : op_sim(&HEA) = New opfuncp(AddressOf trap_fdcb) : op_sim(&HEB) = New opfuncp(AddressOf trap_fdcb)
            op_sim(&HEC) = New opfuncp(AddressOf trap_fdcb) : op_sim(&HED) = New opfuncp(AddressOf trap_fdcb) : op_sim(&HEE) = New opfuncp(AddressOf op_sb5iyd) : op_sim(&HEF) = New opfuncp(AddressOf trap_fdcb)

            op_sim(&HF0) = New opfuncp(AddressOf trap_fdcb) : op_sim(&HF1) = New opfuncp(AddressOf trap_fdcb) : op_sim(&HF2) = New opfuncp(AddressOf trap_fdcb) : op_sim(&HF3) = New opfuncp(AddressOf trap_fdcb)
            op_sim(&HF4) = New opfuncp(AddressOf trap_fdcb) : op_sim(&HF5) = New opfuncp(AddressOf trap_fdcb) : op_sim(&HF6) = New opfuncp(AddressOf op_sb6iyd) : op_sim(&HF7) = New opfuncp(AddressOf trap_fdcb)
            op_sim(&HF8) = New opfuncp(AddressOf trap_fdcb) : op_sim(&HF9) = New opfuncp(AddressOf trap_fdcb) : op_sim(&HFA) = New opfuncp(AddressOf trap_fdcb) : op_sim(&HFB) = New opfuncp(AddressOf trap_fdcb)
            op_sim(&HFC) = New opfuncp(AddressOf trap_fdcb) : op_sim(&HFD) = New opfuncp(AddressOf trap_fdcb) : op_sim(&HFE) = New opfuncp(AddressOf op_sb7iyd) : op_sim(&HFF) = New opfuncp(AddressOf trap_fdcb)
        End Sub ' New
    End Class ' op_fdcb

    Public op_fdcb1 As New op_fdcb

    '====================================
    ' This function traps all illegal opcodes following the initial 0xFD 0xCB of a 4 byte opcode.
    Private Function trap_fdcb(ByVal Data As Integer) As ULong
        Call Haupt.cpuError(COMMON.OPTRAP4)
        Call Haupt.cpuState(COMMON.STOPPED)
        trap_fdcb = 0
    End Function ' trap_fdcb

#Region "BIT i,(IY+d)"
    '------------------------------------
    Private Function op_tb0iyd(ByVal Data As Integer) As ULong                  '&H46         ' BIT 0,(IY+d)
        op_tb0iyd = tb(Data, 0)
    End Function '46    ' op_tb0iyd
    Private Function op_tb1iyd(ByVal Data As Integer) As ULong                  '&H4E         ' BIT 1,(IY+d)
        op_tb1iyd = tb(Data, 1)
    End Function '4E    ' op_tb1iyd
    Private Function op_tb2iyd(ByVal Data As Integer) As ULong                  '&H56         ' BIT 2,(IY+d)
        op_tb2iyd = tb(Data, 2)
    End Function '56    ' op_tb2iyd
    Private Function op_tb3iyd(ByVal Data As Integer) As ULong                  '&H5E         ' BIT 3,(IY+d)
        op_tb3iyd = tb(Data, 3)
    End Function '5E    ' op_tb3iyd
    Private Function op_tb4iyd(ByVal Data As Integer) As ULong                  '&H66         ' BIT 4,(IY+d)
        op_tb4iyd = tb(Data, 4)
    End Function '66    ' op_tb4iyd
    Private Function op_tb5iyd(ByVal Data As Integer) As ULong                  '&H6E         ' BIT 5,(IY+d)
        op_tb5iyd = tb(Data, 5)
    End Function '6E    ' op_tb5iyd
    Private Function op_tb6iyd(ByVal Data As Integer) As ULong                  '&H76         ' BIT 6,(IY+d)
        op_tb6iyd = tb(Data, 6)
    End Function '76    ' op_tb6iyd
    Private Function op_tb7iyd(ByVal Data As Integer) As ULong                  '&H7E         ' BIT 7,(IY+d)
        op_tb7iyd = tb(Data, 7)
    End Function '7E    ' op_tb7iyd
    Private Function tb(ByVal Data As Integer, ByVal Bit1 As Integer) As ULong
        Dim i As ULong
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        i = 2 ^ Bit1
        Call COMMON.vZ80cpu.FlagNflag2()
        COMMON.vZ80cpu.F = COMMON.vZ80cpu.F Or COMMON.H_FLAG
        If (COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.IY + Data) And i) = i Then
            COMMON.vZ80cpu.F = COMMON.vZ80cpu.F And Not (COMMON.Z_FLAG Or COMMON.P_FLAG)
        Else
            COMMON.vZ80cpu.F = COMMON.vZ80cpu.F Or (COMMON.Z_FLAG Or COMMON.P_FLAG)
        End If
        tb = 20
    End Function ' tb
#End Region
#Region "RES i,(IY+d)"
    '------------------------------------
    Private Function op_rb0iyd(ByVal Data As Integer) As ULong                  '&H86         ' RES 0,(IY+d)
        op_rb0iyd = rb(Data, 0)
    End Function '86    ' op_rb0iyd
    Private Function op_rb1iyd(ByVal Data As Integer) As ULong                  '&H8E         ' RES 1,(IY+d)
        op_rb1iyd = rb(Data, 1)
    End Function '8E    ' op_rb1iyd
    Private Function op_rb2iyd(ByVal Data As Integer) As ULong                  '&H96         ' RES 2,(IY+d)
        op_rb2iyd = rb(Data, 2)
    End Function '96    ' op_rb2iyd
    Private Function op_rb3iyd(ByVal Data As Integer) As ULong                  '&H9E         ' RES 3,(IY+d)
        op_rb3iyd = rb(Data, 3)
    End Function '9E    ' op_rb3iyd
    Private Function op_rb4iyd(ByVal Data As Integer) As ULong                  '&HA6         ' RES 4,(IY+d)
        op_rb4iyd = rb(Data, 4)
    End Function 'A6    ' op_rb4iyd
    Private Function op_rb5iyd(ByVal Data As Integer) As ULong                  '&HAE         ' RES 5,(IY+d)
        op_rb5iyd = rb(Data, 5)
    End Function 'AE    ' op_rb5iyd
    Private Function op_rb6iyd(ByVal Data As Integer) As ULong                  '&HB6         ' RES 6,(IY+d)
        op_rb6iyd = rb(Data, 6)
    End Function 'B6    ' op_rb6iyd
    Private Function op_rb7iyd(ByVal Data As Integer) As ULong                  '&HBE         ' RES 7,(IY+d)
        op_rb7iyd = rb(Data, 7)
    End Function 'BE    ' op_rb7iyd
    Private Function rb(ByVal data As Integer, ByVal Bit1 As Integer) As ULong
        Dim i As ULong
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        i = &HFF - 2 ^ Bit1
        COMMON.vZ80cpu.Speicher_schreiben_Byte(COMMON.vZ80cpu.IY + data, (COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.IY + data) And i))
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_NONE)
        rb = 23
    End Function ' rb
#End Region
#Region "SET i,(IY+d)"
    '------------------------------------
    Private Function op_sb0iyd(ByVal Data As Integer) As ULong                  '&HC6         ' SET 0,(IY+d)
        op_sb0iyd = sb(Data, 0)
    End Function 'C6    ' op_sb0iyd
    Private Function op_sb1iyd(ByVal Data As Integer) As ULong                  '&HCE         ' SET 1,(IY+d)
        op_sb1iyd = sb(Data, 1)
    End Function 'CE    ' op_sb1iyd
    Private Function op_sb2iyd(ByVal Data As Integer) As ULong                  '&HD6         ' SET 2,(IY+d)
        op_sb2iyd = sb(Data, 2)
    End Function 'D6    ' op_sb2iyd
    Private Function op_sb3iyd(ByVal Data As Integer) As ULong                  '&HDE         ' SET 3,(IY+d)
        op_sb3iyd = sb(Data, 3)
    End Function 'DE    ' op_sb3iyd
    Private Function op_sb4iyd(ByVal Data As Integer) As ULong                  '&HE6         ' SET 4,(IY+d)
        op_sb4iyd = sb(Data, 4)
    End Function 'E6    ' op_sb4iyd
    Private Function op_sb5iyd(ByVal Data As Integer) As ULong                  '&HEE         ' SET 5,(IY+d)
        op_sb5iyd = sb(Data, 5)
    End Function 'EE    ' op_sb5iyd
    Private Function op_sb6iyd(ByVal Data As Integer) As ULong                  '&HF6         ' SET 6,(IY+d)
        op_sb6iyd = sb(Data, 6)
    End Function 'F6    ' op_sb6iyd
    Private Function op_sb7iyd(ByVal Data As Integer) As ULong                  '&HFE         ' SET 7,(IY+d)
        op_sb7iyd = sb(Data, 7)
    End Function 'FE    ' op_sb7iyd
    Private Function sb(ByVal Data As Integer, ByVal Bit1 As Integer) As ULong
        Dim i As ULong
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        i = 2 ^ Bit1
        COMMON.vZ80cpu.Speicher_schreiben_Byte(COMMON.vZ80cpu.IY + Data, (COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.IY + Data) Or i))
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_NONE)
        sb = 23
    End Function ' sb
#End Region

#Region "RLC, RRC, RL, RR, SLA, SRA, SRL"
    Private Function op_rlciyd(ByVal Data As Integer) As ULong                  '&H06         ' RLC (IY+d)
        Dim i As Integer
        Dim p As Byte
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        p = COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.IY + Data)
        If (p And &H80) = &H80 Then i = 1 Else i = 0
        Call COMMON.vZ80cpu.FlagCflag1((i <> 0))
        COMMON.vZ80cpu.F = COMMON.vZ80cpu.F And Not (COMMON.H_FLAG Or COMMON.N_FLAG)
        p = p << 1
        p = p Or i
        COMMON.vZ80cpu.Speicher_schreiben_Byte(COMMON.vZ80cpu.IY + Data, p)

        Call COMMON.vZ80cpu.FlagZflag2(p <> 0)
        Call COMMON.vZ80cpu.FlagSflag1((p And &H80))
        Call COMMON.vZ80cpu.FlagPflag2(COMMON.vZ80cpu.parrity(p) = 1)
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_NONE)
        op_rlciyd = 23
    End Function '06    ' op_rlciyd
    Private Function op_rrciyd(ByVal Data As Integer) As ULong                  '&H0E         ' RRC (IY+d)
        Dim i As Integer
        Dim p As Byte
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        p = COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.IY + Data)
        If (p And &H1) = &H1 Then i = 1 Else i = 0
        Call COMMON.vZ80cpu.FlagCflag1(i <> 0)
        COMMON.vZ80cpu.F = COMMON.vZ80cpu.F And Not (COMMON.H_FLAG Or COMMON.N_FLAG)
        p = p >> 1
        If (i = 1) Then p = p Or &H80
        COMMON.vZ80cpu.Speicher_schreiben_Byte(COMMON.vZ80cpu.IY + Data, p)

        Call COMMON.vZ80cpu.FlagZflag2(p <> 0)
        Call COMMON.vZ80cpu.FlagSflag1((p And &H80))
        Call COMMON.vZ80cpu.FlagPflag2(COMMON.vZ80cpu.parrity(p) = 1)
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_NONE)
        op_rrciyd = 23
    End Function '0E    ' op_rrciyd
    Private Function op_rliyd(ByVal Data As Integer) As ULong                  '&H16         ' RL (IY+d)
        Dim old_c_flag As Integer
        Dim p As Byte
        Dim i As Integer
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        p = COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.IY + Data)
        old_c_flag = COMMON.vZ80cpu.F And COMMON.C_FLAG
        If (p And &H80) = &H80 Then i = 1 Else i = 0
        Call COMMON.vZ80cpu.FlagCflag1(i <> 0)
        p = p << 1
        If old_c_flag = 1 Then p = p Or 1
        COMMON.vZ80cpu.Speicher_schreiben_Byte(COMMON.vZ80cpu.IY + Data, p)

        COMMON.vZ80cpu.F = COMMON.vZ80cpu.F And Not (COMMON.H_FLAG Or COMMON.N_FLAG)
        Call COMMON.vZ80cpu.FlagZflag2(p <> 0)
        Call COMMON.vZ80cpu.FlagSflag1((p And &H80))
        Call COMMON.vZ80cpu.FlagPflag2(COMMON.vZ80cpu.parrity(p) = 1)
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_NONE)
        op_rliyd = 23
    End Function '16    ' op_rliyd
    Private Function op_rriyd(ByVal Data As Integer) As ULong                  '&H1E         ' RR (IY+d)
        Dim p As Byte
        Dim i As Integer
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        p = COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.IY + Data)
        If (p And &H1) = &H1 Then i = 1 Else i = 0
        Call COMMON.vZ80cpu.FlagCflag1(i <> 0)
        p = p >> 1
        If i = 1 Then p = p Or &H80
        COMMON.vZ80cpu.Speicher_schreiben_Byte(COMMON.vZ80cpu.IY + Data, p)
        COMMON.vZ80cpu.F = COMMON.vZ80cpu.F And Not (COMMON.H_FLAG Or COMMON.N_FLAG)
        Call COMMON.vZ80cpu.FlagZflag2(p <> 0)
        Call COMMON.vZ80cpu.FlagSflag1((p And &H80))
        Call COMMON.vZ80cpu.FlagPflag2(COMMON.vZ80cpu.parrity(p) = 1)
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_NONE)
        op_rriyd = 23
    End Function '1E    ' op_rriyd
    Private Function op_slaiyd(ByVal Data As Integer) As ULong                  '&H26         ' SLA (IY+d)
        Dim p As Byte
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        p = COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.IY + Data)
        Call COMMON.vZ80cpu.FlagCflag1((p And &H80))
        p = p << 1
        COMMON.vZ80cpu.Speicher_schreiben_Byte(COMMON.vZ80cpu.IY + Data, p)
        COMMON.vZ80cpu.F = COMMON.vZ80cpu.F And Not (COMMON.H_FLAG Or COMMON.N_FLAG)
        Call COMMON.vZ80cpu.FlagZflag2(p <> 0)
        Call COMMON.vZ80cpu.FlagSflag1((p And &H80))
        Call COMMON.vZ80cpu.FlagPflag2(COMMON.vZ80cpu.parrity(p) = 1)
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_NONE)
        op_slaiyd = 23
    End Function '26    ' op_slaiyd
    Private Function op_sraiyd(ByVal Data As Integer) As ULong                  '&H2E         ' SRA (IY+d)
        Dim i As Integer
        Dim p As Byte
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        p = COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.IY + Data) : i = p And &H80
        Call COMMON.vZ80cpu.FlagCflag1((p And &H1))
        p = p >> 1
        p = p Or i
        COMMON.vZ80cpu.Speicher_schreiben_Byte(COMMON.vZ80cpu.IY + Data, p)
        COMMON.vZ80cpu.F = COMMON.vZ80cpu.F And Not (COMMON.H_FLAG Or COMMON.N_FLAG)
        Call COMMON.vZ80cpu.FlagZflag2(p <> 0)
        Call COMMON.vZ80cpu.FlagSflag1((p And &H80))
        Call COMMON.vZ80cpu.FlagPflag2(COMMON.vZ80cpu.parrity(p) = 1)
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_NONE)
        op_sraiyd = 23
    End Function '2E    ' op_sraiyd
    Private Function op_srliyd(ByVal Data As Integer) As ULong                  '&H3E         ' SRL (IY+d)
        Dim p As Byte
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_WO Or COMMON.CPU_MEMR)
        p = COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.IY + Data)
        Call COMMON.vZ80cpu.FlagCflag1((p And &H1))
        p = p >> 1
        COMMON.vZ80cpu.Speicher_schreiben_Byte(COMMON.vZ80cpu.IY + Data, p)
        COMMON.vZ80cpu.F = COMMON.vZ80cpu.F And Not (COMMON.H_FLAG Or COMMON.N_FLAG)
        Call COMMON.vZ80cpu.FlagZflag2(p <> 0)
        Call COMMON.vZ80cpu.FlagSflag1((p And &H80))
        Call COMMON.vZ80cpu.FlagPflag2(COMMON.vZ80cpu.parrity(p) = 1)
        Call COMMON.vZ80cpu.busfront(COMMON.CPU_NONE)
        op_srliyd = 23
    End Function '3E    ' op_srliyd
#End Region

    '====================================
    Public Function op_fdcb_handel() As Integer
        Dim d As Integer
        Call COMMON.vZ80cpu.PCplus1() : d = COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.PC)
        Call COMMON.vZ80cpu.PCplus1() : op_fdcb_handel = op_fdcb1.op_sim(COMMON.vZ80cpu.Speicher_lesen_Byte(COMMON.vZ80cpu.PC)).Invoke(d)
    End Function ' op_fdcb_handel

End Module ' FDCB
