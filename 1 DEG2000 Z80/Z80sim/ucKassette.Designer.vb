<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()>
Partial Class ucKassette
    Inherits System.Windows.Forms.UserControl

    'UserControl überschreibt den Löschvorgang, um die Komponentenliste zu bereinigen.
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
        Dim DataGridViewCellStyle3 As System.Windows.Forms.DataGridViewCellStyle = New System.Windows.Forms.DataGridViewCellStyle()
        Dim DataGridViewCellStyle4 As System.Windows.Forms.DataGridViewCellStyle = New System.Windows.Forms.DataGridViewCellStyle()
        Dim DataGridViewCellStyle1 As System.Windows.Forms.DataGridViewCellStyle = New System.Windows.Forms.DataGridViewCellStyle()
        Dim DataGridViewCellStyle5 As System.Windows.Forms.DataGridViewCellStyle = New System.Windows.Forms.DataGridViewCellStyle()
        Dim DataGridViewCellStyle2 As System.Windows.Forms.DataGridViewCellStyle = New System.Windows.Forms.DataGridViewCellStyle()
        Me.RecordAnsicht = New System.Windows.Forms.DataGridView()
        Me.StatusStrip1 = New System.Windows.Forms.StatusStrip()
        Me.crcRecordT = New System.Windows.Forms.ToolStripStatusLabel()
        Me.crcRecord = New System.Windows.Forms.ToolStripStatusLabel()
        Me.BM = New System.Windows.Forms.ToolStripStatusLabel()
        Me.crcFileT = New System.Windows.Forms.ToolStripStatusLabel()
        Me.crcFile = New System.Windows.Forms.ToolStripStatusLabel()
        Me.Datei = New System.Windows.Forms.Button()
        Me.Verzeichnis = New System.Windows.Forms.Button()
        Me.Rewind = New System.Windows.Forms.Button()
        Me.BMback = New System.Windows.Forms.Button()
        Me.BMvor = New System.Windows.Forms.Button()
        Me.RecordBack = New System.Windows.Forms.Button()
        Me.RecordVor = New System.Windows.Forms.Button()
        Me.OpenCassette = New System.Windows.Forms.Button()
        Me.OpenFileDialog1 = New System.Windows.Forms.OpenFileDialog()
        Me.CreateCassette = New System.Windows.Forms.Button()
        Me.SaveFileDialog1 = New System.Windows.Forms.SaveFileDialog()
        Me.FilePos = New System.Windows.Forms.Label()
        Me.DataGridViewTextBoxColumn1 = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.DataGridViewTextBoxColumn2 = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.DataGridViewTextBoxColumn3 = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.DataGridViewTextBoxColumn4 = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.DataGridViewTextBoxColumn5 = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.DataGridViewTextBoxColumn6 = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.DataGridViewTextBoxColumn7 = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.DataGridViewTextBoxColumn8 = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.DataGridViewTextBoxColumn9 = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.DataGridViewTextBoxColumn10 = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.DataGridViewTextBoxColumn11 = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.DataGridViewTextBoxColumn12 = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.DataGridViewTextBoxColumn13 = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.DataGridViewTextBoxColumn14 = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.DataGridViewTextBoxColumn15 = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.DataGridViewTextBoxColumn16 = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.DataGridViewTextBoxColumn17 = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.DataGridViewTextBoxColumn18 = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.DataGridViewTextBoxColumn19 = New System.Windows.Forms.DataGridViewTextBoxColumn()
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
        CType(Me.RecordAnsicht, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.StatusStrip1.SuspendLayout()
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
        Me.RecordAnsicht.RowHeadersWidthSizeMode = System.Windows.Forms.DataGridViewRowHeadersWidthSizeMode.DisableResizing
        Me.RecordAnsicht.ScrollBars = System.Windows.Forms.ScrollBars.None
        Me.RecordAnsicht.Size = New System.Drawing.Size(677, 180)
        Me.RecordAnsicht.TabIndex = 65
        '
        'StatusStrip1
        '
        Me.StatusStrip1.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.crcRecordT, Me.crcRecord, Me.BM, Me.crcFileT, Me.crcFile})
        Me.StatusStrip1.Location = New System.Drawing.Point(0, 214)
        Me.StatusStrip1.Name = "StatusStrip1"
        Me.StatusStrip1.Size = New System.Drawing.Size(678, 22)
        Me.StatusStrip1.TabIndex = 75
        Me.StatusStrip1.Text = "StatusStrip1"
        '
        'crcRecordT
        '
        Me.crcRecordT.AutoSize = False
        Me.crcRecordT.BorderSides = CType(((System.Windows.Forms.ToolStripStatusLabelBorderSides.Left Or System.Windows.Forms.ToolStripStatusLabelBorderSides.Top) _
            Or System.Windows.Forms.ToolStripStatusLabelBorderSides.Bottom), System.Windows.Forms.ToolStripStatusLabelBorderSides)
        Me.crcRecordT.Font = New System.Drawing.Font("Arial Rounded MT Bold", 9.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.crcRecordT.ForeColor = System.Drawing.SystemColors.ControlDarkDark
        Me.crcRecordT.Name = "crcRecordT"
        Me.crcRecordT.Size = New System.Drawing.Size(100, 17)
        Me.crcRecordT.Text = "CRC record: "
        '
        'crcRecord
        '
        Me.crcRecord.AutoSize = False
        Me.crcRecord.BorderSides = CType(((System.Windows.Forms.ToolStripStatusLabelBorderSides.Top Or System.Windows.Forms.ToolStripStatusLabelBorderSides.Right) _
            Or System.Windows.Forms.ToolStripStatusLabelBorderSides.Bottom), System.Windows.Forms.ToolStripStatusLabelBorderSides)
        Me.crcRecord.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Text
        Me.crcRecord.Font = New System.Drawing.Font("Arial Rounded MT Bold", 9.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.crcRecord.Name = "crcRecord"
        Me.crcRecord.Size = New System.Drawing.Size(100, 17)
        Me.crcRecord.TextAlign = System.Drawing.ContentAlignment.MiddleLeft
        '
        'BM
        '
        Me.BM.AutoSize = False
        Me.BM.BackColor = System.Drawing.Color.FromArgb(CType(CType(255, Byte), Integer), CType(CType(255, Byte), Integer), CType(CType(192, Byte), Integer))
        Me.BM.BorderSides = CType((((System.Windows.Forms.ToolStripStatusLabelBorderSides.Left Or System.Windows.Forms.ToolStripStatusLabelBorderSides.Top) _
            Or System.Windows.Forms.ToolStripStatusLabelBorderSides.Right) _
            Or System.Windows.Forms.ToolStripStatusLabelBorderSides.Bottom), System.Windows.Forms.ToolStripStatusLabelBorderSides)
        Me.BM.Font = New System.Drawing.Font("Arial Rounded MT Bold", 9.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.BM.ForeColor = System.Drawing.SystemColors.ControlText
        Me.BM.Name = "BM"
        Me.BM.Size = New System.Drawing.Size(260, 17)
        Me.BM.Text = "B  A  N  D  M  A  R  K  E"
        '
        'crcFileT
        '
        Me.crcFileT.AutoSize = False
        Me.crcFileT.BorderSides = CType(((System.Windows.Forms.ToolStripStatusLabelBorderSides.Left Or System.Windows.Forms.ToolStripStatusLabelBorderSides.Top) _
            Or System.Windows.Forms.ToolStripStatusLabelBorderSides.Bottom), System.Windows.Forms.ToolStripStatusLabelBorderSides)
        Me.crcFileT.Font = New System.Drawing.Font("Arial Rounded MT Bold", 9.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.crcFileT.ForeColor = System.Drawing.SystemColors.ControlDarkDark
        Me.crcFileT.Name = "crcFileT"
        Me.crcFileT.Size = New System.Drawing.Size(100, 17)
        Me.crcFileT.Text = "CRC File:"
        '
        'crcFile
        '
        Me.crcFile.AutoSize = False
        Me.crcFile.BorderSides = CType(((System.Windows.Forms.ToolStripStatusLabelBorderSides.Top Or System.Windows.Forms.ToolStripStatusLabelBorderSides.Right) _
            Or System.Windows.Forms.ToolStripStatusLabelBorderSides.Bottom), System.Windows.Forms.ToolStripStatusLabelBorderSides)
        Me.crcFile.Font = New System.Drawing.Font("Arial Rounded MT Bold", 9.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.crcFile.Name = "crcFile"
        Me.crcFile.Size = New System.Drawing.Size(100, 17)
        '
        'Datei
        '
        Me.Datei.Location = New System.Drawing.Point(527, 186)
        Me.Datei.Name = "Datei"
        Me.Datei.Size = New System.Drawing.Size(40, 25)
        Me.Datei.TabIndex = 83
        Me.Datei.Text = "Datei"
        Me.Datei.UseVisualStyleBackColor = True
        '
        'Verzeichnis
        '
        Me.Verzeichnis.Location = New System.Drawing.Point(481, 186)
        Me.Verzeichnis.Name = "Verzeichnis"
        Me.Verzeichnis.Size = New System.Drawing.Size(40, 25)
        Me.Verzeichnis.TabIndex = 82
        Me.Verzeichnis.Text = "Dir"
        Me.Verzeichnis.UseVisualStyleBackColor = True
        '
        'Rewind
        '
        Me.Rewind.Location = New System.Drawing.Point(343, 186)
        Me.Rewind.Name = "Rewind"
        Me.Rewind.Size = New System.Drawing.Size(40, 25)
        Me.Rewind.TabIndex = 81
        Me.Rewind.Text = "|<=="
        Me.Rewind.UseVisualStyleBackColor = True
        '
        'BMback
        '
        Me.BMback.Location = New System.Drawing.Point(389, 186)
        Me.BMback.Name = "BMback"
        Me.BMback.Size = New System.Drawing.Size(40, 25)
        Me.BMback.TabIndex = 80
        Me.BMback.Text = "<=="
        Me.BMback.UseVisualStyleBackColor = True
        '
        'BMvor
        '
        Me.BMvor.Location = New System.Drawing.Point(619, 186)
        Me.BMvor.Name = "BMvor"
        Me.BMvor.Size = New System.Drawing.Size(40, 25)
        Me.BMvor.TabIndex = 79
        Me.BMvor.Text = "==>"
        Me.BMvor.UseVisualStyleBackColor = True
        '
        'RecordBack
        '
        Me.RecordBack.Location = New System.Drawing.Point(435, 186)
        Me.RecordBack.Name = "RecordBack"
        Me.RecordBack.Size = New System.Drawing.Size(40, 25)
        Me.RecordBack.TabIndex = 78
        Me.RecordBack.Text = "<---"
        Me.RecordBack.UseVisualStyleBackColor = True
        '
        'RecordVor
        '
        Me.RecordVor.Location = New System.Drawing.Point(573, 186)
        Me.RecordVor.Name = "RecordVor"
        Me.RecordVor.Size = New System.Drawing.Size(40, 25)
        Me.RecordVor.TabIndex = 77
        Me.RecordVor.Text = "--->"
        Me.RecordVor.UseVisualStyleBackColor = True
        '
        'OpenCassette
        '
        Me.OpenCassette.Location = New System.Drawing.Point(84, 186)
        Me.OpenCassette.Name = "OpenCassette"
        Me.OpenCassette.Size = New System.Drawing.Size(73, 25)
        Me.OpenCassette.TabIndex = 76
        Me.OpenCassette.Text = "Open"
        Me.OpenCassette.UseVisualStyleBackColor = True
        '
        'OpenFileDialog1
        '
        Me.OpenFileDialog1.FileName = "OpenFileDialog1"
        '
        'CreateCassette
        '
        Me.CreateCassette.Location = New System.Drawing.Point(5, 186)
        Me.CreateCassette.Name = "CreateCassette"
        Me.CreateCassette.Size = New System.Drawing.Size(73, 25)
        Me.CreateCassette.TabIndex = 84
        Me.CreateCassette.Text = "Create"
        Me.CreateCassette.UseVisualStyleBackColor = True
        '
        'FilePos
        '
        Me.FilePos.AutoSize = True
        Me.FilePos.Font = New System.Drawing.Font("Arial", 7.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.FilePos.Location = New System.Drawing.Point(160, 189)
        Me.FilePos.MaximumSize = New System.Drawing.Size(170, 0)
        Me.FilePos.MinimumSize = New System.Drawing.Size(180, 19)
        Me.FilePos.Name = "FilePos"
        Me.FilePos.Size = New System.Drawing.Size(180, 19)
        Me.FilePos.TabIndex = 85
        Me.FilePos.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
        '
        'DataGridViewTextBoxColumn1
        '
        DataGridViewCellStyle4.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft
        DataGridViewCellStyle4.BackColor = System.Drawing.Color.FromArgb(CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer))
        DataGridViewCellStyle4.Font = New System.Drawing.Font("Courier New", 9.75!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        DataGridViewCellStyle4.ForeColor = System.Drawing.Color.Gray
        DataGridViewCellStyle4.SelectionBackColor = System.Drawing.Color.FromArgb(CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer))
        DataGridViewCellStyle4.SelectionForeColor = System.Drawing.Color.Gray
        Me.DataGridViewTextBoxColumn1.DefaultCellStyle = DataGridViewCellStyle4
        Me.DataGridViewTextBoxColumn1.HeaderText = ""
        Me.DataGridViewTextBoxColumn1.Name = "DataGridViewTextBoxColumn1"
        Me.DataGridViewTextBoxColumn1.Width = 45
        '
        'DataGridViewTextBoxColumn2
        '
        Me.DataGridViewTextBoxColumn2.HeaderText = "0"
        Me.DataGridViewTextBoxColumn2.Name = "DataGridViewTextBoxColumn2"
        Me.DataGridViewTextBoxColumn2.Width = 30
        '
        'DataGridViewTextBoxColumn3
        '
        Me.DataGridViewTextBoxColumn3.HeaderText = "1"
        Me.DataGridViewTextBoxColumn3.Name = "DataGridViewTextBoxColumn3"
        Me.DataGridViewTextBoxColumn3.Width = 30
        '
        'DataGridViewTextBoxColumn4
        '
        Me.DataGridViewTextBoxColumn4.HeaderText = "2"
        Me.DataGridViewTextBoxColumn4.Name = "DataGridViewTextBoxColumn4"
        Me.DataGridViewTextBoxColumn4.Width = 30
        '
        'DataGridViewTextBoxColumn5
        '
        Me.DataGridViewTextBoxColumn5.HeaderText = "3"
        Me.DataGridViewTextBoxColumn5.Name = "DataGridViewTextBoxColumn5"
        Me.DataGridViewTextBoxColumn5.Width = 30
        '
        'DataGridViewTextBoxColumn6
        '
        Me.DataGridViewTextBoxColumn6.HeaderText = "4"
        Me.DataGridViewTextBoxColumn6.Name = "DataGridViewTextBoxColumn6"
        Me.DataGridViewTextBoxColumn6.Width = 30
        '
        'DataGridViewTextBoxColumn7
        '
        Me.DataGridViewTextBoxColumn7.HeaderText = "5"
        Me.DataGridViewTextBoxColumn7.Name = "DataGridViewTextBoxColumn7"
        Me.DataGridViewTextBoxColumn7.Width = 30
        '
        'DataGridViewTextBoxColumn8
        '
        Me.DataGridViewTextBoxColumn8.HeaderText = "6"
        Me.DataGridViewTextBoxColumn8.Name = "DataGridViewTextBoxColumn8"
        Me.DataGridViewTextBoxColumn8.Width = 30
        '
        'DataGridViewTextBoxColumn9
        '
        Me.DataGridViewTextBoxColumn9.HeaderText = "7"
        Me.DataGridViewTextBoxColumn9.Name = "DataGridViewTextBoxColumn9"
        Me.DataGridViewTextBoxColumn9.Width = 30
        '
        'DataGridViewTextBoxColumn10
        '
        Me.DataGridViewTextBoxColumn10.HeaderText = "8"
        Me.DataGridViewTextBoxColumn10.Name = "DataGridViewTextBoxColumn10"
        Me.DataGridViewTextBoxColumn10.Width = 30
        '
        'DataGridViewTextBoxColumn11
        '
        Me.DataGridViewTextBoxColumn11.HeaderText = "9"
        Me.DataGridViewTextBoxColumn11.Name = "DataGridViewTextBoxColumn11"
        Me.DataGridViewTextBoxColumn11.Width = 30
        '
        'DataGridViewTextBoxColumn12
        '
        Me.DataGridViewTextBoxColumn12.HeaderText = "A"
        Me.DataGridViewTextBoxColumn12.Name = "DataGridViewTextBoxColumn12"
        Me.DataGridViewTextBoxColumn12.Width = 30
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
        'DataGridViewTextBoxColumn14
        '
        Me.DataGridViewTextBoxColumn14.HeaderText = "C"
        Me.DataGridViewTextBoxColumn14.Name = "DataGridViewTextBoxColumn14"
        Me.DataGridViewTextBoxColumn14.Width = 30
        '
        'DataGridViewTextBoxColumn15
        '
        Me.DataGridViewTextBoxColumn15.HeaderText = "D"
        Me.DataGridViewTextBoxColumn15.Name = "DataGridViewTextBoxColumn15"
        Me.DataGridViewTextBoxColumn15.Width = 30
        '
        'DataGridViewTextBoxColumn16
        '
        Me.DataGridViewTextBoxColumn16.HeaderText = "E"
        Me.DataGridViewTextBoxColumn16.Name = "DataGridViewTextBoxColumn16"
        Me.DataGridViewTextBoxColumn16.Width = 30
        '
        'DataGridViewTextBoxColumn17
        '
        Me.DataGridViewTextBoxColumn17.HeaderText = "F"
        Me.DataGridViewTextBoxColumn17.Name = "DataGridViewTextBoxColumn17"
        Me.DataGridViewTextBoxColumn17.Width = 30
        '
        'DataGridViewTextBoxColumn18
        '
        Me.DataGridViewTextBoxColumn18.HeaderText = ""
        Me.DataGridViewTextBoxColumn18.Name = "DataGridViewTextBoxColumn18"
        Me.DataGridViewTextBoxColumn18.Width = 15
        '
        'DataGridViewTextBoxColumn19
        '
        DataGridViewCellStyle5.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft
        DataGridViewCellStyle5.BackColor = System.Drawing.Color.FromArgb(CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer))
        DataGridViewCellStyle5.Font = New System.Drawing.Font("Courier New", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        DataGridViewCellStyle5.ForeColor = System.Drawing.Color.Gray
        DataGridViewCellStyle5.SelectionBackColor = System.Drawing.Color.FromArgb(CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer))
        DataGridViewCellStyle5.SelectionForeColor = System.Drawing.Color.Gray
        Me.DataGridViewTextBoxColumn19.DefaultCellStyle = DataGridViewCellStyle5
        Me.DataGridViewTextBoxColumn19.HeaderText = "Char"
        Me.DataGridViewTextBoxColumn19.Name = "DataGridViewTextBoxColumn19"
        Me.DataGridViewTextBoxColumn19.Width = 135
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
        'ucKassette
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.Controls.Add(Me.FilePos)
        Me.Controls.Add(Me.CreateCassette)
        Me.Controls.Add(Me.Datei)
        Me.Controls.Add(Me.Verzeichnis)
        Me.Controls.Add(Me.Rewind)
        Me.Controls.Add(Me.BMback)
        Me.Controls.Add(Me.BMvor)
        Me.Controls.Add(Me.RecordBack)
        Me.Controls.Add(Me.RecordVor)
        Me.Controls.Add(Me.OpenCassette)
        Me.Controls.Add(Me.StatusStrip1)
        Me.Controls.Add(Me.RecordAnsicht)
        Me.Name = "ucKassette"
        Me.Size = New System.Drawing.Size(678, 236)
        CType(Me.RecordAnsicht, System.ComponentModel.ISupportInitialize).EndInit()
        Me.StatusStrip1.ResumeLayout(False)
        Me.StatusStrip1.PerformLayout()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub

    Friend WithEvents RecordAnsicht As DataGridView
    Friend WithEvents DataGridViewTextBoxColumn13 As DataGridViewTextBoxColumn
    Friend WithEvents sp0 As DataGridViewTextBoxColumn
    Friend WithEvents sp1 As DataGridViewTextBoxColumn
    Friend WithEvents sp2 As DataGridViewTextBoxColumn
    Friend WithEvents sp3 As DataGridViewTextBoxColumn
    Friend WithEvents sp4 As DataGridViewTextBoxColumn
    Friend WithEvents sp5 As DataGridViewTextBoxColumn
    Friend WithEvents sp6 As DataGridViewTextBoxColumn
    Friend WithEvents sp7 As DataGridViewTextBoxColumn
    Friend WithEvents sp8 As DataGridViewTextBoxColumn
    Friend WithEvents sp9 As DataGridViewTextBoxColumn
    Friend WithEvents spA As DataGridViewTextBoxColumn
    Friend WithEvents spB As DataGridViewTextBoxColumn
    Friend WithEvents spC As DataGridViewTextBoxColumn
    Friend WithEvents spD As DataGridViewTextBoxColumn
    Friend WithEvents spE As DataGridViewTextBoxColumn
    Friend WithEvents spF As DataGridViewTextBoxColumn
    Friend WithEvents spNULL As DataGridViewTextBoxColumn
    Friend WithEvents spChar As DataGridViewTextBoxColumn
    Friend WithEvents StatusStrip1 As StatusStrip
    Friend WithEvents crcRecordT As ToolStripStatusLabel
    Friend WithEvents crcRecord As ToolStripStatusLabel
    Friend WithEvents BM As ToolStripStatusLabel
    Friend WithEvents crcFileT As ToolStripStatusLabel
    Friend WithEvents crcFile As ToolStripStatusLabel
    Friend WithEvents Datei As Button
    Friend WithEvents Verzeichnis As Button
    Friend WithEvents Rewind As Button
    Friend WithEvents BMback As Button
    Friend WithEvents BMvor As Button
    Friend WithEvents RecordBack As Button
    Friend WithEvents RecordVor As Button
    Friend WithEvents OpenCassette As Button
    Friend WithEvents DataGridViewTextBoxColumn1 As DataGridViewTextBoxColumn
    Friend WithEvents DataGridViewTextBoxColumn2 As DataGridViewTextBoxColumn
    Friend WithEvents DataGridViewTextBoxColumn3 As DataGridViewTextBoxColumn
    Friend WithEvents DataGridViewTextBoxColumn4 As DataGridViewTextBoxColumn
    Friend WithEvents DataGridViewTextBoxColumn5 As DataGridViewTextBoxColumn
    Friend WithEvents DataGridViewTextBoxColumn6 As DataGridViewTextBoxColumn
    Friend WithEvents DataGridViewTextBoxColumn7 As DataGridViewTextBoxColumn
    Friend WithEvents DataGridViewTextBoxColumn8 As DataGridViewTextBoxColumn
    Friend WithEvents DataGridViewTextBoxColumn9 As DataGridViewTextBoxColumn
    Friend WithEvents DataGridViewTextBoxColumn10 As DataGridViewTextBoxColumn
    Friend WithEvents DataGridViewTextBoxColumn11 As DataGridViewTextBoxColumn
    Friend WithEvents DataGridViewTextBoxColumn12 As DataGridViewTextBoxColumn
    Friend WithEvents DataGridViewTextBoxColumn14 As DataGridViewTextBoxColumn
    Friend WithEvents DataGridViewTextBoxColumn15 As DataGridViewTextBoxColumn
    Friend WithEvents DataGridViewTextBoxColumn16 As DataGridViewTextBoxColumn
    Friend WithEvents DataGridViewTextBoxColumn17 As DataGridViewTextBoxColumn
    Friend WithEvents DataGridViewTextBoxColumn18 As DataGridViewTextBoxColumn
    Friend WithEvents DataGridViewTextBoxColumn19 As DataGridViewTextBoxColumn
    Friend WithEvents OpenFileDialog1 As OpenFileDialog
    Friend WithEvents CreateCassette As Button
    Friend WithEvents SaveFileDialog1 As SaveFileDialog
    Friend WithEvents FilePos As Label
End Class
