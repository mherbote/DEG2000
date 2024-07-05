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
        Me.Kassetten1 = New System.Windows.Forms.DataGridView()
        Me.MiniDisk = New System.Windows.Forms.DataGridView()
        Me.StandardDisk = New System.Windows.Forms.DataGridView()
        Me.Label1 = New System.Windows.Forms.Label()
        Me.Label2 = New System.Windows.Forms.Label()
        Me.Label3 = New System.Windows.Forms.Label()
        Me.OpenFileDialog1 = New System.Windows.Forms.OpenFileDialog()
        Me.DataGridViewTextBoxColumn1 = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.DataGridViewTextBoxColumn2 = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.DataGridViewTextBoxColumn3 = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.DataGridViewTextBoxColumn4 = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.DataGridViewTextBoxColumn7 = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.DataGridViewTextBoxColumn10 = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.AnzeigeKassetten = New System.Windows.Forms.Button()
        CType(Me.Kassetten1, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.MiniDisk, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.StandardDisk, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SuspendLayout()
        '
        'Kassetten1
        '
        Me.Kassetten1.AllowUserToAddRows = False
        Me.Kassetten1.AllowUserToDeleteRows = False
        Me.Kassetten1.AllowUserToResizeColumns = False
        Me.Kassetten1.AllowUserToResizeRows = False
        Me.Kassetten1.BackgroundColor = System.Drawing.Color.FromArgb(CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer))
        DataGridViewCellStyle1.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleCenter
        DataGridViewCellStyle1.BackColor = System.Drawing.SystemColors.Control
        DataGridViewCellStyle1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        DataGridViewCellStyle1.ForeColor = System.Drawing.SystemColors.WindowText
        DataGridViewCellStyle1.SelectionBackColor = System.Drawing.SystemColors.Highlight
        DataGridViewCellStyle1.SelectionForeColor = System.Drawing.SystemColors.HighlightText
        DataGridViewCellStyle1.WrapMode = System.Windows.Forms.DataGridViewTriState.[True]
        Me.Kassetten1.ColumnHeadersDefaultCellStyle = DataGridViewCellStyle1
        Me.Kassetten1.ColumnHeadersHeight = 22
        Me.Kassetten1.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.DisableResizing
        Me.Kassetten1.Location = New System.Drawing.Point(1, 20)
        Me.Kassetten1.Name = "Kassetten1"
        Me.Kassetten1.RowHeadersVisible = False
        Me.Kassetten1.RowHeadersWidthSizeMode = System.Windows.Forms.DataGridViewRowHeadersWidthSizeMode.DisableResizing
        Me.Kassetten1.ScrollBars = System.Windows.Forms.ScrollBars.None
        Me.Kassetten1.Size = New System.Drawing.Size(641, 154)
        Me.Kassetten1.TabIndex = 0
        '
        'MiniDisk
        '
        Me.MiniDisk.AllowUserToAddRows = False
        Me.MiniDisk.AllowUserToDeleteRows = False
        Me.MiniDisk.AllowUserToResizeColumns = False
        Me.MiniDisk.AllowUserToResizeRows = False
        Me.MiniDisk.BackgroundColor = System.Drawing.Color.FromArgb(CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer))
        DataGridViewCellStyle2.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleCenter
        DataGridViewCellStyle2.BackColor = System.Drawing.SystemColors.Control
        DataGridViewCellStyle2.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        DataGridViewCellStyle2.ForeColor = System.Drawing.SystemColors.WindowText
        DataGridViewCellStyle2.SelectionBackColor = System.Drawing.SystemColors.Highlight
        DataGridViewCellStyle2.SelectionForeColor = System.Drawing.SystemColors.HighlightText
        DataGridViewCellStyle2.WrapMode = System.Windows.Forms.DataGridViewTriState.[True]
        Me.MiniDisk.ColumnHeadersDefaultCellStyle = DataGridViewCellStyle2
        Me.MiniDisk.ColumnHeadersHeight = 22
        Me.MiniDisk.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.DisableResizing
        Me.MiniDisk.Location = New System.Drawing.Point(1, 210)
        Me.MiniDisk.Name = "MiniDisk"
        Me.MiniDisk.RowHeadersVisible = False
        Me.MiniDisk.ScrollBars = System.Windows.Forms.ScrollBars.None
        Me.MiniDisk.Size = New System.Drawing.Size(641, 110)
        Me.MiniDisk.TabIndex = 1
        '
        'StandardDisk
        '
        Me.StandardDisk.AllowUserToAddRows = False
        Me.StandardDisk.AllowUserToDeleteRows = False
        Me.StandardDisk.AllowUserToResizeColumns = False
        Me.StandardDisk.AllowUserToResizeRows = False
        Me.StandardDisk.BackgroundColor = System.Drawing.Color.FromArgb(CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer))
        DataGridViewCellStyle3.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleCenter
        DataGridViewCellStyle3.BackColor = System.Drawing.SystemColors.Control
        DataGridViewCellStyle3.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        DataGridViewCellStyle3.ForeColor = System.Drawing.SystemColors.WindowText
        DataGridViewCellStyle3.SelectionBackColor = System.Drawing.SystemColors.Highlight
        DataGridViewCellStyle3.SelectionForeColor = System.Drawing.SystemColors.HighlightText
        DataGridViewCellStyle3.WrapMode = System.Windows.Forms.DataGridViewTriState.[True]
        Me.StandardDisk.ColumnHeadersDefaultCellStyle = DataGridViewCellStyle3
        Me.StandardDisk.ColumnHeadersHeight = 22
        Me.StandardDisk.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.DisableResizing
        Me.StandardDisk.Location = New System.Drawing.Point(1, 345)
        Me.StandardDisk.Name = "StandardDisk"
        Me.StandardDisk.RowHeadersVisible = False
        Me.StandardDisk.ScrollBars = System.Windows.Forms.ScrollBars.None
        Me.StandardDisk.Size = New System.Drawing.Size(641, 66)
        Me.StandardDisk.TabIndex = 2
        '
        'Label1
        '
        Me.Label1.Font = New System.Drawing.Font("Microsoft Sans Serif", 9.75!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label1.Location = New System.Drawing.Point(0, 0)
        Me.Label1.Name = "Label1"
        Me.Label1.Size = New System.Drawing.Size(574, 20)
        Me.Label1.TabIndex = 3
        Me.Label1.Text = "Kassetten"
        Me.Label1.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
        '
        'Label2
        '
        Me.Label2.Font = New System.Drawing.Font("Microsoft Sans Serif", 9.75!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label2.Location = New System.Drawing.Point(-2, 190)
        Me.Label2.Name = "Label2"
        Me.Label2.Size = New System.Drawing.Size(574, 20)
        Me.Label2.TabIndex = 4
        Me.Label2.Text = "Mini Disketten"
        Me.Label2.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
        '
        'Label3
        '
        Me.Label3.Font = New System.Drawing.Font("Microsoft Sans Serif", 9.75!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label3.Location = New System.Drawing.Point(0, 325)
        Me.Label3.Name = "Label3"
        Me.Label3.Size = New System.Drawing.Size(574, 20)
        Me.Label3.TabIndex = 5
        Me.Label3.Text = "Standard Disketten"
        Me.Label3.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
        '
        'OpenFileDialog1
        '
        Me.OpenFileDialog1.FileName = "OpenFileDialog1"
        '
        'DataGridViewTextBoxColumn1
        '
        DataGridViewCellStyle4.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleCenter
        Me.DataGridViewTextBoxColumn1.DefaultCellStyle = DataGridViewCellStyle4
        Me.DataGridViewTextBoxColumn1.HeaderText = "Art"
        Me.DataGridViewTextBoxColumn1.Name = "DataGridViewTextBoxColumn1"
        Me.DataGridViewTextBoxColumn1.Width = 20
        '
        'DataGridViewTextBoxColumn2
        '
        DataGridViewCellStyle5.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleCenter
        Me.DataGridViewTextBoxColumn2.DefaultCellStyle = DataGridViewCellStyle5
        Me.DataGridViewTextBoxColumn2.HeaderText = "Nr"
        Me.DataGridViewTextBoxColumn2.Name = "DataGridViewTextBoxColumn2"
        Me.DataGridViewTextBoxColumn2.Width = 50
        '
        'DataGridViewTextBoxColumn3
        '
        DataGridViewCellStyle6.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft
        Me.DataGridViewTextBoxColumn3.DefaultCellStyle = DataGridViewCellStyle6
        Me.DataGridViewTextBoxColumn3.HeaderText = "SYS 4"
        Me.DataGridViewTextBoxColumn3.Name = "DataGridViewTextBoxColumn3"
        Me.DataGridViewTextBoxColumn3.Width = 430
        '
        'DataGridViewTextBoxColumn4
        '
        DataGridViewCellStyle7.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleCenter
        Me.DataGridViewTextBoxColumn4.DefaultCellStyle = DataGridViewCellStyle7
        Me.DataGridViewTextBoxColumn4.HeaderText = "Zurodnung"
        Me.DataGridViewTextBoxColumn4.Name = "DataGridViewTextBoxColumn4"
        Me.DataGridViewTextBoxColumn4.Width = 70
        '
        'DataGridViewTextBoxColumn7
        '
        DataGridViewCellStyle8.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleCenter
        Me.DataGridViewTextBoxColumn7.DefaultCellStyle = DataGridViewCellStyle8
        Me.DataGridViewTextBoxColumn7.HeaderText = "Nr"
        Me.DataGridViewTextBoxColumn7.Name = "DataGridViewTextBoxColumn7"
        Me.DataGridViewTextBoxColumn7.Width = 20
        '
        'DataGridViewTextBoxColumn10
        '
        Me.DataGridViewTextBoxColumn10.HeaderText = "Show"
        Me.DataGridViewTextBoxColumn10.Name = "DataGridViewTextBoxColumn10"
        Me.DataGridViewTextBoxColumn10.Width = 70
        '
        'AnzeigeKassetten
        '
        Me.AnzeigeKassetten.BackColor = System.Drawing.Color.FromArgb(CType(CType(192, Byte), Integer), CType(CType(255, Byte), Integer), CType(CType(192, Byte), Integer))
        Me.AnzeigeKassetten.Location = New System.Drawing.Point(574, 0)
        Me.AnzeigeKassetten.Name = "AnzeigeKassetten"
        Me.AnzeigeKassetten.Size = New System.Drawing.Size(70, 20)
        Me.AnzeigeKassetten.TabIndex = 6
        Me.AnzeigeKassetten.Text = "An"
        Me.AnzeigeKassetten.UseVisualStyleBackColor = False
        '
        'Laufwerke
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(644, 413)
        Me.ControlBox = False
        Me.Controls.Add(Me.AnzeigeKassetten)
        Me.Controls.Add(Me.Label3)
        Me.Controls.Add(Me.Label2)
        Me.Controls.Add(Me.Label1)
        Me.Controls.Add(Me.StandardDisk)
        Me.Controls.Add(Me.MiniDisk)
        Me.Controls.Add(Me.Kassetten1)
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.None
        Me.Icon = CType(resources.GetObject("$this.Icon"), System.Drawing.Icon)
        Me.Name = "Laufwerke"
        Me.Text = "Laufwerke"
        CType(Me.Kassetten1, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.MiniDisk, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.StandardDisk, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)

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
