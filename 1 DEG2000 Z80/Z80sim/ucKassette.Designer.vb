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
        components = New System.ComponentModel.Container()
        Dim DataGridViewCellStyle3 As System.Windows.Forms.DataGridViewCellStyle = New System.Windows.Forms.DataGridViewCellStyle()
        Dim DataGridViewCellStyle4 As System.Windows.Forms.DataGridViewCellStyle = New System.Windows.Forms.DataGridViewCellStyle()
        Dim DataGridViewCellStyle5 As System.Windows.Forms.DataGridViewCellStyle = New System.Windows.Forms.DataGridViewCellStyle()
        Dim DataGridViewCellStyle1 As System.Windows.Forms.DataGridViewCellStyle = New System.Windows.Forms.DataGridViewCellStyle()
        Dim DataGridViewCellStyle2 As System.Windows.Forms.DataGridViewCellStyle = New System.Windows.Forms.DataGridViewCellStyle()
        RecordAnsicht = New System.Windows.Forms.DataGridView()
        StatusStrip1 = New System.Windows.Forms.StatusStrip()
        crcRecordT = New System.Windows.Forms.ToolStripStatusLabel()
        crcRecord = New System.Windows.Forms.ToolStripStatusLabel()
        BM = New System.Windows.Forms.ToolStripStatusLabel()
        crcFileT = New System.Windows.Forms.ToolStripStatusLabel()
        crcFile = New System.Windows.Forms.ToolStripStatusLabel()
        Datei = New System.Windows.Forms.Button()
        Verzeichnis = New System.Windows.Forms.Button()
        Rewind = New System.Windows.Forms.Button()
        BMback = New System.Windows.Forms.Button()
        BMvor = New System.Windows.Forms.Button()
        RecordBack = New System.Windows.Forms.Button()
        RecordVor = New System.Windows.Forms.Button()
        OpenCassette = New System.Windows.Forms.Button()
        OpenFileDialog1 = New System.Windows.Forms.OpenFileDialog()
        CreateCassette = New System.Windows.Forms.Button()
        SaveFileDialog1 = New System.Windows.Forms.SaveFileDialog()
        FilePos = New System.Windows.Forms.Label()
        DataGridViewTextBoxColumn1 = New System.Windows.Forms.DataGridViewTextBoxColumn()
        DataGridViewTextBoxColumn2 = New System.Windows.Forms.DataGridViewTextBoxColumn()
        DataGridViewTextBoxColumn3 = New System.Windows.Forms.DataGridViewTextBoxColumn()
        DataGridViewTextBoxColumn4 = New System.Windows.Forms.DataGridViewTextBoxColumn()
        DataGridViewTextBoxColumn5 = New System.Windows.Forms.DataGridViewTextBoxColumn()
        DataGridViewTextBoxColumn6 = New System.Windows.Forms.DataGridViewTextBoxColumn()
        DataGridViewTextBoxColumn7 = New System.Windows.Forms.DataGridViewTextBoxColumn()
        DataGridViewTextBoxColumn8 = New System.Windows.Forms.DataGridViewTextBoxColumn()
        DataGridViewTextBoxColumn9 = New System.Windows.Forms.DataGridViewTextBoxColumn()
        DataGridViewTextBoxColumn10 = New System.Windows.Forms.DataGridViewTextBoxColumn()
        DataGridViewTextBoxColumn11 = New System.Windows.Forms.DataGridViewTextBoxColumn()
        DataGridViewTextBoxColumn12 = New System.Windows.Forms.DataGridViewTextBoxColumn()
        DataGridViewTextBoxColumn14 = New System.Windows.Forms.DataGridViewTextBoxColumn()
        DataGridViewTextBoxColumn15 = New System.Windows.Forms.DataGridViewTextBoxColumn()
        DataGridViewTextBoxColumn16 = New System.Windows.Forms.DataGridViewTextBoxColumn()
        DataGridViewTextBoxColumn17 = New System.Windows.Forms.DataGridViewTextBoxColumn()
        DataGridViewTextBoxColumn18 = New System.Windows.Forms.DataGridViewTextBoxColumn()
        DataGridViewTextBoxColumn19 = New System.Windows.Forms.DataGridViewTextBoxColumn()
        ToolTip1 = New System.Windows.Forms.ToolTip(components)
        DataGridViewTextBoxColumn13 = New System.Windows.Forms.DataGridViewTextBoxColumn()
        sp0 = New System.Windows.Forms.DataGridViewTextBoxColumn()
        sp1 = New System.Windows.Forms.DataGridViewTextBoxColumn()
        sp2 = New System.Windows.Forms.DataGridViewTextBoxColumn()
        sp3 = New System.Windows.Forms.DataGridViewTextBoxColumn()
        sp4 = New System.Windows.Forms.DataGridViewTextBoxColumn()
        sp5 = New System.Windows.Forms.DataGridViewTextBoxColumn()
        sp6 = New System.Windows.Forms.DataGridViewTextBoxColumn()
        sp7 = New System.Windows.Forms.DataGridViewTextBoxColumn()
        sp8 = New System.Windows.Forms.DataGridViewTextBoxColumn()
        sp9 = New System.Windows.Forms.DataGridViewTextBoxColumn()
        spA = New System.Windows.Forms.DataGridViewTextBoxColumn()
        spB = New System.Windows.Forms.DataGridViewTextBoxColumn()
        spC = New System.Windows.Forms.DataGridViewTextBoxColumn()
        spD = New System.Windows.Forms.DataGridViewTextBoxColumn()
        spE = New System.Windows.Forms.DataGridViewTextBoxColumn()
        spF = New System.Windows.Forms.DataGridViewTextBoxColumn()
        spNULL = New System.Windows.Forms.DataGridViewTextBoxColumn()
        spChar = New System.Windows.Forms.DataGridViewTextBoxColumn()
        CType(RecordAnsicht, System.ComponentModel.ISupportInitialize).BeginInit()
        StatusStrip1.SuspendLayout()
        SuspendLayout()
        '
        'RecordAnsicht
        '
        RecordAnsicht.AllowUserToAddRows = False
        RecordAnsicht.AllowUserToDeleteRows = False
        RecordAnsicht.AllowUserToResizeColumns = False
        RecordAnsicht.AllowUserToResizeRows = False
        RecordAnsicht.BackgroundColor = System.Drawing.Color.FromArgb(CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer))
        RecordAnsicht.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize
        RecordAnsicht.Columns.AddRange(New System.Windows.Forms.DataGridViewColumn() {DataGridViewTextBoxColumn13, sp0, sp1, sp2, sp3, sp4, sp5, sp6, sp7, sp8, sp9, spA, spB, spC, spD, spE, spF, spNULL, spChar})
        DataGridViewCellStyle3.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft
        DataGridViewCellStyle3.BackColor = System.Drawing.Color.FromArgb(CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer))
        DataGridViewCellStyle3.Font = New System.Drawing.Font("Arial Rounded MT Bold", 9.75!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        DataGridViewCellStyle3.ForeColor = System.Drawing.Color.Gray
        DataGridViewCellStyle3.SelectionBackColor = System.Drawing.Color.FromArgb(CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer))
        DataGridViewCellStyle3.SelectionForeColor = System.Drawing.Color.Gray
        DataGridViewCellStyle3.WrapMode = System.Windows.Forms.DataGridViewTriState.[False]
        RecordAnsicht.DefaultCellStyle = DataGridViewCellStyle3
        RecordAnsicht.EditMode = System.Windows.Forms.DataGridViewEditMode.EditProgrammatically
        RecordAnsicht.Enabled = False
        RecordAnsicht.GridColor = System.Drawing.Color.FromArgb(CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer))
        RecordAnsicht.Location = New System.Drawing.Point(0, 0)
        RecordAnsicht.MultiSelect = False
        RecordAnsicht.Name = "RecordAnsicht"
        RecordAnsicht.RowHeadersVisible = False
        RecordAnsicht.RowHeadersWidthSizeMode = System.Windows.Forms.DataGridViewRowHeadersWidthSizeMode.DisableResizing
        RecordAnsicht.ScrollBars = System.Windows.Forms.ScrollBars.None
        RecordAnsicht.Size = New System.Drawing.Size(677, 180)
        RecordAnsicht.TabIndex = 65
        '
        'StatusStrip1
        '
        StatusStrip1.Items.AddRange(New System.Windows.Forms.ToolStripItem() {crcRecordT, crcRecord, BM, crcFileT, crcFile})
        StatusStrip1.Location = New System.Drawing.Point(0, 214)
        StatusStrip1.Name = "StatusStrip1"
        StatusStrip1.Size = New System.Drawing.Size(678, 22)
        StatusStrip1.TabIndex = 75
        StatusStrip1.Text = "StatusStrip1"
        '
        'crcRecordT
        '
        crcRecordT.AutoSize = False
        crcRecordT.BorderSides = CType(((System.Windows.Forms.ToolStripStatusLabelBorderSides.Left Or System.Windows.Forms.ToolStripStatusLabelBorderSides.Top) _
            Or System.Windows.Forms.ToolStripStatusLabelBorderSides.Bottom), System.Windows.Forms.ToolStripStatusLabelBorderSides)
        crcRecordT.Font = New System.Drawing.Font("Arial Rounded MT Bold", 9.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        crcRecordT.ForeColor = System.Drawing.SystemColors.ControlDarkDark
        crcRecordT.Name = "crcRecordT"
        crcRecordT.Size = New System.Drawing.Size(100, 17)
        crcRecordT.Text = "CRC record: "
        '
        'crcRecord
        '
        crcRecord.AutoSize = False
        crcRecord.BorderSides = CType(((System.Windows.Forms.ToolStripStatusLabelBorderSides.Top Or System.Windows.Forms.ToolStripStatusLabelBorderSides.Right) _
            Or System.Windows.Forms.ToolStripStatusLabelBorderSides.Bottom), System.Windows.Forms.ToolStripStatusLabelBorderSides)
        crcRecord.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Text
        crcRecord.Font = New System.Drawing.Font("Arial Rounded MT Bold", 9.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        crcRecord.Name = "crcRecord"
        crcRecord.Size = New System.Drawing.Size(100, 17)
        crcRecord.TextAlign = System.Drawing.ContentAlignment.MiddleLeft
        '
        'BM
        '
        BM.AutoSize = False
        BM.BackColor = System.Drawing.Color.FromArgb(CType(CType(255, Byte), Integer), CType(CType(255, Byte), Integer), CType(CType(192, Byte), Integer))
        BM.BorderSides = CType((((System.Windows.Forms.ToolStripStatusLabelBorderSides.Left Or System.Windows.Forms.ToolStripStatusLabelBorderSides.Top) _
            Or System.Windows.Forms.ToolStripStatusLabelBorderSides.Right) _
            Or System.Windows.Forms.ToolStripStatusLabelBorderSides.Bottom), System.Windows.Forms.ToolStripStatusLabelBorderSides)
        BM.Font = New System.Drawing.Font("Arial Rounded MT Bold", 9.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        BM.ForeColor = System.Drawing.SystemColors.ControlText
        BM.Name = "BM"
        BM.Size = New System.Drawing.Size(260, 17)
        BM.Text = "B  A  N  D  M  A  R  K  E"
        '
        'crcFileT
        '
        crcFileT.AutoSize = False
        crcFileT.BorderSides = CType(((System.Windows.Forms.ToolStripStatusLabelBorderSides.Left Or System.Windows.Forms.ToolStripStatusLabelBorderSides.Top) _
            Or System.Windows.Forms.ToolStripStatusLabelBorderSides.Bottom), System.Windows.Forms.ToolStripStatusLabelBorderSides)
        crcFileT.Font = New System.Drawing.Font("Arial Rounded MT Bold", 9.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        crcFileT.ForeColor = System.Drawing.SystemColors.ControlDarkDark
        crcFileT.Name = "crcFileT"
        crcFileT.Size = New System.Drawing.Size(100, 17)
        crcFileT.Text = "CRC File:"
        '
        'crcFile
        '
        crcFile.AutoSize = False
        crcFile.BorderSides = CType(((System.Windows.Forms.ToolStripStatusLabelBorderSides.Top Or System.Windows.Forms.ToolStripStatusLabelBorderSides.Right) _
            Or System.Windows.Forms.ToolStripStatusLabelBorderSides.Bottom), System.Windows.Forms.ToolStripStatusLabelBorderSides)
        crcFile.Font = New System.Drawing.Font("Arial Rounded MT Bold", 9.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        crcFile.Name = "crcFile"
        crcFile.Size = New System.Drawing.Size(100, 17)
        '
        'Datei
        '
        Datei.Location = New System.Drawing.Point(527, 186)
        Datei.Name = "Datei"
        Datei.Size = New System.Drawing.Size(40, 25)
        Datei.TabIndex = 83
        Datei.Text = "Datei"
        Datei.UseVisualStyleBackColor = True
        '
        'Verzeichnis
        '
        Verzeichnis.Location = New System.Drawing.Point(481, 186)
        Verzeichnis.Name = "Verzeichnis"
        Verzeichnis.Size = New System.Drawing.Size(40, 25)
        Verzeichnis.TabIndex = 82
        Verzeichnis.Text = "Dir"
        Verzeichnis.UseVisualStyleBackColor = True
        '
        'Rewind
        '
        Rewind.Location = New System.Drawing.Point(343, 186)
        Rewind.Name = "Rewind"
        Rewind.Size = New System.Drawing.Size(40, 25)
        Rewind.TabIndex = 81
        Rewind.Text = "|<=="
        Rewind.UseVisualStyleBackColor = True
        '
        'BMback
        '
        BMback.Location = New System.Drawing.Point(389, 186)
        BMback.Name = "BMback"
        BMback.Size = New System.Drawing.Size(40, 25)
        BMback.TabIndex = 80
        BMback.Text = "<=="
        BMback.UseVisualStyleBackColor = True
        '
        'BMvor
        '
        BMvor.Location = New System.Drawing.Point(619, 186)
        BMvor.Name = "BMvor"
        BMvor.Size = New System.Drawing.Size(40, 25)
        BMvor.TabIndex = 79
        BMvor.Text = "==>"
        BMvor.UseVisualStyleBackColor = True
        '
        'RecordBack
        '
        RecordBack.Location = New System.Drawing.Point(435, 186)
        RecordBack.Name = "RecordBack"
        RecordBack.Size = New System.Drawing.Size(40, 25)
        RecordBack.TabIndex = 78
        RecordBack.Text = "<---"
        RecordBack.UseVisualStyleBackColor = True
        '
        'RecordVor
        '
        RecordVor.Location = New System.Drawing.Point(573, 186)
        RecordVor.Name = "RecordVor"
        RecordVor.Size = New System.Drawing.Size(40, 25)
        RecordVor.TabIndex = 77
        RecordVor.Text = "--->"
        RecordVor.UseVisualStyleBackColor = True
        '
        'OpenCassette
        '
        OpenCassette.Location = New System.Drawing.Point(84, 186)
        OpenCassette.Name = "OpenCassette"
        OpenCassette.Size = New System.Drawing.Size(73, 25)
        OpenCassette.TabIndex = 76
        OpenCassette.Text = "Open"
        OpenCassette.UseVisualStyleBackColor = True
        '
        'OpenFileDialog1
        '
        OpenFileDialog1.FileName = "OpenFileDialog1"
        '
        'CreateCassette
        '
        CreateCassette.Location = New System.Drawing.Point(5, 186)
        CreateCassette.Name = "CreateCassette"
        CreateCassette.Size = New System.Drawing.Size(73, 25)
        CreateCassette.TabIndex = 84
        CreateCassette.Text = "Create"
        CreateCassette.UseVisualStyleBackColor = True
        '
        'FilePos
        '
        FilePos.AutoSize = True
        FilePos.Font = New System.Drawing.Font("Arial", 7.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        FilePos.Location = New System.Drawing.Point(160, 189)
        FilePos.MaximumSize = New System.Drawing.Size(170, 0)
        FilePos.MinimumSize = New System.Drawing.Size(180, 19)
        FilePos.Name = "FilePos"
        FilePos.Size = New System.Drawing.Size(180, 19)
        FilePos.TabIndex = 85
        FilePos.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
        '
        'DataGridViewTextBoxColumn1
        '
        DataGridViewCellStyle4.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft
        DataGridViewCellStyle4.BackColor = System.Drawing.Color.FromArgb(CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer))
        DataGridViewCellStyle4.Font = New System.Drawing.Font("Courier New", 9.75!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        DataGridViewCellStyle4.ForeColor = System.Drawing.Color.Gray
        DataGridViewCellStyle4.SelectionBackColor = System.Drawing.Color.FromArgb(CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer))
        DataGridViewCellStyle4.SelectionForeColor = System.Drawing.Color.Gray
        DataGridViewTextBoxColumn1.DefaultCellStyle = DataGridViewCellStyle4
        DataGridViewTextBoxColumn1.HeaderText = ""
        DataGridViewTextBoxColumn1.Name = "DataGridViewTextBoxColumn1"
        DataGridViewTextBoxColumn1.Width = 45
        '
        'DataGridViewTextBoxColumn2
        '
        DataGridViewTextBoxColumn2.HeaderText = "0"
        DataGridViewTextBoxColumn2.Name = "DataGridViewTextBoxColumn2"
        DataGridViewTextBoxColumn2.Width = 30
        '
        'DataGridViewTextBoxColumn3
        '
        DataGridViewTextBoxColumn3.HeaderText = "1"
        DataGridViewTextBoxColumn3.Name = "DataGridViewTextBoxColumn3"
        DataGridViewTextBoxColumn3.Width = 30
        '
        'DataGridViewTextBoxColumn4
        '
        DataGridViewTextBoxColumn4.HeaderText = "2"
        DataGridViewTextBoxColumn4.Name = "DataGridViewTextBoxColumn4"
        DataGridViewTextBoxColumn4.Width = 30
        '
        'DataGridViewTextBoxColumn5
        '
        DataGridViewTextBoxColumn5.HeaderText = "3"
        DataGridViewTextBoxColumn5.Name = "DataGridViewTextBoxColumn5"
        DataGridViewTextBoxColumn5.Width = 30
        '
        'DataGridViewTextBoxColumn6
        '
        DataGridViewTextBoxColumn6.HeaderText = "4"
        DataGridViewTextBoxColumn6.Name = "DataGridViewTextBoxColumn6"
        DataGridViewTextBoxColumn6.Width = 30
        '
        'DataGridViewTextBoxColumn7
        '
        DataGridViewTextBoxColumn7.HeaderText = "5"
        DataGridViewTextBoxColumn7.Name = "DataGridViewTextBoxColumn7"
        DataGridViewTextBoxColumn7.Width = 30
        '
        'DataGridViewTextBoxColumn8
        '
        DataGridViewTextBoxColumn8.HeaderText = "6"
        DataGridViewTextBoxColumn8.Name = "DataGridViewTextBoxColumn8"
        DataGridViewTextBoxColumn8.Width = 30
        '
        'DataGridViewTextBoxColumn9
        '
        DataGridViewTextBoxColumn9.HeaderText = "7"
        DataGridViewTextBoxColumn9.Name = "DataGridViewTextBoxColumn9"
        DataGridViewTextBoxColumn9.Width = 30
        '
        'DataGridViewTextBoxColumn10
        '
        DataGridViewTextBoxColumn10.HeaderText = "8"
        DataGridViewTextBoxColumn10.Name = "DataGridViewTextBoxColumn10"
        DataGridViewTextBoxColumn10.Width = 30
        '
        'DataGridViewTextBoxColumn11
        '
        DataGridViewTextBoxColumn11.HeaderText = "9"
        DataGridViewTextBoxColumn11.Name = "DataGridViewTextBoxColumn11"
        DataGridViewTextBoxColumn11.Width = 30
        '
        'DataGridViewTextBoxColumn12
        '
        DataGridViewTextBoxColumn12.HeaderText = "A"
        DataGridViewTextBoxColumn12.Name = "DataGridViewTextBoxColumn12"
        DataGridViewTextBoxColumn12.Width = 30
        '
        'DataGridViewTextBoxColumn14
        '
        DataGridViewTextBoxColumn14.HeaderText = "C"
        DataGridViewTextBoxColumn14.Name = "DataGridViewTextBoxColumn14"
        DataGridViewTextBoxColumn14.Width = 30
        '
        'DataGridViewTextBoxColumn15
        '
        DataGridViewTextBoxColumn15.HeaderText = "D"
        DataGridViewTextBoxColumn15.Name = "DataGridViewTextBoxColumn15"
        DataGridViewTextBoxColumn15.Width = 30
        '
        'DataGridViewTextBoxColumn16
        '
        DataGridViewTextBoxColumn16.HeaderText = "E"
        DataGridViewTextBoxColumn16.Name = "DataGridViewTextBoxColumn16"
        DataGridViewTextBoxColumn16.Width = 30
        '
        'DataGridViewTextBoxColumn17
        '
        DataGridViewTextBoxColumn17.HeaderText = "F"
        DataGridViewTextBoxColumn17.Name = "DataGridViewTextBoxColumn17"
        DataGridViewTextBoxColumn17.Width = 30
        '
        'DataGridViewTextBoxColumn18
        '
        DataGridViewTextBoxColumn18.HeaderText = ""
        DataGridViewTextBoxColumn18.Name = "DataGridViewTextBoxColumn18"
        DataGridViewTextBoxColumn18.Width = 15
        '
        'DataGridViewTextBoxColumn19
        '
        DataGridViewCellStyle5.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft
        DataGridViewCellStyle5.BackColor = System.Drawing.Color.FromArgb(CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer))
        DataGridViewCellStyle5.Font = New System.Drawing.Font("Courier New", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        DataGridViewCellStyle5.ForeColor = System.Drawing.Color.Gray
        DataGridViewCellStyle5.SelectionBackColor = System.Drawing.Color.FromArgb(CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer))
        DataGridViewCellStyle5.SelectionForeColor = System.Drawing.Color.Gray
        DataGridViewTextBoxColumn19.DefaultCellStyle = DataGridViewCellStyle5
        DataGridViewTextBoxColumn19.HeaderText = "Char"
        DataGridViewTextBoxColumn19.Name = "DataGridViewTextBoxColumn19"
        DataGridViewTextBoxColumn19.Width = 135
        '
        'DataGridViewTextBoxColumn13
        '
        DataGridViewCellStyle1.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft
        DataGridViewCellStyle1.BackColor = System.Drawing.Color.FromArgb(CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer))
        DataGridViewCellStyle1.Font = New System.Drawing.Font("Courier New", 9.75!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        DataGridViewCellStyle1.ForeColor = System.Drawing.Color.Gray
        DataGridViewCellStyle1.SelectionBackColor = System.Drawing.Color.FromArgb(CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer))
        DataGridViewCellStyle1.SelectionForeColor = System.Drawing.Color.Gray
        DataGridViewTextBoxColumn13.DefaultCellStyle = DataGridViewCellStyle1
        DataGridViewTextBoxColumn13.FillWeight = 30.0!
        DataGridViewTextBoxColumn13.HeaderText = ""
        DataGridViewTextBoxColumn13.Name = "DataGridViewTextBoxColumn13"
        DataGridViewTextBoxColumn13.Width = 30
        '
        'sp0
        '
        sp0.HeaderText = "0"
        sp0.Name = "sp0"
        sp0.Width = 30
        '
        'sp1
        '
        sp1.HeaderText = "1"
        sp1.Name = "sp1"
        sp1.Width = 30
        '
        'sp2
        '
        sp2.HeaderText = "2"
        sp2.Name = "sp2"
        sp2.Width = 30
        '
        'sp3
        '
        sp3.HeaderText = "3"
        sp3.Name = "sp3"
        sp3.Width = 30
        '
        'sp4
        '
        sp4.HeaderText = "4"
        sp4.Name = "sp4"
        sp4.Width = 30
        '
        'sp5
        '
        sp5.HeaderText = "5"
        sp5.Name = "sp5"
        sp5.Width = 30
        '
        'sp6
        '
        sp6.HeaderText = "6"
        sp6.Name = "sp6"
        sp6.Width = 30
        '
        'sp7
        '
        sp7.HeaderText = "7"
        sp7.Name = "sp7"
        sp7.Width = 30
        '
        'sp8
        '
        sp8.HeaderText = "8"
        sp8.Name = "sp8"
        sp8.Width = 30
        '
        'sp9
        '
        sp9.HeaderText = "9"
        sp9.Name = "sp9"
        sp9.Width = 30
        '
        'spA
        '
        spA.HeaderText = "A"
        spA.Name = "spA"
        spA.Width = 30
        '
        'spB
        '
        spB.HeaderText = "B"
        spB.Name = "spB"
        spB.Width = 30
        '
        'spC
        '
        spC.HeaderText = "C"
        spC.Name = "spC"
        spC.Width = 30
        '
        'spD
        '
        spD.HeaderText = "D"
        spD.Name = "spD"
        spD.Width = 30
        '
        'spE
        '
        spE.HeaderText = "E"
        spE.Name = "spE"
        spE.Width = 30
        '
        'spF
        '
        spF.HeaderText = "F"
        spF.Name = "spF"
        spF.Width = 30
        '
        'spNULL
        '
        spNULL.HeaderText = ""
        spNULL.Name = "spNULL"
        spNULL.Width = 15
        '
        'spChar
        '
        DataGridViewCellStyle2.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft
        DataGridViewCellStyle2.BackColor = System.Drawing.Color.FromArgb(CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer))
        DataGridViewCellStyle2.Font = New System.Drawing.Font("Courier New", 10.0!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        DataGridViewCellStyle2.ForeColor = System.Drawing.Color.Gray
        DataGridViewCellStyle2.SelectionBackColor = System.Drawing.Color.FromArgb(CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer))
        DataGridViewCellStyle2.SelectionForeColor = System.Drawing.Color.Gray
        spChar.DefaultCellStyle = DataGridViewCellStyle2
        spChar.FillWeight = 150.0!
        spChar.HeaderText = "Char"
        spChar.Name = "spChar"
        spChar.Width = 150
        '
        'ucKassette
        '
        AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Controls.Add(FilePos)
        Controls.Add(CreateCassette)
        Controls.Add(Datei)
        Controls.Add(Verzeichnis)
        Controls.Add(Rewind)
        Controls.Add(BMback)
        Controls.Add(BMvor)
        Controls.Add(RecordBack)
        Controls.Add(RecordVor)
        Controls.Add(OpenCassette)
        Controls.Add(StatusStrip1)
        Controls.Add(RecordAnsicht)
        Name = "ucKassette"
        Size = New System.Drawing.Size(678, 236)
        CType(RecordAnsicht, System.ComponentModel.ISupportInitialize).EndInit()
        StatusStrip1.ResumeLayout(False)
        StatusStrip1.PerformLayout()
        ResumeLayout(False)
        PerformLayout()

    End Sub

    Friend WithEvents RecordAnsicht As DataGridView
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
    Friend WithEvents ToolTip1 As ToolTip
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
End Class
