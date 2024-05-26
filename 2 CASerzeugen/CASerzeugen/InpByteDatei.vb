Imports System
Imports System.IO

Public Class InpByteDatei
    Public Dateiname As String
    Public Buffer As Buffer1
    Public FilePos As Integer

    Public Sub New()
        Buffer = New Buffer1
    End Sub ' New KassetenLW

    Public Class Zeile
        Public Z(0 To 15) As Byte
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

    Public Function Open_InpDatei(ByVal dateiname As String) As Boolean
        Try
            _fi = New FileInfo(dateiname)
            _fs = _fi.OpenRead
            dateiname = dateiname
            Open_InpDatei = True
            FilePos = 0
        Catch ex As Exception
            MsgBox("can't open file " + dateiname)
            dateiname = ""
            Open_InpDatei = False
            FilePos = -1
        End Try
    End Function

    Public Function Close_InpDatei() As Boolean
        _fs.Close()
        Close_InpDatei = True
        FilePos = -1
    End Function

    Public Sub Lesen_Block(ByVal iPuffer As Byte)
        Dim i As Byte

        For i = 0 To 15
            Buffer.B(iPuffer).Z(i) = 0
        Next
        _fs.Read(Buffer.B(iPuffer).Z, 0, 16)
    End Sub
End Class
