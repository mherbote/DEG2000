Public Class Font

    Private CharCode(0 To 255, 0 To 20) As Byte

    Public zeichenTemplateNormal As Boolean(,,) = New Boolean(256, 50, 50) {}
    'Public zeichenTemplateInvers As Boolean(,,)                                                                         ' für Cursor Unterstrich
    'Public zeichenTemplateCurs_2 As Boolean(,,)                                                                         ' für inversen Cursor

#Region "Pixelanz X und Y"
    Private _pixelanzX As UInteger
    Public Property PixelanzX() As UInteger
        Get
            Return _pixelanzX
        End Get
        Set(ByVal value As UInteger)
            _pixelanzX = value
        End Set
    End Property
    Private _pixelanzY As UInteger
    Public Property PixelanzY() As UInteger
        Get
            Return _pixelanzY
        End Get
        Set(ByVal value As UInteger)
            _pixelanzY = value
        End Set
    End Property
#End Region

    Public Sub Font()
    End Sub

    Public Function LoadBwsFont(ByVal FontDateiname As String)
        Dim value As Byte()
        Dim i, _pZ, _pY1 As UInteger

        Try
            value = My.Computer.FileSystem.ReadAllBytes(FontDateiname)
        Catch ex As Exception
            MsgBox("Font nicht gefunden!")
            LoadBwsFont = False
            End
        End Try

        If value(0) <> 170 Or value(1) <> 85 Then
            MsgBox("Ungültiger Font!")
            LoadBwsFont = False
            End
        End If

        _pixelanzX = value(3) * 256 + value(2)
        _pixelanzY = value(5) * 256 + value(4)

        i = 8
        For _pZ = 0 To 255
            For _pY1 = 0 To PixelanzY - 1
                CharCode(_pZ, _pY1) = value(i)
                i = i + 1
            Next _pY1
        Next _pZ
        LoadBwsFont = True
    End Function

    Public Sub BwsFont2zeichenTemplate()
        Dim charZeile As Byte
        Dim _code, x, y As UInteger

        For _code = 0 To 255
            For y = 0 To PixelanzY
                charZeile = CharCode(_code, y)
                For x = 0 To PixelanzX
                    If IstBit(charZeile, x) Then
                        zeichenTemplateNormal(_code, y, x) = True
                        '                       zeichenTemplateInvers(_code, y, x) = False
                    Else
                        zeichenTemplateNormal(_code, y, x) = False
                        '                        zeichenTemplateInvers(_code, y, x) = True
                    End If
                Next x
            Next y
            Next _code
    End Sub
    Private Function IstBit(ByVal charZeile As Byte, ByVal pos As UInt16) As Boolean
        Select Case pos
            Case 7
                IstBit = (charZeile And &H1) = &H1
            Case 6
                IstBit = (charZeile And &H2) = &H2
            Case 5
                IstBit = (charZeile And &H4) = &H4
            Case 4
                IstBit = (charZeile And &H8) = &H8
            Case 3
                IstBit = (charZeile And &H10) = &H10
            Case 2
                IstBit = (charZeile And &H20) = &H20
            Case 1
                IstBit = (charZeile And &H40) = &H40
            Case 0
                IstBit = (charZeile And &H80) = &H80
            Case Else
                IstBit = False
        End Select
    End Function ' IstBit

End Class
