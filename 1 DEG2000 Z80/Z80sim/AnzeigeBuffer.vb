Imports System.Drawing

Public Class AnzeigeBuffer
    Private AnzeigeSeg As UShort
    Private AnzeigeStart As Integer
    Private BereichsIndex As Byte

    Private Sub AnzeigeHS_Load(sender As System.Object, e As System.EventArgs) Handles MyBase.Load
        Dim segAdr As UShort
        Dim j As UShort
        Dim hilf1() As String
        Dim c As New NumericUpDownColumn

#Region "PCstack"
        segAdr = 0 ' COMMON.vZ80cpu.STACK - &H40
        Call COMMON.initGrid(PCstack, System.Drawing.Color.LightGray, System.Drawing.Color.LightGray, System.Drawing.Color.Black, System.Drawing.Color.Black)
        With PCstack
            For j = 0 To 7
                hilf1 = {HexAnzeige_WordByte(segAdr + j * 16, "B"),
                                             "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "",
                                             " ",
                                             ""}
                .Rows.Add(hilf1)
                .Rows(.Rows.Count - 1).Height = 20
            Next
            .Columns(18).DefaultCellStyle.Font = New System.Drawing.Font("Courier New", 12, System.Drawing.FontStyle.Regular)
            .Rows(4).Cells(1).Style.BackColor = Drawing.Color.LightBlue
            .Rows(4).Cells(2).Style.BackColor = Drawing.Color.LightBlue
        End With
#End Region
#Region "BufferKassettenSteuerung"
        segAdr = &H2B03 - 2
        Call COMMON.initGrid(BufferKassettenSteuerung, System.Drawing.Color.LightGray, System.Drawing.Color.LightGray, System.Drawing.Color.Black, System.Drawing.Color.Black)
        With BufferKassettenSteuerung
            For j = 0 To 2
                hilf1 = {HexAnzeige_WordByte(segAdr + j, "B"),
                                             "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "",
                                             " ",
                                             ""}
                .Rows.Add(hilf1)
                .Rows(.Rows.Count - 1).Height = 20
            Next
            .Columns(18).DefaultCellStyle.Font = New System.Drawing.Font("Courier New", 12, System.Drawing.FontStyle.Regular)
        End With
#End Region
#Region "BufferKassette"
        segAdr = &HE65
        Call COMMON.initGrid(BufferKassette, System.Drawing.Color.LightGray, System.Drawing.Color.LightGray, System.Drawing.Color.Black, System.Drawing.Color.Black)
        With BufferKassette
            For j = 0 To 7
                hilf1 = {HexAnzeige_WordByte(segAdr + j, "B"),
                                             "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "",
                                             " ",
                                             ""}
                .Rows.Add(hilf1)
                .Rows(.Rows.Count - 1).Height = 20
            Next
            .Columns(18).DefaultCellStyle.Font = New System.Drawing.Font("Courier New", 12, System.Drawing.FontStyle.Regular)
        End With
#End Region
#Region "BufferKassetten"
        segAdr = &H2B03 - 2
        Call COMMON.initGrid(BufferKassetten, System.Drawing.Color.LightGray, System.Drawing.Color.LightGray, System.Drawing.Color.Black, System.Drawing.Color.Black)
        With BufferKassetten
            For j = 0 To 37
                hilf1 = {HexAnzeige_WordByte(segAdr + j, "B"), j - 2, "", "", "", "", ""}
                .Rows.Add(hilf1)
                .Rows(.Rows.Count - 1).Height = 20
            Next
            '                .Columns(18).DefaultCellStyle.Font = New System.Drawing.Font("Courier New", 12, System.Drawing.FontStyle.Regular)
            For j = 0 To 4
                BufferKassetten.Rows(29).Cells(j).Style.BackColor = Color.LightBlue
            Next
        End With
#End Region
    End Sub ' AnzeigeHS_Load

#Region "Anzeige-Routinen"
    Private Sub AnzeigenPCstack()
        Dim BIndexI As UShort
        Dim i As UShort
        Dim j As UShort
        Dim adr As Integer
        Dim b As Byte
        Dim c As Byte
        Dim hilf2 As String

        Try
            AnzeigeStart = COMMON.vZ80cpu.STACK - &H40
            BIndexI = (COMMON.vZ80cpu.STACK And &HF000) / &H1000
            BereichsIndex = COMMON.vZ80cpu.Seg_HS(BIndexI)

            StackBereich.Text = BereichsIndex
            Stack.Text = HexAnzeige_WordByte(COMMON.vZ80cpu.STACK, "B")
            With PCstack
                c = AnzeigeStart And &HF
                For i = 0 To 15
                    Select Case c
                        Case 10
                            .Columns(i + 1).HeaderText = "A"
                        Case 11
                            .Columns(i + 1).HeaderText = "B"
                        Case 12
                            .Columns(i + 1).HeaderText = "C"
                        Case 13
                            .Columns(i + 1).HeaderText = "D"
                        Case 14
                            .Columns(i + 1).HeaderText = "E"
                        Case 15
                            .Columns(i + 1).HeaderText = "F"
                        Case Else
                            .Columns(i + 1).HeaderText = c
                    End Select
                    c += 1
                    If c = 16 Then c = 0
                Next
                .Enabled = True
                For j = 0 To 7
                    adr = AnzeigeStart + j * 16
                    If adr < 0 Then
                        adr = &HFFFF + adr + 1
                    End If
                    .Rows(j).Cells(0).Value = HexAnzeige_WordByte(adr, "B")
                    hilf2 = ""
                    For i = 0 To 15
                        b = COMMON.vZ80cpu.Speicher_lesen_Byte1(adr + i, BereichsIndex)
                        .Rows(j).Cells(i + 1).Value = COMMON.vZ80cpu.HexAnzeigeByte(b)
                        hilf2 += Chr(b)
                    Next
                    .Rows(j).Cells(18).Value = hilf2
                Next
                .Refresh()
            End With
        Catch ex As Exception

        End Try
    End Sub ' AnzeigenPCstack
    Private Sub AnzeigeBufferKassettenSteuerung()
        Dim i As UShort
        Dim j As UShort
        Dim b As Byte
        Dim hilf2 As String

        AnzeigeStart = &H2B03 - 2
        BereichsIndex = 1

        With BufferKassettenSteuerung
            .Enabled = True
            Try
                For j = 0 To 2
                    .Rows(j).Cells(0).Value = HexAnzeige_WordByte(AnzeigeStart + j * 16, "B")
                    hilf2 = ""
                    For i = 0 To 15
                        b = COMMON.vZ80cpu.Speicher_lesen_Byte1(AnzeigeStart + j * 16 + i, BereichsIndex)
                        .Rows(j).Cells(i + 1).Value = COMMON.vZ80cpu.HexAnzeigeByte(b)
                        hilf2 += Chr(b)
                    Next
                    .Rows(j).Cells(18).Value = hilf2
                Next
            Catch ex As Exception

            End Try
            .Refresh()
        End With
    End Sub ' AnzeigeBufferKassettenSteuerung
    Private Sub AnzeigenBuffer()
        Dim i As UShort
        Dim j As UShort
        Dim b As Byte
        Dim hilf2 As String

        AnzeigeStart = &HE65
        'BereichsIndex = Convert.ToByte(BereichsWahl.Rows(AnzeigeSeg).Cells(1).Value)
        BereichsIndex = 1

        With BufferKassette
            .Enabled = True
            Try
                For j = 0 To 7
                    .Rows(j).Cells(0).Value = HexAnzeige_WordByte(AnzeigeStart + j * 16, "B")
                    hilf2 = ""
                    For i = 0 To 15
                        b = COMMON.vZ80cpu.Speicher_lesen_Byte1(AnzeigeStart + j * 16 + i, BereichsIndex)
                        .Rows(j).Cells(i + 1).Value = COMMON.vZ80cpu.HexAnzeigeByte(b)
                        hilf2 += Chr(b)
                    Next
                    .Rows(j).Cells(18).Value = hilf2
                Next
            Catch ex As Exception

            End Try
            .Refresh()
        End With
    End Sub ' AnzeigenBuffer
    Private Sub AnzeigenBufferKassetten()
        Dim j As UShort
        Dim b As Byte
        Dim c As Byte

        AnzeigeStart = &H2B03 - 2
        BereichsIndex = 1

        With BufferKassetten
            .Enabled = True
            Try
                For j = 0 To 37
                    .Rows(j).Cells(0).Value = HexAnzeige_WordByte(AnzeigeStart + j, "B")
                    .Rows(j).Cells(1).Value = j - 2
                    b = COMMON.vZ80cpu.Speicher_lesen_Byte1(AnzeigeStart + j, BereichsIndex)
                    .Rows(j).Cells(2).Value = COMMON.vZ80cpu.HexAnzeigeByte(b)
                    Select Case j
                        Case 0
                            .Rows(j).Cells(3).Value = "K0.HSB"
                            .Rows(j).Cells(4).Value = "HS-Bereich"
                        Case 1
                            .Rows(j).Cells(3).Value = "K0.LPD"
                            .Rows(j).Cells(4).Value = "Länge der Daten"
                        Case 2
                            .Rows(j).Cells(3).Value = ""
                            .Rows(j).Cells(4).Value = "Status"
                        Case 3
                            .Rows(j).Cells(3).Value = ""
                            .Rows(j).Cells(4).Value = "Fehlerschlüssel"
                        Case 4
                            .Rows(j).Cells(3).Value = ""
                            .Rows(j).Cells(4).Value = "AKB Basisadresse"
                        Case 5
                            .Rows(j).Cells(3).Value = ""
                            .Rows(j).Cells(4).Value = "Subadresse"
                        Case 6
                            .Rows(j).Cells(3).Value = ""
                            .Rows(j).Cells(4).Value = "Kommando"
                            c = b
                        Case 7
                            .Rows(j).Cells(3).Value = ""
                            .Rows(j).Cells(4).Value = "L-Teil Adr Eintrittspunkt"
                        Case 8
                            .Rows(j).Cells(3).Value = ""
                            .Rows(j).Cells(4).Value = "H-Teil Adr Eintrittspunkt"
                        Case 9
                            .Rows(j).Cells(3).Value = ""
                            .Rows(j).Cells(4).Value = "L-Teil Blockadresse"
                        Case 10
                            .Rows(j).Cells(3).Value = ""
                            .Rows(j).Cells(4).Value = "H-Teil Blockadresse"
                        Case 11
                            .Rows(j).Cells(3).Value = ""
                            .Rows(j).Cells(4).Value = "H-Teil Blocklänge"
                        Case 12
                            .Rows(j).Cells(3).Value = ""
                            .Rows(j).Cells(4).Value = "L-Teil Blocklänge"
                        Case 13
                            .Rows(j).Cells(3).Value = ""
                            .Rows(j).Cells(4).Value = "Anz Lese-/Schreib-W"
                        Case 14
                            .Rows(j).Cells(3).Value = ""
                            .Rows(j).Cells(4).Value = "Anz Blocklückenverlägerungen"
                        Case 15
                            .Rows(j).Cells(3).Value = ""
                            .Rows(j).Cells(4).Value = "'Kmbg'"
                        Case 16
                            .Rows(j).Cells(3).Value = ""
                            .Rows(j).Cells(4).Value = "'Kmbg'"
                        Case 17
                            .Rows(j).Cells(3).Value = ""
                            .Rows(j).Cells(4).Value = ""
                        Case 18
                            .Rows(j).Cells(3).Value = ""
                            .Rows(j).Cells(4).Value = ""
                        Case 19
                            .Rows(j).Cells(3).Value = ""
                            .Rows(j).Cells(4).Value = "Blockzähler"
                        Case 20
                            .Rows(j).Cells(3).Value = ""
                            .Rows(j).Cells(4).Value = ""
                        Case 21
                            .Rows(j).Cells(3).Value = ""
                            .Rows(j).Cells(4).Value = ""
                        Case 22
                            .Rows(j).Cells(3).Value = ""
                            .Rows(j).Cells(4).Value = ""
                        Case 23
                            .Rows(j).Cells(3).Value = ""
                            .Rows(j).Cells(4).Value = "Pufferzeiger"
                        Case 24
                            .Rows(j).Cells(3).Value = ""
                            .Rows(j).Cells(4).Value = ""
                        Case 25
                            .Rows(j).Cells(3).Value = ""
                            .Rows(j).Cells(4).Value = "Pufferzähler"
                        Case 26
                            .Rows(j).Cells(3).Value = ""
                            .Rows(j).Cells(4).Value = ""
                        Case 27
                            .Rows(j).Cells(3).Value = ""
                            .Rows(j).Cells(4).Value = "Pufferadresse ?"
                        Case 28
                            .Rows(j).Cells(3).Value = ""
                            .Rows(j).Cells(4).Value = "Pufferadresse ?"
                        Case 29
                            .Rows(j).Cells(3).Value = ""
                            .Rows(j).Cells(4).Value = ""
                        Case 30
                            .Rows(j).Cells(3).Value = " 1"
                            .Rows(j).Cells(4).Value = "StartByte"
                        Case 31
                            .Rows(j).Cells(3).Value = " 2"
                            .Rows(j).Cells(4).Value = "Kommando"
                        Case 32
                            .Rows(j).Cells(3).Value = " 3"
                            .Rows(j).Cells(4).Value = "Subadresse"
                        Case 33, 34, 35, 36, 37
                            Select Case c
                                Case &H31, &H41, &H21, &H11, &H15
                                    Select Case j
                                        Case 33
                                            .Rows(j).Cells(3).Value = " 4"
                                            .Rows(j).Cells(4).Value = "Endebyte"
                                        Case 34, 35, 36, 37
                                            .Rows(j).Cells(3).Value = "---"
                                            .Rows(j).Cells(4).Value = "---"
                                    End Select
                                Case &H71, &H75
                                    Select Case j
                                        Case 33
                                            .Rows(j).Cells(3).Value = " 4"
                                            .Rows(j).Cells(4).Value = "Anzahl BM"
                                        Case 34
                                            .Rows(j).Cells(3).Value = " 5"
                                            .Rows(j).Cells(4).Value = "Endebyte"
                                        Case 35, 36, 37
                                            .Rows(j).Cells(3).Value = "---"
                                            .Rows(j).Cells(4).Value = "---"
                                    End Select
                                Case &H51
                                    Select Case j
                                        Case 33
                                            .Rows(j).Cells(3).Value = " 4"
                                            .Rows(j).Cells(4).Value = "'B'"
                                        Case 34
                                            .Rows(j).Cells(3).Value = " 5"
                                            .Rows(j).Cells(4).Value = "Endebyte"
                                        Case 35, 36, 37
                                            .Rows(j).Cells(3).Value = "---"
                                            .Rows(j).Cells(4).Value = "---"
                                    End Select
                                Case &H52
                                    Select Case j
                                        Case 33
                                            .Rows(j).Cells(3).Value = " 4"
                                            .Rows(j).Cells(4).Value = "'S'"
                                        Case 34
                                            .Rows(j).Cells(3).Value = " 5"
                                            .Rows(j).Cells(4).Value = "Endebyte"
                                        Case 35, 36, 37
                                            .Rows(j).Cells(3).Value = "---"
                                            .Rows(j).Cells(4).Value = "---"
                                    End Select
                                Case &H2
                                    Select Case j
                                        Case 33
                                            .Rows(j).Cells(3).Value = " 4"
                                            .Rows(j).Cells(4).Value = "HS-Bereich"
                                        Case 34
                                            .Rows(j).Cells(3).Value = " 5"
                                            .Rows(j).Cells(4).Value = "H(Puffer)"
                                        Case 35
                                            .Rows(j).Cells(3).Value = " 6"
                                            .Rows(j).Cells(4).Value = "L(Puffer)"
                                        Case 36
                                            .Rows(j).Cells(3).Value = " 7"
                                            .Rows(j).Cells(4).Value = "Endebyte"
                                        Case 37
                                            .Rows(j).Cells(3).Value = " 8"
                                            .Rows(j).Cells(4).Value = "---"
                                    End Select
                                Case &H8
                                    Select Case j
                                        Case 33
                                            .Rows(j).Cells(3).Value = " 4"
                                            .Rows(j).Cells(4).Value = "Länge"
                                        Case 34
                                            .Rows(j).Cells(3).Value = " 5"
                                            .Rows(j).Cells(4).Value = "HS-Bereich"
                                        Case 35
                                            .Rows(j).Cells(3).Value = " 6"
                                            .Rows(j).Cells(4).Value = "H(Puffer)"
                                        Case 36
                                            .Rows(j).Cells(3).Value = " 7"
                                            .Rows(j).Cells(4).Value = "L(Puffer)"
                                        Case 37
                                            .Rows(j).Cells(3).Value = " 8"
                                            .Rows(j).Cells(4).Value = "Endebyte"
                                    End Select
                                Case Else
                                    Select Case j
                                        Case 33
                                            .Rows(j).Cells(3).Value = " 4"
                                            .Rows(j).Cells(4).Value = "---"
                                        Case 34
                                            .Rows(j).Cells(3).Value = " 5"
                                            .Rows(j).Cells(4).Value = "---"
                                        Case 35
                                            .Rows(j).Cells(3).Value = " 6"
                                            .Rows(j).Cells(4).Value = "---"
                                        Case 36
                                            .Rows(j).Cells(3).Value = " 7"
                                            .Rows(j).Cells(4).Value = "---"
                                        Case 37
                                            .Rows(j).Cells(3).Value = " 8"
                                            .Rows(j).Cells(4).Value = "---"
                                    End Select
                            End Select
                    End Select
                Next
            Catch ex As Exception

            End Try
        End With
    End Sub ' AnzeigenBufferKassetten

    Private Sub AnzeigeBuffer_Click(sender As Object, e As EventArgs)
        Call AnzeigeBuffer1()
    End Sub

    Public Sub AnzeigeBuffer1()
        Call AnzeigenPCstack()
        Call AnzeigeBufferKassettenSteuerung()
        Call AnzeigenBuffer()
        Call AnzeigenBufferKassetten()
    End Sub
    Public Sub AnzeigeBuffer2()
        Call AnzeigenBufferKassetten()
    End Sub
#End Region

    Private Sub BufferKassetten_CellMouseEnter(sender As Object, e As DataGridViewCellEventArgs) Handles BufferKassetten.CellMouseEnter
        '    Private Sub BufferKassetten_CellMouseLeave(sender As Object, e As DataGridViewCellEventArgs) Handles BufferKassetten.CellMouseLeave
        Dim b As Byte
        '   Zeile 3 ... Fehlerschlüssel
        If (e.RowIndex = 3) And (e.ColumnIndex = 2) Then
            Dim cell As DataGridViewCell = BufferKassetten.Rows(e.RowIndex).Cells(e.ColumnIndex)
            b = cell.Value
            Select Case b
                Case 0
                    cell.ToolTipText = ""
                Case 10
                    cell.ToolTipText = "falsches Kommando"
                Case 11
                    cell.ToolTipText = "angewähltes Gerät nicht reserviert"
                Case 12
                    cell.ToolTipText = "Subadresse falsch"
                Case 13
                    cell.ToolTipText = "Pufferlänge kleiner 12 oder größer 256"
                Case 14
                    cell.ToolTipText = "Ende der Aufzeichnungen auf dieser Kassettenseite (Lesen)"
                Case 15
                    cell.ToolTipText = "angewähltes Gerät besetzt"
                Case 16
                    cell.ToolTipText = "Ende/Anfang der Aufzeichnungen (BM suchen)"
                Case 17
                    cell.ToolTipText = "gelesener Block länger 260 Byte"
                Case 18
                    cell.ToolTipText = "Bandmarke nicht gefunden"
                Case 19
                    cell.ToolTipText = "Aufzeichnen verboten (bei Kommando: Aufzeichnen)"
            End Select
        End If

        ' Zeile 6 ... Kommando
        If (e.RowIndex = 6 Or e.RowIndex = 31) And (e.ColumnIndex = 2) Then
            Dim cell As DataGridViewCell = BufferKassetten.Rows(e.RowIndex).Cells(e.ColumnIndex)
            b = cell.Value
            Select Case b
                Case 2
                    cell.ToolTipText = "nächsten Record einlesen"
                Case 8
                    cell.ToolTipText = "nächsten Record schreiben"
                Case 11
                    cell.ToolTipText = "einen Record vorsetzen"
                Case 15
                    cell.ToolTipText = "einen Record rücksetzen"
                Case 21
                    cell.ToolTipText = "umspulen (rewind)"
                Case 31
                    cell.ToolTipText = "reservieren EIN"
                Case 41
                    cell.ToolTipText = "reservieren AUS"
                Case 51
                    cell.ToolTipText = "schreiben einer Bandmarke"
                Case 61
                    cell.ToolTipText = "schreiben einer Schlusslücke"
                Case 71
                    cell.ToolTipText = "suchen n-te Bandmarke vorwärts"
                Case 75
                    cell.ToolTipText = "suchen n-te Bandmarke rückwärts"
            End Select
        End If
    End Sub

End Class
