Imports System
Imports System.Drawing
Imports System.IO
Imports System.Windows.Media.Converters

Public Class ucKassette

    Public Kassette As New KassettenLW
    Public RIndex As Integer
    Public Aktiv As Boolean                                                                             ' True wenn Reservieren EIN
    Public Anz As Byte
    Private KNr As Byte

#Region "Private Routinen"
    Private Sub ucKassette_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        Call COMMON.initGrid(RecordAnsicht, Drawing.Color.Gainsboro, Drawing.Color.Gainsboro, Drawing.Color.Black, Drawing.Color.Black)
        Call ButtonEnabled(False)
        'Call COMMON.PrintGrid(Anzeige, {"r ... einen Satz vorwärts                  e,E ... Ende"})
        'Call COMMON.PrintGrid(Anzeige, {"R ... einen Satz rückwärts"})
        'Call COMMON.PrintGrid(Anzeige, {"b ... Nächste  Bandmarke                   "})
        'Call COMMON.PrintGrid(Anzeige, {"B ... Vorige   Bandmarke"})
        'Call COMMON.PrintGrid(Anzeige, {""})
        'Call COMMON.PrintGrid(Anzeige, {"A ... Bandanfang"})
        'Call COMMON.PrintGrid(Anzeige, {"d ... zur Datei"})
        'Call COMMON.PrintGrid(Anzeige, {"D ... zum Verzeichnis"})
        BM.Text = ""
        BM.BackColor = SystemColors.Control
        KNr = 0
        Kassette.ucKi = Kassetten.ucK1
        Aktiv = False
    End Sub
    Private Sub ButtonEnabled(ByVal vis As Boolean)
        Verzeichnis.Enabled = vis
        Datei.Enabled = vis
        Rewind.Enabled = vis
        BMback.Enabled = vis
        BMvor.Enabled = vis
        RecordBack.Enabled = vis
        RecordVor.Enabled = vis
    End Sub ' ButtonEnabled

    Private Sub RecordAnzeigen()
        Dim i, j As Integer
        Dim hilf As String

        Try
            Call COMMON.initGrid(RecordAnsicht, Drawing.Color.Gainsboro, Drawing.Color.Gainsboro, Drawing.Color.Black, Drawing.Color.Black)
            'Anzeige.Rows(1).Cells(0).Value = ""
            'Anzeige.Rows(2).Cells(0).Value = ""
            'Anzeige.Rows(3).Cells(0).Value = ""
            If Aktiv Then
                ButtonEnabled(False)
            Else
                Select Case Kassette.MBtyp
                    Case &H10
                        Verzeichnis.Enabled = True
                        Datei.Enabled = Kassette.Dir
                    Case Else
                        Verzeichnis.Enabled = False
                        Datei.Enabled = False
                End Select
            End If

            With RecordAnsicht
                If Not Aktiv Then
                    RecordVor.Enabled = True
                    BMvor.Enabled = True
                End If

                Select Case Anz
                    Case 0
                        BM.Text = "B  A  N  D  A N F A N G"
                        BM.BackColor = Color.FromArgb(255, 255, 192)
                        crcRecord.Text = ""
                        crcFile.Text = ""
                    Case 1
                        Select Case Chr(Kassette.buffer.b(1).z(0))
                            Case "B"
                                'Anzeige.Rows(0).Cells(0).Value = "B a n d  M a r k e"               '15
                                BM.Text = "B  A  N  D  M  A  R  K  E"
                                BM.BackColor = Color.FromArgb(255, 255, 192)
                                crcRecord.Text = ""
                                crcFile.Text = ""
                            Case "S"
                                'Anzeige.Rows(0).Cells(0).Value = "S c h l u s s l ü c k e"          '15
                                BM.Text = "S c h l u s s l ü c k e"
                                BM.BackColor = Color.FromArgb(255, 255, 192)
                                crcRecord.Text = ""
                                crcFile.Text = ""
                                If Not Aktiv Then
                                    RecordVor.Enabled = False
                                    BMvor.Enabled = False
                                End If
                            Case Else
                                BM.Text = ""
                                BM.BackColor = SystemColors.Control

                                Call RecordAnzeigen1(1)
                                If Kassetten.Visible Then
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
                                End If
                        End Select
                    Case 2
                        BM.Text = ""
                        BM.BackColor = SystemColors.Control

                        Call RecordAnzeigen1(2)
                        Kassette.D = 0 : Kassette.E = 0
                        For j = 1 To 2
                            If Kassetten.Visible Then
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
                            End If
                            Call Kassette.CRC(Kassette.buffer.b(j))
                        Next
                        'Anzeige.Rows(0).Cells(0).Value = "CRC-Satz : " + COMMON.vZ80cpu.HexAnzeigeByte(Kassette.buffer.b(0).z(14)) +
                        '                                                 COMMON.vZ80cpu.HexAnzeigeByte(Kassette.buffer.b(0).z(15))
                        'Anzeige.Rows(1).Cells(0).Value = "CRC      : " + COMMON.vZ80cpu.HexAnzeigeByte(Kassette.D) + COMMON.vZ80cpu.HexAnzeigeByte(Kassette.E)
                        Kassette.D1 = 0 : Kassette.E1 = 0
                        'Anzeige.Rows(3).Cells(0).Value = "CRC-Datei: " + COMMON.vZ80cpu.HexAnzeigeByte(Kassette.D1) + COMMON.vZ80cpu.HexAnzeigeByte(Kassette.E1)
                        crcRecord.Text = COMMON.vZ80cpu.HexAnzeigeByte(Kassette.buffer.b(0).z(14)) + COMMON.vZ80cpu.HexAnzeigeByte(Kassette.buffer.b(0).z(15)) + " / " +
                                         COMMON.vZ80cpu.HexAnzeigeByte(Kassette.D) + COMMON.vZ80cpu.HexAnzeigeByte(Kassette.E)
                        crcFile.Text = COMMON.vZ80cpu.HexAnzeigeByte(Kassette.D1) + COMMON.vZ80cpu.HexAnzeigeByte(Kassette.E1)
                    Case 8
                        BM.Text = ""
                        BM.BackColor = SystemColors.Control

                        Call RecordAnzeigen1(8)
                        Kassette.D = 0 : Kassette.E = 0
                        For j = 1 To Anz
                            If Kassetten.Visible Then
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
                            End If
                            Call Kassette.CRC(Kassette.buffer.b(j))
                        Next
                        'Anzeige.Rows(0).Cells(0).Value = "CRC-Satz : " + COMMON.vZ80cpu.HexAnzeigeByte(Kassette.buffer.b(0).z(14)) +
                        '                                                 COMMON.vZ80cpu.HexAnzeigeByte(Kassette.buffer.b(0).z(15))
                        'Anzeige.Rows(1).Cells(0).Value = "CRC      : " + COMMON.vZ80cpu.HexAnzeigeByte(Kassette.D) + COMMON.vZ80cpu.HexAnzeigeByte(Kassette.E)
                        Kassette.D = Kassette.D1 : Kassette.E = Kassette.E1
                        For j = 1 To Anz
                            Call Kassette.CRC(Kassette.buffer.b(j))
                        Next
                        Kassette.D1 = Kassette.D : Kassette.E1 = Kassette.E
                        'Anzeige.Rows(3).Cells(0).Value = "CRC-Datei: " + COMMON.vZ80cpu.HexAnzeigeByte(Kassette.D1) + COMMON.vZ80cpu.HexAnzeigeByte(Kassette.E1)

                        crcRecord.Text = COMMON.vZ80cpu.HexAnzeigeByte(Kassette.buffer.b(0).z(14)) + COMMON.vZ80cpu.HexAnzeigeByte(Kassette.buffer.b(0).z(15)) + " / " +
                                         COMMON.vZ80cpu.HexAnzeigeByte(Kassette.D) + COMMON.vZ80cpu.HexAnzeigeByte(Kassette.E)
                        crcFile.Text = COMMON.vZ80cpu.HexAnzeigeByte(Kassette.D1) + COMMON.vZ80cpu.HexAnzeigeByte(Kassette.E1)
                End Select
                Select Case Kassette.MBtyp
                    Case &H10
                        FilePos.Text = "MRES"
                    Case &HEE
                        FilePos.Text = "undefiniert"
                    Case &HFF
                        FilePos.Text = "FREI"
                End Select
                FilePos.Text = FilePos.Text + " / "
                FilePos.Text = FilePos.Text + "FilePos: " + Format(Kassette.FilePos, "##,###,##0") +
                                             "  Record: " + Format(Kassette.Record, "##,###,##0")
                If Not Aktiv Then
                    If Kassette.Record = 1 Then
                        RecordBack.Enabled = False
                        BMback.Enabled = False
                    Else
                        RecordBack.Enabled = True
                        BMback.Enabled = True
                    End If
                End If
            End With
        Catch ex As Exception
        End Try
    End Sub ' RecordAnzeigen
    Private Sub RecordAnzeigen1(Anz1 As Integer)
        Dim j As Integer

        If Not Kassetten.Visible Then Exit Sub

        With RecordAnsicht
            For j = 1 To Anz1
                .Rows.Add({"", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", " ", ""})
                .Rows(.Rows.Count - 1).Height = 20
            Next
        End With
    End Sub ' RecordAnzeigen1

#Region "Click Routinen"
    Private Sub Rewind_Click(sender As System.Object, e As System.EventArgs) Handles Rewind.Click                   '"A"
        Call Cassette_Rewind()
        Call ChangeFocus()
    End Sub ' Rewind_Click

    Private Sub BMback_Click(sender As System.Object, e As System.EventArgs) Handles BMback.Click                   '"B"
        Call Cassette_BMback()
        Call ChangeFocus()
    End Sub ' BMback_Click
    Private Sub RecordBack_Click(sender As System.Object, e As System.EventArgs) Handles RecordBack.Click           '"R"
        Call Cassette_RecordBack()
        Call ChangeFocus()
    End Sub ' RecordBack_Click

    Private Sub Verzeichnis_Click(sender As System.Object, e As System.EventArgs) Handles Verzeichnis.Click         '"D"
        Dim i As Integer
        '        If Kassette.FilePos > 462 * 16 Then
        Call Kassette.Rewind()
        For i = 1 To 2 + 3 + 3
            Anz = Kassette.Record_Lesen
        Next
        '        End If
        Call RecordAnzeigen()
        Call ChangeFocus()
    End Sub ' Verzeichnis_Click
    Private Sub Datei_Click(sender As System.Object, e As System.EventArgs) Handles Datei.Click                     '"d"
        If Anz = 2 Then
            Anz = Kassette.BM_nr(Kassette.buffer.b(2).z(7))                     ' (2).(7) = Dateinummer
            Anz = Kassette.Record_Lesen
            Kassette.D1 = 0 : Kassette.E1 = 0
            Call RecordAnzeigen()
        End If
        Call ChangeFocus()
    End Sub ' Datei_Click

    Private Sub RecordVor_Click(sender As System.Object, e As System.EventArgs) Handles RecordVor.Click             '"r"
        Call Cassette_RecordVor()
        Call ChangeFocus()
    End Sub ' RecordVor_Click
    Private Sub BMvor_Click(sender As System.Object, e As System.EventArgs) Handles BMvor.Click                     '"b"
        Call Cassette_BMvor()
        Call ChangeFocus()
    End Sub ' BMvor_Click

    Private Sub OpenCassette_Click(sender As System.Object, e As System.EventArgs) Handles OpenCassette.Click
        Select Case sender.Parent.Name
            Case "ucK1"
                KNr = 0
                Kassette.ucKi = Kassetten.ucK1
            Case "ucK2"
                KNr = 1
                Kassette.ucKi = Kassetten.ucK2
            Case "ucK3"
                KNr = 2
                Kassette.ucKi = Kassetten.ucK3
            Case "ucK4"
                KNr = 3
                Kassette.ucKi = Kassetten.ucK4
            Case "ucK5"
                KNr = 4
                Kassette.ucKi = Kassetten.ucK5
            Case "ucK6"
                KNr = 5
                Kassette.ucKi = Kassetten.ucK6
        End Select
        Call OpenKassette1(OpenCassette.Text, KNr)
        Call ChangeFocus()
    End Sub

    Private Sub CreateKassette_Click(sender As Object, e As EventArgs) Handles CreateCassette.Click
        Select Case sender.Parent.Name
            Case "ucK1"
                KNr = 0
                Kassette.ucKi = Kassetten.ucK1
            Case "ucK2"
                KNr = 1
                Kassette.ucKi = Kassetten.ucK2
            Case "ucK3"
                KNr = 2
                Kassette.ucKi = Kassetten.ucK3
            Case "ucK4"
                KNr = 3
                Kassette.ucKi = Kassetten.ucK4
            Case "ucK5"
                KNr = 4
                Kassette.ucKi = Kassetten.ucK5
            Case "ucK6"
                KNr = 5
                Kassette.ucKi = Kassetten.ucK6
        End Select
        Call CreateKassette1(CreateCassette.Text, KNr)
        Call ChangeFocus()
    End Sub

    Private Sub ChangeFocus()
        If Tastatur.Visible Then
            Tastatur.Focus()
        ElseIf BWS.Visible Then
            BWS.Focus()
        End If
    End Sub
#End Region

#End Region

#Region "Public Routinen"

#Region "OpenKassette"
    Public Sub OpenKassette1(ButtonText As String, RowIndex As Integer)
        Try
            If ButtonText = "Open" Then
                OpenFileDialog1.InitialDirectory = COMMON.TapeVerzeichnis
                OpenFileDialog1.FileName = "*.CAS"
                If OpenFileDialog1.ShowDialog() = Windows.Forms.DialogResult.OK Then
                    CreateCassette.Enabled = False
                    Kassette.Open_Kassette(OpenFileDialog1.FileName)
                    Select Case Kassette.FilePos
                        Case -1
                        Case Else
                            FilePos.Text = Kassette.FilePos
                            Call ButtonEnabled(True)
                            OpenCassette.Text = "Close"
                            'Call Kassette.Next_Record()
                            '# Anz = Kassette.Record_Lesen()
                            Anz = 0
                            Kassette.MBtyp = &HEE
                            Call RecordAnzeigen()
                            With Laufwerke.Kassetten1
                                If Kassette.RO Then
                                    .Rows(RowIndex).Cells("DateinameK").Style.BackColor = Drawing.Color.LightPink
                                Else
                                    .Rows(RowIndex).Cells("DateinameK").Style.BackColor = Drawing.Color.LightGreen
                                End If
                                .Rows(RowIndex).Cells("DateinameK").Value = OpenFileDialog1.FileName
                                .Rows(RowIndex).Cells("ChangeK").Value = "Close"
                                .Rows(RowIndex).Cells("CheckCreateK").Value = True
                            End With
                            RIndex = RowIndex
                    End Select
                End If
            Else                                                                      ' Close
                CreateCassette.Enabled = True
                Call COMMON.initGrid(RecordAnsicht, Drawing.Color.Gainsboro, Drawing.Color.Gainsboro, Drawing.Color.Black, Drawing.Color.Black)
                Kassette.Close_Kassette()
                Call ButtonEnabled(False)
                OpenCassette.Text = "Open"
                crcRecord.Text = ""
                crcFile.Text = ""
                BM.Text = ""
                BM.BackColor = SystemColors.Control
                FilePos.Text = ""
                With Laufwerke.Kassetten1
                    .Rows(RowIndex).Cells("DateinameK").Style.BackColor = Drawing.Color.LightBlue
                    .Rows(RowIndex).Cells("DateinameK").Value = "Keine Zuordnung"
                    .Rows(RowIndex).Cells("ChangeK").Value = "Open"
                    .Rows(RowIndex).Cells("CheckCreateK").Value = False
                End With
            End If
        Catch ex As Exception
            MsgBox("ucKassette.OpenKassette1 : " + ex.Message)
        End Try
    End Sub
    Public Sub OpenKassette2(ButtonText As String, RowIndex As Integer, AKB As Int16)
        Kassetten.TabControl1.SelectTab(AKB - 1)
        Call OpenKassette1(ButtonText, RowIndex)
    End Sub
#End Region

#Region "CreateKassette"
    Private Sub CreateKassette1(ButtonText As String, RowIndex As Integer)
        Try
            If ButtonText = "Create" Then
                SaveFileDialog1.InitialDirectory = COMMON.TapeVerzeichnis
                SaveFileDialog1.FileName = "*.CAS"
                If SaveFileDialog1.ShowDialog() = Windows.Forms.DialogResult.OK Then
                    CreateCassette.Enabled = False
                    Kassette.Create_Kassette(SaveFileDialog1.FileName)
                    Select Case Kassette.FilePos
                        Case -1
                        Case Else
                            FilePos.Text = Kassette.FilePos
                            Call ButtonEnabled(True)
                            OpenCassette.Text = "Close"
                            Call Kassette.Record_Back()
                            Anz = Kassette.Record_Lesen()
                            Call RecordAnzeigen()
                            With Laufwerke.Kassetten1
                                .Rows(RowIndex).Cells("DateinameK").Style.BackColor = Drawing.Color.Aquamarine
                                .Rows(RowIndex).Cells("DateinameK").Value = SaveFileDialog1.FileName
                                .Rows(RowIndex).Cells("ChangeK").Value = "Close"
                                .Rows(RowIndex).Cells("CheckCreateK").Value = True
                            End With
                    End Select
                End If
            Else                                                                      ' Close
                '###  Kassette schliessen

                CreateCassette.Enabled = True
                '#Call COMMON.initGrid(RecordAnsicht, Drawing.Color.Gainsboro, Drawing.Color.Gainsboro, Drawing.Color.Black, Drawing.Color.Black)
                Kassette.Close_Kassette()
                Call ButtonEnabled(False)
                OpenCassette.Text = "Open"
                crcRecord.Text = ""
                crcFile.Text = ""
                BM.Text = ""
                BM.BackColor = SystemColors.Control
                FilePos.Text = ""
                With Laufwerke.Kassetten1
                    .Rows(RowIndex).Cells("DateinameK").Value = "Keine Zuordnung"
                    .Rows(RowIndex).Cells("ChangeK").Value = "Open"
                    .Rows(RowIndex).Cells("CheckCreateK").Value = False
                End With
            End If
        Catch ex As Exception

        End Try
    End Sub
    Public Sub CreateKassette2(ButtonText As String, RowIndex As Integer, AKB As Int16)
        Kassetten.TabControl1.SelectTab(AKB - 1)
        Call CreateKassette1(ButtonText, RowIndex)
    End Sub
#End Region

#Region "RenameKassette"
    Public Sub RenameKassette(Name As String, RowIndex As Integer)
        Dim NameOld As String
        Try
            Name = Name + ".CAS"
            NameOld = Laufwerke.Kassetten1.Rows(RowIndex).Cells("DateinameK").Value
            Kassette.Close_Kassette()                                                               ' Kassette schließen

            My.Computer.FileSystem.RenameFile(NameOld, Name)                                        ' Kassette umbenennen

            NameOld = Path.GetDirectoryName(NameOld) + "\"

            Kassette.Open_Kassette(NameOld + Name)
            Laufwerke.Kassetten1.Rows(RowIndex).Cells("DateinameK").Value = NameOld + Name

            Kassette.Record_Lesen()                                                                 ' BM       lesen
            Kassette.Record_Lesen()                                                                 ' 1. Block lesen
            Kassette.Record_Lesen()                                                                 ' 2. Block lesen
            Cassette_ReadBlock()                                                                    ' 3. Block lesen und anzeigen
        Catch ex As Exception
            MsgBox("ucKassette.RenameKassette: ", ex.Message)
        End Try
    End Sub
#End Region

#Region "öffentliche Kassetten-Routinen"
    Public Sub Cassette_Rewind()
        Call Kassette.Rewind()
        '# Anz = Kassette.Record_Lesen
        Anz = 0
        Kassette.MBtyp = &HEE
        Call RecordAnzeigen()
        '#        Me.Refresh()
    End Sub

    Public Sub Cassette_RecordVor()
        'Call Kassette.Next_Record()
        Anz = Kassette.Record_Lesen
        Call RecordAnzeigen()
    End Sub
    Public Sub Cassette_RecordBack()
        Call Kassette.Record_Back()
        Call Kassette.Record_Back()
        Anz = Kassette.Record_Lesen
        Call RecordAnzeigen()
    End Sub

    Public Sub Cassette_BMvor()
        Anz = Kassette.Next_BM
        Call RecordAnzeigen()
    End Sub
    Public Sub Cassette_BMback()
        Anz = Kassette.Previous_BM
        Call RecordAnzeigen()
        If Kassette.Record = 0 Then
            Call Cassette_RecordVor()
        End If
    End Sub
    Public Sub Cassette_ReadBlock()
        Anz = Kassette.Record_Lesen
        Call RecordAnzeigen()
    End Sub
    Public Sub Cassette_WriteRecord(ByVal Laenge As Byte)
        Call Kassette.Record_Schreiben(Laenge)
        Call Cassette_DisplayAfterWrite()
    End Sub
    Public Sub Cassette_WriteSpezialRecord(ByVal Kennung As String, ByVal Laenge As Byte, Optional ByVal FirstBM As Boolean = False)
        Call Kassette.SpezialRecord_Schreiben(Kennung, Laenge, FirstBM)
        Call Cassette_DisplayAfterWrite()
    End Sub
    Private Sub Cassette_DisplayAfterWrite()
        Call Kassette.Record_Back()
        Anz = Kassette.Record_Lesen
        Call RecordAnzeigen()
    End Sub

#Region "MouseHover für die Button"
    Private Sub Rewind_MouseHover(sender As Object, e As EventArgs) Handles Rewind.MouseHover
        If Rewind.Enabled Then ToolTip1.Show("Bandanfang", Me.Rewind)
    End Sub
    Private Sub BMback_MouseHover(sender As Object, e As EventArgs) Handles BMback.MouseHover
        If BMback.Enabled Then ToolTip1.Show("vorherige Bandmarke", Me.BMback)
    End Sub
    Private Sub RecordBack_MouseHover(sender As Object, e As EventArgs) Handles RecordBack.MouseHover
        If RecordBack.Enabled Then ToolTip1.Show("vorheriger Record", Me.RecordBack)
    End Sub
    Private Sub Verzeichnis_MouseHover(sender As Object, e As EventArgs) Handles Verzeichnis.MouseHover
        If Verzeichnis.Enabled Then ToolTip1.Show("MRES-Directory", Me.Verzeichnis)
    End Sub
    Private Sub Datei_MouseHover(sender As Object, e As EventArgs) Handles Datei.MouseHover
        If Datei.Enabled Then ToolTip1.Show("MRES-Datei", Me.Datei)
    End Sub
    Private Sub RecordVor_MouseHover(sender As Object, e As EventArgs) Handles RecordVor.MouseHover
        If RecordVor.Enabled Then ToolTip1.Show("nächster Record", Me.RecordVor)
    End Sub
    Private Sub BMvor_MouseHover(sender As Object, e As EventArgs) Handles BMvor.MouseHover
        If BMvor.Enabled Then ToolTip1.Show("nächste Bandmarke", Me.BMvor)
    End Sub
#End Region
#End Region

#End Region

End Class
