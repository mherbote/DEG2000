Imports System
Imports System.ComponentModel
Imports System.Drawing
Imports System.IO
Imports System.Text

Public Class IOsim

#Region "Global vaiables"
    '                       0  1  2  3  4  5  6  7  8  9  A  B  C  D  E  F
    Public UM1() As Byte = {0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0}          ' 1  '0000 - 7FFF Standard, 8000-CFFF auf 0, D000-FFFF auf 4
    Public UM2() As Byte = {4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 0, 0, 0}          ' 2  '0000 - FFFF auf 4 (Anwender-TRAM)

    '                          0  1  2  3  4  5  6  7  8  9  A  B  C  D  E  F
    Public GoSys1() As Byte = {0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0}       ' 3  '0000 - 7FFF Standard, 8000-FFFF auf 0 (System-TRAM)
    Public Sys_12() As Byte = {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}       ' 4  '0000 - FFFF Standard
    Public Sys_44() As Byte = {0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0}       ' 5  '7000 - 7FFF Standard, alles andere auf 0 (System-TRAM)

    '                        0  1  2  3  4  5  6  7  8  9  A  B  C  D  E  F
    Public SDir() As Byte = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 4, 4}         ' 6  '0000 - CFFF auf 0 (System-TRAM), D000-FFFF auf 4 (Anwender-TRAM)
    Public RDir() As Byte = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}         ' 7  '0000 - FFFF auf 0 (System-TRAM)

    '                          0  1  2  3  4  5  6  7  8  9  A  B  C  D  E  F
    Public Sys_31() As Byte = {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 3, 1, 1, 1, 1, 1}       ' 8  '0000 - FFFF Standard,     außer A000-AFFF auf 3 (SYS3)
    Public Sys_32() As Byte = {3, 3, 3, 1, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3}       ' 9  '0000 - FFFF auf 3 (SYS3), außer 3000-3FFF auf Standard
    Public Sys_33() As Byte = {0, 3, 3, 1, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3}       '10  '0000 - FFFF auf 3 (SYS3), außer 0000-0FFF und 3000-3FFF auf Standard

#End Region

#Region "Local variables"
    Delegate Function op_funcb(ByVal adr As Byte) As Byte
    Private port(0 To 255, 0 To 1) As op_funcb
    Private op_f As op_funcb
    Private data_n As Byte
    Private KeyProc As Boolean

    Private Memory_buffer(6) As Byte
    Private Cursor_buffer(7) As Byte

    Private Kassette_buffer(9) As Byte
    Private Kassette_Status(4) As Byte                                                                  '0 ... Position für Input Status/Fehlerschlüssel
    '                                                                                                   '1 ... HS-Bereich
    '                                                                                                   '2 ... Länge der Daten  im Puffer
    '                                                                                                   '3 ... Status
    '                                                                                                   '4 ... Fehlerschlüssel

    'Private Kassette_Status(6) As Byte                                                                  '0 ... Position für Input Status/Fehlerschlüssel
    ''                                                                                                   '1 ... Status
    ''                                                                                                   '2 ... Fehlerschlüssel
    ''                                                                                                   '3 ... Länge der Daten im Puffer
    ''                                                                                                   '4 ... Basisadresse der AKB  (30H, 38H, 58H)
    ''                                                                                                   '5 ... Subadresse            (1, 2)
    ''                                                                                                   '6 ... Kommando


    'Private MEMswitch(4, 16) As Byte
    Private Date_buffer(3) As Byte
    Private Time_buffer(8) As Byte
#End Region

#Region "Global Routinen"
    Public Sub New()
        Call init_io()
        Memory_buffer(0) = 0
        Kassette_buffer(0) = 0
        Kassette_Status(0) = 0
        Date_buffer(0) = 0
        Time_buffer(0) = 0
    End Sub

    Public Function io_in(adr As Byte)
        op_f = port(adr, 0)
        io_in = op_f(data_n)
    End Function

    Public Function io_out(ByVal adr As Byte, ByVal data As Byte)
        op_f = port(adr, 1)
        io_out = op_f(data)
    End Function
#End Region

#Region "Locale routinen"
#Region "init_io, io_trap"
    Private Sub init_io()
        Dim i As Integer
        For i = 0 To &HFF
            port(i, 0) = New op_funcb(AddressOf io_trap)                        ' for input
            port(i, 1) = New op_funcb(AddressOf io_trap)                        ' for output
        Next

#Region "Set Port's for Cassette / AKB 30H,38H,58H"
        ' AKB1 &H30                                                             ' Laufwerke 1 und 2
        port(&H30, 0) = New op_funcb(AddressOf AKB1A_in__30)
        port(&H30, 1) = New op_funcb(AddressOf AKB1A_out_30)
        ' AKB2 &H38                                                             ' Laufwerke 3 und 4
        port(&H38, 0) = New op_funcb(AddressOf AKB2A_in__38)
        port(&H38, 1) = New op_funcb(AddressOf AKB2A_out_38)
        ' AKB3 &H58                                                             ' Laufwerke 5 und 6
        port(&H58, 0) = New op_funcb(AddressOf AKB3A_in__58)
        port(&H58, 1) = New op_funcb(AddressOf AKB3A_out_58)

        'port(&H30, 0) = New op_funcb(AddressOf AKB1A_in__30)                    ' AKB Baustein 1 --- TOR A
        'port(&H30, 1) = New op_funcb(AddressOf AKB1A_out_30)
        'port(&H31, 0) = New op_funcb(AddressOf AKB1A_in__31)
        'port(&H31, 1) = New op_funcb(AddressOf AKB1A_out_31)
        'port(&H32, 0) = New op_funcb(AddressOf AKB1B_in__32)                    ' AKB Baustein 1 --- TOR B
        'port(&H32, 1) = New op_funcb(AddressOf AKB1B_out_32)
        'port(&H33, 0) = New op_funcb(AddressOf AKB1B_in__33)
        'port(&H33, 1) = New op_funcb(AddressOf AKB1B_out_33)
        port(&H34, 0) = New op_funcb(AddressOf AKB2A_in__34)                    ' AKB Baustein 2 --- TOR A
        'port(&H34, 1) = New op_funcb(AddressOf AKB2A_out_34)
        port(&H35, 0) = New op_funcb(AddressOf AKB2A_in__35)
        'port(&H35, 1) = New op_funcb(AddressOf AKB2A_out_35)
        'port(&H36, 0) = New op_funcb(AddressOf AKB2B_in__36)                    ' AKB Baustein 2 --- TOR B
        'port(&H36, 1) = New op_funcb(AddressOf AKB2B_out_36)
        'port(&H37, 0) = New op_funcb(AddressOf AKB2B_in__37)
        'port(&H37, 1) = New op_funcb(AddressOf AKB2B_out_37)
#End Region

#Region "Set Port's for Keyboard A0H"
        port(&HA0, 0) = New op_funcb(AddressOf Tast_in_d)
        port(&HA1, 0) = New op_funcb(AddressOf Tast_in_s1)
        port(&HA0, 1) = New op_funcb(AddressOf Tast_out_s0)
        port(&HA1, 1) = New op_funcb(AddressOf Tast_out_s1)
        port(&HA2, 1) = New op_funcb(AddressOf Tast_out_s2)
#End Region

#Region "Set Port's for Memory-Switch C0H"
        port(&HC0, 1) = New op_funcb(AddressOf Switch_out_s1)
#End Region

#Region "Set Port's for On-/Off- Cursor 40H"
        port(&H40, 1) = New op_funcb(AddressOf Cursor_out_s1)
#End Region

#Region "Set Port's for Date/Time FEH/FFH"
        port(&HFE, 0) = New op_funcb(AddressOf Date_in)
        port(&HFF, 0) = New op_funcb(AddressOf Time_in)
#End Region

#Region "Port's for Corect BWS FDH"
        port(&HFD, 1) = New op_funcb(AddressOf CorrBWS_out)
#End Region

        KeyProc = False
    End Sub
    Private Function io_trap(ByVal Data As Byte) As Byte
        io_trap = Data
        io_trap = 0
    End Function
#End Region

#Region "AKB ... Kassettenansteuerung"
#Region "AKBiA_in__"
    Private Function AKB1A_in__30(ByVal Data As Byte) As Byte
        AKB1A_in__30 = AKBiA_in(&H30, Data)
    End Function
    Private Function AKB2A_in__38(ByVal Data As Byte) As Byte
        AKB2A_in__38 = AKBiA_in(&H38, Data)
    End Function
    Private Function AKB3A_in__58(ByVal Data As Byte) As Byte
        AKB3A_in__58 = AKBiA_in(&H58, Data)
    End Function
    Private Function AKBiA_in(ByVal port As Byte, ByVal Data As Byte) As Byte
        Try
            AKBiA_in = Nothing
            Kassette_Status(0) = Kassette_Status(0) + 1
            If Kassette_Status(0) < 5 Then
                AKBiA_in = Kassette_Status(Kassette_Status(0))
            End If
        Catch ex As Exception
            MsgBox("IOsim.AKBiA_in (" + Format(port, "0") + "): " + ex.Message)
        End Try
        Return AKBiA_in
    End Function
#End Region

#Region "AKBiA_out_"
    Private Function AKB1A_out_30(ByVal Data As Byte) As Byte
        AKB1A_out_30 = AKBiA_out(&H30, Data)
    End Function
    Private Function AKB2A_out_38(ByVal Data As Byte) As Byte
        AKB2A_out_38 = AKBiA_out(&H38, Data)
    End Function
    Private Function AKB3A_out_58(ByVal Data As Byte) As Byte
        AKB3A_out_58 = AKBiA_out(&H58, Data)
    End Function
    Private Function AKBiA_out(ByVal port As Byte, ByVal Data As Byte) As Byte
        Dim weiter As Boolean = False
        Dim ucKj As ucKassette
        Dim Kass As Byte
        Dim i, j, Anz, B As Byte
        Dim Adresse, HSbereich As Integer
        Dim Name As String

        '1) Kassette Reservieren EIN / AUS, Rewind, einen Block vor-/rücksetzen
        '   1.Byte:    F0 Startbyte
        '   2.Byte:    31 Reservieren EIN
        '              41 Reservieren AUS
        '              21 Rewind / Umspulen
        '              11 einen Block vorsetzen
        '              15 einen Block rücksetzen
        '   3.Byte:       Laufwerk 1 oder 2
        '   4.Byte:    FF Endemarkierung
        '2) n-te BM vor-/rückwärts
        '   1.Byte:    F0 Startbyte
        '   2.Byte:    71 n-te BM vorwärts
        '              75 n-te BM rückwärts
        '              51 schreibe BM
        '              61 schreibe Schlusslücke
        '   3.Byte:       Laufwerk 1 oder 2
        '   4.Byte:    - Anzahl BM bei 71/75
        '              - "B"       bei 51
        '              - "S"       bei 61
        '   5.Byte:    FF Endemarkierung
        '3) Record lesen
        '   1.Byte:    F0 Startbyte
        '   2.Byte:    02 nächsten Record einlesen
        '              44 Name der Kassette ändern
        '   3.Byte:       Laufwerk 1 oder 2
        '   4.Byte:       HS-Bereich
        '   5.Byte:       H-Teil Pufferadresse
        '   6.Byte:       L-Teil Pufferadresse
        '   7.Byte:    FF Endemarkierung
        '4) Record schreiben
        '   1.Byte:    F0 Startbyte
        '   2.Byte:    08 nächsten Record schreiben
        '   3.Byte:       Laufwerk 1 oder 2
        '   4.Byte:       Länge der Daten  (20H | 80H)
        '   5.Byte:       HS-Bereich
        '   6.Byte:       H-Teil Pufferadresse
        '   7.Byte:       L-Teil Pufferadresse
        '   8.Byte:    FF Endemarkierung
        Try
            AKBiA_out = Nothing
#Region "Kassette_buffer(i) übernehmen"
            If Data = &HF0 Then                                                                         ' Kommando-Startbyte
                Kassette_buffer(0) = 0
            End If
            If Kassette_buffer(0) >= 0 And Kassette_buffer(0) < 10 Then
                Kassette_buffer(0) = Kassette_buffer(0) + 1
            End If
            Select Case Kassette_buffer(0)
                Case 1                                                                                  '1. Byte "Startbyte" &HF0
                    If (Data = &HF0) Then
                        Kassette_buffer(Kassette_buffer(0)) = Data
                    Else
                        Kassette_buffer(0) = 0
                    End If
                Case 2                                                                                  '2. Byte "Kommando"
                    If Data = &H31 Or Data = &H41 Or
                       Data = &H11 Or Data = &H15 Or
                       Data = &H51 Or Data = &H61 Or
                       Data = &H71 Or Data = &H75 Or
                       Data = &H21 Or Data = &H2 Or
                       Data = &H8 Or Data = &H44 Then
                        Kassette_buffer(Kassette_buffer(0)) = Data
                    Else
                        Kassette_buffer(0) = 0
                    End If
                Case 3                                                                                  '3. 
                    Select Case Kassette_buffer(2)
                        Case &H31, &H41,                                                                '           Reservieren EIN / AUS
                             &H11, &H15,                                                                '           einen Block vor-/rück- setzen
                             &H71, &H75,                                                                '           n-te  BM    vor-/rück- setzen
                             &H51, &H61,                                                                '           BM / Schlusslücke schreiben
                             &H21, &H44,                                                                '           Rewind / Name ändern
                             &H2, &H8                                                                   '           nächsten Record einlesen / schreiben
                            If Data = 1 Or Data = 2 Then                                                '               Laufwerk 1 oder 2
                                Kassette_buffer(Kassette_buffer(0)) = Data
                            Else
                                Kassette_buffer(0) = 0
                            End If
                        Case Else
                            Kassette_buffer(0) = 0
                    End Select
                Case 4                                                                                  '4. 
                    Select Case Kassette_buffer(2)
                        Case &H31, &H41,                                                                '       Reservieren EIN / AUS
                             &H11, &H15,                                                                '       einen Block vor-/rück- setzen
                             &H21                                                                       '       Rewind
                            If Data = &HFF Then
                                Kassette_buffer(Kassette_buffer(0)) = Data
                                weiter = True
                            Else
                                Kassette_buffer(0) = 0
                            End If
                        Case &H51, &H61                                                                 '       BM / Schlusslücke schreiben
                            Kassette_buffer(Kassette_buffer(0)) = Data                                  '           "B" ... Bandmarke
                            '                                                                           '           "S" ,,, Schlusslücke
                        Case &H71, &H75                                                                 '       n-te  BM    vor-/rück- setzen
                            Kassette_buffer(Kassette_buffer(0)) = Data                                  '           N
                        Case &H2,                                                                       '       nächsten Record einlesen
                             &H44                                                                       '       Name ändern
                            Kassette_buffer(Kassette_buffer(0)) = Data                                  '           HS-Seg
                        Case &H8                                                                        '       nächsten Record schreiben
                            If Data = &H20 Or Data = &H80 Then                                          '           Länge der Daten
                                Kassette_buffer(Kassette_buffer(0)) = Data
                            Else
                                Kassette_buffer(0) = 0
                            End If
                        Case Else
                            Kassette_buffer(0) = 0
                    End Select
                Case 5
                    Select Case Kassette_buffer(2)
                        Case &H51, &H61,                                                                '       BM / Schlusslücke schreiben
                             &H71, &H75                                                                 '       n-te  BM    vor-/rück- setzen
                            If Data = &HFF Then
                                Kassette_buffer(Kassette_buffer(0)) = Data
                                weiter = True
                            Else
                                Kassette_buffer(0) = 0
                            End If
                        Case &H2,                                                                       '       nächsten Record einlesen
                             &H44                                                                       '       Name ändern
                            Kassette_buffer(Kassette_buffer(0)) = Data                                  '           H-Teil Pufferadresse
                        Case &H8                                                                        '       nächsten Record schreiben
                            Kassette_buffer(Kassette_buffer(0)) = Data                                  '           HS-Seg
                        Case Else
                            Kassette_buffer(0) = 0
                    End Select
                Case 6
                    Select Case Kassette_buffer(2)
                        Case &H2,                                                                       '       nächsten Record einlesen
                             &H44                                                                       '       Name ändern
                            Kassette_buffer(Kassette_buffer(0)) = Data                                  '           L-Teil Pufferadresse
                        Case &H8                                                                        '       nächsten Record schreiben
                            Kassette_buffer(Kassette_buffer(0)) = Data                                  '           H-Teil Pufferadresse
                        Case Else
                            Kassette_buffer(0) = 0
                    End Select
                Case 7
                    Select Case Kassette_buffer(2)
                        Case &H2,                                                                       '       nächsten Record einlesen
                             &H44                                                                       '       Name ändern
                            If Data = &HFF Then
                                Kassette_buffer(Kassette_buffer(0)) = Data
                                weiter = True
                            Else
                                Kassette_buffer(0) = 0
                            End If
                        Case &H8                                                                        '       nächsten Record schreiben
                            Kassette_buffer(Kassette_buffer(0)) = Data                                  '           L-Teil Pufferadresse
                        Case Else
                            Kassette_buffer(0) = 0
                    End Select
                Case 8
                    Select Case Kassette_buffer(2)
                        Case &H8                                                                        '       nächsten Record schreiben
                            If Data = &HFF Then
                                Kassette_buffer(Kassette_buffer(0)) = Data
                                weiter = True
                            Else
                                Kassette_buffer(0) = 0
                            End If
                        Case Else
                            Kassette_buffer(0) = 0
                    End Select
            End Select
#End Region

            If weiter Then
#Region "Kommando von Kassette_buffer ausführen"
#Region "Init für Kassette I"
                ucKj = Nothing
                Select Case port
                    Case &H30
                        Select Case Kassette_buffer(3)
                            Case 1
                                ucKj = Kassetten.ucK1
                                Kass = 0
                            Case 2
                                ucKj = Kassetten.ucK2
                                Kass = 1
                        End Select
                    Case &H38
                        Select Case Kassette_buffer(3)
                            Case 1
                                ucKj = Kassetten.ucK3
                                Kass = 2
                            Case 2
                                ucKj = Kassetten.ucK4
                                Kass = 3
                        End Select
                    Case &H58
                        Select Case Kassette_buffer(3)
                            Case 1
                                ucKj = Kassetten.ucK5
                                Kass = 4
                            Case 2
                                ucKj = Kassetten.ucK6
                                Kass = 5
                        End Select
                End Select
                If IsDBNull(ucKj) Then
                    MsgBox("IOsim.AKBiA_out: ucKj darf nicht NULL sein!")
                    Exit Function
                End If

                Call SetStatus(ucKj, "Init", port)
#End Region
                Select Case Kassette_buffer(2)
#Region "Reservieren EIN / AUS (31H/41H)"
                    Case &H31                                                                           'Reservieren EIN
                        'port + C0_buffer(3)
                        '1.  ist im LW eine Kassette eingelegt
                        '1.a Nein ---> Fehler
                        '1.b JA   dann weiter mit 3.
                        '2.  Button in ucKi deaktivieren, damit LW für EMU
                        '3.  Button in Kassetten (Close) auch deaktivieren
                        '4.  LW auf Bandanfang setzen
                        '##                        Laufwerke.ShowKassette()
                        With ucKj
                            If .OpenCassette.Text = "Close" Then                                        '1.
                                '1.b
                                '.Create.Enabled = False
                                .OpenCassette.Enabled = False
                                .Rewind.Enabled = False                                                 '2.
                                .BMback.Enabled = False
                                .RecordBack.Enabled = False
                                .Verzeichnis.Enabled = False
                                .Datei.Enabled = False
                                .RecordVor.Enabled = False
                                .BMvor.Enabled = False
                                .Aktiv = True

                                Laufwerke.Kassetten1.Rows(Kass).Cells("CheckChangeK").Value = True      '3.

                                '.Cassette_Rewind()                                                     '4.
                                Call SetStatus(ucKj, "ok", port)
                            Else
                                '1.a Error!
                                'MsgBox("Es ist keine Kassette im Laufwerk '" + Format(Kass + 1, "0") + "'",, "Reservieren der Kassette")
                                Call BWS.ErrorToControlArray("Es ist keine Kassette im Laufwerk '" + Format(Kass + 1, "0") + "'", 28, 20,
                                                             System.Drawing.Color.Red, System.Drawing.Color.Yellow, 5000)

                                Call SetStatus(ucKj, "kein RE", port)
                            End If
                        End With
                    Case &H41                                                                           'Reservieren AUS
                        'port + C0_buffer(3)
                        '1.  ist LW Reservieren EIN ?
                        '1.a Nein ----> Fehler
                        '1.b JA   dann weiter mit 2.
                        '2.  Button in Kassetten (Close) wieder aktivieren
                        '3.  Button in ucKi wieder aktivieren
                        '4.  LW auf Bandanfang setzen
                        With ucKj
                            If .Aktiv Then                                                              '1.
                                '1.b
                                Laufwerke.Kassetten1.Rows(Kass).Cells("CheckChangeK").Value = False     '2.

                                .OpenCassette.Enabled = True                                            '3.
                                .Rewind.Enabled = True
                                .BMback.Enabled = True
                                .RecordBack.Enabled = True
                                .Verzeichnis.Enabled = True
                                .Datei.Enabled = True
                                .RecordVor.Enabled = True
                                .BMvor.Enabled = True
                                .Aktiv = False

                                '.Cassette_Rewind()                                                     '4.
                                Call SetStatus(ucKj, "init", port)
                            Else
                                '1.a
                                Call SetStatus(ucKj, "kein RE", port)
                            End If
                        End With
#End Region
#Region "Rewind (21H)"
                    Case &H21                                                                           'Rewind
                        With ucKj
                            If .Aktiv Then
                                .CassetteRewind()
                                Call SetStatus(ucKj, "init", port)
                                Call SetStatus(ucKj, "ok", port)
                            Else
                                Call SetStatus(ucKj, "kein RE", port)
                            End If
                        End With
#End Region
#Region "einen Block vor- / rück- setzen (11H/15H)"
                    Case &H11                                                                           'einen Block vorsetzen
                        With ucKj
                            If .Aktiv Then
                                If .BM.Text = "S c h l u s s l ü c k e" Then
                                    Call SetStatus(ucKj, "Bandende", port)
                                Else
                                    .CassetteRecordVor()
                                    Call SetStatus(ucKj, "ok", port)
                                End If
                            Else
                                '1.a
                                Call SetStatus(ucKj, "kein RE", port)
                            End If
                        End With
                    Case &H15                                                                           'einen Block rücksetzen
                        With ucKj
                            If .Aktiv Then
                                If .Kassette.Record = 1 Then
                                    .CassetteRewind()
                                    Call SetStatus(ucKj, "init", port)
                                    Call SetStatus(ucKj, "ok", port)
                                    'Call SetStatus(ucKj, "Bandende", port)
                                Else
                                    .CassetteRecordBack()
                                    Call SetStatus(ucKj, "ok", port)
                                End If
                            Else
                                '1.a
                                Call SetStatus(ucKj, "kein RE", port)
                            End If
                        End With
#End Region
#Region "n-te BM vor- / rück- setzen (71H/75H)"
                    Case &H71                                                                           'n-te  BM    vorsetzen
                        With ucKj
                            If .Aktiv Then
                                For i = 1 To Kassette_buffer(4)
                                    If .BM.Text = "S c h l u s s l ü c k e" Then
                                        Call SetStatus(ucKj, "BM not", port)
                                        Exit For
                                    Else
                                        .CassetteBMvor()
                                    End If
                                    Call SetStatus(ucKj, "ok", port)
                                Next i
                            Else
                                Call SetStatus(ucKj, "kein RE", port)
                            End If
                        End With
                    Case &H75                                                                           'n-te  BM    rücksetzen
                        With ucKj
                            If .Aktiv Then
                                For i = 1 To Kassette_buffer(4)
                                    If .Kassette.Record = 1 Then
                                        Call SetStatus(ucKj, "BM not", port)
                                        Exit For
                                    Else
                                        .CassetteBMback()
                                    End If
                                    Call SetStatus(ucKj, "ok", port)
                                Next i
                            Else
                                Call SetStatus(ucKj, "kein RE", port)
                            End If
                        End With
#End Region
#Region "Bandmarke / Schlusslücke schreiben (51H/61H)"
                    Case &H51                                                                           'Bandmarke    schreiben
                        With ucKj
                            If .Aktiv Then
                                If .Kassette.RO Then
                                    Call SetStatus(ucKj, "RO", port)
                                Else
                                    Call .CassetteWriteSpezialRecord("B", &H10)
                                    Call SetStatus(ucKj, "ok", port)
                                End If
                            Else
                                Call SetStatus(ucKj, "kein RE", port)
                            End If
                        End With
                    Case &H61                                                                           'Schlusslücke schreiben
                        With ucKj
                            If .Aktiv Then
                                If .Kassette.RO Then
                                    Call SetStatus(ucKj, "RO", port)
                                Else
                                    Call .CassetteWriteSpezialRecord("S", &H10)
                                    Call SetStatus(ucKj, "ok", port)
                                End If
                            Else
                                Call SetStatus(ucKj, "kein RE", port)
                            End If
                        End With
#End Region
#Region "Record einlesen (02H)"
                    Case &H2                                                                            'nächsten Record einlesen
                        With ucKj
                            If .Aktiv Then
                                .CassetteReadBlock()
                                Anz = ucKj.Anz * 16
                                If Anz > &H80 Then
                                    Call SetStatus(ucKj, "to long", port)
                                Else
                                    HSbereich = Kassette_buffer(4)
                                    Adresse = Kassette_buffer(5) * 256 + Kassette_buffer(6)
                                    For j = 1 To &H80                                                   'Daten in den Puffer löschen
                                        COMMON.vZ80cpu.Speicher_schreiben_Byte1(Adresse, 0, HSbereich)
                                        Adresse += 1
                                    Next j

                                    Adresse = Kassette_buffer(5) * 256 + Kassette_buffer(6)
                                    Select Case ucKj.Anz
                                        Case 1
                                            For i = 0 To 15                                             'Daten in den Puffer schreiben
                                                B = ucKj.Kassette.buffer.b(1).z(i)
                                                COMMON.vZ80cpu.Speicher_schreiben_Byte1(Adresse, B, HSbereich)
                                            Next i
                                        Case 2, 8
                                            For j = 1 To ucKj.Anz
                                                For i = 0 To 15                                         'Daten in den Puffer schreiben
                                                    B = ucKj.Kassette.buffer.b(j).z(i)
                                                    COMMON.vZ80cpu.Speicher_schreiben_Byte1(Adresse, B, HSbereich)
                                                    Adresse += 1
                                                Next i
                                            Next j
                                    End Select

                                    Call SetStatus(ucKj, "ok", port)
                                    Select Case ucKj.Anz
                                        Case 1
                                            Select Case Chr(ucKj.Kassette.buffer.b(1).z(0))
                                                Case "B"
                                                    Kassette_Status(2) = 1
                                                Case "S"
                                                    Kassette_Status(2) = 2
                                                Case Else
                                                    Kassette_Status(2) = &H10
                                            End Select
                                        Case 2
                                            Kassette_Status(2) = &H20
                                        Case 8
                                            Kassette_Status(2) = &H80
                                    End Select
                                End If
                            Else
                                Call SetStatus(ucKj, "kein RE", port)
                            End If
                        End With
#End Region
#Region "Record schreiben (08H)"
                    Case &H8                                                                            'nächsten Record schreiben
                        With ucKj
                            If .Aktiv Then
                                If .Kassette.RO Then
                                    Call SetStatus(ucKj, "RO", port)
                                Else
                                    Anz = Kassette_buffer(4) \ 16
                                    HSbereich = Kassette_buffer(5)
                                    Adresse = Kassette_buffer(6) * 256 + Kassette_buffer(7)
                                    ucKj.Kassette.D = 0
                                    ucKj.Kassette.E = 0
                                    For j = 1 To Anz
                                        For i = 0 To 15                                                'Daten in den Puffer schreiben
                                            B = COMMON.vZ80cpu.Speicher_lesen_Byte1(Adresse, HSbereich)
                                            ucKj.Kassette.buffer.b(j).z(i) = B
                                            Adresse += 1
                                        Next i
                                        Call ucKj.Kassette.CRC(ucKj.Kassette.buffer.b(j))
                                    Next j
                                    Call .CassetteWriteRecord(Kassette_buffer(4))
                                    Call SetStatus(ucKj, "ok", port)
                                    Kassette_Status(2) = Kassette_buffer(4)
                                End If
                            Else
                                Call SetStatus(ucKj, "kein RE", port)
                            End If
                        End With
#End Region
#Region "Name der Kassette ändern (44H)"
                    Case &H44
                        With ucKj
                            If .Aktiv Then
                                'Namen für Umbenennung ermitteln
                                i = 0
                                j = 0
                                Name = ""
                                HSbereich = Kassette_buffer(4)
                                Adresse = Kassette_buffer(5) * 256 + Kassette_buffer(6)
                                Do
                                    B = COMMON.vZ80cpu.Speicher_lesen_Byte1(Adresse, HSbereich)
                                    Adresse = Adresse + 1
                                    j = j + 1
                                    Select Case B
                                        Case &H20
                                            Select Case i
                                                Case 0
                                                    Name = Name + "-"
                                                    i = i + 1
                                                Case 1
                                                    Select Case j
                                                        Case 6
                                                            i = i + 1
                                                        Case Else
                                                    End Select
                                                Case 2
                                                    B = 0
                                            End Select
                                        Case Else
                                            Name = Name + Chr(B)
                                    End Select
                                    If j = 6 And i = 0 Then
                                        Name = Name + "-"
                                        i = 2
                                    End If
                                Loop Until B = 0
                                'Umbenennung
                                Call .RenameKassette(Name, .RIndex)

                                Call SetStatus(ucKj, "ok", port)
                            Else
                                Call SetStatus(ucKj, "kein RE", port)
                            End If
                        End With
#End Region
                End Select
#End Region
            End If
        Catch ex As Exception
            MsgBox("IOsim.AKBiA_out (" + COMMON.HexAnzeige_Byte(port) + "H," + COMMON.HexAnzeige_Byte(Kassette_buffer(2)) + "H): " + ex.Message)
        End Try

        AKBiA_out = 0
        Return AKBiA_out
    End Function
    Private Sub SetStatus(ucKj As ucKassette, ByVal Command As String, ByVal port As Byte)
        If IsDBNull(ucKj) Then
            MsgBox("IOsim.SetStatus: ucKj darf nicht NULL sein!")
            Exit Sub
        End If

        Select Case Command
            Case "Init"
                Kassette_Status(0) = 0                                                                  'Index für Kassette_Status
                Kassette_Status(1) = 1                                                                  'HS-Bereich
                Kassette_Status(2) = 0                                                                  'Länge der Daten im Puffer nach Lesen
                Kassette_Status(3) = 0                                                                  'Status
                Kassette_Status(4) = 0                                                                  'Fehlerschlüssel

            Case "ok"
                Kassette_Status(3) = Kassette_Status(3) + &H1                                           'Bit 0 ... Gerät besetzt
                If ucKj.Kassette.RO Then
                    Kassette_Status(3) = Kassette_Status(3) + &H4                                       'Bit 2 ... Aufzeichnen verboten
                End If
                Kassette_Status(3) = Kassette_Status(3) + &H20                                          'Bit 5 ... Gerät reserviert
                Kassette_Status(4) = 0                                                                  'kein Fehler
            Case "kein RE"
                Kassette_Status(3) = Kassette_Status(3) + &H80                                          'Bit 7 ... Fehler
                Kassette_Status(4) = &H11                                                               'angewähltes Gerät nicht reserviert
            Case "Bandende"
                Kassette_Status(3) = Kassette_Status(3) + &H80                                          'Bit 7 ... Fehler
                Kassette_Status(4) = &H14                                                               'Ende der Aufzeichnungen
            Case "BM not"
                Kassette_Status(3) = Kassette_Status(3) + &H80                                          'Bit 7 ... Fehler
                Kassette_Status(4) = &H18                                                               'Bandmarke nicht gefunden
            Case "to long"
                Kassette_Status(3) = Kassette_Status(3) + &H80                                          'Bit 7 ... Fehler
                Kassette_Status(4) = &H13                                                               'Puffer-/Record- Länge
            Case "RO"
                Kassette_Status(3) = Kassette_Status(3) + &H80                                          'Bit 7 ... Fehler
                Kassette_Status(4) = &H19                                                               'Aufzeichnen verboten
        End Select
    End Sub
#End Region

#Region "AKB for OLD"
    Private Function AKB2A_in__34(ByVal Data As Byte) As Byte
        AKB2A_in__34 = 0
    End Function
    Private Function AKB2A_in__35(ByVal Data As Byte) As Byte
        AKB2A_in__35 = 0
    End Function
#End Region
#End Region

#Region "Tastatur"
    Private Function GetChar() As System.Windows.Forms.Keys
        Dim i, j As Integer
        GetChar = -99999

        If KeyProc Then
            For i = 1 To COMMON.NextCharTast0
                If COMMON.NextCharTast1(i) Then
                    GetChar = COMMON.NextCharTast2(i)
                    COMMON.NextCharTast1(i) = False
                    If COMMON.NextCharTast0 > 0 Then
                        COMMON.NextCharTast0 = COMMON.NextCharTast0 - 1
                        Call Haupt.ToolStripStatusAnzeigen()
                    End If
                    For j = 1 To COMMON.NextCharTast0
                        COMMON.NextCharTast1(j) = COMMON.NextCharTast1(j + 1)
                        COMMON.NextCharTast2(j) = COMMON.NextCharTast2(j + 1)
                    Next j
                    COMMON.NextCharTast1(COMMON.NextCharTast0 + 1) = False
                    COMMON.NextCharTast2(COMMON.NextCharTast0 + 1) = NONE
                    Call Tastatur.FillBuffer()
                    Exit For
                End If
            Next i
        End If
    End Function
    Private Function Tast_in_d() As Byte
        Dim NextChar As System.Windows.Forms.Keys

        NextChar = GetChar()
        Tast_in_d = Nothing
        If NextChar = -99999 Then
            'Tast_in_d = &HFF
        Else
            If (NextChar And &H100) = &H100 Then
                Tast_in_d = NextChar - &H100
            ElseIf (NextChar And &H200) = &H200 Then
                Tast_in_d = NextChar - &H200
            Else
                Tast_in_d = NextChar
            End If
            KeyProc = False
        End If
    End Function

    Private Function GetStat() As Byte
        Dim i As Integer
        GetStat = &H8

        If KeyProc Then
            GetStat = &HF7                           '/UCS2
        Else
            For i = 1 To COMMON.NextCharTast0
                If COMMON.NextCharTast1(i) Then
                    GetStat = &HF7                   '/UCS2
                    KeyProc = True
                    Exit For
                End If
            Next i
        End If
    End Function
    Private Function Tast_in_s1() As Byte
        Tast_in_s1 = GetStat()
    End Function

    Private Function Tast_out_s0(ByVal data As Byte) As Byte

        Tast_out_s0 = 0
    End Function
    Private Function Tast_out_s1(ByVal data As Byte) As Byte

        Tast_out_s1 = 0
    End Function
    Private Function Tast_out_s2(ByVal data As Byte) As Byte
        Dim i As Int16

        Select Case data
            Case 4                                                                   'Fehleranzeige ein
                Call Tastatur.Fehleranzeige(Drawing.Color.Red)
            Case 14                                                                  'Fehleranzeige aus
                Call Tastatur.Fehleranzeige(Drawing.Color.WhiteSmoke)
            Case 24                                                                  'Fehleranzeige ein & Hupe lang
                Call Tastatur.Fehleranzeige(Drawing.Color.Red)
                Tastatur.Refresh()
                For i = 1 To 3
                    My.Computer.Audio.Play(COMMON.WavVerzeichnis + "\Alarm.wav")
                    Threading.Thread.Sleep(1000)
                Next i
            Case 5                                                                   'Hupe lang
                My.Computer.Audio.Play(COMMON.WavVerzeichnis + "\Alarm.wav")
                Threading.Thread.Sleep(3000)
            Case 6                                                                   'Hupe kurz
                My.Computer.Audio.Play(COMMON.WavVerzeichnis + "\Bell.wav")
                Threading.Thread.Sleep(3000)
            Case 7                                                                   'INS_MOD ein
                Tastatur.Button122.BackColor = Drawing.Color.Red
            Case 17                                                                  'INS_MOD aus
                Tastatur.Button122.BackColor = Drawing.Color.WhiteSmoke
            Case 8                                                                   'Programm        -Tastatur aktivieren
                COMMON.PSTAS = COMMON.PTAS
                Call Tastatur.PSTAS_Grundstellung()
            Case 9                                                                   'Schreibmaschinen-Tastatur aktivieren
                COMMON.PSTAS = COMMON.STAS
                Call Tastatur.PSTAS_Grundstellung()
        End Select

        Tast_out_s2 = 0
    End Function
#End Region

#Region "Memory-Switch"
    Private Function Switch_out_s1(ByVal data As Byte) As Byte
        Dim weiter As Boolean = False
        Dim i As Integer

        '1) einen Bereich auf BereichNr      umschalten
        '   1.Byte:    F0 Startbyte
        '   2.Byte:    01
        '   3.Byte:       Bereich
        '   4.Byte        BereichNr (0,1,2,3,4)
        '   5.Byte:    FF Endemarkierung
        '2) alle Bereiche auf 0 1 2 3 oder 4 umschalten
        '   1.Byte:    F0 Startbyte
        '   2.Byte:    02
        '   3.Byte        BereichNr (0,1,2,3,4)
        '   4.Byte:    FF Endemarkierung
        '3) alle Bereiche auf SYS4-Constantenliste umschalten
        '   1.Byte:    F0 Startbyte
        '   2.Byte:    03
        '   3.Byte        BereichNr (01, ... , 10)
        '   4.Byte:    FF Endemarkierung
        '4) mehrere Bereiche auf 0 1 2 3 oder 4 umschalten
        '   1.Byte:    F0 Startbyte
        '   2.Byte:    04
        '   3.Byte:       Bereich von
        '   4.Byte:       Bereich bis
        '   5.Byte        BereichNr (0,1,2,3,4)
        '   6.Byte:    FF Endemarkierung

        If data = &HF0 Then
            Memory_buffer(0) = 0
        End If
        If Memory_buffer(0) >= 0 And Memory_buffer(0) < 6 Then
            Memory_buffer(0) = Memory_buffer(0) + 1
        End If
        Select Case Memory_buffer(0)
            Case 1                                                              '1. Byte "Startbyte" &HF0
                If (data = &HF0) Then
                    Memory_buffer(Memory_buffer(0)) = data
                Else
                    Memory_buffer(0) = 0
                End If
            Case 2                                                              '2. Byte "Auswahlbyte"
                If (data > 0 And data < 5) Then
                    Memory_buffer(Memory_buffer(0)) = data
                Else
                    Memory_buffer(0) = 0
                End If
            Case 3                                                              '3. Byte 
                Select Case Memory_buffer(2)
                    Case 1, 4
                        If (data >= 0 And data <= 15) Then
                            Memory_buffer(Memory_buffer(0)) = data
                        Else
                            Memory_buffer(0) = 0
                        End If
                    Case 2
                        If (data >= 0 And data <= 4) Then
                            Memory_buffer(Memory_buffer(0)) = data
                        Else
                            Memory_buffer(0) = 0
                        End If
                    Case 3
                        If (data >= 1 And data <= 10) Then
                            Memory_buffer(Memory_buffer(0)) = data
                        Else
                            Memory_buffer(0) = 0
                        End If
                End Select
            Case 4                                                              '4. Byte 
                Select Case Memory_buffer(2)
                    Case 1
                        If (data >= 0 And data <= 4) Then
                            Memory_buffer(Memory_buffer(0)) = data
                        Else
                            Memory_buffer(0) = 0
                        End If
                    Case 2, 3
                        If (data = &HFF) Then
                            Memory_buffer(Memory_buffer(0)) = data
                            weiter = True
                        Else
                            Memory_buffer(0) = 0
                        End If
                    Case 4
                        If (data >= 0 And data <= 15 And Memory_buffer(Memory_buffer(0) - 1) < data) Then
                            Memory_buffer(Memory_buffer(0)) = data
                        Else
                            Memory_buffer(0) = 0
                        End If
                End Select
            Case 5                                                              '5. Byte
                Select Case Memory_buffer(2)
                    Case 1
                        If (data = &HFF) Then
                            Memory_buffer(Memory_buffer(0)) = data
                            weiter = True
                        Else
                            Memory_buffer(0) = 0
                        End If
                    Case 4
                        If (data >= 0 And data <= 4) Then
                            Memory_buffer(Memory_buffer(0)) = data
                        Else
                            Memory_buffer(0) = 0
                        End If
                End Select
            Case 6                                                              '6. Byte
                Select Case Memory_buffer(2)
                    Case 4
                        If (data = &HFF) Then
                            Memory_buffer(Memory_buffer(0)) = data
                            weiter = True
                        Else
                            Memory_buffer(0) = 0
                        End If
                End Select
        End Select

        If (weiter) Then
            Select Case Memory_buffer(2)
                Case 1                                                      '           einen Bereich auf BereichNr            umschalten
                    COMMON.vZ80cpu.Seg_HS(Memory_buffer(3)) = Memory_buffer(4)
                Case 2                                                      '           alle Bereiche auf 0,1,2,3 oder 4       umschalten
                    For i = 0 To 15
                        COMMON.vZ80cpu.Seg_HS(i) = Memory_buffer(3)
                    Next
                Case 3                                                      '           alle Bereiche auf SYS4-Constantenliste umschalten
                    Select Case Memory_buffer(3)
                        Case 1
                            For i = 0 To 15
                                COMMON.vZ80cpu.Seg_HS(i) = UM1(i)
                            Next i
                        Case 2
                            For i = 0 To 15
                                COMMON.vZ80cpu.Seg_HS(i) = UM2(i)
                            Next
                        Case 3
                            For i = 0 To 15
                                COMMON.vZ80cpu.Seg_HS(i) = GoSys1(i)
                            Next
                        Case 4
                            For i = 0 To 15
                                COMMON.vZ80cpu.Seg_HS(i) = Sys_12(i)
                            Next
                        Case 5
                            For i = 0 To 15
                                COMMON.vZ80cpu.Seg_HS(i) = Sys_44(i)        ' Startphase SYS 4.4
                            Next
                        Case 6
                            For i = 0 To 15
                                COMMON.vZ80cpu.Seg_HS(i) = SDir(i)
                            Next
                        Case 7
                            For i = 0 To 15
                                COMMON.vZ80cpu.Seg_HS(i) = RDir(i)
                            Next
                        Case 8
                            For i = 0 To 15
                                COMMON.vZ80cpu.Seg_HS(i) = Sys_31(i)
                            Next
                        Case 9
                            For i = 0 To 15
                                COMMON.vZ80cpu.Seg_HS(i) = Sys_32(i)
                            Next
                        Case 10
                            For i = 0 To 15
                                COMMON.vZ80cpu.Seg_HS(i) = Sys_33(i)
                            Next
                    End Select
                Case 4                                                      '           mehrere Bereiche auf 0 1 2 3 oder 4 umschalten
                    For i = Memory_buffer(3) To Memory_buffer(4)
                        COMMON.vZ80cpu.Seg_HS(i) = Memory_buffer(5)
                    Next
            End Select
        End If

        Switch_out_s1 = 0
    End Function
#End Region

#Region "On-/Off- Cursor"
    Private Function Cursor_out_s1(ByVal data As Byte) As Byte
        Dim weiter As Boolean = False
        Dim BWSA, HL As ULong
        Dim X, Y As Int16

        '1) Cursor EIN-Schalten
        '   1.Byte:    F0 Startbyte
        '   2.Byte:    01
        '   3.Byte:       X
        '   4.Byte        Y
        '   5.Byte:    FF Endemarkierung
        '2) Cursor AUS-Schalten
        '   1.Byte:    F0 Startbyte
        '   2.Byte:    02
        '   3.Byte:    FF Endemarkierung
        '3) CursorTyp setzen
        '   1.Byte:    F0 Startbyte
        '   2.Byte:    03
        '   3.Byte:       0 ... None
        '                 1 ... Normal
        '                 2 ... Invers
        '                 3 ... Full
        '   4.Byte:    FF Endemarkierung
        '4) Cursor EIN-Schalten mit HL als BWS-Adresse
        '   1.Byte:    F0 Startbyte
        '   2.Byte:    04
        '   3.Byte:       Low  (SY.BWSA)
        '   4.Byte        High (SY.BWSA)
        '   5.Byte:       L    (HL)
        '   6.Byte        H    (HL)
        '   7.Byte:    FF Endemarkierung

        If data = &HF0 Then
            Cursor_buffer(0) = 0
        End If
        If Cursor_buffer(0) >= 0 And Cursor_buffer(0) < 8 Then
            Cursor_buffer(0) = Cursor_buffer(0) + 1
        End If

        Try

            Select Case Cursor_buffer(0)
                Case 1                                                              '1. Byte "Startbyte" &HF0
                    If (data = &HF0) Then
                        Cursor_buffer(Cursor_buffer(0)) = data
                    Else
                        Cursor_buffer(0) = 0
                    End If
                Case 2                                                              '2. Byte Kommando
                    If (data > 0 And data < 5) Then
                        Cursor_buffer(Cursor_buffer(0)) = data
                    Else
                        Cursor_buffer(0) = 0
                    End If
                Case 3                                                              '3. Byte
                    Select Case Cursor_buffer(2)
                        Case 1                                                      '        Cursor EIN
                            If (data >= 0 And data < BWS.BWSx) Then
                                Cursor_buffer(Cursor_buffer(0)) = data
                            Else
                                Cursor_buffer(0) = 0
                            End If
                        Case 2                                                      '        Cursor AUS
                            If (data = &HFF) Then
                                Cursor_buffer(Cursor_buffer(0)) = data
                                weiter = True
                            Else
                                Cursor_buffer(0) = 0
                            End If
                        Case 3                                                      '        CursorTyp
                            If (data >= 0 And data < 4) Then
                                Cursor_buffer(Cursor_buffer(0)) = data
                            Else
                                Cursor_buffer(0) = 0
                            End If
                        Case 4                                                      '        Cursor EIN mit HL als BWS-Adresse
                            Cursor_buffer(Cursor_buffer(0)) = data                  '        Low  (SY.BWSA)
                    End Select
                Case 4
                    Select Case Cursor_buffer(2)
                        Case 1                                                      '        Cursor EIN
                            If (data >= 0 And data < BWS.BWSy) Then
                                Cursor_buffer(Cursor_buffer(0)) = data
                            Else
                                Cursor_buffer(0) = 0
                            End If
                        Case 2                                                      '        Cursor AUS
                            Cursor_buffer(0) = 0
                        Case 3                                                      '        CursorTyp
                            If (data = &HFF) Then
                                Cursor_buffer(Cursor_buffer(0)) = data
                                weiter = True
                            Else
                                Cursor_buffer(0) = 0
                            End If
                        Case 4                                                      '        Cursor EIN mit HL als BWS-Adresse
                            Cursor_buffer(Cursor_buffer(0)) = data                  '        High (SY.BWSA)
                    End Select
                Case 5
                    Select Case Cursor_buffer(2)
                        Case 1                                                      '        Cursor EIN
                            If (data = &HFF) Then
                                Cursor_buffer(Cursor_buffer(0)) = data
                                weiter = True
                            Else
                                Cursor_buffer(0) = 0
                            End If
                        Case 4                                                      '        Cursor EIN mit HL als BWS-Adresse
                            Cursor_buffer(Cursor_buffer(0)) = data                  '        L    (HL)
                        Case Else
                            Cursor_buffer(0) = 0
                    End Select
                Case 6
                    Select Case Cursor_buffer(2)
                        Case 4                                                      '        Cursor EIN mit HL als BWS-Adresse
                            Cursor_buffer(Cursor_buffer(0)) = data                  '        H    (HL)
                        Case Else
                            Cursor_buffer(0) = 0
                    End Select
                Case 7
                    Select Case Cursor_buffer(2)
                        Case 4                                                      '        Cursor EIN mit HL als BWS-Adresse
                            If (data = &HFF) Then
                                Cursor_buffer(Cursor_buffer(0)) = data
                                weiter = True
                            Else
                                Cursor_buffer(0) = 0
                            End If
                        Case Else
                            Cursor_buffer(0) = 0
                    End Select
            End Select

            If (weiter) Then
                Select Case Cursor_buffer(2)
                    Case 1                                                          'Cursor EIN
                        BWS.SetCursor(Cursor_buffer(3), Cursor_buffer(4))
                    Case 2                                                          'Cursor AUS
                        BWS.ResetCursor()
                    Case 3                                                          'CursorTyp
                        Select Case Cursor_buffer(3)
                            Case 0
                                BWS.SetCursorTyp(BWS.eCursorTyp.None)
                            Case 1
                                BWS.SetCursorTyp(BWS.eCursorTyp.Normal)
                            Case 2
                                BWS.SetCursorTyp(BWS.eCursorTyp.Invers)
                            Case 3
                                BWS.SetCursorTyp(BWS.eCursorTyp.Full)
                        End Select
                    Case 4                                                          'Cursor EIN mit HL als BWS-Adresse
                        BWSA = Cursor_buffer(4) * 256 + Cursor_buffer(3)
                        HL = Cursor_buffer(6) * 256 + Cursor_buffer(5)
                        If HL <= (BWSA + 80 * 32) Then
                            HL = HL - BWSA
                            X = 0
                            Y = 0
                            While HL > 80
                                HL = HL - 80
                                Y = Y + 1
                            End While
                            X = HL
                            BWS.SetCursor(X, Y)
                        End If
                End Select
            End If

        Catch ex As Exception
            MsgBox("IOsim.Cursor_out_s1: " + ex.Message)
        End Try

        Cursor_out_s1 = 0
    End Function
#End Region

#Region "Date/Time"
    Private Function Date_in()
        Date_in = Nothing
        Try
            If Date_buffer(0) = 0 Then
                Date_buffer(1) = Now.Day
                Date_buffer(2) = Now.Month
                Date_buffer(3) = Format(Now.Year).Substring(2)
            End If

            Date_buffer(0) = Date_buffer(0) + 1
            If Date_buffer(0) < 4 Then
                Date_in = Date_buffer(Date_buffer(0))
            End If

            If Date_buffer(0) = 3 Then
                Date_buffer(0) = 0
            End If
        Catch ex As Exception
            MsgBox("IOsim.DateTime_in: " + ex.Message)
        End Try
    End Function
    Private Function Time_in()
        Dim Time_str As String
        Time_in = Nothing
        Try
            If Time_buffer(0) = 0 Then
                Time_str = Format$(Now, "hh:mm:ss")
                For Time_buffer(0) = 0 To Len(Time_str) - 1
                    Time_buffer(Time_buffer(0)) = Time_str.Substring(Time_buffer(0), 1)
                Next Time_buffer(0)
            End If

            Time_buffer(0) = Time_buffer(0) + 1
            If Time_buffer(0) < 4 Then
                Time_in = Time_buffer(Time_buffer(0))
            End If

            If Time_buffer(0) = 3 Then
                Time_buffer(0) = 0
            End If
        Catch ex As Exception
            MsgBox("IOsim.DateTime_out: " + ex.Message)
        End Try
    End Function
#End Region

#Region "Corect BWS FDH"
    Private Function CorrBWS_out() As Byte
        Call BWS.ResetControlArray2()

        CorrBWS_out = 0
    End Function
#End Region

#End Region

End Class
