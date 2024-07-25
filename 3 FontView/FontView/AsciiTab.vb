Public Class AsciiTab
    Public PBoxAscii(0 To 15, 0 To COMMON.ATabZ - 1) As Zeichen

    Public Function Init(x As Int16, y As Int16, xe As Int16, ye As Int16, BGaus As Color, BGein As Color, XYgrenze As Int16) As Integer
        Dim i, j, ix, jy As Integer
        Dim k As Color
        k = BGaus
        jy = 0 ' Top
        Try
            For j = 0 To COMMON.ATabZ - 1
                ix = 0 'Left
                For i = 0 To 15
                    PBoxAscii(i, j) = New Zeichen
                    Me.Controls.Add(PBoxAscii(i, j))
                    With PBoxAscii(i, j)
                        .Init(x, y, xe, ye, BGaus, BGein, XYgrenze)

                        .Left = ix
                        .Top = jy
                        .BackColor = k 'Color.White
                        .BorderStyle = BorderStyle.None

                        .Visible = True
                    End With
                    ix = ix + xe * x + 4

                    If COMMON.Zeichen1 Then
                        Select Case k
                            Case BGaus
                                k = BGein
                            Case BGein
                                k = BGaus
                        End Select
                    End If
                Next i
                jy = jy + ye * y + 4
            Next j
        Catch ex As Exception
            MsgBox("FontView_Load: " + ex.Message)
        End Try

        Init = jy
    End Function
End Class
