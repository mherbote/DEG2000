<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class AnzeigeKassette
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

    'Wird vom Windows Form-Designer benötigt.
    Private components As System.ComponentModel.IContainer

    'Hinweis: Die folgende Prozedur ist für den Windows Form-Designer erforderlich.
    'Das Bearbeiten ist mit dem Windows Form-Designer möglich.  
    'Das Bearbeiten mit dem Code-Editor ist nicht möglich.
    <System.Diagnostics.DebuggerStepThrough()> _
    Private Sub InitializeComponent()
        Dim DataGridViewCellStyle3 As System.Windows.Forms.DataGridViewCellStyle = New System.Windows.Forms.DataGridViewCellStyle()
        Dim DataGridViewCellStyle1 As System.Windows.Forms.DataGridViewCellStyle = New System.Windows.Forms.DataGridViewCellStyle()
        Dim DataGridViewCellStyle2 As System.Windows.Forms.DataGridViewCellStyle = New System.Windows.Forms.DataGridViewCellStyle()
        Dim DataGridViewCellStyle5 As System.Windows.Forms.DataGridViewCellStyle = New System.Windows.Forms.DataGridViewCellStyle()
        Dim DataGridViewCellStyle4 As System.Windows.Forms.DataGridViewCellStyle = New System.Windows.Forms.DataGridViewCellStyle()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(AnzeigeKassette))
        Me.RecordAnsicht = New System.Windows.Forms.DataGridView()
        Me.DataGridViewTextBoxColumn13 = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.sp0 = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.sp1 = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.sp2 = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.sp3 = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.sp4 = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.sp5 = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.sp6 = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.sp7 = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.sp8 = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.sp9 = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.spA = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.spB = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.spC = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.spD = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.spE = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.spF = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.spNULL = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.spChar = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.Anzeige = New System.Windows.Forms.DataGridView()
        Me.DataGridViewTextBoxColumn1 = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.OpenFileDialog1 = New System.Windows.Forms.OpenFileDialog()
        Me.OpenCassette = New System.Windows.Forms.Button()
        Me.RecordVor = New System.Windows.Forms.Button()
        Me.RecordBack = New System.Windows.Forms.Button()
        Me.BMvor = New System.Windows.Forms.Button()
        Me.BMback = New System.Windows.Forms.Button()
        Me.Rewind = New System.Windows.Forms.Button()
        Me.Verzeichnis = New System.Windows.Forms.Button()
        Me.Datei = New System.Windows.Forms.Button()
        CType(Me.RecordAnsicht, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.Anzeige, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SuspendLayout()
        '
        'RecordAnsicht
        '
        Me.RecordAnsicht.AllowUserToAddRows = False
        Me.RecordAnsicht.AllowUserToDeleteRows = False
        Me.RecordAnsicht.AllowUserToResizeColumns = False
        Me.RecordAnsicht.AllowUserToResizeRows = False
        Me.RecordAnsicht.BackgroundColor = System.Drawing.Color.FromArgb(CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer))
        Me.RecordAnsicht.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize
        Me.RecordAnsicht.Columns.AddRange(New System.Windows.Forms.DataGridViewColumn() {Me.DataGridViewTextBoxColumn13, Me.sp0, Me.sp1, Me.sp2, Me.sp3, Me.sp4, Me.sp5, Me.sp6, Me.sp7, Me.sp8, Me.sp9, Me.spA, Me.spB, Me.spC, Me.spD, Me.spE, Me.spF, Me.spNULL, Me.spChar})
        DataGridViewCellStyle3.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft
        DataGridViewCellStyle3.BackColor = System.Drawing.Color.FromArgb(CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer))
        DataGridViewCellStyle3.Font = New System.Drawing.Font("Arial Rounded MT Bold", 9.75!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        DataGridViewCellStyle3.ForeColor = System.Drawing.Color.Gray
        DataGridViewCellStyle3.SelectionBackColor = System.Drawing.Color.FromArgb(CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer))
        DataGridViewCellStyle3.SelectionForeColor = System.Drawing.Color.Gray
        DataGridViewCellStyle3.WrapMode = System.Windows.Forms.DataGridViewTriState.[False]
        Me.RecordAnsicht.DefaultCellStyle = DataGridViewCellStyle3
        Me.RecordAnsicht.EditMode = System.Windows.Forms.DataGridViewEditMode.EditProgrammatically
        Me.RecordAnsicht.Enabled = False
        Me.RecordAnsicht.GridColor = System.Drawing.Color.FromArgb(CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer))
        Me.RecordAnsicht.Location = New System.Drawing.Point(0, 0)
        Me.RecordAnsicht.MultiSelect = False
        Me.RecordAnsicht.Name = "RecordAnsicht"
        Me.RecordAnsicht.RowHeadersVisible = False
        Me.RecordAnsicht.ScrollBars = System.Windows.Forms.ScrollBars.None
        Me.RecordAnsicht.Size = New System.Drawing.Size(677, 180)
        Me.RecordAnsicht.TabIndex = 64
        '
        'DataGridViewTextBoxColumn13
        '
        DataGridViewCellStyle1.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft
        DataGridViewCellStyle1.BackColor = System.Drawing.Color.FromArgb(CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer))
        DataGridViewCellStyle1.Font = New System.Drawing.Font("Courier New", 9.75!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        DataGridViewCellStyle1.ForeColor = System.Drawing.Color.Gray
        DataGridViewCellStyle1.SelectionBackColor = System.Drawing.Color.FromArgb(CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer))
        DataGridViewCellStyle1.SelectionForeColor = System.Drawing.Color.Gray
        Me.DataGridViewTextBoxColumn13.DefaultCellStyle = DataGridViewCellStyle1
        Me.DataGridViewTextBoxColumn13.HeaderText = ""
        Me.DataGridViewTextBoxColumn13.Name = "DataGridViewTextBoxColumn13"
        Me.DataGridViewTextBoxColumn13.Width = 45
        '
        'sp0
        '
        Me.sp0.HeaderText = "0"
        Me.sp0.Name = "sp0"
        Me.sp0.Width = 30
        '
        'sp1
        '
        Me.sp1.HeaderText = "1"
        Me.sp1.Name = "sp1"
        Me.sp1.Width = 30
        '
        'sp2
        '
        Me.sp2.HeaderText = "2"
        Me.sp2.Name = "sp2"
        Me.sp2.Width = 30
        '
        'sp3
        '
        Me.sp3.HeaderText = "3"
        Me.sp3.Name = "sp3"
        Me.sp3.Width = 30
        '
        'sp4
        '
        Me.sp4.HeaderText = "4"
        Me.sp4.Name = "sp4"
        Me.sp4.Width = 30
        '
        'sp5
        '
        Me.sp5.HeaderText = "5"
        Me.sp5.Name = "sp5"
        Me.sp5.Width = 30
        '
        'sp6
        '
        Me.sp6.HeaderText = "6"
        Me.sp6.Name = "sp6"
        Me.sp6.Width = 30
        '
        'sp7
        '
        Me.sp7.HeaderText = "7"
        Me.sp7.Name = "sp7"
        Me.sp7.Width = 30
        '
        'sp8
        '
        Me.sp8.HeaderText = "8"
        Me.sp8.Name = "sp8"
        Me.sp8.Width = 30
        '
        'sp9
        '
        Me.sp9.HeaderText = "9"
        Me.sp9.Name = "sp9"
        Me.sp9.Width = 30
        '
        'spA
        '
        Me.spA.HeaderText = "A"
        Me.spA.Name = "spA"
        Me.spA.Width = 30
        '
        'spB
        '
        Me.spB.HeaderText = "B"
        Me.spB.Name = "spB"
        Me.spB.Width = 30
        '
        'spC
        '
        Me.spC.HeaderText = "C"
        Me.spC.Name = "spC"
        Me.spC.Width = 30
        '
        'spD
        '
        Me.spD.HeaderText = "D"
        Me.spD.Name = "spD"
        Me.spD.Width = 30
        '
        'spE
        '
        Me.spE.HeaderText = "E"
        Me.spE.Name = "spE"
        Me.spE.Width = 30
        '
        'spF
        '
        Me.spF.HeaderText = "F"
        Me.spF.Name = "spF"
        Me.spF.Width = 30
        '
        'spNULL
        '
        Me.spNULL.HeaderText = ""
        Me.spNULL.Name = "spNULL"
        Me.spNULL.Width = 15
        '
        'spChar
        '
        DataGridViewCellStyle2.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft
        DataGridViewCellStyle2.BackColor = System.Drawing.Color.FromArgb(CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer))
        DataGridViewCellStyle2.Font = New System.Drawing.Font("Courier New", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        DataGridViewCellStyle2.ForeColor = System.Drawing.Color.Gray
        DataGridViewCellStyle2.SelectionBackColor = System.Drawing.Color.FromArgb(CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer))
        DataGridViewCellStyle2.SelectionForeColor = System.Drawing.Color.Gray
        Me.spChar.DefaultCellStyle = DataGridViewCellStyle2
        Me.spChar.HeaderText = "Char"
        Me.spChar.Name = "spChar"
        Me.spChar.Width = 135
        '
        'Anzeige
        '
        Me.Anzeige.AllowUserToResizeColumns = False
        Me.Anzeige.AllowUserToResizeRows = False
        Me.Anzeige.BackgroundColor = System.Drawing.Color.FromArgb(CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer))
        Me.Anzeige.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.DisableResizing
        Me.Anzeige.ColumnHeadersVisible = False
        Me.Anzeige.Columns.AddRange(New System.Windows.Forms.DataGridViewColumn() {Me.DataGridViewTextBoxColumn1})
        DataGridViewCellStyle5.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft
        DataGridViewCellStyle5.BackColor = System.Drawing.Color.FromArgb(CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer))
        DataGridViewCellStyle5.Font = New System.Drawing.Font("Courier New", 9.75!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        DataGridViewCellStyle5.ForeColor = System.Drawing.Color.Gray
        DataGridViewCellStyle5.SelectionBackColor = System.Drawing.Color.FromArgb(CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer))
        DataGridViewCellStyle5.SelectionForeColor = System.Drawing.Color.Gray
        DataGridViewCellStyle5.WrapMode = System.Windows.Forms.DataGridViewTriState.[False]
        Me.Anzeige.DefaultCellStyle = DataGridViewCellStyle5
        Me.Anzeige.EditMode = System.Windows.Forms.DataGridViewEditMode.EditProgrammatically
        Me.Anzeige.Enabled = False
        Me.Anzeige.GridColor = System.Drawing.Color.FromArgb(CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer))
        Me.Anzeige.Location = New System.Drawing.Point(680, 95)
        Me.Anzeige.MultiSelect = False
        Me.Anzeige.Name = "Anzeige"
        Me.Anzeige.ReadOnly = True
        Me.Anzeige.RowHeadersVisible = False
        Me.Anzeige.ScrollBars = System.Windows.Forms.ScrollBars.None
        Me.Anzeige.Size = New System.Drawing.Size(177, 85)
        Me.Anzeige.TabIndex = 65
        '
        'DataGridViewTextBoxColumn1
        '
        DataGridViewCellStyle4.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft
        DataGridViewCellStyle4.BackColor = System.Drawing.Color.FromArgb(CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer))
        DataGridViewCellStyle4.Font = New System.Drawing.Font("Courier New", 9.75!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        DataGridViewCellStyle4.ForeColor = System.Drawing.Color.Gray
        Me.DataGridViewTextBoxColumn1.DefaultCellStyle = DataGridViewCellStyle4
        Me.DataGridViewTextBoxColumn1.HeaderText = "Zeile"
        Me.DataGridViewTextBoxColumn1.Name = "DataGridViewTextBoxColumn1"
        Me.DataGridViewTextBoxColumn1.ReadOnly = True
        Me.DataGridViewTextBoxColumn1.Width = 300
        '
        'OpenFileDialog1
        '
        Me.OpenFileDialog1.FileName = "OpenFileDialog1"
        '
        'OpenCassette
        '
        Me.OpenCassette.Location = New System.Drawing.Point(680, 0)
        Me.OpenCassette.Name = "OpenCassette"
        Me.OpenCassette.Size = New System.Drawing.Size(177, 25)
        Me.OpenCassette.TabIndex = 66
        Me.OpenCassette.Text = "Open Cassette"
        Me.OpenCassette.UseVisualStyleBackColor = True
        '
        'RecordVor
        '
        Me.RecordVor.Location = New System.Drawing.Point(771, 31)
        Me.RecordVor.Name = "RecordVor"
        Me.RecordVor.Size = New System.Drawing.Size(30, 25)
        Me.RecordVor.TabIndex = 67
        Me.RecordVor.Text = "--->"
        Me.RecordVor.UseVisualStyleBackColor = True
        '
        'RecordBack
        '
        Me.RecordBack.Location = New System.Drawing.Point(735, 31)
        Me.RecordBack.Name = "RecordBack"
        Me.RecordBack.Size = New System.Drawing.Size(30, 25)
        Me.RecordBack.TabIndex = 68
        Me.RecordBack.Text = "<---"
        Me.RecordBack.UseVisualStyleBackColor = True
        '
        'BMvor
        '
        Me.BMvor.Location = New System.Drawing.Point(772, 62)
        Me.BMvor.Name = "BMvor"
        Me.BMvor.Size = New System.Drawing.Size(40, 25)
        Me.BMvor.TabIndex = 69
        Me.BMvor.Text = "==>"
        Me.BMvor.UseVisualStyleBackColor = True
        '
        'BMback
        '
        Me.BMback.Location = New System.Drawing.Point(726, 62)
        Me.BMback.Name = "BMback"
        Me.BMback.Size = New System.Drawing.Size(40, 25)
        Me.BMback.TabIndex = 70
        Me.BMback.Text = "<=="
        Me.BMback.UseVisualStyleBackColor = True
        '
        'Rewind
        '
        Me.Rewind.Location = New System.Drawing.Point(680, 62)
        Me.Rewind.Name = "Rewind"
        Me.Rewind.Size = New System.Drawing.Size(40, 25)
        Me.Rewind.TabIndex = 71
        Me.Rewind.Text = "|<=="
        Me.Rewind.UseVisualStyleBackColor = True
        '
        'Verzeichnis
        '
        Me.Verzeichnis.Location = New System.Drawing.Point(680, 31)
        Me.Verzeichnis.Name = "Verzeichnis"
        Me.Verzeichnis.Size = New System.Drawing.Size(40, 25)
        Me.Verzeichnis.TabIndex = 72
        Me.Verzeichnis.Text = "Dir"
        Me.Verzeichnis.UseVisualStyleBackColor = True
        '
        'Datei
        '
        Me.Datei.Location = New System.Drawing.Point(817, 31)
        Me.Datei.Name = "Datei"
        Me.Datei.Size = New System.Drawing.Size(40, 25)
        Me.Datei.TabIndex = 73
        Me.Datei.Text = "Datei"
        Me.Datei.UseVisualStyleBackColor = True
        '
        'AnzeigeKassette
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(858, 182)
        Me.ControlBox = False
        Me.Controls.Add(Me.Datei)
        Me.Controls.Add(Me.Verzeichnis)
        Me.Controls.Add(Me.Rewind)
        Me.Controls.Add(Me.BMback)
        Me.Controls.Add(Me.BMvor)
        Me.Controls.Add(Me.RecordBack)
        Me.Controls.Add(Me.RecordVor)
        Me.Controls.Add(Me.OpenCassette)
        Me.Controls.Add(Me.Anzeige)
        Me.Controls.Add(Me.RecordAnsicht)
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedToolWindow
        Me.Icon = CType(resources.GetObject("$this.Icon"), System.Drawing.Icon)
        Me.Name = "AnzeigeKassette"
        Me.Text = "Kassetteninhalt anzeigen"
        Me.TopMost = True
        CType(Me.RecordAnsicht, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.Anzeige, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)

    End Sub
    Friend WithEvents RecordAnsicht As System.Windows.Forms.DataGridView
    Friend WithEvents DataGridViewTextBoxColumn13 As System.Windows.Forms.DataGridViewTextBoxColumn
    Friend WithEvents sp0 As System.Windows.Forms.DataGridViewTextBoxColumn
    Friend WithEvents sp1 As System.Windows.Forms.DataGridViewTextBoxColumn
    Friend WithEvents sp2 As System.Windows.Forms.DataGridViewTextBoxColumn
    Friend WithEvents sp3 As System.Windows.Forms.DataGridViewTextBoxColumn
    Friend WithEvents sp4 As System.Windows.Forms.DataGridViewTextBoxColumn
    Friend WithEvents sp5 As System.Windows.Forms.DataGridViewTextBoxColumn
    Friend WithEvents sp6 As System.Windows.Forms.DataGridViewTextBoxColumn
    Friend WithEvents sp7 As System.Windows.Forms.DataGridViewTextBoxColumn
    Friend WithEvents sp8 As System.Windows.Forms.DataGridViewTextBoxColumn
    Friend WithEvents sp9 As System.Windows.Forms.DataGridViewTextBoxColumn
    Friend WithEvents spA As System.Windows.Forms.DataGridViewTextBoxColumn
    Friend WithEvents spB As System.Windows.Forms.DataGridViewTextBoxColumn
    Friend WithEvents spC As System.Windows.Forms.DataGridViewTextBoxColumn
    Friend WithEvents spD As System.Windows.Forms.DataGridViewTextBoxColumn
    Friend WithEvents spE As System.Windows.Forms.DataGridViewTextBoxColumn
    Friend WithEvents spF As System.Windows.Forms.DataGridViewTextBoxColumn
    Friend WithEvents spNULL As System.Windows.Forms.DataGridViewTextBoxColumn
    Friend WithEvents spChar As System.Windows.Forms.DataGridViewTextBoxColumn
    Friend WithEvents Anzeige As System.Windows.Forms.DataGridView
    Friend WithEvents OpenFileDialog1 As System.Windows.Forms.OpenFileDialog
    Friend WithEvents OpenCassette As System.Windows.Forms.Button
    Friend WithEvents RecordVor As System.Windows.Forms.Button
    Friend WithEvents RecordBack As System.Windows.Forms.Button
    Friend WithEvents BMvor As System.Windows.Forms.Button
    Friend WithEvents BMback As System.Windows.Forms.Button
    Friend WithEvents Rewind As System.Windows.Forms.Button
    Friend WithEvents Verzeichnis As System.Windows.Forms.Button
    Friend WithEvents Datei As System.Windows.Forms.Button
    Friend WithEvents DataGridViewTextBoxColumn1 As System.Windows.Forms.DataGridViewTextBoxColumn
End Class
