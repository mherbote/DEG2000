<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class AnzeigeHS
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
        Dim DataGridViewCellStyle1 As System.Windows.Forms.DataGridViewCellStyle = New System.Windows.Forms.DataGridViewCellStyle()
        Dim DataGridViewCellStyle4 As System.Windows.Forms.DataGridViewCellStyle = New System.Windows.Forms.DataGridViewCellStyle()
        Dim DataGridViewCellStyle2 As System.Windows.Forms.DataGridViewCellStyle = New System.Windows.Forms.DataGridViewCellStyle()
        Dim DataGridViewCellStyle3 As System.Windows.Forms.DataGridViewCellStyle = New System.Windows.Forms.DataGridViewCellStyle()
        Dim DataGridViewCellStyle5 As System.Windows.Forms.DataGridViewCellStyle = New System.Windows.Forms.DataGridViewCellStyle()
        Dim DataGridViewCellStyle6 As System.Windows.Forms.DataGridViewCellStyle = New System.Windows.Forms.DataGridViewCellStyle()
        Dim DataGridViewCellStyle7 As System.Windows.Forms.DataGridViewCellStyle = New System.Windows.Forms.DataGridViewCellStyle()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(AnzeigeHS))
        HSanzeige = New System.Windows.Forms.DataGridView()
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
        BereichsWahl = New System.Windows.Forms.DataGridView()
        Bereich = New System.Windows.Forms.DataGridViewButtonColumn()
        BereichAll = New System.Windows.Forms.DataGridView()
        Column1 = New System.Windows.Forms.DataGridViewButtonColumn()
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
        Button1 = New System.Windows.Forms.Button()
        Button2 = New System.Windows.Forms.Button()
        CType(HSanzeige, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(BereichsWahl, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(BereichAll, System.ComponentModel.ISupportInitialize).BeginInit()
        SuspendLayout()
        '
        'HSanzeige
        '
        HSanzeige.AllowUserToAddRows = False
        HSanzeige.AllowUserToDeleteRows = False
        HSanzeige.AllowUserToResizeColumns = False
        HSanzeige.AllowUserToResizeRows = False
        HSanzeige.BackgroundColor = System.Drawing.Color.FromArgb(CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer))
        DataGridViewCellStyle1.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleRight
        DataGridViewCellStyle1.BackColor = System.Drawing.SystemColors.Control
        DataGridViewCellStyle1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        DataGridViewCellStyle1.ForeColor = System.Drawing.SystemColors.WindowText
        DataGridViewCellStyle1.SelectionBackColor = System.Drawing.SystemColors.Highlight
        DataGridViewCellStyle1.SelectionForeColor = System.Drawing.SystemColors.HighlightText
        DataGridViewCellStyle1.WrapMode = System.Windows.Forms.DataGridViewTriState.[True]
        HSanzeige.ColumnHeadersDefaultCellStyle = DataGridViewCellStyle1
        HSanzeige.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize
        HSanzeige.Columns.AddRange(New System.Windows.Forms.DataGridViewColumn() {DataGridViewTextBoxColumn13, sp0, sp1, sp2, sp3, sp4, sp5, sp6, sp7, sp8, sp9, spA, spB, spC, spD, spE, spF, spNULL, spChar})
        DataGridViewCellStyle4.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft
        DataGridViewCellStyle4.BackColor = System.Drawing.Color.FromArgb(CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer))
        DataGridViewCellStyle4.Font = New System.Drawing.Font("Arial Rounded MT Bold", 9.75!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        DataGridViewCellStyle4.ForeColor = System.Drawing.Color.Gray
        DataGridViewCellStyle4.SelectionBackColor = System.Drawing.Color.FromArgb(CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer))
        DataGridViewCellStyle4.SelectionForeColor = System.Drawing.Color.Gray
        DataGridViewCellStyle4.WrapMode = System.Windows.Forms.DataGridViewTriState.[False]
        HSanzeige.DefaultCellStyle = DataGridViewCellStyle4
        HSanzeige.EditMode = System.Windows.Forms.DataGridViewEditMode.EditProgrammatically
        HSanzeige.Enabled = False
        HSanzeige.GridColor = System.Drawing.Color.FromArgb(CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer))
        HSanzeige.Location = New System.Drawing.Point(0, 0)
        HSanzeige.MultiSelect = False
        HSanzeige.Name = "HSanzeige"
        HSanzeige.RowHeadersVisible = False
        HSanzeige.ScrollBars = System.Windows.Forms.ScrollBars.None
        HSanzeige.Size = New System.Drawing.Size(777, 340)
        HSanzeige.TabIndex = 63
        '
        'DataGridViewTextBoxColumn13
        '
        DataGridViewCellStyle2.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft
        DataGridViewCellStyle2.BackColor = System.Drawing.Color.FromArgb(CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer))
        DataGridViewCellStyle2.Font = New System.Drawing.Font("Courier New", 9.75!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        DataGridViewCellStyle2.ForeColor = System.Drawing.Color.Gray
        DataGridViewCellStyle2.SelectionBackColor = System.Drawing.Color.FromArgb(CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer))
        DataGridViewCellStyle2.SelectionForeColor = System.Drawing.Color.Gray
        DataGridViewTextBoxColumn13.DefaultCellStyle = DataGridViewCellStyle2
        DataGridViewTextBoxColumn13.HeaderText = ""
        DataGridViewTextBoxColumn13.Name = "DataGridViewTextBoxColumn13"
        DataGridViewTextBoxColumn13.SortMode = System.Windows.Forms.DataGridViewColumnSortMode.NotSortable
        DataGridViewTextBoxColumn13.Width = 45
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
        DataGridViewCellStyle3.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft
        DataGridViewCellStyle3.BackColor = System.Drawing.Color.FromArgb(CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer))
        DataGridViewCellStyle3.Font = New System.Drawing.Font("Courier New", 6.0!)
        DataGridViewCellStyle3.ForeColor = System.Drawing.Color.Gray
        DataGridViewCellStyle3.SelectionBackColor = System.Drawing.Color.FromArgb(CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer))
        DataGridViewCellStyle3.SelectionForeColor = System.Drawing.Color.Gray
        spChar.DefaultCellStyle = DataGridViewCellStyle3
        spChar.HeaderText = "Char"
        spChar.MinimumWidth = 185
        spChar.Name = "spChar"
        spChar.Width = 185
        '
        'BereichsWahl
        '
        BereichsWahl.AllowUserToAddRows = False
        BereichsWahl.AllowUserToDeleteRows = False
        BereichsWahl.AllowUserToResizeColumns = False
        BereichsWahl.AllowUserToResizeRows = False
        BereichsWahl.BackgroundColor = System.Drawing.Color.FromArgb(CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer))
        BereichsWahl.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize
        BereichsWahl.Columns.AddRange(New System.Windows.Forms.DataGridViewColumn() {Bereich})
        BereichsWahl.EditMode = System.Windows.Forms.DataGridViewEditMode.EditProgrammatically
        BereichsWahl.ImeMode = System.Windows.Forms.ImeMode.NoControl
        BereichsWahl.Location = New System.Drawing.Point(783, 0)
        BereichsWahl.MultiSelect = False
        BereichsWahl.Name = "BereichsWahl"
        BereichsWahl.RowHeadersVisible = False
        BereichsWahl.ScrollBars = System.Windows.Forms.ScrollBars.None
        BereichsWahl.Size = New System.Drawing.Size(122, 340)
        BereichsWahl.TabIndex = 64
        '
        'Bereich
        '
        Bereich.FillWeight = 60.0!
        Bereich.HeaderText = "HS-Sektor"
        Bereich.Name = "Bereich"
        Bereich.Resizable = System.Windows.Forms.DataGridViewTriState.[False]
        Bereich.Width = 60
        '
        'BereichAll
        '
        BereichAll.AllowUserToAddRows = False
        BereichAll.AllowUserToDeleteRows = False
        BereichAll.AllowUserToResizeColumns = False
        BereichAll.AllowUserToResizeRows = False
        BereichAll.BackgroundColor = System.Drawing.Color.FromArgb(CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer))
        BereichAll.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize
        BereichAll.Columns.AddRange(New System.Windows.Forms.DataGridViewColumn() {Column1})
        BereichAll.EditMode = System.Windows.Forms.DataGridViewEditMode.EditProgrammatically
        BereichAll.Location = New System.Drawing.Point(911, 78)
        BereichAll.MultiSelect = False
        BereichAll.Name = "BereichAll"
        BereichAll.RowHeadersVisible = False
        BereichAll.Size = New System.Drawing.Size(91, 200)
        BereichAll.TabIndex = 69
        '
        'Column1
        '
        DataGridViewCellStyle5.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleCenter
        DataGridViewCellStyle5.WrapMode = System.Windows.Forms.DataGridViewTriState.[True]
        Column1.DefaultCellStyle = DataGridViewCellStyle5
        Column1.FillWeight = 73.0!
        Column1.HeaderText = "HS-Sektoren"
        Column1.Name = "Column1"
        Column1.Resizable = System.Windows.Forms.DataGridViewTriState.[True]
        Column1.SortMode = System.Windows.Forms.DataGridViewColumnSortMode.Automatic
        Column1.Width = 88
        '
        'DataGridViewTextBoxColumn1
        '
        DataGridViewCellStyle6.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft
        DataGridViewCellStyle6.BackColor = System.Drawing.Color.FromArgb(CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer))
        DataGridViewCellStyle6.Font = New System.Drawing.Font("Courier New", 9.75!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        DataGridViewCellStyle6.ForeColor = System.Drawing.Color.Gray
        DataGridViewCellStyle6.SelectionBackColor = System.Drawing.Color.FromArgb(CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer))
        DataGridViewCellStyle6.SelectionForeColor = System.Drawing.Color.Gray
        DataGridViewTextBoxColumn1.DefaultCellStyle = DataGridViewCellStyle6
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
        DataGridViewCellStyle7.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft
        DataGridViewCellStyle7.BackColor = System.Drawing.Color.FromArgb(CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer))
        DataGridViewCellStyle7.Font = New System.Drawing.Font("Courier New", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        DataGridViewCellStyle7.ForeColor = System.Drawing.Color.Gray
        DataGridViewCellStyle7.SelectionBackColor = System.Drawing.Color.FromArgb(CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer), CType(CType(224, Byte), Integer))
        DataGridViewCellStyle7.SelectionForeColor = System.Drawing.Color.Gray
        DataGridViewTextBoxColumn19.DefaultCellStyle = DataGridViewCellStyle7
        DataGridViewTextBoxColumn19.HeaderText = "Char"
        DataGridViewTextBoxColumn19.Name = "DataGridViewTextBoxColumn19"
        DataGridViewTextBoxColumn19.Width = 135
        '
        'Button1
        '
        Button1.BackColor = System.Drawing.Color.FromArgb(CType(CType(192, Byte), Integer), CType(CType(255, Byte), Integer), CType(CType(192, Byte), Integer))
        Button1.FlatAppearance.BorderSize = 2
        Button1.FlatAppearance.MouseDownBackColor = System.Drawing.Color.Red
        Button1.FlatAppearance.MouseOverBackColor = System.Drawing.Color.Violet
        Button1.FlatStyle = System.Windows.Forms.FlatStyle.Flat
        Button1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Button1.Location = New System.Drawing.Point(911, 12)
        Button1.Name = "Button1"
        Button1.Size = New System.Drawing.Size(90, 23)
        Button1.TabIndex = 70
        Button1.Text = "als Global"
        Button1.UseVisualStyleBackColor = False
        '
        'Button2
        '
        Button2.BackColor = System.Drawing.Color.FromArgb(CType(CType(255, Byte), Integer), CType(CType(128, Byte), Integer), CType(CType(128, Byte), Integer))
        Button2.FlatAppearance.BorderSize = 2
        Button2.FlatAppearance.MouseDownBackColor = System.Drawing.Color.Maroon
        Button2.FlatStyle = System.Windows.Forms.FlatStyle.Flat
        Button2.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Button2.Location = New System.Drawing.Point(911, 317)
        Button2.Name = "Button2"
        Button2.Size = New System.Drawing.Size(90, 23)
        Button2.TabIndex = 71
        Button2.Text = "0100 H"
        Button2.UseVisualStyleBackColor = False
        '
        'AnzeigeHS
        '
        AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        ClientSize = New System.Drawing.Size(1004, 340)
        ControlBox = False
        Controls.Add(Button2)
        Controls.Add(Button1)
        Controls.Add(BereichAll)
        Controls.Add(BereichsWahl)
        Controls.Add(HSanzeige)
        FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedToolWindow
        Icon = CType(resources.GetObject("$this.Icon"), System.Drawing.Icon)
        Name = "AnzeigeHS"
        Text = "Speicher anzeigen"
        CType(HSanzeige, System.ComponentModel.ISupportInitialize).EndInit()
        CType(BereichsWahl, System.ComponentModel.ISupportInitialize).EndInit()
        CType(BereichAll, System.ComponentModel.ISupportInitialize).EndInit()
        ResumeLayout(False)

    End Sub
    Friend WithEvents HSanzeige As System.Windows.Forms.DataGridView
    Friend WithEvents BereichsWahl As DataGridView
    Friend WithEvents BereichAll As DataGridView
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
    Friend WithEvents Bereich As DataGridViewButtonColumn
    Friend WithEvents Button1 As Button
    Friend WithEvents Button2 As Button
    Friend WithEvents Column1 As DataGridViewButtonColumn
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
