<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()>
Partial Class FontView
    Inherits System.Windows.Forms.Form

    'Form overrides dispose to clean up the component list.
    <System.Diagnostics.DebuggerNonUserCode()>
    Protected Overrides Sub Dispose(ByVal disposing As Boolean)
        Try
            If disposing AndAlso components IsNot Nothing Then
                components.Dispose()
            End If
        Finally
            MyBase.Dispose(disposing)
        End Try
    End Sub

    'Required by the Windows Form Designer
    Private components As System.ComponentModel.IContainer

    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.  
    'Do not modify it using the code editor.
    <System.Diagnostics.DebuggerStepThrough()>
    Private Sub InitializeComponent()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FontView))
        StatusStrip1 = New StatusStrip()
        ToolStripStatusLabel1 = New ToolStripStatusLabel()
        MenuStrip1 = New MenuStrip()
        MenuStrip2 = New MenuStrip()
        DateiToolStripMenuItem = New ToolStripMenuItem()
        FontdateiladenToolStripMenuItem1 = New ToolStripMenuItem()
        OpenFileDialog1 = New OpenFileDialog()
        FontName = New TextBox()
        tFontName = New Label()
        Button1 = New Button()
        Button2 = New Button()
        PixelX = New TextBox()
        PixelY = New TextBox()
        Label1 = New Label()
        Label2 = New Label()
        Label3 = New Label()
        CodeBereich = New TextBox()
        Button3 = New Button()
        Button4 = New Button()
        StatusStrip1.SuspendLayout()
        MenuStrip2.SuspendLayout()
        SuspendLayout()
        ' 
        ' StatusStrip1
        ' 
        StatusStrip1.Items.AddRange(New ToolStripItem() {ToolStripStatusLabel1})
        StatusStrip1.Location = New Point(0, 594)
        StatusStrip1.Name = "StatusStrip1"
        StatusStrip1.Size = New Size(984, 22)
        StatusStrip1.TabIndex = 0
        StatusStrip1.Text = "StatusStrip1"
        ' 
        ' ToolStripStatusLabel1
        ' 
        ToolStripStatusLabel1.Name = "ToolStripStatusLabel1"
        ToolStripStatusLabel1.Size = New Size(154, 17)
        ToolStripStatusLabel1.Text = "(c) Marcus Herbote, 2024.07"
        ' 
        ' MenuStrip1
        ' 
        MenuStrip1.Location = New Point(0, 24)
        MenuStrip1.Name = "MenuStrip1"
        MenuStrip1.Size = New Size(984, 24)
        MenuStrip1.TabIndex = 1
        MenuStrip1.Text = "MenuStrip1"
        ' 
        ' MenuStrip2
        ' 
        MenuStrip2.Items.AddRange(New ToolStripItem() {DateiToolStripMenuItem})
        MenuStrip2.Location = New Point(0, 0)
        MenuStrip2.Name = "MenuStrip2"
        MenuStrip2.Size = New Size(984, 24)
        MenuStrip2.TabIndex = 2
        MenuStrip2.Text = "MenuStrip2"
        ' 
        ' DateiToolStripMenuItem
        ' 
        DateiToolStripMenuItem.DropDownItems.AddRange(New ToolStripItem() {FontdateiladenToolStripMenuItem1})
        DateiToolStripMenuItem.Name = "DateiToolStripMenuItem"
        DateiToolStripMenuItem.Size = New Size(46, 20)
        DateiToolStripMenuItem.Text = "&Datei"
        ' 
        ' FontdateiladenToolStripMenuItem1
        ' 
        FontdateiladenToolStripMenuItem1.Name = "FontdateiladenToolStripMenuItem1"
        FontdateiladenToolStripMenuItem1.Size = New Size(156, 22)
        FontdateiladenToolStripMenuItem1.Text = "Fontdatei &laden"
        ' 
        ' OpenFileDialog1
        ' 
        OpenFileDialog1.FileName = "OpenFileDialog1"
        ' 
        ' FontName
        ' 
        FontName.BorderStyle = BorderStyle.FixedSingle
        FontName.Enabled = False
        FontName.Location = New Point(120, 50)
        FontName.Name = "FontName"
        FontName.Size = New Size(500, 23)
        FontName.TabIndex = 3
        ' 
        ' tFontName
        ' 
        tFontName.AutoSize = True
        tFontName.Location = New Point(20, 53)
        tFontName.Name = "tFontName"
        tFontName.Size = New Size(61, 15)
        tFontName.TabIndex = 4
        tFontName.Text = "Fontname"
        ' 
        ' Button1
        ' 
        Button1.Image = CType(resources.GetObject("Button1.Image"), Image)
        Button1.Location = New Point(661, 43)
        Button1.Name = "Button1"
        Button1.Size = New Size(35, 35)
        Button1.TabIndex = 5
        Button1.UseVisualStyleBackColor = True
        ' 
        ' Button2
        ' 
        Button2.Image = CType(resources.GetObject("Button2.Image"), Image)
        Button2.Location = New Point(714, 43)
        Button2.Name = "Button2"
        Button2.Size = New Size(35, 35)
        Button2.TabIndex = 6
        Button2.UseVisualStyleBackColor = True
        ' 
        ' PixelX
        ' 
        PixelX.BorderStyle = BorderStyle.FixedSingle
        PixelX.Enabled = False
        PixelX.Location = New Point(120, 90)
        PixelX.Name = "PixelX"
        PixelX.Size = New Size(50, 23)
        PixelX.TabIndex = 7
        PixelX.TextAlign = HorizontalAlignment.Center
        ' 
        ' PixelY
        ' 
        PixelY.BorderStyle = BorderStyle.FixedSingle
        PixelY.Enabled = False
        PixelY.Location = New Point(250, 90)
        PixelY.Name = "PixelY"
        PixelY.Size = New Size(50, 23)
        PixelY.TabIndex = 8
        PixelY.TextAlign = HorizontalAlignment.Center
        ' 
        ' Label1
        ' 
        Label1.AutoSize = True
        Label1.Location = New Point(20, 92)
        Label1.Name = "Label1"
        Label1.Size = New Size(45, 15)
        Label1.TabIndex = 9
        Label1.Text = "Pixel in"
        ' 
        ' Label2
        ' 
        Label2.AutoSize = True
        Label2.Location = New Point(306, 92)
        Label2.Name = "Label2"
        Label2.Size = New Size(14, 15)
        Label2.TabIndex = 10
        Label2.Text = "Y"
        ' 
        ' Label3
        ' 
        Label3.AutoSize = True
        Label3.Location = New Point(176, 92)
        Label3.Name = "Label3"
        Label3.Size = New Size(14, 15)
        Label3.TabIndex = 11
        Label3.Text = "X"
        ' 
        ' CodeBereich
        ' 
        CodeBereich.BorderStyle = BorderStyle.FixedSingle
        CodeBereich.Enabled = False
        CodeBereich.Location = New Point(550, 90)
        CodeBereich.Name = "CodeBereich"
        CodeBereich.Size = New Size(70, 23)
        CodeBereich.TabIndex = 12
        CodeBereich.TextAlign = HorizontalAlignment.Center
        ' 
        ' Button3
        ' 
        Button3.Image = CType(resources.GetObject("Button3.Image"), Image)
        Button3.Location = New Point(798, 43)
        Button3.Name = "Button3"
        Button3.Size = New Size(35, 35)
        Button3.TabIndex = 13
        Button3.UseVisualStyleBackColor = True
        ' 
        ' Button4
        ' 
        Button4.Image = CType(resources.GetObject("Button4.Image"), Image)
        Button4.Location = New Point(839, 43)
        Button4.Name = "Button4"
        Button4.Size = New Size(35, 35)
        Button4.TabIndex = 14
        Button4.UseVisualStyleBackColor = True
        ' 
        ' FontView
        ' 
        AutoScaleDimensions = New SizeF(7F, 15F)
        AutoScaleMode = AutoScaleMode.Font
        ClientSize = New Size(984, 616)
        Controls.Add(Button4)
        Controls.Add(Button3)
        Controls.Add(CodeBereich)
        Controls.Add(Label3)
        Controls.Add(Label2)
        Controls.Add(Label1)
        Controls.Add(PixelY)
        Controls.Add(PixelX)
        Controls.Add(Button2)
        Controls.Add(Button1)
        Controls.Add(tFontName)
        Controls.Add(FontName)
        Controls.Add(StatusStrip1)
        Controls.Add(MenuStrip1)
        Controls.Add(MenuStrip2)
        MainMenuStrip = MenuStrip1
        Name = "FontView"
        Text = "FontView"
        StatusStrip1.ResumeLayout(False)
        StatusStrip1.PerformLayout()
        MenuStrip2.ResumeLayout(False)
        MenuStrip2.PerformLayout()
        ResumeLayout(False)
        PerformLayout()
    End Sub

    Friend WithEvents StatusStrip1 As StatusStrip
    Friend WithEvents ToolStripStatusLabel1 As ToolStripStatusLabel
    Friend WithEvents MenuStrip1 As MenuStrip
    Friend WithEvents MenuStrip2 As MenuStrip
    Friend WithEvents DateiToolStripMenuItem As ToolStripMenuItem
    Friend WithEvents OpenFileDialog1 As OpenFileDialog
    Friend WithEvents FontdateiladenToolStripMenuItem1 As ToolStripMenuItem
    Friend WithEvents FontName As TextBox
    Friend WithEvents tFontName As Label
    Friend WithEvents Button1 As Button
    Friend WithEvents Button2 As Button
    Friend WithEvents PixelX As TextBox
    Friend WithEvents PixelY As TextBox
    Friend WithEvents Label1 As Label
    Friend WithEvents Label2 As Label
    Friend WithEvents Label3 As Label
    Friend WithEvents CodeBereich As TextBox
    Friend WithEvents Button3 As Button
    Friend WithEvents Button4 As Button

End Class
