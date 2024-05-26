Module Module1
    Private Const HEX As String = "0123456789ABCDEF"
    Private Const Verzeichnis As String = "D:\Daten\Entwicklung\DEG2000\ORIG\CAS"
    Private Const CasName As String = "LAD2B"

    Private ReadOnly Kassette = New KassettenLW
    Private ReadOnly Inpdatei = New InpByteDatei

    Private _j As Integer
    Private _dateianz As Byte
    Private _datei As Byte

    Private _dateiL(103) As Integer
    Private _dateiN(103) As String

    Public Sub Main()
        Dim i1 As Integer

        Call kassette.Open_Kassette(Verzeichnis + "\" + CasName + "\" + CasName + ".CAS")

        '                                                                                   '                   BANDMARKE schreiben
        Call kassette.Schreiben_SpezialBlock("B")

        '                                                                                   ' ==================
        ' Volumename lesen und schreiben                                                    ' Bandkopf im EBCD-Code
        Call inpdatei.Open_InpDatei(Verzeichnis + "\" + CasName + "\" + CasName + ".VOL")
        For i1 = 1 To 3
            Call Inp2Out1(8)
        Next
        Call inpdatei.Close_InpDatei()
        '                                                                                   '                   BANDMARKE schreiben
        Call kassette.Schreiben_SpezialBlock("B")

        '                                                                                   ' ==================
        '                                                                                   ' Verzeichnis
        Call inpdatei.Open_InpDatei(Verzeichnis + "\" + CasName + "\" + CasName + ".DIR")
        '                                                                                   '                   Trennsatz
        Call Inp2Out1(2)
        '                                                                                   '                   "DS"-Satz
        Call Inp2Out1(2)
        '                                                                                   '                   Bibliothekssatz 1 ... 103 (max.)
        _j = 0 : _dateianz = 0
        Do
            _j = _j + 1
            Call Inp2Out2()
        Loop Until _j = 103 'Or inpdatei.eof '#
        Call inpdatei.Close_InpDatei()
        '                                                                                   '                   BANDMARKE schreiben
        Call kassette.Schreiben_SpezialBlock("B")

        '                                                                                   ' ==================
        '                                                                                   ' Datei 1 ... 103 (max.)
        For Datei = 1 To _dateianz
            '                                                                               '                   Blockkennzeichensatz "n"
            Call Inp2Out3(Datei)
            '                                                                               '                   "k" Blöcke der Datei "n"
            Try
                Call Inpdatei.Open_InpDatei(Verzeichnis + "\" + CasName + "\" + _dateiN(Datei)) '+ ".")
                For i1 = 1 To _dateiL(Datei)
                    Call Inp2Out4()
                Next
                Call inpdatei.Close_InpDatei()
            Catch ex As Exception

            End Try
            '                                                                               '                   BANDMARKE schreiben
            Call kassette.Schreiben_SpezialBlock("B")
        Next

        '                                                                                   ' ==================
        '                                                                                   ' Blockkennzeichensatz "n"+1
        Call Inp2Out3(_dateianz + 1)

        '                                                                                   ' ==================
        '                                                                                   ' Schlußlücke
        Call kassette.Schreiben_SpezialBlock("S")
        '
        Call kassette.Close_Kassette()
    End Sub

    Private Sub Inp2Out1(ByVal blockanz As Integer)
        Dim i2 As Integer
        Dim i3 As Integer

        Call kassette.Schreiben_Block("V", &H10 * blockanz)
        For i2 = 1 To blockanz
            Call inpdatei.Lesen_Block(0)
            For i3 = 0 To 15
                kassette.Buffer.B(0).z(i3) = inpdatei.Buffer.B(0).Z(i3)
            Next
            Call kassette.Schreiben_Block()
        Next
        Call kassette.Schreiben_Block("N", &H10 * blockanz)
    End Sub

    Private Sub Inp2Out2()
        Dim i2 As Integer
        Dim i3 As Integer

        Call kassette.Schreiben_Block("V", &H20)
        For i2 = 1 To 2
            Call inpdatei.Lesen_Block(i2)
        Next
        If inpdatei.Buffer.B(2).Z(7) <> _j Then
            For i3 = 0 To 15
                inpdatei.Buffer.B(1).Z(i3) = &HA5
                inpdatei.Buffer.B(2).Z(i3) = &HA5
            Next
        Else
            _dateianz = _dateianz + 1
            _dateiL(_dateianz) = inpdatei.Buffer.B(2).Z(10) * 256 + inpdatei.Buffer.B(2).Z(9)
            _dateiN(_dateianz) = ""
            For i3 = 0 To 5
                _dateiN(_dateianz) = _dateiN(_dateianz) + Chr(inpdatei.Buffer.B(1).Z(i3))
            Next
            Debug.Print(Format(_dateianz) + " " + _dateiN(_dateianz) + " " + Format(_dateiL(_dateianz)))
        End If

        For i2 = 1 To 2
            For i3 = 0 To 15
                kassette.Buffer.B(0).z(i3) = inpdatei.Buffer.B(i2).Z(i3)
            Next
            Call kassette.Schreiben_Block()
        Next
        Call kassette.Schreiben_Block("N", &H20)
    End Sub

    Private Sub Inp2Out3(ByVal block As Byte)
        Dim i2 As Integer
        Dim i3 As Integer

        For i3 = 0 To 15
            inpdatei.Buffer.B(1).Z(i3) = 0
            inpdatei.Buffer.B(2).Z(i3) = 0
        Next
        inpdatei.Buffer.B(1).Z(0) = block

        Call kassette.Schreiben_Block("V", &H20)
        For i2 = 1 To 2
            For i3 = 0 To 15
                kassette.Buffer.B(0).z(i3) = inpdatei.Buffer.B(i2).Z(i3)
            Next
            Call kassette.Schreiben_Block()
        Next

        Call kassette.Schreiben_Block("N", &H20)
    End Sub

    Private Sub Inp2Out4()
        Dim i2 As Integer
        Dim i3 As Integer

        Call kassette.Schreiben_Block("V", &H80)
        For i2 = 0 To 7
            Call inpdatei.Lesen_Block(i2)
            For i3 = 0 To 15
                kassette.Buffer.B(0).z(i3) = inpdatei.Buffer.B(i2).Z(i3)
            Next
            Call kassette.Schreiben_Block()
        Next

        Call kassette.Schreiben_Block("N", &H80)
    End Sub

    Private Function HexAnzeige_Byte(ByVal wert As Byte) As String
        HexAnzeige_Byte = Mid(HEX, ((wert And 255) \ 16) + 1, 1) + Mid(HEX, ((wert And 255) And 15) + 1, 1)
    End Function ' HexAnzeige_Byte
    Private Function HexAnzeige_WordByte(ByVal wert As ULong, ByVal steuerung As String) As String
        Select Case UCase(steuerung)
            Case "H"
                HexAnzeige_WordByte = Mid(HEX, ((wert \ 256) \ 16) + 1, 1) + Mid(HEX, ((wert \ 256) And 15) + 1, 1)
            Case "L"
                HexAnzeige_WordByte = Mid(HEX, ((wert And 255) \ 16) + 1, 1) + Mid(HEX, ((wert And 255) And 15) + 1, 1)
            Case "B"
                HexAnzeige_WordByte = Mid(HEX, ((wert \ 256) \ 16) + 1, 1) + Mid(HEX, ((wert \ 256) And 15) + 1, 1) +
                                      Mid(HEX, ((wert And 255) \ 16) + 1, 1) + Mid(HEX, ((wert And 255) And 15) + 1, 1)
            Case "B "
                HexAnzeige_WordByte = Mid(HEX, ((wert \ 256) \ 16) + 1, 1) + Mid(HEX, ((wert \ 256) And 15) + 1, 1) + " " +
                                      Mid(HEX, ((wert And 255) \ 16) + 1, 1) + Mid(HEX, ((wert And 255) And 15) + 1, 1)
            Case "S"
                HexAnzeige_WordByte = Mid(HEX, ((wert \ 256) \ 16) + 1, 1)
            Case Else
                HexAnzeige_WordByte = ""
        End Select
    End Function ' HexAnzeige_WordByte
End Module
