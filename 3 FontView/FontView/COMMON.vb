Module COMMON
    Public Ascii2 As Boolean = False
    Public Zeichen1 As Boolean = False
    Public Zeichen2 As Boolean = False

    Public ATab As AsciiTab
    Public Zei As Zeichen

    Public ATabZ As Integer = 4                                                         'ATab Zeilenanzahl
    Public ATabS As Integer = 0                                                         'ATab Startzeile {0,4,8,12}

    Public xxx As Integer = 6                                                           'Pixelanzahl in X
    Public yyy As Integer = 10                                                          'Pixelanzahl in Y
    Public xy1 As Integer = 3                                                           'Pixelanzahl for ATab-Pixel
    Public xy2 As Integer = 27                                                          'Pixelanzahl for Zei -Pixel

    Public ZeiCode As Integer                                                           'Code for Zei

    Public Caus As Color = Color.White
    Public Cei1 As Color = Color.Black
    Public Cei2 As Color = Color.Blue

    Public FontDateiname As String
    Public CharCode(0 To 255, 0 To 20) As Byte

    Public Convert1(0 To 63) As Integer
    Public Convert2(0 To 63) As Integer
    Public Convert3(0 To 63) As Integer

End Module
