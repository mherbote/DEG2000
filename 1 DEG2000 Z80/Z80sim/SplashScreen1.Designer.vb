<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class SplashScreen1
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
    Friend WithEvents DEG2000 As System.Windows.Forms.Label
    Friend WithEvents Version As System.Windows.Forms.Label
    Friend WithEvents Copyright As System.Windows.Forms.Label
    Friend WithEvents MainLayoutPanel As System.Windows.Forms.TableLayoutPanel
    Friend WithEvents DetailsLayoutPanel As System.Windows.Forms.TableLayoutPanel

    'Wird vom Windows Form-Designer benötigt.
    Private components As System.ComponentModel.IContainer

    'Hinweis: Die folgende Prozedur ist für den Windows Form-Designer erforderlich.
    'Das Bearbeiten ist mit dem Windows Form-Designer möglich.  
    'Das Bearbeiten mit dem Code-Editor ist nicht möglich.
    <System.Diagnostics.DebuggerStepThrough()> _
    Private Sub InitializeComponent()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(SplashScreen1))
        MainLayoutPanel = New System.Windows.Forms.TableLayoutPanel()
        DetailsLayoutPanel = New System.Windows.Forms.TableLayoutPanel()
        Version = New System.Windows.Forms.Label()
        Copyright = New System.Windows.Forms.Label()
        DEG2000 = New System.Windows.Forms.Label()
        MainLayoutPanel.SuspendLayout()
        DetailsLayoutPanel.SuspendLayout()
        SuspendLayout()
        '
        'MainLayoutPanel
        '
        MainLayoutPanel.BackgroundImage = Global.DEG2000.My.Resources.Resources.MRES_3_k
        MainLayoutPanel.BackgroundImageLayout = System.Windows.Forms.ImageLayout.None
        MainLayoutPanel.ColumnCount = 2
        MainLayoutPanel.ColumnStyles.Add(New System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Absolute, 222.0!))
        MainLayoutPanel.ColumnStyles.Add(New System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Absolute, 121.0!))
        MainLayoutPanel.Controls.Add(DetailsLayoutPanel, 1, 1)
        MainLayoutPanel.Controls.Add(DEG2000, 1, 0)
        MainLayoutPanel.Dock = System.Windows.Forms.DockStyle.Fill
        MainLayoutPanel.Location = New System.Drawing.Point(0, 0)
        MainLayoutPanel.Name = "MainLayoutPanel"
        MainLayoutPanel.RowStyles.Add(New System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 256.0!))
        MainLayoutPanel.RowStyles.Add(New System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 8.0!))
        MainLayoutPanel.Size = New System.Drawing.Size(496, 303)
        MainLayoutPanel.TabIndex = 0
        '
        'DetailsLayoutPanel
        '
        DetailsLayoutPanel.Anchor = System.Windows.Forms.AnchorStyles.None
        DetailsLayoutPanel.BackColor = System.Drawing.Color.Transparent
        DetailsLayoutPanel.ColumnCount = 1
        DetailsLayoutPanel.ColumnStyles.Add(New System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Absolute, 142.0!))
        DetailsLayoutPanel.ColumnStyles.Add(New System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Absolute, 142.0!))
        DetailsLayoutPanel.Controls.Add(Version, 0, 0)
        DetailsLayoutPanel.Controls.Add(Copyright, 0, 1)
        DetailsLayoutPanel.Location = New System.Drawing.Point(225, 259)
        DetailsLayoutPanel.Name = "DetailsLayoutPanel"
        DetailsLayoutPanel.RowStyles.Add(New System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 33.0!))
        DetailsLayoutPanel.RowStyles.Add(New System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 33.0!))
        DetailsLayoutPanel.Size = New System.Drawing.Size(268, 41)
        DetailsLayoutPanel.TabIndex = 1
        '
        'Version
        '
        Version.Anchor = System.Windows.Forms.AnchorStyles.None
        Version.BackColor = System.Drawing.Color.Transparent
        Version.Font = New System.Drawing.Font("Microsoft Sans Serif", 9.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Version.Location = New System.Drawing.Point(3, 0)
        Version.Name = "Version"
        Version.Size = New System.Drawing.Size(262, 20)
        Version.TabIndex = 1
        Version.Text = "Version {0}.{1:00}"
        '
        'Copyright
        '
        Copyright.Anchor = System.Windows.Forms.AnchorStyles.None
        Copyright.BackColor = System.Drawing.Color.Transparent
        Copyright.Font = New System.Drawing.Font("Microsoft Sans Serif", 9.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Copyright.Location = New System.Drawing.Point(3, 20)
        Copyright.Name = "Copyright"
        Copyright.Size = New System.Drawing.Size(262, 21)
        Copyright.TabIndex = 2
        Copyright.Text = "Copyright (c) Marcus Herbote, Berlin"
        '
        'DEG2000
        '
        DEG2000.Anchor = System.Windows.Forms.AnchorStyles.None
        DEG2000.BackColor = System.Drawing.Color.Transparent
        DEG2000.Font = New System.Drawing.Font("Microsoft Sans Serif", 18.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        DEG2000.Location = New System.Drawing.Point(225, 22)
        DEG2000.Name = "DEG2000"
        DEG2000.Size = New System.Drawing.Size(268, 212)
        DEG2000.TabIndex = 0
        DEG2000.Text = "DEG2000 Emulator"
        DEG2000.TextAlign = System.Drawing.ContentAlignment.BottomLeft
        '
        'SplashScreen1
        '
        AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        ClientSize = New System.Drawing.Size(496, 303)
        ControlBox = False
        Controls.Add(MainLayoutPanel)
        FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle
        Icon = CType(resources.GetObject("$this.Icon"), System.Drawing.Icon)
        MaximizeBox = False
        MinimizeBox = False
        Name = "SplashScreen1"
        ShowInTaskbar = False
        StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen
        MainLayoutPanel.ResumeLayout(False)
        DetailsLayoutPanel.ResumeLayout(False)
        ResumeLayout(False)

    End Sub

End Class
