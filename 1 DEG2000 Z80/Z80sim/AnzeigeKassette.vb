Imports System
Imports System.IO

Public Class AnzeigeKassette

    Private Kassette As New KassettenLW
    Private Anz As Byte

    Private Sub AnzeigeKassette_Load(sender As System.Object, e As System.EventArgs) Handles MyBase.Load
        Call COMMON.initGrid(RecordAnsicht, Drawing.Color.Gainsboro, Drawing.Color.Gainsboro, Drawing.Color.Black, Drawing.Color.Black)
        Call COMMON.initGrid(Anzeige, Drawing.Color.Gainsboro, Drawing.Color.Gainsboro, Drawing.Color.Black, Drawing.Color.Black)
        Call COMMON.PrintGrid(Anzeige, {""})
        Call COMMON.PrintGrid(Anzeige, {""})
        Call COMMON.PrintGrid(Anzeige, {""})
        Call ButtonE(False)

        'Call COMMON.PrintGrid(Anzeige, {"r ... einen Satz vorwärts                  e,E ... Ende"})
        'Call COMMON.PrintGrid(Anzeige, {"R ... einen Satz rückwärts"})
        'Call COMMON.PrintGrid(Anzeige, {"b ... Nächste  Bandmarke                   "})
        'Call COMMON.PrintGrid(Anzeige, {"B ... Vorige   Bandmarke"})
        'Call COMMON.PrintGrid(Anzeige, {""})
        'Call COMMON.PrintGrid(Anzeige, {"A ... Bandanfang"})
        'Call COMMON.PrintGrid(Anzeige, {"d ... zur Datei"})
        'Call COMMON.PrintGrid(Anzeige, {"D ... zum Verzeichnis"})
    End Sub ' AnzeigeKassette_Load

    'Private Sub AnzeigeKassette_Deactivate(sender As Object, e As System.EventArgs) Handles Me.Deactivate
    '    Haupt.KassetteAnzeigen.Checked = False
    'End Sub ' AnzeigeKassette_Deactivate

    Private Sub RecordAnzeigen()
        Dim i, j As Int16
        Dim hilf As String

        Try
            Call COMMON.initGrid(RecordAnsicht, Drawing.Color.Gainsboro, Drawing.Color.Gainsboro, Drawing.Color.Black, Drawing.Color.Black)
            Anzeige.Rows(1).Cells(0).Value = ""
            Anzeige.Rows(2).Cells(0).Value = ""
            Anzeige.Rows(3).Cells(0).Value = ""

            With RecordAnsicht
                Select Case Anz
                    Case 1
                        Select Case Chr(Kassette.buffer.b(1).z(0))
                            Case "B"
                                Anzeige.Rows(0).Cells(0).Value = "B a n d  M a r k e"               '15
                            Case "S"
                                Anzeige.Rows(0).Cells(0).Value = "S c h l u s s l ü c k e"          '15
                            Case Else
                                Call RecordAnzeigen1()
                                hilf = ""
                                For i = 0 To 15
                                    .Rows(0).Cells(i + 1).Value = COMMON.vZ80cpu.HexAnzeigeByte(Kassette.buffer.b(1).z(i))
                                    If Kassette.buffer.b(1).z(i) > &H1F And Kassette.buffer.b(1).z(i) < &H7F Then
                                        hilf = hilf + Chr(Kassette.buffer.b(1).z(i))
                                    Else
                                        hilf = hilf + "."
                                    End If
                                Next
                                .Rows(0).Cells(18).Value = hilf
                                .Refresh()
                        End Select
                    Case 2
                        Call RecordAnzeigen1()
                        Kassette.D = 0 : Kassette.E = 0
                        For j = 1 To 2
                            hilf = ""
                            For i = 0 To 15
                                .Rows(j - 1).Cells(i + 1).Value = COMMON.vZ80cpu.HexAnzeigeByte(Kassette.buffer.b(j).z(i))
                                If Kassette.buffer.b(j).z(i) > &H1F And Kassette.buffer.b(j).z(i) < &H7F Then
                                    hilf = hilf + Chr(Kassette.buffer.b(j).z(i))
                                Else
                                    hilf = hilf + "."
                                End If
                            Next
                            .Rows(j - 1).Cells(18).Value = hilf
                            .Refresh()
                            Call Kassette.CRC(Kassette.buffer.b(j))
                        Next
                        Anzeige.Rows(0).Cells(0).Value = "CRC-Satz : " + COMMON.vZ80cpu.HexAnzeigeByte(Kassette.buffer.b(0).z(14)) +
                                                                         COMMON.vZ80cpu.HexAnzeigeByte(Kassette.buffer.b(0).z(15))
                        Anzeige.Rows(1).Cells(0).Value = "CRC      : " + COMMON.vZ80cpu.HexAnzeigeByte(Kassette.D) + COMMON.vZ80cpu.HexAnzeigeByte(Kassette.E)
                        Kassette.D1 = 0 : Kassette.E1 = 0
                        Anzeige.Rows(3).Cells(0).Value = "CRC-Datei: " + COMMON.vZ80cpu.HexAnzeigeByte(Kassette.D1) + COMMON.vZ80cpu.HexAnzeigeByte(Kassette.E1)
                    Case 8
                        Call RecordAnzeigen1()
                        Kassette.D = 0 : Kassette.E = 0
                        For j = 1 To Anz
                            hilf = ""
                            For i = 0 To 15
                                .Rows(j - 1).Cells(i + 1).Value = COMMON.vZ80cpu.HexAnzeigeByte(Kassette.buffer.b(j).z(i))
                                If Kassette.FilePos > 5 * 16 And Kassette.FilePos < 75 * 16 Then
                                    If COMMON.EBDC(Kassette.buffer.b(j).z(i)) > &H1F And COMMON.EBDC(Kassette.buffer.b(j).z(i)) < &H7F Then
                                        hilf = hilf + Chr(COMMON.EBDC(Kassette.buffer.b(j).z(i)))
                                    Else
                                        hilf = hilf + "."
                                    End If
                                Else
                                    If Kassette.buffer.b(j).z(i) > &H1F And Kassette.buffer.b(j).z(i) < &H7F Then
                                        hilf = hilf + Chr(Kassette.buffer.b(j).z(i))
                                    Else
                                        hilf = hilf + "."
                                    End If

                                End If
                            Next
                            .Rows(j - 1).Cells(18).Value = hilf
                            .Refresh()
                            Call Kassette.CRC(Kassette.buffer.b(j))
                        Next
                        Anzeige.Rows(0).Cells(0).Value = "CRC-Satz : " + COMMON.vZ80cpu.HexAnzeigeByte(Kassette.buffer.b(0).z(14)) +
                                                                         COMMON.vZ80cpu.HexAnzeigeByte(Kassette.buffer.b(0).z(15))
                        Anzeige.Rows(1).Cells(0).Value = "CRC      : " + COMMON.vZ80cpu.HexAnzeigeByte(Kassette.D) + COMMON.vZ80cpu.HexAnzeigeByte(Kassette.E)
                        Kassette.D = Kassette.D1 : Kassette.E = Kassette.E1
                        For j = 1 To Anz
                            Call Kassette.CRC(Kassette.buffer.b(j))
                        Next
                        Kassette.D1 = Kassette.D : Kassette.E1 = Kassette.E
                        Anzeige.Rows(3).Cells(0).Value = "CRC-Datei: " + COMMON.vZ80cpu.HexAnzeigeByte(Kassette.D1) + COMMON.vZ80cpu.HexAnzeigeByte(Kassette.E1)
                End Select
            End With
        Catch ex As Exception
        End Try
    End Sub ' RecordAnzeigen
    Private Sub RecordAnzeigen1()
        Dim j As Int16

        With RecordAnsicht
            For j = 1 To Anz
                .Rows.Add({"", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", " ", ""})
                .Rows(.Rows.Count - 1).Height = 20
            Next
        End With
    End Sub ' RecordAnzeigen1

    Private Sub OpenCassette_Click(sender As System.Object, e As System.EventArgs) Handles OpenCassette.Click
        OpenFileDialog1.InitialDirectory = COMMON.TapeVerzeichnis
        OpenFileDialog1.FileName = "*.CAS"
        If OpenFileDialog1.ShowDialog() = Windows.Forms.DialogResult.OK Then
            Kassette.Open_Kassette(OpenFileDialog1.FileName)
            Select Case Kassette.FilePos
                Case -1
                Case Else
                    Call ButtonE(True)
                    'Call Kassette.Next_Record()
                    Anz = Kassette.Lesen_Record()
                    Call RecordAnzeigen()
            End Select
        End If
    End Sub ' OpenCassette_Click

    Private Sub ButtonE(ByVal vis As Boolean)
        Verzeichnis.Enabled = vis
        Datei.Enabled = vis
        Rewind.Enabled = vis
        BMback.Enabled = vis
        BMvor.Enabled = vis
        RecordBack.Enabled = vis
        RecordVor.Enabled = vis
    End Sub ' ButtonE

    Private Sub Verzeichnis_Click(sender As System.Object, e As System.EventArgs) Handles Verzeichnis.Click         '"D"
        Dim i As Integer
        '        If Kassette.FilePos > 462 * 16 Then
        Call Kassette.Rewind()
        For i = 1 To 2 + 3 + 3
            Anz = Kassette.Lesen_Record
        Next
        '        End If
        Call RecordAnzeigen()
    End Sub ' Verzeichnis_Click

    Private Sub Datei_Click(sender As System.Object, e As System.EventArgs) Handles Datei.Click                     '"d"
        If Anz = 2 Then
            Anz = Kassette.BM_nr(Kassette.buffer.b(2).z(7))                     ' (2).(7) = Dateinummer
            Anz = Kassette.Lesen_Record
            Kassette.D1 = 0 : Kassette.E1 = 0
            Call RecordAnzeigen()
        End If
    End Sub ' Datei_Click

    Private Sub Rewind_Click(sender As System.Object, e As System.EventArgs) Handles Rewind.Click                   '"A"
        Call Kassette.Rewind()
        Anz = Kassette.Lesen_Record
        Call RecordAnzeigen()
    End Sub ' Rewind_Click

    Private Sub BMback_Click(sender As System.Object, e As System.EventArgs) Handles BMback.Click                   '"B"
        Anz = Kassette.Previous_BM
        Call RecordAnzeigen()
    End Sub ' BMback_Click

    Private Sub RecordBack_Click(sender As System.Object, e As System.EventArgs) Handles RecordBack.Click           '"R"
        Call Kassette.Back_Record()
        Call Kassette.Back_Record()
        Anz = Kassette.Lesen_Record
        Call RecordAnzeigen()
    End Sub ' RecordBack_Click

    Private Sub RecordVor_Click(sender As System.Object, e As System.EventArgs) Handles RecordVor.Click             '"r"
        'Call Kassette.Next_Record()
        Anz = Kassette.Lesen_Record
        Call RecordAnzeigen()
    End Sub ' RecordVor_Click

    Private Sub BMvor_Click(sender As System.Object, e As System.EventArgs) Handles BMvor.Click                     '"b"
        Anz = Kassette.Next_BM
        Call RecordAnzeigen()
    End Sub ' BMvor_Click
End Class ' AnzeigeKassette