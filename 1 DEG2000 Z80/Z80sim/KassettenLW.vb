Imports System
Imports System.Drawing
Imports System.IO
Imports System.Windows

Public Class KassettenLW

    Public KassettenDateiname As String
    Public buffer As buffer1
    Public FilePos As Integer
    Public FilePosOut As Integer
    Public Record As Integer
    Public ucKi As Object
    Public RO As Boolean
    Public MBtyp As Integer
    Public Dir As Boolean

    Public Sub New()
        buffer = New buffer1
        MBtyp = &H10
        Dir = False
    End Sub ' New KassetenLW

    Public Class zeile
        Public z(0 To 15) As Byte
    End Class
    Public Class buffer1
        Public b(0 To 8) As zeile

        Public Sub New()
            Dim i As Integer

            For i = 0 To 8
                b(i) = New zeile
            Next
        End Sub ' New buffer1
    End Class

    Private fi As FileInfo
    Private fs As FileStream
    Private fs_out As FileStream

    Private Anz As Byte
    Public D, E, D1, E1 As Byte

    Public Function Open_Kassette(ByVal Dateiname As String) As Boolean
        Try
            fi = New FileInfo(Dateiname)
            RO = fi.IsReadOnly
            '           fs = fi.Open(FileMode.Open, FileAccess.ReadWrite)
            fs = fi.OpenRead
            KassettenDateiname = Dateiname
            Open_Kassette = True
            FilePos = 0
            Record = 0
        Catch ex As Exception
            MsgBox("KassettenLW.Open_Kassette: " + "can't open file " + Dateiname)
            KassettenDateiname = ""
            Open_Kassette = False
            FilePos = -1
        End Try
    End Function

    Public Function Create_Kassette(ByVal Dateiname As String) As Boolean
        Try
            fi = New FileInfo(Dateiname)
            fs = fi.Create
            FilePos = 0
            Record = 0
            KassettenDateiname = Dateiname
            SpezialRecord_Schreiben("B", &H10, True)
            SpezialRecord_Schreiben("S", &H10)
            'fs.Close()
            'fs = fi.OpenRead
            Create_Kassette = True
        Catch ex As Exception
            Create_Kassette = False
            FilePos = -1
        End Try
    End Function

    Public Function Close_Kassette() As Boolean
        If Not IsNothing(fs) Then
            fs.Close()
        End If
        Close_Kassette = True
        FilePos = -1
    End Function ' Close_Kassette

    Public Function Record_Lesen() As Byte
        Dim i As Byte

        Try
            If fs.Position < fs.Length - 2 * 16 Then
                fs.Read(buffer.b(0).z, 0, 16)
                If Chr(buffer.b(0).z(0)) <> "V" Then
                    Call ErrorRecord()
                    'fs.Close()
                    Record_Lesen = 0
                    Exit Function
                End If
                '
                Anz = buffer.b(0).z(1) \ 16
                For i = 1 To Anz
                    fs.Read(buffer.b(i).z, 0, 16)
                Next
                If fs.Position = 32 Then
                    Select Case buffer.b(1).z(0)
                        Case &H42                               ' "B"
                            Select Case buffer.b(1).z(15)
                                Case &H42                       ' "B"
                                    MBtyp = &H10
                                Case Else
                                    MBtyp = &HFF
                            End Select
                    End Select
                End If
                If MBtyp = &H10 And Anz = 2 And buffer.b(0).z(3) = &H57 Then
                    Dir = True
                Else
                    Dir = False
                End If

                '
                fs.Read(buffer.b(0).z, 0, 16)
                If Chr(buffer.b(0).z(0)) <> "N" Then
                    Call ErrorRecord()
                    'fs.Close()
                    Record_Lesen = 0
                    Exit Function
                End If
                Record_Lesen = Anz
            Else
                Record_Lesen = 0
            End If
        Catch ex As Exception
            Record_Lesen = 0
            MsgBox("KassettenLW.Lesen_Record: " + ex.Message,, "Kassette lesen")
        End Try
        FilePos = fs.Position
        Record = Record + 1
    End Function ' Lesen_Record

    Public Sub Record_Next()
        fs.Read(buffer.b(0).z, 0, 16)
        If Chr(buffer.b(0).z(0)) <> "V" Then
            Call ErrorRecord()
            'fs.Close()
            Exit Sub
        End If
        '
        Anz = buffer.b(0).z(1) \ 16
        fs.Position = fs.Position + Anz * 16
        '
        fs.Read(buffer.b(0).z, 0, 16)
        If Chr(buffer.b(0).z(0)) <> "N" Then
            Call ErrorRecord()
            'fs.Close()
            Exit Sub
        End If
        FilePos = fs.Position
        Record = Record + 1
    End Sub ' Next_Record

    Public Function Record_Back() As Byte
        Dim i As Integer

        Try
            If fs.Position > 0 Then
                fs.Position = fs.Position - 1 * 16
                '
                fs.Read(buffer.b(0).z, 0, 16)
                If Chr(buffer.b(0).z(0)) <> "N" Then
                    Call ErrorRecord()
                    'fs.Close()
                    Record_Back = 0
                    Exit Function
                End If
                '
                Anz = buffer.b(0).z(1) \ 16
                '
                For i = Anz To 1 Step -1
                    fs.Position = fs.Position - 2 * 16
                    fs.Read(buffer.b(i).z, 0, 16)
                Next
                '
                fs.Position = fs.Position - 2 * 16
                fs.Read(buffer.b(0).z, 0, 16)
                If Chr(buffer.b(0).z(0)) <> "V" Then
                    Call ErrorRecord()
                    'fs.Close()
                    Record_Back = 0
                    Exit Function
                End If
                fs.Position = fs.Position - 1 * 16
                Record_Back = Anz
            Else
                Record_Back = 0
            End If
        Catch ex As Exception
            Record_Back = 0
        End Try
        FilePos = fs.Position
        Record = Record - 1
    End Function ' Back_Record

    Public Function Next_BM() As Byte
        Do
            Anz = Record_Lesen()
        Loop Until Anz = 1 And (Chr(buffer.b(1).z(0)) = "B" Or fs.Position = fs.Length)
        Next_BM = Anz
        FilePos = fs.Position
    End Function ' Next_BM

    Public Function Previous_BM() As Byte
        Do
            Anz = Record_Back()
        Loop Until Anz = 1 And Chr(buffer.b(1).z(0)) = "B"
        Previous_BM = Anz
        FilePos = fs.Position
    End Function ' Previous_BM

    Public Function BM_nr(ByVal nr As Byte) As Byte
        Dim i As Byte
        For i = 1 To nr
            Do
                Anz = Record_Lesen()
            Loop Until Anz = 1 And (Chr(buffer.b(1).z(0)) = "B" Or fs.Position = fs.Length)
        Next
        BM_nr = Anz
        FilePos = fs.Position
    End Function ' BM_nr

    Public Sub Rewind()
        fs.Position = 0
        FilePos = fs.Position
        Record = 0
    End Sub ' Rewind

    Public Sub SpezialBlock_Schreiben(ByVal s As String, ByVal Laenge As Byte, Optional ByVal FirstBM As Boolean = False)
        Dim i As Byte

        Try
            For i = 0 To 15
                buffer.b(0).z(i) = Asc(s)
            Next
            buffer.b(0).z(1) = Laenge
            If FirstBM Then
                buffer.b(0).z(15) = &HFF
            End If
            If s = "N" And (Laenge = &H20 Or Laenge = &H80) Then
                buffer.b(0).z(14) = D
                buffer.b(0).z(15) = E
            End If
            fs_out.Write(buffer.b(0).z, 0, 16)
        Catch ex As Exception
            MsgBox("KassettenLW.Schreiben_Block ('" + s + "'): " + ex.Message)
        End Try
    End Sub ' Schreiben_Block
    Public Sub SpezialRecord_Schreiben(ByVal Kennung As String, ByVal Laenge As Byte, Optional ByVal FirstBM As Boolean = False)
        '                                                                                           
        '                                                                                           
        Try
            fs.Close()
            FilePosOut = FilePos
            fs_out = fi.OpenWrite()
            fs_out.Position = FilePosOut
            Call SpezialBlock_Schreiben("V", Laenge, FirstBM)
            Call SpezialBlock_Schreiben(Kennung, Laenge, FirstBM)
            Call SpezialBlock_Schreiben("N", Laenge, FirstBM)

            fs_out.Flush()
            fs_out.Close()

            fs = fi.OpenRead()
            fs.Position = FilePos

            Call Record_Lesen()
        Catch ex As Exception
            MsgBox("KassettenLW.SpezialRecord_Schreiben: " + ex.Message)
        End Try
    End Sub ' SpezialBlock_Schreiben

    Public Sub Record_Schreiben(ByVal Laenge As Byte)
        Try
            fs.Close()
            FilePosOut = FilePos
            fs_out = fi.OpenWrite()
            fs_out.Position = FilePosOut
            Call SpezialBlock_Schreiben("V", Laenge)

            Anz = Laenge \ 16
            For i = 1 To Anz
                fs_out.Write(buffer.b(i).z, 0, 16)
            Next

            Call SpezialBlock_Schreiben("N", Laenge)

            fs_out.Flush()
            fs_out.Close()

            fs = fi.OpenRead()
            fs.Position = FilePos

            Call Record_Lesen()
        Catch ex As Exception
            MsgBox("KassettenLW.Record_Schreiben: " + ex.Message)
        End Try
    End Sub
    Public Sub CRC(buf As zeile)
        Dim B1, B2, A, C As Byte
        Dim CY, CY1, CY2 As Byte

        For B1 = 0 To 15
            C = buf.z(B1)
            For B2 = 1 To 8
                A = C
                A = A Xor D
                If (A And &H1) = &H1 Then CY = 1 Else CY = 0

                A = A \ 2
                If CY = 1 Then A = A Or &H80

                If (E And &H1) = &H1 Then CY1 = 1 Else CY1 = 0
                E = E \ 2
                If CY = 1 Then E = E Or &H80

                If (D And &H1) = &H1 Then CY2 = 1 Else CY2 = 0
                D = D \ 2
                If CY1 = 1 Then D = D Or &H80
                If CY = 1 Then
                    D = D Xor &H1
                    E = E Xor &H20
                End If
                If (C And &H1) = &H1 Then CY = 1 Else CY = 0
                C = C \ 2
                If CY = 1 Then C = C Or &H80
            Next
        Next
    End Sub

    Private Sub ErrorRecord()
        Try
            Select Case ucKi.name
                Case "ucK1"
                    With Kassetten.ucK1
                        .BM.BackColor = Color.FromArgb(255, 192, 192)
                        '.BM.ForeColor = System.Drawing.Color.Red
                        .BM.Text = "Fehler: " + Chr(buffer.b(0).z(0))
                        .crcRecord.Text = ""
                        .crcFile.Text = ""
                    End With
                Case "ucK2"
                    With Kassetten.ucK2
                        .BM.BackColor = Color.FromArgb(255, 192, 192)
                        '.BM.ForeColor = System.Drawing.Color.Red
                        .BM.Text = "Fehler: " + Chr(buffer.b(0).z(0))
                        .crcRecord.Text = ""
                        .crcFile.Text = ""
                    End With
                Case "ucK3"
                    With Kassetten.ucK3
                        .BM.BackColor = Color.FromArgb(255, 192, 192)
                        '.BM.ForeColor = System.Drawing.Color.Red
                        .BM.Text = "Fehler: " + Chr(buffer.b(0).z(0))
                        .crcRecord.Text = ""
                        .crcFile.Text = ""
                    End With
                Case "ucK4"
                    With Kassetten.ucK4
                        .BM.BackColor = Color.FromArgb(255, 192, 192)
                        '.BM.ForeColor = System.Drawing.Color.Red
                        .BM.Text = "Fehler: " + Chr(buffer.b(0).z(0))
                        .crcRecord.Text = ""
                        .crcFile.Text = ""
                    End With
                Case "ucK5"
                    With Kassetten.ucK5
                        .BM.BackColor = Color.FromArgb(255, 192, 192)
                        '.BM.ForeColor = System.Drawing.Color.Red
                        .BM.Text = "Fehler: " + Chr(buffer.b(0).z(0))
                        .crcRecord.Text = ""
                        .crcFile.Text = ""
                    End With
                Case "ucK6"
                    With Kassetten.ucK6
                        .BM.BackColor = Color.FromArgb(255, 192, 192)
                        '.BM.ForeColor = System.Drawing.Color.Red
                        .BM.Text = "Fehler: " + Chr(buffer.b(0).z(0))
                        .crcRecord.Text = ""
                        .crcFile.Text = ""
                    End With
            End Select
        Catch ex As Exception
            MsgBox("KassettenLW: (" + ucKi + ") " + ex.Message)
        End Try
    End Sub

End Class
