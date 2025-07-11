<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()>
Partial Class Laufwerke
    Inherits System.Windows.Forms.Form

    'Das Formular überschreibt den Löschvorgang, um die Komponentenliste zu bereinigen.
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

    'Wird vom Windows Form-Designer benötigt.
    Private components As System.ComponentModel.IContainer

    'Hinweis: Die folgende Prozedur ist für den Windows Form-Designer erforderlich.
    'Das Bearbeiten ist mit dem Windows Form-Designer möglich.  
    'Das Bearbeiten mit dem Code-Editor ist nicht möglich.
    <System.Diagnostics.DebuggerStepThrough()>
    Private Sub InitializeComponent()
        Dim DataGridViewCellStyle1 As System.Windows.Forms.DataGridViewCellStyle = New System.Windows.Forms.DataGridViewCellStyle()
        Dim DataGridViewCellStyle2 As System.Windows.Forms.DataGridViewCellStyle = New System.Windows.Forms.DataGridViewCellStyle()
        Dim DataGridViewCellStyle3 As System.Windows.Forms.DataGridViewCellStyle = New System.Windows.Forms.DataGridViewCellStyle()
        Dim DataGridViewCellStyle4 As System.Windows.Forms.DataGridViewCellStyle = New System.Windows.Forms.DataGridViewCellStyle()
        Dim DataGridViewCellStyle5 As System.Windows.Forms.DataGridViewCellStyle = New System.Windows.Forms.DataGridViewCellStyle()
        Dim DataGridViewCellStyle6 As System.Windows.Forms.DataGridViewCellStyle = New System.Windows.Forms.DataGridViewCellStyle()
        Dim DataGridViewCellStyle7 As System.Windows.Forms.DataGridViewCellStyle = New System.Windows.Forms.DataGridViewCellStyle()
        Dim DataGridViewCellStyle8 As System.Windows.Forms.DataGridViewCellStyle = New System.Windows.Forms.DataGridViewCellStyle()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(Laufwerke))
        Kassetten1 = New System.Windows.Forms.DataGridView()
        MiniDisk = New System.Windows.Forms.DataGridView()
        StandardDisk = New System.Windows.Forms.DataGridView()
        Label1 = New System.Windows.Forms.Label()
        Label2 = New System.Windows.Forms.Label()
        Label3 = New System.Windows.Forms.Label()
        OpenFileDialog1 = New System.Windows.Forms.OpenFileDialog()
        DataGridViewTextBoxColumn1 = New System.Windows.Forms.DataGridViewTextBoxColumn()
        DataGridViewTextBoxColumn2 = New System.Windows.Forms.DataGridViewTextBoxColumn()
        DataGridViewTextBoxColumn3 = New System.Windows.Forms.DataGridViewTextBoxColumn()
        DataGridViewTextBoxColumn4 = New System.Windows.Forms.DataGridViewTextBoxColumn()
        DataGridViewTextBoxColumn7 = New System.Windows.Forms.DataGridViewTextBoxColumn()
        DataGridViewTextBoxColumn10 = New System.Windows.Forms.DataGridViewTextBoxColumn()
        AnzeigeKassetten = New System.Windows.Forms.Button()
        CType(Kassetten1, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(MiniDisk, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(StandardDisk, System.ComponentModel.ISupportInitialize).BeginInit()
        SuspendLayout()
        '
        'Kassetten1
        '
        Kassetten1.AllowUserToAddRows = False
        Kassetten1.AllowUserToDeleteRows = False
        Kassetten1.AllowUserToResizeColumns = False
        Kassetten1.AllowUserToResizeRows = False
        Kassetten1.BackgroundColor = System.Drawing.Color.FromArgb(CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer))
        DataGridViewCellStyle1.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleCenter
        DataGridViewCellStyle1.BackColor = System.Drawing.SystemColors.Control
        DataGridViewCellStyle1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        DataGridViewCellStyle1.ForeColor = System.Drawing.SystemColors.WindowText
        DataGridViewCellStyle1.SelectionBackColor = System.Drawing.SystemColors.Highlight
        DataGridViewCellStyle1.SelectionForeColor = System.Drawing.SystemColors.HighlightText
        DataGridViewCellStyle1.WrapMode = System.Windows.Forms.DataGridViewTriState.[True]
        Kassetten1.ColumnHeadersDefaultCellStyle = DataGridViewCellStyle1
        Kassetten1.ColumnHeadersHeight = 22
        Kassetten1.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.DisableResizing
        Kassetten1.Location = New System.Drawing.Point(1, 20)
        Kassetten1.Name = "Kassetten1"
        Kassetten1.RowHeadersVisible = False
        Kassetten1.RowHeadersWidthSizeMode = System.Windows.Forms.DataGridViewRowHeadersWidthSizeMode.DisableResizing
        Kassetten1.ScrollBars = System.Windows.Forms.ScrollBars.None
        Kassetten1.Size = New System.Drawing.Size(641, 154)
        Kassetten1.TabIndex = 0
        '
        'MiniDisk
        '
        MiniDisk.AllowUserToAddRows = False
        MiniDisk.AllowUserToDeleteRows = False
        MiniDisk.AllowUserToResizeColumns = False
        MiniDisk.AllowUserToResizeRows = False
        MiniDisk.BackgroundColor = System.Drawing.Color.FromArgb(CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer))
        DataGridViewCellStyle2.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleCenter
        DataGridViewCellStyle2.BackColor = System.Drawing.SystemColors.Control
        DataGridViewCellStyle2.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        DataGridViewCellStyle2.ForeColor = System.Drawing.SystemColors.WindowText
        DataGridViewCellStyle2.SelectionBackColor = System.Drawing.SystemColors.Highlight
        DataGridViewCellStyle2.SelectionForeColor = System.Drawing.SystemColors.HighlightText
        DataGridViewCellStyle2.WrapMode = System.Windows.Forms.DataGridViewTriState.[True]
        MiniDisk.ColumnHeadersDefaultCellStyle = DataGridViewCellStyle2
        MiniDisk.ColumnHeadersHeight = 22
        MiniDisk.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.DisableResizing
        MiniDisk.Location = New System.Drawing.Point(1, 210)
        MiniDisk.Name = "MiniDisk"
        MiniDisk.RowHeadersVisible = False
        MiniDisk.ScrollBars = System.Windows.Forms.ScrollBars.None
        MiniDisk.Size = New System.Drawing.Size(641, 110)
        MiniDisk.TabIndex = 1
        '
        'StandardDisk
        '
        StandardDisk.AllowUserToAddRows = False
        StandardDisk.AllowUserToDeleteRows = False
        StandardDisk.AllowUserToResizeColumns = False
        StandardDisk.AllowUserToResizeRows = False
        StandardDisk.BackgroundColor = System.Drawing.Color.FromArgb(CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer))
        DataGridViewCellStyle3.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleCenter
        DataGridViewCellStyle3.BackColor = System.Drawing.SystemColors.Control
        DataGridViewCellStyle3.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        DataGridViewCellStyle3.ForeColor = System.Drawing.SystemColors.WindowText
        DataGridViewCellStyle3.SelectionBackColor = System.Drawing.SystemColors.Highlight
        DataGridViewCellStyle3.SelectionForeColor = System.Drawing.SystemColors.HighlightText
        DataGridViewCellStyle3.WrapMode = System.Windows.Forms.DataGridViewTriState.[True]
        StandardDisk.ColumnHeadersDefaultCellStyle = DataGridViewCellStyle3
        StandardDisk.ColumnHeadersHeight = 22
        StandardDisk.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.DisableResizing
        StandardDisk.Location = New System.Drawing.Point(1, 345)
        StandardDisk.Name = "StandardDisk"
        StandardDisk.RowHeadersVisible = False
        StandardDisk.ScrollBars = System.Windows.Forms.ScrollBars.None
        StandardDisk.Size = New System.Drawing.Size(641, 66)
        StandardDisk.TabIndex = 2
        '
        'Label1
        '
        Label1.Font = New System.Drawing.Font("Microsoft Sans Serif", 9.75!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Label1.Location = New System.Drawing.Point(0, 0)
        Label1.Name = "Label1"
        Label1.Size = New System.Drawing.Size(574, 20)
        Label1.TabIndex = 3
        Label1.Text = "Kassetten"
        Label1.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
        '
        'Label2
        '
        Label2.Font = New System.Drawing.Font("Microsoft Sans Serif", 9.75!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Label2.Location = New System.Drawing.Point(-2, 190)
        Label2.Name = "Label2"
        Label2.Size = New System.Drawing.Size(574, 20)
        Label2.TabIndex = 4
        Label2.Text = "Mini Disketten"
        Label2.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
        '
        'Label3
        '
        Label3.Font = New System.Drawing.Font("Microsoft Sans Serif", 9.75!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Label3.Location = New System.Drawing.Point(0, 325)
        Label3.Name = "Label3"
        Label3.Size = New System.Drawing.Size(574, 20)
        Label3.TabIndex = 5
        Label3.Text = "Standard Disketten"
        Label3.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
        '
        'OpenFileDialog1
        '
        OpenFileDialog1.FileName = "OpenFileDialog1"
        '
        'DataGridViewTextBoxColumn1
        '
        DataGridViewCellStyle4.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleCenter
        DataGridViewTextBoxColumn1.DefaultCellStyle = DataGridViewCellStyle4
        DataGridViewTextBoxColumn1.HeaderText = "Art"
        DataGridViewTextBoxColumn1.Name = "DataGridViewTextBoxColumn1"
        DataGridViewTextBoxColumn1.Width = 20
        '
        'DataGridViewTextBoxColumn2
        '
        DataGridViewCellStyle5.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleCenter
        DataGridViewTextBoxColumn2.DefaultCellStyle = DataGridViewCellStyle5
        DataGridViewTextBoxColumn2.HeaderText = "Nr"
        DataGridViewTextBoxColumn2.Name = "DataGridViewTextBoxColumn2"
        DataGridViewTextBoxColumn2.Width = 50
        '
        'DataGridViewTextBoxColumn3
        '
        DataGridViewCellStyle6.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft
        DataGridViewTextBoxColumn3.DefaultCellStyle = DataGridViewCellStyle6
        DataGridViewTextBoxColumn3.HeaderText = "SYS 4"
        DataGridViewTextBoxColumn3.Name = "DataGridViewTextBoxColumn3"
        DataGridViewTextBoxColumn3.Width = 430
        '
        'DataGridViewTextBoxColumn4
        '
        DataGridViewCellStyle7.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleCenter
        DataGridViewTextBoxColumn4.DefaultCellStyle = DataGridViewCellStyle7
        DataGridViewTextBoxColumn4.HeaderText = "Zurodnung"
        DataGridViewTextBoxColumn4.Name = "DataGridViewTextBoxColumn4"
        DataGridViewTextBoxColumn4.Width = 70
        '
        'DataGridViewTextBoxColumn7
        '
        DataGridViewCellStyle8.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleCenter
        DataGridViewTextBoxColumn7.DefaultCellStyle = DataGridViewCellStyle8
        DataGridViewTextBoxColumn7.HeaderText = "Nr"
        DataGridViewTextBoxColumn7.Name = "DataGridViewTextBoxColumn7"
        DataGridViewTextBoxColumn7.Width = 20
        '
        'DataGridViewTextBoxColumn10
        '
        DataGridViewTextBoxColumn10.HeaderText = "Show"
        DataGridViewTextBoxColumn10.Name = "DataGridViewTextBoxColumn10"
        DataGridViewTextBoxColumn10.Width = 70
        '
        'AnzeigeKassetten
        '
        AnzeigeKassetten.BackColor = System.Drawing.Color.FromArgb(CType(CType(192, Byte), Integer), CType(CType(255, Byte), Integer), CType(CType(192, Byte), Integer))
        AnzeigeKassetten.Location = New System.Drawing.Point(574, 0)
        AnzeigeKassetten.Name = "AnzeigeKassetten"
        AnzeigeKassetten.Size = New System.Drawing.Size(70, 20)
        AnzeigeKassetten.TabIndex = 6
        AnzeigeKassetten.Text = "An"
        AnzeigeKassetten.UseVisualStyleBackColor = False
        '
        'Laufwerke
        '
        AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        ClientSize = New System.Drawing.Size(644, 413)
        ControlBox = False
        Controls.Add(AnzeigeKassetten)
        Controls.Add(Label3)
        Controls.Add(Label2)
        Controls.Add(Label1)
        Controls.Add(StandardDisk)
        Controls.Add(MiniDisk)
        Controls.Add(Kassetten1)
        FormBorderStyle = System.Windows.Forms.FormBorderStyle.None
        Icon = CType(resources.GetObject("$this.Icon"), System.Drawing.Icon)
        Name = "Laufwerke"
        Text = "Laufwerke"
        CType(Kassetten1, System.ComponentModel.ISupportInitialize).EndInit()
        CType(MiniDisk, System.ComponentModel.ISupportInitialize).EndInit()
        CType(StandardDisk, System.ComponentModel.ISupportInitialize).EndInit()
        ResumeLayout(False)

    End Sub

    Friend WithEvents Kassetten1 As DataGridView
    Friend WithEvents DataGridViewTextBoxColumn1 As DataGridViewTextBoxColumn
    Friend WithEvents DataGridViewTextBoxColumn2 As DataGridViewTextBoxColumn
    Friend WithEvents DataGridViewTextBoxColumn3 As DataGridViewTextBoxColumn
    Friend WithEvents DataGridViewTextBoxColumn4 As DataGridViewTextBoxColumn
    Friend WithEvents MiniDisk As DataGridView
    Friend WithEvents StandardDisk As DataGridView
    Friend WithEvents Label1 As Label
    Friend WithEvents Label2 As Label
    Friend WithEvents Label3 As Label
    Friend WithEvents OpenFileDialog1 As OpenFileDialog
    Friend WithEvents DataGridViewTextBoxColumn7 As DataGridViewTextBoxColumn
    Friend WithEvents DataGridViewTextBoxColumn10 As DataGridViewTextBoxColumn
    Friend WithEvents AnzeigeKassetten As Button
End Class
