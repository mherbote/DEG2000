Module Font1

    Public Function LoadFont(ByVal FontDateiname As String) As Boolean
        Dim value As Byte()
        Dim i, _pZ, _pY1 As UInteger

        Try
            value = My.Computer.FileSystem.ReadAllBytes(FontDateiname)
        Catch ex As Exception
            MsgBox("Font.LoadBwsFont: " + "Font nicht gefunden!")
            LoadFont = False
            Exit Function
        End Try

        If value(0) <> 170 Or value(1) <> 85 Then
            MsgBox("Font.LoadBwsFont: " + "Ungültiger Font!")
            LoadFont = False
            Exit Function
        End If

        FontView.PixelX.Text = value(3) * 256 + value(2)
        FontView.PixelY.Text = value(5) * 256 + value(4)
        FontView.PixelX.Refresh()
        FontView.PixelY.Refresh()
        COMMON.xxx = value(3) * 256 + value(2)
        COMMON.yyy = value(5) * 256 + value(4)

        i = 8
        For _pZ = 0 To 255
            For _pY1 = 0 To COMMON.yyy - 1
                COMMON.CharCode(_pZ, _pY1) = value(i)
                i = i + 1
            Next _pY1
        Next _pZ
        LoadFont = True
    End Function

    Public Sub ConvertBelegen()
        Dim i, j, k As Integer

        j = 0
        For i = 0 To 63
            COMMON.Convert3(i) = j
            j = j + 1
            If j = 16 Then j = 0
        Next i

        j = 0
        k = 0
        For i = 0 To 63
            COMMON.Convert2(i) = j
            k = k + 1
            If k = 16 Then
                j = j + 1
                k = 0
            End If
        Next i

        k = COMMON.ATabS * 16
        For i = 0 To 63
            COMMON.Convert1(i) = k
            k = k + 1
        Next i
    End Sub ' ConvertBelegen

    Public Sub Font2Zei(code As UInteger)
        Dim charZeile As Byte
        Dim x, y, xx, yy As UInteger

        Try
            xx = COMMON.Convert3(code - COMMON.ATabS * 16)
            yy = COMMON.Convert2(code - COMMON.ATabS * 16)
            For y = 0 To COMMON.yyy - 1
                charZeile = COMMON.CharCode(code, y)
                For x = 0 To COMMON.xxx - 1
                    If IstBit(charZeile, x) Then
                        COMMON.Zei.PBox(x, y).BackColor = COMMON.Cei1
                    Else
                        COMMON.Zei.PBox(x, y).BackColor = COMMON.Caus
                    End If
                Next x
            Next y
        Catch ex As Exception
            MsgBox("Font.Font2ATab: " + ex.Message)
        End Try
    End Sub

    Public Sub Font2ATab()
        Dim charZeile As Byte
        Dim _code, x, y, xx, yy As UInteger

        Try
            For _code = COMMON.ATabS * 16 To COMMON.ATabS * 16 + COMMON.ATabZ * 16 - 1
                xx = COMMON.Convert3(_code - COMMON.ATabS * 16)
                yy = COMMON.Convert2(_code - COMMON.ATabS * 16)
                For y = 0 To COMMON.yyy - 1
                    charZeile = COMMON.CharCode(_code, y)
                    For x = 0 To COMMON.xxx - 1
                        If IstBit(charZeile, x) Then
                            COMMON.ATab.PBoxAscii(xx, yy).PBox(x, y).BackColor = COMMON.Cei1
                        Else
                            COMMON.ATab.PBoxAscii(xx, yy).PBox(x, y).BackColor = COMMON.Caus
                        End If
                    Next x
                Next y
            Next _code
        Catch ex As Exception
            MsgBox("Font.Font2ATab: " + ex.Message)
        End Try
    End Sub ' Font2ATab
    Private Function IstBit(ByVal charZeile As Byte, ByVal pos As Integer) As Boolean
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
End Module
