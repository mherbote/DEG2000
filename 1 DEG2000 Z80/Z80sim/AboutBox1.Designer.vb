<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class AboutBox1
    Inherits System.Windows.Forms.Form

    'Das Formular überschreibt den Löschvorgang, um die Komponentenliste zu bereinigen.
    <System.Diagnostics.DebuggerNonUserCode()> _
    Protected Overrides Sub Dispose(ByVal disposing As Boolean)
        Try
            If disposing AndAlso components IsNot Nothing Then
                components.Dispose()
            End If
        Finally
            MyBase.Dispose(disposing)
        End Try
    End Sub

    Friend WithEvents TableLayoutPanel As System.Windows.Forms.TableLayoutPanel
    Friend WithEvents LabelProductName As System.Windows.Forms.Label
    Friend WithEvents LabelVersion As System.Windows.Forms.Label
    Friend WithEvents LabelCompanyName As System.Windows.Forms.Label
    Friend WithEvents LabelCopyright As System.Windows.Forms.Label

    'Wird vom Windows Form-Designer benötigt.
    Private components As System.ComponentModel.IContainer

    'Hinweis: Die folgende Prozedur ist für den Windows Form-Designer erforderlich.
    'Das Bearbeiten ist mit dem Windows Form-Designer möglich.  
    'Das Bearbeiten mit dem Code-Editor ist nicht möglich.
    <System.Diagnostics.DebuggerStepThrough()> _
    Private Sub InitializeComponent()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(AboutBox1))
        TableLayoutPanel = New System.Windows.Forms.TableLayoutPanel()
        TextBoxDescription = New System.Windows.Forms.TextBox()
        LabelProductName = New System.Windows.Forms.Label()
        LabelVersion = New System.Windows.Forms.Label()
        LabelCopyright = New System.Windows.Forms.Label()
        LabelCompanyName = New System.Windows.Forms.Label()
        OKButton = New System.Windows.Forms.Button()
        LogoPictureBox = New System.Windows.Forms.PictureBox()
        TableLayoutPanel.SuspendLayout()
        CType(LogoPictureBox, System.ComponentModel.ISupportInitialize).BeginInit()
        SuspendLayout()
        '
        'TableLayoutPanel
        '
        TableLayoutPanel.ColumnCount = 1
        TableLayoutPanel.ColumnStyles.Add(New System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 100.0!))
        TableLayoutPanel.Controls.Add(TextBoxDescription, 0, 5)
        TableLayoutPanel.Controls.Add(LabelProductName, 0, 0)
        TableLayoutPanel.Controls.Add(LabelVersion, 0, 1)
        TableLayoutPanel.Controls.Add(LabelCopyright, 0, 2)
        TableLayoutPanel.Controls.Add(LabelCompanyName, 0, 3)
        TableLayoutPanel.Controls.Add(OKButton, 0, 6)
        TableLayoutPanel.Controls.Add(LogoPictureBox, 0, 4)
        TableLayoutPanel.Dock = System.Windows.Forms.DockStyle.Fill
        TableLayoutPanel.Location = New System.Drawing.Point(9, 9)
        TableLayoutPanel.Name = "TableLayoutPanel"
        TableLayoutPanel.RowCount = 7
        TableLayoutPanel.RowStyles.Add(New System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 20.0!))
        TableLayoutPanel.RowStyles.Add(New System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 20.0!))
        TableLayoutPanel.RowStyles.Add(New System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 20.0!))
        TableLayoutPanel.RowStyles.Add(New System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 6.164383!))
        TableLayoutPanel.RowStyles.Add(New System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 93.83562!))
        TableLayoutPanel.RowStyles.Add(New System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 1.0!))
        TableLayoutPanel.RowStyles.Add(New System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 107.0!))
        TableLayoutPanel.RowStyles.Add(New System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 30.0!))
        TableLayoutPanel.Size = New System.Drawing.Size(411, 434)
        TableLayoutPanel.TabIndex = 0
        '
        'TextBoxDescription
        '
        TextBoxDescription.BorderStyle = System.Windows.Forms.BorderStyle.None
        TableLayoutPanel.SetColumnSpan(TextBoxDescription, 2)
        TextBoxDescription.Dock = System.Windows.Forms.DockStyle.Fill
        TextBoxDescription.Location = New System.Drawing.Point(6, 299)
        TextBoxDescription.Margin = New System.Windows.Forms.Padding(6, 3, 3, 3)
        TextBoxDescription.Multiline = True
        TextBoxDescription.Name = "TextBoxDescription"
        TextBoxDescription.ReadOnly = True
        TextBoxDescription.RightToLeft = System.Windows.Forms.RightToLeft.No
        TextBoxDescription.ScrollBars = System.Windows.Forms.ScrollBars.Both
        TextBoxDescription.Size = New System.Drawing.Size(402, 101)
        TextBoxDescription.TabIndex = 3
        TextBoxDescription.TabStop = False
        TextBoxDescription.Text = resources.GetString("TextBoxDescription.Text")
        '
        'LabelProductName
        '
        LabelProductName.Dock = System.Windows.Forms.DockStyle.Fill
        LabelProductName.Location = New System.Drawing.Point(6, 0)
        LabelProductName.Margin = New System.Windows.Forms.Padding(6, 0, 3, 0)
        LabelProductName.MaximumSize = New System.Drawing.Size(0, 17)
        LabelProductName.Name = "LabelProductName"
        LabelProductName.Size = New System.Drawing.Size(402, 17)
        LabelProductName.TabIndex = 0
        LabelProductName.Text = "Produktname"
        LabelProductName.TextAlign = System.Drawing.ContentAlignment.MiddleLeft
        '
        'LabelVersion
        '
        LabelVersion.Dock = System.Windows.Forms.DockStyle.Fill
        LabelVersion.Location = New System.Drawing.Point(6, 20)
        LabelVersion.Margin = New System.Windows.Forms.Padding(6, 0, 3, 0)
        LabelVersion.MaximumSize = New System.Drawing.Size(0, 17)
        LabelVersion.Name = "LabelVersion"
        LabelVersion.Size = New System.Drawing.Size(402, 17)
        LabelVersion.TabIndex = 0
        LabelVersion.Text = "Version"
        LabelVersion.TextAlign = System.Drawing.ContentAlignment.MiddleLeft
        '
        'LabelCopyright
        '
        LabelCopyright.Dock = System.Windows.Forms.DockStyle.Fill
        LabelCopyright.Location = New System.Drawing.Point(6, 40)
        LabelCopyright.Margin = New System.Windows.Forms.Padding(6, 0, 3, 0)
        LabelCopyright.MaximumSize = New System.Drawing.Size(0, 17)
        LabelCopyright.Name = "LabelCopyright"
        LabelCopyright.Size = New System.Drawing.Size(402, 17)
        LabelCopyright.TabIndex = 0
        LabelCopyright.Text = "Copyright"
        LabelCopyright.TextAlign = System.Drawing.ContentAlignment.MiddleLeft
        '
        'LabelCompanyName
        '
        LabelCompanyName.Dock = System.Windows.Forms.DockStyle.Fill
        LabelCompanyName.Location = New System.Drawing.Point(6, 60)
        LabelCompanyName.Margin = New System.Windows.Forms.Padding(6, 0, 3, 0)
        LabelCompanyName.MaximumSize = New System.Drawing.Size(0, 17)
        LabelCompanyName.Name = "LabelCompanyName"
        LabelCompanyName.Size = New System.Drawing.Size(402, 14)
        LabelCompanyName.TabIndex = 0
        LabelCompanyName.Text = "Firmenname"
        LabelCompanyName.TextAlign = System.Drawing.ContentAlignment.MiddleLeft
        '
        'OKButton
        '
        OKButton.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        OKButton.DialogResult = System.Windows.Forms.DialogResult.Cancel
        OKButton.Location = New System.Drawing.Point(333, 406)
        OKButton.Name = "OKButton"
        OKButton.Size = New System.Drawing.Size(75, 25)
        OKButton.TabIndex = 0
        OKButton.Text = "&OK"
        '
        'LogoPictureBox
        '
        LogoPictureBox.Image = Global.DEG2000.My.Resources.Resources.MRES
        LogoPictureBox.Location = New System.Drawing.Point(3, 77)
        LogoPictureBox.Name = "LogoPictureBox"
        TableLayoutPanel.SetRowSpan(LogoPictureBox, 2)
        LogoPictureBox.Size = New System.Drawing.Size(404, 215)
        LogoPictureBox.TabIndex = 0
        LogoPictureBox.TabStop = False
        '
        'AboutBox1
        '
        AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        CancelButton = OKButton
        ClientSize = New System.Drawing.Size(429, 452)
        Controls.Add(TableLayoutPanel)
        FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog
        MaximizeBox = False
        MinimizeBox = False
        Name = "AboutBox1"
        Padding = New System.Windows.Forms.Padding(9)
        ShowInTaskbar = False
        StartPosition = System.Windows.Forms.FormStartPosition.CenterParent
        Text = "AboutBox1"
        TableLayoutPanel.ResumeLayout(False)
        TableLayoutPanel.PerformLayout()
        CType(LogoPictureBox, System.ComponentModel.ISupportInitialize).EndInit()
        ResumeLayout(False)

    End Sub
    Friend WithEvents LogoPictureBox As System.Windows.Forms.PictureBox
    Friend WithEvents OKButton As System.Windows.Forms.Button
    Friend WithEvents TextBoxDescription As System.Windows.Forms.TextBox

End Class
