Module Disass

    Public Class optab
        Public fun(0 To 255) As Z80cpu.opfunc2
        Public txt(0 To 255) As String

        Public Sub New()
            fun(&H0) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H0) = "NOP  "          ' &H00
            fun(&H1) = New Z80cpu.opfunc2(AddressOf nnout) : txt(&H1) = "LD   BC,"       ' &H01
            fun(&H2) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H2) = "LD   (BC),A"    ' &H02
            fun(&H3) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H3) = "INC  BC"        ' &H03
            fun(&H4) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H4) = "INC  B"         ' &H04
            fun(&H5) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H5) = "DEC  B"         ' &H05
            fun(&H6) = New Z80cpu.opfunc2(AddressOf nout) : txt(&H6) = "LD   B,"         ' &H06
            fun(&H7) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H7) = "RLCA "          ' &H07
            fun(&H8) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H8) = "EX   AF,AF'"    ' &H08
            fun(&H9) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H9) = "ADD  HL,BC"     ' &H09
            fun(&HA) = New Z80cpu.opfunc2(AddressOf opout) : txt(&HA) = "LD   A,(BC)"    ' &H0A
            fun(&HB) = New Z80cpu.opfunc2(AddressOf opout) : txt(&HB) = "DEC  BC"        ' &H0B
            fun(&HC) = New Z80cpu.opfunc2(AddressOf opout) : txt(&HC) = "INC  C"         ' &H0C
            fun(&HD) = New Z80cpu.opfunc2(AddressOf opout) : txt(&HD) = "DEC  C"         ' &H0D
            fun(&HE) = New Z80cpu.opfunc2(AddressOf nout) : txt(&HE) = "LD   C,"         ' &H0E
            fun(&HF) = New Z80cpu.opfunc2(AddressOf opout) : txt(&HF) = "RRCA "          ' &H0F

            fun(&H10) = New Z80cpu.opfunc2(AddressOf rout) : txt(&H10) = "DJNZ  "        ' &H10
            fun(&H11) = New Z80cpu.opfunc2(AddressOf nnout) : txt(&H11) = "LD   DE,"     ' &H11
            fun(&H12) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H12) = "LD   (DE),A"  ' &H12
            fun(&H13) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H13) = "INC  DE"      ' &H13
            fun(&H14) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H14) = "INC  D"       ' &H14
            fun(&H15) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H15) = "DEC  D"       ' &H15
            fun(&H16) = New Z80cpu.opfunc2(AddressOf nout) : txt(&H16) = "LD   D,"       ' &H16
            fun(&H17) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H17) = "RLA  "        ' &H17
            fun(&H18) = New Z80cpu.opfunc2(AddressOf rout) : txt(&H18) = "JR   "         ' &H18
            fun(&H19) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H19) = "ADD  HL,DE"   ' &H19
            fun(&H1A) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H1A) = "LD   A,(DE)"  ' &H1A
            fun(&H1B) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H1B) = "DEC  DE"      ' &H1B
            fun(&H1C) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H1C) = "INC  E"       ' &H1C
            fun(&H1D) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H1D) = "DEC  E"       ' &H1D
            fun(&H1E) = New Z80cpu.opfunc2(AddressOf nout) : txt(&H1E) = "LD   E,"       ' &H1E
            fun(&H1F) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H1F) = "RRA  "        ' &H1F

            fun(&H20) = New Z80cpu.opfunc2(AddressOf rout) : txt(&H20) = "JR   NZ,"      ' &H20
            fun(&H21) = New Z80cpu.opfunc2(AddressOf nnout) : txt(&H21) = "LD   HL,"     ' &H21
            fun(&H22) = New Z80cpu.opfunc2(AddressOf inout1) : txt(&H22) = "LD   ("      ' &H22
            fun(&H23) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H23) = "INC  HL"      ' &H23
            fun(&H24) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H24) = "INC  H"       ' &H24
            fun(&H25) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H25) = "DEC  H"       ' &H25
            fun(&H26) = New Z80cpu.opfunc2(AddressOf nout) : txt(&H26) = "LD   H,"       ' &H26
            fun(&H27) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H27) = "DAA  "        ' &H27
            fun(&H28) = New Z80cpu.opfunc2(AddressOf rout) : txt(&H28) = "JR   Z"        ' &H28
            fun(&H29) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H29) = "ADD  HL,HL"   ' &H29
            fun(&H2A) = New Z80cpu.opfunc2(AddressOf inout2) : txt(&H2A) = "LD   HL,("   ' &H2A
            fun(&H2B) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H2B) = "DEC  HL"      ' &H2B
            fun(&H2C) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H2C) = "INC  L"       ' &H2C
            fun(&H2D) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H2D) = "DEC  L"       ' &H2D
            fun(&H2E) = New Z80cpu.opfunc2(AddressOf nout) : txt(&H2E) = "LD   L,"       ' &H2E
            fun(&H2F) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H2F) = "CPL  "        ' &H2F

            fun(&H30) = New Z80cpu.opfunc2(AddressOf rout) : txt(&H30) = "JR   NC,"      ' &H30
            fun(&H31) = New Z80cpu.opfunc2(AddressOf nnout) : txt(&H31) = "LD   SP,"     ' &H31
            fun(&H32) = New Z80cpu.opfunc2(AddressOf inout3) : txt(&H32) = "LD   ("      ' &H32
            fun(&H33) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H33) = "INC  SP"      ' &H33
            fun(&H34) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H34) = "INC  (HL)"    ' &H34
            fun(&H35) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H35) = "DEC  (HL)"    ' &H35
            fun(&H36) = New Z80cpu.opfunc2(AddressOf nout) : txt(&H36) = "LD   (HL),"    ' &H36
            fun(&H37) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H37) = "SCF   "       ' &H37
            fun(&H38) = New Z80cpu.opfunc2(AddressOf rout) : txt(&H38) = "JR   C,"       ' &H38
            fun(&H39) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H39) = "ADD  HL,SP"   ' &H39
            fun(&H3A) = New Z80cpu.opfunc2(AddressOf inout2) : txt(&H3A) = "LD   A,("    ' &H3A
            fun(&H3B) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H3B) = "DEC  SP"      ' &H3B
            fun(&H3C) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H3C) = "INC  A"       ' &H3C
            fun(&H3D) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H3D) = "DEC  A"       ' &H3D
            fun(&H3E) = New Z80cpu.opfunc2(AddressOf nout) : txt(&H3E) = "LD   A,"       ' &H3E
            fun(&H3F) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H3F) = "CCF  "        ' &H3F

            fun(&H40) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H40) = "LD   B,B"     ' &H40
            fun(&H41) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H41) = "LD   B,C"     ' &H41
            fun(&H42) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H42) = "LD   B,D"     ' &H42
            fun(&H43) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H43) = "LD   B,E"     ' &H43
            fun(&H44) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H44) = "LD   B,H"     ' &H44
            fun(&H45) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H45) = "LD   B,L"     ' &H45
            fun(&H46) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H46) = "LD   B,(HL)"  ' &H46
            fun(&H47) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H47) = "LD   B,A"     ' &H47
            fun(&H48) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H48) = "LD   C,B"     ' &H48
            fun(&H49) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H49) = "LD   C,C"     ' &H49
            fun(&H4A) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H4A) = "LD   C,D"     ' &H4A
            fun(&H4B) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H4B) = "LD   C,E"     ' &H4B
            fun(&H4C) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H4C) = "LD   C,H"     ' &H4C
            fun(&H4D) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H4D) = "LD   C,L"     ' &H4D
            fun(&H4E) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H4E) = "LD   C,(HL)"  ' &H4E
            fun(&H4F) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H4F) = "LD   C,A"     ' &H4F

            fun(&H50) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H50) = "LD   D,B"     ' &H50
            fun(&H51) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H51) = "LD   D,C"     ' &H51
            fun(&H52) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H52) = "LD   D,D"     ' &H52
            fun(&H53) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H53) = "LD   D,E"     ' &H53
            fun(&H54) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H54) = "LD   D,H"     ' &H54
            fun(&H55) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H55) = "LD   D,L"     ' &H55
            fun(&H56) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H56) = "LD   D,(HL)"  ' &H56
            fun(&H57) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H57) = "LD   D,A"     ' &H57
            fun(&H58) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H58) = "LD   E,B"     ' &H58
            fun(&H59) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H59) = "LD   E,C"     ' &H59
            fun(&H5A) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H5A) = "LD   E,D"     ' &H5A
            fun(&H5B) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H5B) = "LD   E,E"     ' &H5B
            fun(&H5C) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H5C) = "LD   E,H"     ' &H5C
            fun(&H5D) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H5D) = "LD   E,L"     ' &H5D
            fun(&H5E) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H5E) = "LD   E,(HL)"  ' &H5E
            fun(&H5F) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H5F) = "LD   E,A"     ' &H5F

            fun(&H60) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H60) = "LD   H,B"     ' &H60
            fun(&H61) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H61) = "LD   H,C"     ' &H61
            fun(&H62) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H62) = "LD   H,D"     ' &H62
            fun(&H63) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H63) = "LD   H,E"     ' &H63
            fun(&H64) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H64) = "LD   H,H"     ' &H64
            fun(&H65) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H65) = "LD   H,L"     ' &H65
            fun(&H66) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H66) = "LD   H,(HL)"  ' &H66
            fun(&H67) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H67) = "LD   H,A"     ' &H67
            fun(&H68) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H68) = "LD   L,B"     ' &H68
            fun(&H69) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H69) = "LD   L,C"     ' &H69
            fun(&H6A) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H6A) = "LD   L,D"     ' &H6A
            fun(&H6B) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H6B) = "LD   L,E"     ' &H6B
            fun(&H6C) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H6C) = "LD   L,H"     ' &H6C
            fun(&H6D) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H6D) = "LD   L,L"     ' &H6D
            fun(&H6E) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H6E) = "LD   L,(HL)"  ' &H6E
            fun(&H6F) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H6F) = "LD   L,A"     ' &H6F

            fun(&H70) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H70) = "LD   (HL),B"  ' &H70
            fun(&H71) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H71) = "LD   (HL),C"  ' &H71
            fun(&H72) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H72) = "LD   (HL),D"  ' &H72
            fun(&H73) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H73) = "LD   (HL),E"  ' &H73
            fun(&H74) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H74) = "LD   (HL),H"  ' &H74
            fun(&H75) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H75) = "LD   (HL),L"  ' &H75
            fun(&H76) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H76) = "HALT "        ' &H76
            fun(&H77) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H77) = "LD   (HL),A"  ' &H77
            fun(&H78) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H78) = "LD   A,B"     ' &H78
            fun(&H79) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H79) = "LD   A,C"     ' &H79
            fun(&H7A) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H7A) = "LD   A,D"     ' &H7A
            fun(&H7B) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H7B) = "LD   A,E"     ' &H7B
            fun(&H7C) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H7C) = "LD   A,H"     ' &H7C
            fun(&H7D) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H7D) = "LD   A,L"     ' &H7D
            fun(&H7E) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H7E) = "LD   A,(HL)"  ' &H7E
            fun(&H7F) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H7F) = "LD   A,A"     ' &H7F

            fun(&H80) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H80) = "ADD  A,B"     ' &H80
            fun(&H81) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H81) = "ADD  A,C"     ' &H81
            fun(&H82) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H82) = "ADD  A,D"     ' &H82
            fun(&H83) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H83) = "ADD  A,E"     ' &H83
            fun(&H84) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H84) = "ADD  A,H"     ' &H84
            fun(&H85) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H85) = "ADD  A,L"     ' &H85
            fun(&H86) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H86) = "ADD  A,(HL)"  ' &H86
            fun(&H87) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H87) = "ADD  A,A"     ' &H87
            fun(&H88) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H88) = "ADC  A,B"     ' &H88
            fun(&H89) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H89) = "ADC  A,C"     ' &H89
            fun(&H8A) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H8A) = "ADC  A,D"     ' &H8A
            fun(&H8B) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H8B) = "ADC  A,E"     ' &H8B
            fun(&H8C) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H8C) = "ADC  A,H"     ' &H8C
            fun(&H8D) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H8D) = "ADC  A,L"     ' &H8D
            fun(&H8E) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H8E) = "ADC  A,(HL)"  ' &H8E
            fun(&H8F) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H8F) = "ADC  A,A"     ' &H8F

            fun(&H90) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H90) = "SUB  B"       ' &H90
            fun(&H91) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H91) = "SUB  C"       ' &H91
            fun(&H92) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H92) = "SUB  D"       ' &H92
            fun(&H93) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H93) = "SUB  E"       ' &H93
            fun(&H94) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H94) = "SUB  H"       ' &H94
            fun(&H95) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H95) = "SUB  L"       ' &H95
            fun(&H96) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H96) = "SUB  (HL)"    ' &H96
            fun(&H97) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H97) = "SUB  A"       ' &H97
            fun(&H98) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H98) = "SBC  A,B"     ' &H98
            fun(&H99) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H99) = "SBC  A,C"     ' &H99
            fun(&H9A) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H9A) = "SBC  A,D"     ' &H9A
            fun(&H9B) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H9B) = "SBC  A,E"     ' &H9B
            fun(&H9C) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H9C) = "SBC  A,H"     ' &H9C
            fun(&H9D) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H9D) = "SBC  A,L"     ' &H9D
            fun(&H9E) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H9E) = "SBC  A,(HL)"  ' &H9E
            fun(&H9F) = New Z80cpu.opfunc2(AddressOf opout) : txt(&H9F) = "SBC  A,A"     ' &H9F

            fun(&HA0) = New Z80cpu.opfunc2(AddressOf opout) : txt(&HA0) = "AND  B"       ' &HA0
            fun(&HA1) = New Z80cpu.opfunc2(AddressOf opout) : txt(&HA1) = "AND  C"       ' &HA1
            fun(&HA2) = New Z80cpu.opfunc2(AddressOf opout) : txt(&HA2) = "AND  D"       ' &HA2
            fun(&HA3) = New Z80cpu.opfunc2(AddressOf opout) : txt(&HA3) = "AND  E"       ' &HA3
            fun(&HA4) = New Z80cpu.opfunc2(AddressOf opout) : txt(&HA4) = "AND  H"       ' &HA4
            fun(&HA5) = New Z80cpu.opfunc2(AddressOf opout) : txt(&HA5) = "AND  L"       ' &HA5
            fun(&HA6) = New Z80cpu.opfunc2(AddressOf opout) : txt(&HA6) = "AND  (HL)"    ' &HA6
            fun(&HA7) = New Z80cpu.opfunc2(AddressOf opout) : txt(&HA7) = "AND  A"       ' &HA7
            fun(&HA8) = New Z80cpu.opfunc2(AddressOf opout) : txt(&HA8) = "XOR  B"       ' &HA8
            fun(&HA9) = New Z80cpu.opfunc2(AddressOf opout) : txt(&HA9) = "XOR  C"       ' &HA9
            fun(&HAA) = New Z80cpu.opfunc2(AddressOf opout) : txt(&HAA) = "XOR  D"       ' &HAA
            fun(&HAB) = New Z80cpu.opfunc2(AddressOf opout) : txt(&HAB) = "XOR  E"       ' &HAB
            fun(&HAC) = New Z80cpu.opfunc2(AddressOf opout) : txt(&HAC) = "XOR  H"       ' &HAC
            fun(&HAD) = New Z80cpu.opfunc2(AddressOf opout) : txt(&HAD) = "XOR  L"       ' &HAD
            fun(&HAE) = New Z80cpu.opfunc2(AddressOf opout) : txt(&HAE) = "XOR  (HL)"    ' &HAE
            fun(&HAF) = New Z80cpu.opfunc2(AddressOf opout) : txt(&HAF) = "XOR  A"       ' &HAF

            fun(&HB0) = New Z80cpu.opfunc2(AddressOf opout) : txt(&HB0) = "OR   B"       ' &HB0
            fun(&HB1) = New Z80cpu.opfunc2(AddressOf opout) : txt(&HB1) = "OR   C"       ' &HB1
            fun(&HB2) = New Z80cpu.opfunc2(AddressOf opout) : txt(&HB2) = "OR   D"       ' &HB2
            fun(&HB3) = New Z80cpu.opfunc2(AddressOf opout) : txt(&HB3) = "OR   E"       ' &HB3
            fun(&HB4) = New Z80cpu.opfunc2(AddressOf opout) : txt(&HB4) = "OR   H"       ' &HB4
            fun(&HB5) = New Z80cpu.opfunc2(AddressOf opout) : txt(&HB5) = "OR   L"       ' &HB5
            fun(&HB6) = New Z80cpu.opfunc2(AddressOf opout) : txt(&HB6) = "OR   (HL)"    ' &HB6
            fun(&HB7) = New Z80cpu.opfunc2(AddressOf opout) : txt(&HB7) = "OR   A"       ' &HB7
            fun(&HB8) = New Z80cpu.opfunc2(AddressOf opout) : txt(&HB8) = "CP   B"       ' &HB8
            fun(&HB9) = New Z80cpu.opfunc2(AddressOf opout) : txt(&HB9) = "CP   C"       ' &HB9
            fun(&HBA) = New Z80cpu.opfunc2(AddressOf opout) : txt(&HBA) = "CP   D"       ' &HBA
            fun(&HBB) = New Z80cpu.opfunc2(AddressOf opout) : txt(&HBB) = "CP   E"       ' &HBB
            fun(&HBC) = New Z80cpu.opfunc2(AddressOf opout) : txt(&HBC) = "CP   H"       ' &HBC
            fun(&HBD) = New Z80cpu.opfunc2(AddressOf opout) : txt(&HBD) = "CP   L"       ' &HBD
            fun(&HBE) = New Z80cpu.opfunc2(AddressOf opout) : txt(&HBE) = "CP   (HL)"    ' &HBE
            fun(&HBF) = New Z80cpu.opfunc2(AddressOf opout) : txt(&HBF) = "CP   A"       ' &HBF

            fun(&HC0) = New Z80cpu.opfunc2(AddressOf opout) : txt(&HC0) = "RET  NZ"      ' &HC0
            fun(&HC1) = New Z80cpu.opfunc2(AddressOf opout) : txt(&HC1) = "POP  BC"      ' &HC1
            fun(&HC2) = New Z80cpu.opfunc2(AddressOf nnout) : txt(&HC2) = "JP   NZ,"     ' &HC2
            fun(&HC3) = New Z80cpu.opfunc2(AddressOf nnout) : txt(&HC3) = "JP   "        ' &HC3
            fun(&HC4) = New Z80cpu.opfunc2(AddressOf nnout) : txt(&HC4) = "CALL NZ,"     ' &HC4
            fun(&HC5) = New Z80cpu.opfunc2(AddressOf opout) : txt(&HC5) = "PUSH BC"      ' &HC5
            fun(&HC6) = New Z80cpu.opfunc2(AddressOf nout) : txt(&HC6) = "ADD  A,"       ' &HC6
            fun(&HC7) = New Z80cpu.opfunc2(AddressOf opout) : txt(&HC7) = "RST  0"       ' &HC7
            fun(&HC8) = New Z80cpu.opfunc2(AddressOf opout) : txt(&HC8) = "RET  Z"       ' &HC8
            fun(&HC9) = New Z80cpu.opfunc2(AddressOf opout) : txt(&HC9) = "RET  "        ' &HC9
            fun(&HCA) = New Z80cpu.opfunc2(AddressOf nnout) : txt(&HCA) = "JP   Z,"      ' &HCA
            fun(&HCB) = New Z80cpu.opfunc2(AddressOf cbop) : txt(&HCB) = ""              ' &HCB
            fun(&HCC) = New Z80cpu.opfunc2(AddressOf nnout) : txt(&HCC) = "CALL Z,"      ' &HCC
            fun(&HCD) = New Z80cpu.opfunc2(AddressOf nnout) : txt(&HCD) = "CALL "        ' &HCD
            fun(&HCE) = New Z80cpu.opfunc2(AddressOf nout) : txt(&HCE) = "ADC  A,"       ' &HCE
            fun(&HCF) = New Z80cpu.opfunc2(AddressOf opout) : txt(&HCF) = "RST  8"       ' &HCF

            fun(&HD0) = New Z80cpu.opfunc2(AddressOf opout) : txt(&HD0) = "RET  NC"      ' &HD0
            fun(&HD1) = New Z80cpu.opfunc2(AddressOf opout) : txt(&HD1) = "POP  DE"      ' &HD1
            fun(&HD2) = New Z80cpu.opfunc2(AddressOf nnout) : txt(&HD2) = "JP   NC,"     ' &HD2
            fun(&HD3) = New Z80cpu.opfunc2(AddressOf iout1) : txt(&HD3) = "OUT  ("       ' &HD3
            fun(&HD4) = New Z80cpu.opfunc2(AddressOf nnout) : txt(&HD4) = "CALL NC,"     ' &HD4
            fun(&HD5) = New Z80cpu.opfunc2(AddressOf opout) : txt(&HD5) = "PUSH DE"      ' &HD5
            fun(&HD6) = New Z80cpu.opfunc2(AddressOf nout) : txt(&HD6) = "SUB  "         ' &HD6
            fun(&HD7) = New Z80cpu.opfunc2(AddressOf opout) : txt(&HD7) = "RST  10"      ' &HD7
            fun(&HD8) = New Z80cpu.opfunc2(AddressOf opout) : txt(&HD8) = "RET  C"       ' &HD8
            fun(&HD9) = New Z80cpu.opfunc2(AddressOf opout) : txt(&HD9) = "EXX  "        ' &HD9
            fun(&HDA) = New Z80cpu.opfunc2(AddressOf nnout) : txt(&HDA) = "JP   C,"      ' &HDA
            fun(&HDB) = New Z80cpu.opfunc2(AddressOf iout2) : txt(&HDB) = "IN   A,("     ' &HDB
            fun(&HDC) = New Z80cpu.opfunc2(AddressOf nnout) : txt(&HDC) = "CALL C,"      ' &HDC
            fun(&HDD) = New Z80cpu.opfunc2(AddressOf ddfd) : txt(&HDD) = ""              ' &HDD
            fun(&HDE) = New Z80cpu.opfunc2(AddressOf nout) : txt(&HDE) = "SBC  A,"       ' &HDE
            fun(&HDF) = New Z80cpu.opfunc2(AddressOf opout) : txt(&HDF) = "RST  18"      ' &HDF

            fun(&HE0) = New Z80cpu.opfunc2(AddressOf opout) : txt(&HE0) = "RET  PO"      ' &HE0
            fun(&HE1) = New Z80cpu.opfunc2(AddressOf opout) : txt(&HE1) = "POP  HL"      ' &HE1
            fun(&HE2) = New Z80cpu.opfunc2(AddressOf nnout) : txt(&HE2) = "JP   PO,"     ' &HE2
            fun(&HE3) = New Z80cpu.opfunc2(AddressOf opout) : txt(&HE3) = "EX   (SP),HL" ' &HE3
            fun(&HE4) = New Z80cpu.opfunc2(AddressOf nnout) : txt(&HE4) = "CALL PO,"     ' &HE4
            fun(&HE5) = New Z80cpu.opfunc2(AddressOf opout) : txt(&HE5) = "PUSH HL"      ' &HE5
            fun(&HE6) = New Z80cpu.opfunc2(AddressOf nout) : txt(&HE6) = "AND  "         ' &HE6
            fun(&HE7) = New Z80cpu.opfunc2(AddressOf opout) : txt(&HE7) = "RST  20"      ' &HE7
            fun(&HE8) = New Z80cpu.opfunc2(AddressOf opout) : txt(&HE8) = "RET  PE"      ' &HE8
            fun(&HE9) = New Z80cpu.opfunc2(AddressOf opout) : txt(&HE9) = "JP   (HL)"    ' &HE9
            fun(&HEA) = New Z80cpu.opfunc2(AddressOf nnout) : txt(&HEA) = "JP   PE,"     ' &HEA
            fun(&HEB) = New Z80cpu.opfunc2(AddressOf opout) : txt(&HEB) = "EX   DE,HL"   ' &HEB
            fun(&HEC) = New Z80cpu.opfunc2(AddressOf nnout) : txt(&HEC) = "CALL PE,"     ' &HEC
            fun(&HED) = New Z80cpu.opfunc2(AddressOf edop) : txt(&HED) = ""              ' &HED
            fun(&HEE) = New Z80cpu.opfunc2(AddressOf nout) : txt(&HEE) = "XOR  "         ' &HEE
            fun(&HEF) = New Z80cpu.opfunc2(AddressOf opout) : txt(&HEF) = "RST  28"      ' &HEF

            fun(&HF0) = New Z80cpu.opfunc2(AddressOf opout) : txt(&HF0) = "RET  P"       ' &HF0
            fun(&HF1) = New Z80cpu.opfunc2(AddressOf opout) : txt(&HF1) = "POP  AF"      ' &HF1
            fun(&HF2) = New Z80cpu.opfunc2(AddressOf nnout) : txt(&HF2) = "JP   P,"      ' &HF2
            fun(&HF3) = New Z80cpu.opfunc2(AddressOf opout) : txt(&HF3) = "DI   "        ' &HF3
            fun(&HF4) = New Z80cpu.opfunc2(AddressOf nnout) : txt(&HF4) = "CALL P,"      ' &HF4
            fun(&HF5) = New Z80cpu.opfunc2(AddressOf opout) : txt(&HF5) = "PUSH AF"      ' &HF5
            fun(&HF6) = New Z80cpu.opfunc2(AddressOf nout) : txt(&HF6) = "OR   "         ' &HF6
            fun(&HF7) = New Z80cpu.opfunc2(AddressOf opout) : txt(&HF7) = "RST  30"      ' &HF7
            fun(&HF8) = New Z80cpu.opfunc2(AddressOf opout) : txt(&HF8) = "RET  M"       ' &HF8
            fun(&HF9) = New Z80cpu.opfunc2(AddressOf opout) : txt(&HF9) = "LD   SP,HL"   ' &HF9
            fun(&HFA) = New Z80cpu.opfunc2(AddressOf nnout) : txt(&HFA) = "JP   M,"      ' &HFA
            fun(&HFB) = New Z80cpu.opfunc2(AddressOf opout) : txt(&HFB) = "EI   "        ' &HFB
            fun(&HFC) = New Z80cpu.opfunc2(AddressOf nnout) : txt(&HFC) = "CALL M,"      ' &HFC
            fun(&HFD) = New Z80cpu.opfunc2(AddressOf ddfd) : txt(&HFD) = ""              ' &HFD
            fun(&HFE) = New Z80cpu.opfunc2(AddressOf nout) : txt(&HFE) = "CP   "         ' &HFE
            fun(&HFF) = New Z80cpu.opfunc2(AddressOf opout) : txt(&HFF) = "RST  38"      ' &HFF
        End Sub ' New
    End Class 'optab

    Public Class regClass
        Public r(0 To 7) As String
        Public Sub New()
            r(0) = "B"
            r(1) = "C"
            r(2) = "D"
            r(3) = "E"
            r(4) = "H"
            r(5) = "L"
            r(6) = "(HL)"
            r(7) = "A"
        End Sub
    End Class ' regClass

    Private Const unknown As String = "???"
    Private Const regix As String = "IX"
    Private Const regiy As String = "IY"

    Private Voptab As New optab
    Private VregClass As New regClass

    Private addr As Integer
    Private op_f As Z80cpu.opfunc2
    Private s As String

    Function disass(ByVal adr As ULong) As ULong
        '                                                                       The procedure disass() is the only global procedure of this module.
        '                                                                       The first argument is a pointer to a unsigned char pointer, which points
        '                                                                       to the op-code to disassemble. The output of the disassembly goes
        '                                                                       to stdout, terminated by a newline. After the disassembly the pointer to 
        '                                                                       the op-code will be increased by the size of the op-code, so that
        '                                                                       disass() can be called again.
        '                                                                       The second argument is the (Z80) address of the op-code to disassemble.
        '                                                                       It is used to calculate the destination address of relative jumps.
        Dim len1 As ULong

        addr = adr
        op_f = Voptab.fun(COMMON.vZ80cpu.Speicher_lesen_Byte(adr))
        s = ""
        s = s + COMMON.vZ80cpu.HexAnzeigeWordByte(adr, "B") + " "
        s = s + Voptab.txt(COMMON.vZ80cpu.Speicher_lesen_Byte(adr))
        len1 = op_f(s, adr)
        disass = adr + len1
    End Function ' disass

    'disassemble 1 byte op-codes 
    Private Function opout(ByRef s As String, ByVal p As UInt16) As ULong
        Call COMMON.PrintGrid(Haupt.CMDliste, {s})
        opout = 1
    End Function ' opout

    'disassemble 2 byte op-codes of type "Op n" 
    Private Function nout(ByRef s As String, ByVal p As UInt16) As ULong
        Call COMMON.PrintGrid(Haupt.CMDliste, {s + COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.Speicher_lesen_Byte(p + 1))})
        nout = 2
    End Function ' nout

    'disassemble 2 byte op-codes with indirect addressing 
    Private Function iout1(ByRef s As String, ByVal p As UInt16) As ULong
        Call COMMON.PrintGrid(Haupt.CMDliste, {s + COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.Speicher_lesen_Byte(p + 1)) + "),A"})
        iout1 = 2
    End Function ' iout1
    Private Function iout2(ByRef s As String, ByVal p As UInt16) As ULong
        Call COMMON.PrintGrid(Haupt.CMDliste, {s + COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.Speicher_lesen_Byte(p + 1)) + ")"})
        iout2 = 2
    End Function ' iout2

    'disassemble 2 byte op-codes with relative addressing
    Private Function rout(ByRef s As String, ByVal p As UInt16) As ULong
        Dim i As SByte

        i = COMMON.Byte2SByte(COMMON.vZ80cpu.Speicher_lesen_Byte(p + 1))
        Call COMMON.PrintGrid(Haupt.CMDliste, {s + COMMON.HexAnzeige_WordByte(addr + i + 2, "B")})
        rout = 2
    End Function ' rout

    'disassemble 3 byte op-codes of type "Op nn"
    Private Function nnout(ByRef s As String, ByVal p As UInt16) As ULong
        Dim i As Integer

        i = COMMON.vZ80cpu.Speicher_lesen_Byte(p + 1) + (COMMON.vZ80cpu.Speicher_lesen_Byte(p + 2) * 256)         'shl 8)
        Call COMMON.PrintGrid(Haupt.CMDliste, {s + COMMON.HexAnzeige_WordByte(i, "B")})
        nnout = 3
    End Function ' nnout

    'disassemble 3 byte op-codes with indirect addressing
    Private Function inout1(ByRef s As String, ByVal p As UInt16) As ULong
        Dim i As Integer
        i = COMMON.vZ80cpu.Speicher_lesen_Byte(p + 1) + (COMMON.vZ80cpu.Speicher_lesen_Byte(p + 2) * 256)   ' shl 8)
        Call COMMON.PrintGrid(Haupt.CMDliste, {s + COMMON.HexAnzeige_WordByte(i, "B") + "),HL"})
        inout1 = 3
    End Function ' inout1
    Private Function inout2(ByRef s As String, ByVal p As UInt16) As ULong
        Dim i As Integer
        i = COMMON.vZ80cpu.Speicher_lesen_Byte(p + 1) + (COMMON.vZ80cpu.Speicher_lesen_Byte(p + 2) * 256) 'shl 8)
        Call COMMON.PrintGrid(Haupt.CMDliste, {s + COMMON.HexAnzeige_WordByte(i, "B") + ")"})
        inout2 = 3
    End Function ' inout2
    Private Function inout3(ByRef s As String, ByVal p As UInt16) As ULong
        Dim i As Integer
        i = COMMON.vZ80cpu.Speicher_lesen_Byte(p + 1) + (COMMON.vZ80cpu.Speicher_lesen_Byte(p + 2) * 256) 'shl 8)
        Call COMMON.PrintGrid(Haupt.CMDliste, {s + COMMON.HexAnzeige_WordByte(i, "B") + "),A"})
        inout3 = 3
    End Function ' inout3


    'disassemble multi byte op-codes with prefix &HCB
    Private Function cbop(ByRef s As String, ByVal p As UInt16) As ULong
        Dim b2 As Integer

        b2 = COMMON.vZ80cpu.Speicher_lesen_Byte(p + 1)
        '
        '
        If b2 >= &H0 And b2 <= &H7 Then
            Call COMMON.PrintGrid(Haupt.CMDliste, {s + "RLC  " + VregClass.r(b2 And 7)})
            GoTo ende
        ElseIf b2 >= &H8 And b2 <= &HF Then
            Call COMMON.PrintGrid(Haupt.CMDliste, {s + "RRC  " + VregClass.r(b2 And 7)})
            GoTo ende
            '
        ElseIf b2 >= &H10 And b2 <= &H17 Then
            Call COMMON.PrintGrid(Haupt.CMDliste, {s + "RL   " + VregClass.r(b2 And 7)})
            GoTo ende
        ElseIf b2 >= &H18 And b2 <= &H1F Then
            Call COMMON.PrintGrid(Haupt.CMDliste, {s + "RR   " + VregClass.r(b2 And 7)})
            GoTo ende
            '
            '
        ElseIf b2 >= &H20 And b2 <= &H27 Then
            Call COMMON.PrintGrid(Haupt.CMDliste, {s + "SLA   " + VregClass.r(b2 And 7)})
            GoTo ende
            '
        ElseIf b2 >= &H28 And b2 <= &H2F Then
            Call COMMON.PrintGrid(Haupt.CMDliste, {s + "SRA   " + VregClass.r(b2 And 7)})
            GoTo ende
            '
            '
        ElseIf b2 >= &H38 And b2 <= &H3F Then
            Call COMMON.PrintGrid(Haupt.CMDliste, {s + "SRL   " + VregClass.r(b2 And 7)})
            GoTo ende
            '
            '
        ElseIf b2 >= &H40 And b2 <= &H7F Then
            Call COMMON.PrintGrid(Haupt.CMDliste, {s + "BIT   " + Chr(((b2 \ 2 ^ 3) And 7) + Asc("0")) + "," + VregClass.r(b2 And 7)})
            GoTo ende
            '
            '
        ElseIf b2 >= &H80 And b2 <= &HBF Then
            Call COMMON.PrintGrid(Haupt.CMDliste, {s + "RES   " + Chr(((b2 \ 2 ^ 3) And 7) + Asc("0")) + "," + VregClass.r(b2 And 7)})
            GoTo ende
            '
            '
        ElseIf b2 >= &HC0 Then
            Call COMMON.PrintGrid(Haupt.CMDliste, {s + "SET   " + Chr(((b2 \ 2 ^ 3) And 7) + Asc("0")) + "," + VregClass.r(b2 And 7)})
            GoTo ende
        End If
        '
        Call COMMON.PrintGrid(Haupt.CMDliste, {s + unknown})
ende:
        cbop = 2
    End Function ' cbop

    'disassemble multi byte op-codes with prefix &HED
    Private Function edop(ByRef s As String, ByVal p As UInt16) As ULong
        Dim b2, i As Integer
        Dim len1 As Integer

        len1 = 2
        b2 = COMMON.vZ80cpu.Speicher_lesen_Byte(p + 1)
        Select Case b2
            Case &H40
                Call COMMON.PrintGrid(Haupt.CMDliste, {s + "IN   B,(C)"})
            Case &H41
                Call COMMON.PrintGrid(Haupt.CMDliste, {s + "OUT  (C),B"})
            Case &H42
                Call COMMON.PrintGrid(Haupt.CMDliste, {s + "SBC  HL,BC"})
            Case &H43
                i = COMMON.vZ80cpu.Speicher_lesen_Byte(p + 2) + (COMMON.vZ80cpu.Speicher_lesen_Byte(p + 3) * 256) 'shl 8)
                Call COMMON.PrintGrid(Haupt.CMDliste, {s + "LD   (" + COMMON.HexAnzeige_WordByte(i, "B") + "),BC"})
                len1 = 4
            Case &H44
                Call COMMON.PrintGrid(Haupt.CMDliste, {s + "NEG  "})
            Case &H45
                Call COMMON.PrintGrid(Haupt.CMDliste, {s + "RETN "})
            Case &H46
                Call COMMON.PrintGrid(Haupt.CMDliste, {s + "IM   0"})
            Case &H47
                Call COMMON.PrintGrid(Haupt.CMDliste, {s + "LD   I,A"})
            Case &H48
                Call COMMON.PrintGrid(Haupt.CMDliste, {s + "IN   C,(C)"})
            Case &H49
                Call COMMON.PrintGrid(Haupt.CMDliste, {s + "OUT  (C),C"})
            Case &H4A
                Call COMMON.PrintGrid(Haupt.CMDliste, {s + "ADC  HL,BC"})
            Case &H4B
                i = COMMON.vZ80cpu.Speicher_lesen_Byte(p + 2) + (COMMON.vZ80cpu.Speicher_lesen_Byte(p + 3) * 256) 'shl 8);
                Call COMMON.PrintGrid(Haupt.CMDliste, {s + "LD   BC,(" + COMMON.HexAnzeige_WordByte(i, "B") + ")"})
                len1 = 4
            Case &H4D
                Call COMMON.PrintGrid(Haupt.CMDliste, {s + "RETI "})
            Case &H4F
                Call COMMON.PrintGrid(Haupt.CMDliste, {s + "LD   R,A"})
                '
            Case &H50
                Call COMMON.PrintGrid(Haupt.CMDliste, {s + "IN   D,(C)"})
            Case &H51
                Call COMMON.PrintGrid(Haupt.CMDliste, {s + "OUT  (C),D"})
            Case &H52
                Call COMMON.PrintGrid(Haupt.CMDliste, {s + "SBC  HL,DE"})
            Case &H53
                i = COMMON.vZ80cpu.Speicher_lesen_Byte(p + 2) + (COMMON.vZ80cpu.Speicher_lesen_Byte(p + 3) * 256) 'shl 8)
                Call COMMON.PrintGrid(Haupt.CMDliste, {s + "LD   (" + COMMON.HexAnzeige_WordByte(i, "B") + "),DE"})
                len1 = 4
            Case &H56
                Call COMMON.PrintGrid(Haupt.CMDliste, {s + "IM   1"})
            Case &H57
                Call COMMON.PrintGrid(Haupt.CMDliste, {s + "LD   A,I"})
            Case &H58
                Call COMMON.PrintGrid(Haupt.CMDliste, {s + "IN   E,(C)"})
            Case &H59
                Call COMMON.PrintGrid(Haupt.CMDliste, {s + "OUT  (C),E"})
            Case &H5A
                Call COMMON.PrintGrid(Haupt.CMDliste, {s + "ADC  HL,DE"})
            Case &H5B
                i = COMMON.vZ80cpu.Speicher_lesen_Byte(p + 2) + (COMMON.vZ80cpu.Speicher_lesen_Byte(p + 3) * 256) 'shl 8);
                Call COMMON.PrintGrid(Haupt.CMDliste, {s + "LD   DE,(" + COMMON.HexAnzeige_WordByte(i, "B") + ")"})
                len1 = 4
            Case &H5E
                Call COMMON.PrintGrid(Haupt.CMDliste, {s + "IM   2"})
            Case &H5F
                Call COMMON.PrintGrid(Haupt.CMDliste, {s + "LD   A,R"})
                '
            Case &H60
                Call COMMON.PrintGrid(Haupt.CMDliste, {s + "IN   H,(C)"})
            Case &H61
                Call COMMON.PrintGrid(Haupt.CMDliste, {s + "OUT  (C),H"})
            Case &H62
                Call COMMON.PrintGrid(Haupt.CMDliste, {s + "SBC  HL,HL"})
            Case &H67
                Call COMMON.PrintGrid(Haupt.CMDliste, {s + "RRD  "})
            Case &H68
                Call COMMON.PrintGrid(Haupt.CMDliste, {s + "IN   L,(C)"})
            Case &H69
                Call COMMON.PrintGrid(Haupt.CMDliste, {s + "OUT  (C),L"})
            Case &H6A
                Call COMMON.PrintGrid(Haupt.CMDliste, {s + "ADC  HL,HL"})
            Case &H6F
                Call COMMON.PrintGrid(Haupt.CMDliste, {s + "RLD  "})
                '
            Case &H72
                Call COMMON.PrintGrid(Haupt.CMDliste, {s + "SBC  HL,SP"})
            Case &H73
                i = COMMON.vZ80cpu.Speicher_lesen_Byte(p + 2) + (COMMON.vZ80cpu.Speicher_lesen_Byte(p + 3) * 256) ' shl 8)
                Call COMMON.PrintGrid(Haupt.CMDliste, {s + "LD   (" + COMMON.HexAnzeige_WordByte(i, "B") + "),SP"})
                len1 = 4
            Case &H78
                Call COMMON.PrintGrid(Haupt.CMDliste, {s + "IN   A,(C)"})
            Case &H79
                Call COMMON.PrintGrid(Haupt.CMDliste, {s + "OUT  (C),A"})
            Case &H7A
                Call COMMON.PrintGrid(Haupt.CMDliste, {s + "ADC  HL,SP"})
            Case &H7B
                i = COMMON.vZ80cpu.Speicher_lesen_Byte(p + 2) + (COMMON.vZ80cpu.Speicher_lesen_Byte(p + 3) * 256) ' shl 8)
                Call COMMON.PrintGrid(Haupt.CMDliste, {s + "LD   SP,(" + COMMON.HexAnzeige_WordByte(i, "B") + ")"})
                len1 = 4
                '
            Case &HA0
                Call COMMON.PrintGrid(Haupt.CMDliste, {s + "LDI  "})
            Case &HA1
                Call COMMON.PrintGrid(Haupt.CMDliste, {s + "CPI  "})
            Case &HA2
                Call COMMON.PrintGrid(Haupt.CMDliste, {s + "INI  "})
            Case &HA3
                Call COMMON.PrintGrid(Haupt.CMDliste, {s + "OUTI "})
            Case &HA8
                Call COMMON.PrintGrid(Haupt.CMDliste, {s + "LDD  "})
            Case &HA9
                Call COMMON.PrintGrid(Haupt.CMDliste, {s + "CPD  "})
            Case &HAA
                Call COMMON.PrintGrid(Haupt.CMDliste, {s + "IND  "})
            Case &HAB
                Call COMMON.PrintGrid(Haupt.CMDliste, {s + "OUTD "})
                '
            Case &HB0
                Call COMMON.PrintGrid(Haupt.CMDliste, {s + "LDIR "})
            Case &HB1
                Call COMMON.PrintGrid(Haupt.CMDliste, {s + "CPIR "})
            Case &HB2
                Call COMMON.PrintGrid(Haupt.CMDliste, {s + "INIR "})
            Case &HB3
                Call COMMON.PrintGrid(Haupt.CMDliste, {s + "OTIR "})
            Case &HB8
                Call COMMON.PrintGrid(Haupt.CMDliste, {s + "LDDR "})
            Case &HB9
                Call COMMON.PrintGrid(Haupt.CMDliste, {s + "CPDR "})
            Case &HBA
                Call COMMON.PrintGrid(Haupt.CMDliste, {s + "INDR "})
            Case &HBB
                Call COMMON.PrintGrid(Haupt.CMDliste, {s + "OTDR "})
                '
            Case Else
                Call COMMON.PrintGrid(Haupt.CMDliste, {s + unknown})
        End Select
        edop = len1
    End Function ' edop

    'disassemble multi byte op-codes with prefix &HDD and &HFD
    Private Function ddfd(ByRef s As String, ByVal p As UInt16) As ULong
        Dim b2 As Integer
        Dim len1 As Integer
        Dim ireg As String

        len1 = 3
        If COMMON.vZ80cpu.Speicher_lesen_Byte(p) = &HDD Then
            ireg = regix
        Else
            ireg = regiy
        End If
        '
        Try
            b2 = COMMON.vZ80cpu.Speicher_lesen_Byte(p + 1)
            If b2 >= &H70 And b2 <= &H77 Then
                Call COMMON.PrintGrid(Haupt.CMDliste, {s + "LD   (" + ireg + "+" +
                                      COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.Speicher_lesen_Byte(p + 2)) + ")," + VregClass.r(b2 And 7)})
                len1 = 3
                GoTo ende
            End If
            '
            Select Case b2
                Case &H9
                    Call COMMON.PrintGrid(Haupt.CMDliste, {s + "ADD  " + ireg + ",BC"})
                    len1 = 2
                Case &H19
                    Call COMMON.PrintGrid(Haupt.CMDliste, {s + "ADD  " + ireg + ",DE"})
                    len1 = 2

                Case &H21
                    Call COMMON.PrintGrid(Haupt.CMDliste, {s + "LD   " + ireg + "," + COMMON.HexAnzeige_WordByte(COMMON.vZ80cpu.Speicher_lesen_Byte(p + 2) +
                                                                                                                 COMMON.vZ80cpu.Speicher_lesen_Byte(p + 3) * 2 ^ 8, "B")})
                    len1 = 4
                Case &H22
                    Call COMMON.PrintGrid(Haupt.CMDliste, {s + "LD   (" + COMMON.HexAnzeige_WordByte(COMMON.vZ80cpu.Speicher_lesen_Byte(p + 2) +
                                                                                                     COMMON.vZ80cpu.Speicher_lesen_Byte(p + 3) * 2 ^ 8, "B") + ")," + ireg})
                    len1 = 4
                Case &H23
                    Call COMMON.PrintGrid(Haupt.CMDliste, {s + "INC  " + ireg})
                    len1 = 2
                Case &H29
                    If COMMON.vZ80cpu.Speicher_lesen_Byte(p) = &HDD Then
                        Call COMMON.PrintGrid(Haupt.CMDliste, {s + "ADD  IX,IX"})
                    Else
                        Call COMMON.PrintGrid(Haupt.CMDliste, {s + "ADD  IY,IY"})
                    End If
                    len1 = 2
                Case &H2A
                    Call COMMON.PrintGrid(Haupt.CMDliste, {s + "LD   " + ireg + ",(" + COMMON.HexAnzeige_WordByte(COMMON.vZ80cpu.Speicher_lesen_Byte(p + 2) +
                                                                                                                  COMMON.vZ80cpu.Speicher_lesen_Byte(p + 3) * 2 ^ 8, "B") + ")"})
                    len1 = 4
                Case &H2B
                    Call COMMON.PrintGrid(Haupt.CMDliste, {s + "DEC  " + ireg})
                    len1 = 2
                Case &H34
                    Call COMMON.PrintGrid(Haupt.CMDliste, {s + "INC  (" + ireg + "+" + COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.Speicher_lesen_Byte(p + 2)) + ")"})
                Case &H35       '
                    Call COMMON.PrintGrid(Haupt.CMDliste, {s + "DEC  (" + ireg + "+" + COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.Speicher_lesen_Byte(p + 2)) + ")"})
                Case &H36
                    Call COMMON.PrintGrid(Haupt.CMDliste, {s + "LD   (" + ireg + "+" + COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.Speicher_lesen_Byte(p + 2)) + ")," +
                                                                                       COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.Speicher_lesen_Byte(p + 3))})
                    len1 = 4
                Case &H39
                    Call COMMON.PrintGrid(Haupt.CMDliste, {s + "ADD  " + ireg + ",SP"})
                    len1 = 2
                Case &H46
                    Call COMMON.PrintGrid(Haupt.CMDliste, {s + "LD   B,(" + ireg + "+" + COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.Speicher_lesen_Byte(p + 2)) + ")"})
                Case &H4E
                    Call COMMON.PrintGrid(Haupt.CMDliste, {s + "LD   C,(" + ireg + "+" + COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.Speicher_lesen_Byte(p + 2)) + ")"})
                Case &H56
                    Call COMMON.PrintGrid(Haupt.CMDliste, {s + "LD   D,(" + ireg + "+" + COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.Speicher_lesen_Byte(p + 2)) + ")"})
                Case &H5E
                    Call COMMON.PrintGrid(Haupt.CMDliste, {s + "LD   E,(" + ireg + "+" + COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.Speicher_lesen_Byte(p + 2)) + ")"})
                Case &H66
                    Call COMMON.PrintGrid(Haupt.CMDliste, {s + "LD   H,(" + ireg + "+" + COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.Speicher_lesen_Byte(p + 2)) + ")"})
                Case &H6E
                    Call COMMON.PrintGrid(Haupt.CMDliste, {s + "LD   L,(" + ireg + "+" + COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.Speicher_lesen_Byte(p + 2)) + ")"})
                Case &H7E
                    Call COMMON.PrintGrid(Haupt.CMDliste, {s + "LD   A,(" + ireg + "+" + COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.Speicher_lesen_Byte(p + 2)) + ")"})
                Case &H86
                    Call COMMON.PrintGrid(Haupt.CMDliste, {s + "ADD  A,(" + ireg + "+" + COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.Speicher_lesen_Byte(p + 2)) + ")"})
                Case &H8E
                    Call COMMON.PrintGrid(Haupt.CMDliste, {s + "ADC  A,(" + ireg + "+" + COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.Speicher_lesen_Byte(p + 2)) + ")"})
                Case &H96
                    Call COMMON.PrintGrid(Haupt.CMDliste, {s + "SUB  (" + ireg + "+" + COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.Speicher_lesen_Byte(p + 2)) + ")"})
                Case &H9E
                    Call COMMON.PrintGrid(Haupt.CMDliste, {s + "SBC  A,(" + ireg + "+" + COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.Speicher_lesen_Byte(p + 2)) + ")"})
                Case &HA6
                    Call COMMON.PrintGrid(Haupt.CMDliste, {s + "AND  (" + ireg + "+" + COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.Speicher_lesen_Byte(p + 2)) + ")"})
                Case &HAE
                    Call COMMON.PrintGrid(Haupt.CMDliste, {s + "XOR  (" + ireg + "+" + COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.Speicher_lesen_Byte(p + 2)) + ")"})
                Case &HB6
                    Call COMMON.PrintGrid(Haupt.CMDliste, {s + "OR   (" + ireg + "+" + COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.Speicher_lesen_Byte(p + 2)) + ")"})
                Case &HBE
                    Call COMMON.PrintGrid(Haupt.CMDliste, {s + "CP   (" + ireg + "+" + COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.Speicher_lesen_Byte(p + 2)) + ")"})
                '
                Case &HCB
                    Select Case COMMON.vZ80cpu.Speicher_lesen_Byte(p + 3)
                        Case &H6
                            Call COMMON.PrintGrid(Haupt.CMDliste, {s + "RLC  (" + ireg + "+" + COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.Speicher_lesen_Byte(p + 2)) + ")"})
                        Case &HE
                            Call COMMON.PrintGrid(Haupt.CMDliste, {s + "RRC  (" + ireg + "+" + COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.Speicher_lesen_Byte(p + 2)) + ")"})
                        Case &H16
                            Call COMMON.PrintGrid(Haupt.CMDliste, {s + "RL   (" + ireg + "+" + COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.Speicher_lesen_Byte(p + 2)) + ")"})
                        Case &H1E
                            Call COMMON.PrintGrid(Haupt.CMDliste, {s + "RR   (" + ireg + "+" + COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.Speicher_lesen_Byte(p + 2)) + ")"})
                        Case &H26
                            Call COMMON.PrintGrid(Haupt.CMDliste, {s + "SLA  (" + ireg + "+" + COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.Speicher_lesen_Byte(p + 2)) + ")"})
                        Case &H2E
                            Call COMMON.PrintGrid(Haupt.CMDliste, {s + "SRA  (" + ireg + "+" + COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.Speicher_lesen_Byte(p + 2)) + ")"})
                        Case &H3E
                            Call COMMON.PrintGrid(Haupt.CMDliste, {s + "SRL  (" + ireg + "+" + COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.Speicher_lesen_Byte(p + 2)) + ")"})
                        Case &H46
                            Call COMMON.PrintGrid(Haupt.CMDliste, {s + "BIT  0,(" + ireg + "+" + COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.Speicher_lesen_Byte(p + 2)) + ")"})
                        Case &H4E
                            Call COMMON.PrintGrid(Haupt.CMDliste, {s + "BIT  1,(" + ireg + "+" + COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.Speicher_lesen_Byte(p + 2)) + ")"})
                        Case &H56
                            Call COMMON.PrintGrid(Haupt.CMDliste, {s + "BIT  2,(" + ireg + "+" + COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.Speicher_lesen_Byte(p + 2)) + ")"})
                        Case &H5E
                            Call COMMON.PrintGrid(Haupt.CMDliste, {s + "BIT  3,(" + ireg + "+" + COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.Speicher_lesen_Byte(p + 2)) + ")"})
                        Case &H66
                            Call COMMON.PrintGrid(Haupt.CMDliste, {s + "BIT  4,(" + ireg + "+" + COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.Speicher_lesen_Byte(p + 2)) + ")"})
                        Case &H6E
                            Call COMMON.PrintGrid(Haupt.CMDliste, {s + "BIT  5,(" + ireg + "+" + COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.Speicher_lesen_Byte(p + 2)) + ")"})
                        Case &H76
                            Call COMMON.PrintGrid(Haupt.CMDliste, {s + "BIT  6,(" + ireg + "+" + COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.Speicher_lesen_Byte(p + 2)) + ")"})
                        Case &H7E
                            Call COMMON.PrintGrid(Haupt.CMDliste, {s + "BIT  7,(" + ireg + "+" + COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.Speicher_lesen_Byte(p + 2)) + ")"})
                        Case &H86
                            Call COMMON.PrintGrid(Haupt.CMDliste, {s + "RES  0,(" + ireg + "+" + COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.Speicher_lesen_Byte(p + 2)) + ")"})
                        Case &H8E
                            Call COMMON.PrintGrid(Haupt.CMDliste, {s + "RES  1,(" + ireg + "+" + COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.Speicher_lesen_Byte(p + 2)) + ")"})
                        Case &H96
                            Call COMMON.PrintGrid(Haupt.CMDliste, {s + "RES  2,(" + ireg + "+" + COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.Speicher_lesen_Byte(p + 2)) + ")"})
                        Case &H9E
                            Call COMMON.PrintGrid(Haupt.CMDliste, {s + "RES  3,(" + ireg + "+" + COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.Speicher_lesen_Byte(p + 2)) + ")"})
                        Case &HA6
                            Call COMMON.PrintGrid(Haupt.CMDliste, {s + "RES  4,(" + ireg + "+" + COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.Speicher_lesen_Byte(p + 2)) + ")"})
                        Case &HAE
                            Call COMMON.PrintGrid(Haupt.CMDliste, {s + "RES  5,(" + ireg + "+" + COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.Speicher_lesen_Byte(p + 2)) + ")"})
                        Case &HB6
                            Call COMMON.PrintGrid(Haupt.CMDliste, {s + "RES  6,(" + ireg + "+" + COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.Speicher_lesen_Byte(p + 2)) + ")"})
                        Case &HBE
                            Call COMMON.PrintGrid(Haupt.CMDliste, {s + "RES  7,(" + ireg + "+" + COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.Speicher_lesen_Byte(p + 2)) + ")"})
                        Case &HC6
                            Call COMMON.PrintGrid(Haupt.CMDliste, {s + "SET  0,(" + ireg + "+" + COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.Speicher_lesen_Byte(p + 2)) + ")"})
                        Case &HCE
                            Call COMMON.PrintGrid(Haupt.CMDliste, {s + "SET  1,(" + ireg + "+" + COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.Speicher_lesen_Byte(p + 2)) + ")"})
                        Case &HD6
                            Call COMMON.PrintGrid(Haupt.CMDliste, {s + "SET  2,(" + ireg + "+" + COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.Speicher_lesen_Byte(p + 2)) + ")"})
                        Case &HDE
                            Call COMMON.PrintGrid(Haupt.CMDliste, {s + "SET  3,(" + ireg + "+" + COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.Speicher_lesen_Byte(p + 2)) + ")"})
                        Case &HE6
                            Call COMMON.PrintGrid(Haupt.CMDliste, {s + "SET  4,(" + ireg + "+" + COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.Speicher_lesen_Byte(p + 2)) + ")"})
                        Case &HEE
                            Call COMMON.PrintGrid(Haupt.CMDliste, {s + "SET  5,(" + ireg + "+" + COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.Speicher_lesen_Byte(p + 2)) + ")"})
                        Case &HF6
                            Call COMMON.PrintGrid(Haupt.CMDliste, {s + "SET  6,(" + ireg + "+" + COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.Speicher_lesen_Byte(p + 2)) + ")"})
                        Case &HFE
                            Call COMMON.PrintGrid(Haupt.CMDliste, {s + "SET  7,(" + ireg + "+" + COMMON.HexAnzeige_Byte(COMMON.vZ80cpu.Speicher_lesen_Byte(p + 2)) + ")"})
                            '
                        Case Else
                            Call COMMON.PrintGrid(Haupt.CMDliste, {s + unknown})
                    End Select
                    len1 = 4
                '
                Case &HE1
                    Call COMMON.PrintGrid(Haupt.CMDliste, {s + "POP  " + ireg})
                    len1 = 2
                Case &HE3
                    Call COMMON.PrintGrid(Haupt.CMDliste, {s + "EX   (SP)," + ireg})
                    len1 = 2
                Case &HE5
                    Call COMMON.PrintGrid(Haupt.CMDliste, {s + "PUSH " + ireg})
                    len1 = 2
                Case &HE9
                    Call COMMON.PrintGrid(Haupt.CMDliste, {s + "JP   (" + ireg + ")"})
                    len1 = 2
                Case &HF9
                    Call COMMON.PrintGrid(Haupt.CMDliste, {s + "LD   SP," + ireg})
                    len1 = 2
                    '
                Case Else
                    Call COMMON.PrintGrid(Haupt.CMDliste, {s + unknown})
            End Select
        Catch ex As Exception
            MsgBox("Disass.ddfd: " + ex.Message)
        End Try
        '
ende:
        ddfd = len1
    End Function ' ddfd

End Module 'Disass