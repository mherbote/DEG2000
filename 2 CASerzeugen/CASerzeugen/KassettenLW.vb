Imports System
Imports System.IO

Public Class KassettenLW

    Public KassettenDateiname As String
    Public Buffer As Buffer1
    Public FilePos As Integer

    Public Sub New()
        Buffer = New Buffer1
    End Sub ' New KassetenLW

    Public Class Zeile
        Public z(0 To 15) As Byte
    End Class
    Public Class Buffer1
        Public B(0 To 8) As Zeile

        Public Sub New()
            Dim i As Int16

            For i = 0 To 8
                B(i) = New Zeile
            Next
        End Sub ' New buffer1
    End Class

    Private _fi As FileInfo
    Private _fs As FileStream

    Private _anz As Byte
    Public D, E, D1, E1 As Byte

    Public Function Open_Kassette(ByVal dateiname As String) As Boolean
        Try
            _fi = New FileInfo(dateiname)
            _fs = _fi.OpenWrite
            KassettenDateiname = dateiname
            Open_Kassette = True
            FilePos = 0
        Catch ex As Exception
            MsgBox("can't open file " + dateiname)
            KassettenDateiname = ""
            Open_Kassette = False
            FilePos = -1
        End Try
    End Function

    Public Function Close_Kassette() As Boolean
        _fs.Close()
        Close_Kassette = True
        FilePos = -1
    End Function ' Close_Kassette

    Public Sub Schreiben_Block(Optional ByVal s As String = "", Optional ByVal anz As Byte = 0)
        Dim i As Byte

        Select Case UCase(s)
            Case "V", "N", "B", "S"
                For i = 0 To 15
                    Buffer.B(0).z(i) = Asc(s)
                Next
                Buffer.B(0).z(1) = anz
        End Select
        Select Case UCase(s)
            Case "V"
                D = 0 : E = 0                
            Case "N"
                Buffer.B(0).z(14) = D
                Buffer.B(0).z(15) = E
            Case Else
                Call Crc(Buffer.B(0))
        End Select
        _fs.Write(Buffer.B(0).z, 0, 16)
    End Sub ' Schreiben_Block

    Public Sub Schreiben_SpezialBlock(ByVal kennung As String)
        '                                                                       'Kennung = "B" ... Bandmarke
        '                                                                       '        = "S" ... Schlusslücke
        Call Schreiben_Block("V", &H10)
        Call Schreiben_Block(Kennung, &H10)
        Call Schreiben_Block("N", &H10)
    End Sub ' Schreiben_SpezialBlock

    Public Sub Crc(buf As Zeile)
        Dim b1 As Byte
        ' ReSharper disable NotAccessedVariable
        Dim b2 As Byte
        ' ReSharper restore NotAccessedVariable
        Dim a As Byte
        Dim c As Byte
        Dim cy, cy1, cy2 As Byte

        For b1 = 0 To 15
            c = buf.z(b1)
            For b2 = 1 To 8
                a = c
                a = a Xor D
                If (a And &H1) = &H1 Then cy = 1 Else cy = 0

                a = a \ 2
                If cy = 1 Then a = a Or &H80

                If (E And &H1) = &H1 Then cy1 = 1 Else cy1 = 0
                E = E \ 2
                If cy = 1 Then E = E Or &H80

                If (D And &H1) = &H1 Then cy2 = 1 Else cy2 = 0
                D = D \ 2
                If cy1 = 1 Then D = D Or &H80
                If cy = 1 Then
                    D = D Xor &H1
                    E = E Xor &H20
                End If
                If (c And &H1) = &H1 Then cy = 1 Else cy = 0
                c = c \ 2
                If cy = 1 Then c = c Or &H80
            Next
        Next
    End Sub

End Class
