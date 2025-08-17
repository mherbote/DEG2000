Public Class Zeichen
    Public PBox(0 To 10, 0 To 30) As PictureBox

    Private _XYgrenze As Int16 = 10
    Private _XeinzelPixel = 30
    Private _YeinzelPixel = 30
    Private _X As Int16 = 6
    Private _Y As Int16 = 10
    Private _bgAus As Color = Color.Gray
    Private _bgEin As Color = Color.Blue

    Public Sub Init(x As Int16, y As Int16, xe As Int16, ye As Int16, BGaus As Color, BGein As Color, XYgrenze As Int16)
        Dim i, j, ix, jy As Integer
        Dim k As Color

        _XeinzelPixel = xe
        _YeinzelPixel = ye
        _X = x
        _Y = y
        _bgAus = BGaus
        _bgEin = BGein
        _XYgrenze = XYgrenze

        Me.Width = _XeinzelPixel * _X
        Me.Height = _YeinzelPixel * _Y

        k = _bgAus
        jy = 0
        Try
            For j = 0 To _Y - 1
                ix = 0
                For i = 0 To _X - 1
                    PBox(i, j) = New PictureBox
                    With PBox(i, j)
                        .Left = ix
                        .Top = jy
                        .Width = _XeinzelPixel
                        .Height = _YeinzelPixel
                        .BackColor = k
                        If _XeinzelPixel < _XYgrenze Or _YeinzelPixel < _XYgrenze Then
                            .BorderStyle = BorderStyle.None
                        Else
                            .BorderStyle = BorderStyle.FixedSingle
                        End If

                        .Visible = True
                    End With
                    Me.Controls.Add(PBox(i, j))

                    ix = ix + _XeinzelPixel

                    If COMMON.Zeichen1 Then
                        Select Case k
                            Case _bgAus
                                k = _bgEin
                            Case _bgEin
                                k = _bgAus
                        End Select
                    End If
                Next
                jy = jy + _YeinzelPixel
            Next
        Catch ex As Exception

        End Try
    End Sub

    Public Sub test()
        Dim i, j As Integer


        For j = 0 To _Y - 1 Step 2
            For i = 0 To _X - 1 Step 2
                With PBox(i, j)
                    .BackColor = _bgEin
                End With
            Next i
        Next j
    End Sub
End Class
