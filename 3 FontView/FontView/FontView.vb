Imports System.DirectoryServices.ActiveDirectory
Imports System.Net.Mime.MediaTypeNames
Imports Microsoft.Win32.SafeHandles

Public Class FontView

    Private Sub FontView_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        Call FontAnzeigen1()
    End Sub ' FontView_Load

    Private Sub FontAnzeigen1()
        Dim top As Integer

        COMMON.ATab = New AsciiTab
        With COMMON.ATab
            .Left = 120
            .Top = 150
            .Width = .Left + 15 * (COMMON.xxx * COMMON.xy1 + 4)
            .Height = .Top + COMMON.ATabZ * (COMMON.yyy * COMMON.xy1 + 4)
            top = .Init(COMMON.xxx, COMMON.yyy, COMMON.xy1, COMMON.xy1, COMMON.Caus, COMMON.Cei1, 10)
        End With
        Controls.Add(COMMON.ATab)
        AddHandler ATab.MouseClick, AddressOf ATabMouse_Click
        If Ascii2 Then
            Call COMMON.ATab.PBoxAscii(2, 2).test()
        End If

        COMMON.Zei = New Zeichen
        With Zei
            .Left = 700
            .Top = 150
            .Width = .Left + (COMMON.xxx * COMMON.xy2 + 4)
            .Height = .Top + (COMMON.yyy * COMMON.xy2 + 4)
            .Init(COMMON.xxx, COMMON.yyy, COMMON.xy2, COMMON.xy2, COMMON.Caus, COMMON.Cei2, 10)
        End With
        Controls.Add(COMMON.Zei)
        If Zeichen2 Then
            Call COMMON.Zei.test()
        End If
    End Sub

    Private Sub ATabMouse_Click(sender As Object, e As EventArgs)

    End Sub

    Private Sub FontdateiladenToolStripMenuItem1_Click(sender As Object, e As EventArgs) Handles FontdateiladenToolStripMenuItem1.Click
        OpenFileDialog1.FileName = "*.FNT"
        'OpenFileDialog1.InitialDirectory = ProgVerz + My.Settings.FontVerzeichnis

        Try
            If OpenFileDialog1.ShowDialog = System.Windows.Forms.DialogResult.OK Then
                FontName.Text = OpenFileDialog1.FileName
                FontName.Refresh()
                COMMON.FontDateiname = OpenFileDialog1.FileName

                FontName.Text = COMMON.FontDateiname
                If Not Font1.LoadFont(COMMON.FontDateiname) Then                                                                ' neuen Font laden
                    End
                End If

                Controls.Remove(COMMON.ATab)
                ATab.Dispose()
                Controls.Remove(COMMON.Zei)
                Zei.Dispose()

                COMMON.ATabS = 0
                CodeBereich.Text = "$00 - $3F"
                COMMON.ZeiCode = 0
                Call FontAnzeigen1()
                Call Font1.ConvertBelegen()
                Call Font1.Font2ATab()
                Call Font1.Font2Zei(COMMON.ZeiCode)
            End If
        Catch ex As Exception

        End Try

    End Sub

    Private Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click
        Select Case COMMON.ATabS
            Case 0
                COMMON.ATabS = 4
                CodeBereich.Text = "$40 - $7F"
            Case 4
                COMMON.ATabS = 8
                CodeBereich.Text = "$80 - $BF"
            Case 8
                COMMON.ATabS = 12
                CodeBereich.Text = "$C0 - $FF"
            Case 12
                COMMON.ATabS = 0
                CodeBereich.Text = "$00 - $3F"
        End Select
        COMMON.ZeiCode = COMMON.ATabS * 16
        Call Font1.ConvertBelegen()
        Call Font1.Font2ATab()
        Call Font1.Font2Zei(COMMON.ZeiCode)
    End Sub

    Private Sub Button2_Click(sender As Object, e As EventArgs) Handles Button2.Click
        Select Case COMMON.ATabS
            Case 0
                COMMON.ATabS = 12
                CodeBereich.Text = "$C0 - $FF"
            Case 4
                COMMON.ATabS = 0
                CodeBereich.Text = "$00 - $3F"
            Case 8
                COMMON.ATabS = 4
                CodeBereich.Text = "$40 - $7F"
            Case 12
                COMMON.ATabS = 8
                CodeBereich.Text = "$80 - $BF"
        End Select
        COMMON.ZeiCode = COMMON.ATabS * 16
        Call Font1.ConvertBelegen()
        Call Font1.Font2ATab()
        Call Font1.Font2Zei(COMMON.ZeiCode)
    End Sub

    Private Sub Button3_Click(sender As Object, e As EventArgs) Handles Button3.Click
        Select Case COMMON.ZeiCode
            Case COMMON.ATabS * 16
                COMMON.ZeiCode = COMMON.ATabS * 16 + 4 * 16 - 1
            Case Else
                COMMON.ZeiCode = COMMON.ZeiCode - 1
        End Select

        Call Font1.Font2Zei(COMMON.ZeiCode)
    End Sub

    Private Sub Button4_Click(sender As Object, e As EventArgs) Handles Button4.Click
        Select Case COMMON.ZeiCode
            Case COMMON.ATabS * 16 + 4 * 16 - 1
                COMMON.ZeiCode = COMMON.ATabS * 16
            Case Else
                COMMON.ZeiCode = COMMON.ZeiCode + 1
        End Select

        Call Font1.Font2Zei(COMMON.ZeiCode)
    End Sub
End Class
