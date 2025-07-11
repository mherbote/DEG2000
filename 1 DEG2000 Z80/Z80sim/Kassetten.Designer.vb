<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class Kassetten
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
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(Kassetten))
        TabControl1 = New System.Windows.Forms.TabControl()
        AKB1 = New System.Windows.Forms.TabPage()
        LabelK2 = New System.Windows.Forms.Label()
        LabelK1 = New System.Windows.Forms.Label()
        AKB2 = New System.Windows.Forms.TabPage()
        Label3 = New System.Windows.Forms.Label()
        Label2 = New System.Windows.Forms.Label()
        AKB3 = New System.Windows.Forms.TabPage()
        Label5 = New System.Windows.Forms.Label()
        Label4 = New System.Windows.Forms.Label()
        ucK2 = New DEG2000.ucKassette()
        ucK1 = New DEG2000.ucKassette()
        ucK4 = New DEG2000.ucKassette()
        ucK3 = New DEG2000.ucKassette()
        ucK6 = New DEG2000.ucKassette()
        ucK5 = New DEG2000.ucKassette()
        TabControl1.SuspendLayout()
        AKB1.SuspendLayout()
        AKB2.SuspendLayout()
        AKB3.SuspendLayout()
        SuspendLayout()
        '
        'TabControl1
        '
        TabControl1.Controls.Add(AKB1)
        TabControl1.Controls.Add(AKB2)
        TabControl1.Controls.Add(AKB3)
        TabControl1.Location = New System.Drawing.Point(0, 0)
        TabControl1.Name = "TabControl1"
        TabControl1.SelectedIndex = 0
        TabControl1.Size = New System.Drawing.Size(687, 582)
        TabControl1.TabIndex = 0
        '
        'AKB1
        '
        AKB1.Controls.Add(LabelK2)
        AKB1.Controls.Add(LabelK1)
        AKB1.Controls.Add(ucK2)
        AKB1.Controls.Add(ucK1)
        AKB1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        AKB1.Location = New System.Drawing.Point(4, 22)
        AKB1.Name = "AKB1"
        AKB1.Padding = New System.Windows.Forms.Padding(3)
        AKB1.Size = New System.Drawing.Size(679, 556)
        AKB1.TabIndex = 0
        AKB1.Text = "Kassette 1,2 AKB=30H"
        AKB1.UseVisualStyleBackColor = True
        '
        'LabelK2
        '
        LabelK2.BackColor = System.Drawing.Color.LightBlue
        LabelK2.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        LabelK2.Font = New System.Drawing.Font("Arial Rounded MT Bold", 12.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        LabelK2.Location = New System.Drawing.Point(0, 300)
        LabelK2.Name = "LabelK2"
        LabelK2.Size = New System.Drawing.Size(677, 23)
        LabelK2.TabIndex = 3
        LabelK2.Text = "Kassette 2 - C for SYS 4"
        LabelK2.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
        '
        'LabelK1
        '
        LabelK1.BackColor = System.Drawing.Color.LightBlue
        LabelK1.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        LabelK1.Font = New System.Drawing.Font("Arial Rounded MT Bold", 12.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        LabelK1.Location = New System.Drawing.Point(0, 2)
        LabelK1.Name = "LabelK1"
        LabelK1.Size = New System.Drawing.Size(677, 23)
        LabelK1.TabIndex = 2
        LabelK1.Text = "Kassette 1 - B for SYS 4"
        LabelK1.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
        '
        'AKB2
        '
        AKB2.Controls.Add(Label3)
        AKB2.Controls.Add(Label2)
        AKB2.Controls.Add(ucK4)
        AKB2.Controls.Add(ucK3)
        AKB2.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        AKB2.Location = New System.Drawing.Point(4, 22)
        AKB2.Name = "AKB2"
        AKB2.Padding = New System.Windows.Forms.Padding(3)
        AKB2.Size = New System.Drawing.Size(679, 556)
        AKB2.TabIndex = 1
        AKB2.Text = "Kassette 3,4 AKB=38H"
        AKB2.UseVisualStyleBackColor = True
        '
        'Label3
        '
        Label3.BackColor = System.Drawing.Color.LightBlue
        Label3.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Label3.Font = New System.Drawing.Font("Arial Rounded MT Bold", 12.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Label3.Location = New System.Drawing.Point(0, 300)
        Label3.Name = "Label3"
        Label3.Size = New System.Drawing.Size(677, 23)
        Label3.TabIndex = 5
        Label3.Text = "Kassette 4 - E for SYS 4"
        Label3.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
        '
        'Label2
        '
        Label2.BackColor = System.Drawing.Color.LightBlue
        Label2.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Label2.Font = New System.Drawing.Font("Arial Rounded MT Bold", 12.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Label2.Location = New System.Drawing.Point(0, 2)
        Label2.Name = "Label2"
        Label2.Size = New System.Drawing.Size(677, 23)
        Label2.TabIndex = 4
        Label2.Text = "Kassette 3 - D for SYS 4"
        Label2.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
        '
        'AKB3
        '
        AKB3.Controls.Add(Label5)
        AKB3.Controls.Add(Label4)
        AKB3.Controls.Add(ucK6)
        AKB3.Controls.Add(ucK5)
        AKB3.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        AKB3.Location = New System.Drawing.Point(4, 22)
        AKB3.Name = "AKB3"
        AKB3.Size = New System.Drawing.Size(679, 556)
        AKB3.TabIndex = 2
        AKB3.Text = "Kassette 5,6 AKB=58H"
        AKB3.UseVisualStyleBackColor = True
        '
        'Label5
        '
        Label5.BackColor = System.Drawing.Color.LightBlue
        Label5.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Label5.Font = New System.Drawing.Font("Arial Rounded MT Bold", 12.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Label5.Location = New System.Drawing.Point(0, 300)
        Label5.Name = "Label5"
        Label5.Size = New System.Drawing.Size(677, 23)
        Label5.TabIndex = 5
        Label5.Text = "Kassette 6 - G for SYS 4"
        Label5.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
        '
        'Label4
        '
        Label4.BackColor = System.Drawing.Color.LightBlue
        Label4.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Label4.Font = New System.Drawing.Font("Arial Rounded MT Bold", 12.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Label4.Location = New System.Drawing.Point(0, 2)
        Label4.Name = "Label4"
        Label4.Size = New System.Drawing.Size(677, 23)
        Label4.TabIndex = 4
        Label4.Text = "Kassette 5 - F for SYS 4"
        Label4.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
        '
        'ucK2
        '
        ucK2.Location = New System.Drawing.Point(0, 323)
        ucK2.Name = "ucK2"
        ucK2.Size = New System.Drawing.Size(678, 236)
        ucK2.TabIndex = 1
        '
        'ucK1
        '
        ucK1.Location = New System.Drawing.Point(0, 25)
        ucK1.Name = "ucK1"
        ucK1.Size = New System.Drawing.Size(678, 236)
        ucK1.TabIndex = 0
        '
        'ucK4
        '
        ucK4.Location = New System.Drawing.Point(0, 323)
        ucK4.Name = "ucK4"
        ucK4.Size = New System.Drawing.Size(678, 236)
        ucK4.TabIndex = 1
        '
        'ucK3
        '
        ucK3.Location = New System.Drawing.Point(0, 25)
        ucK3.Name = "ucK3"
        ucK3.Size = New System.Drawing.Size(678, 236)
        ucK3.TabIndex = 0
        '
        'ucK6
        '
        ucK6.Location = New System.Drawing.Point(0, 323)
        ucK6.Name = "ucK6"
        ucK6.Size = New System.Drawing.Size(678, 236)
        ucK6.TabIndex = 1
        '
        'ucK5
        '
        ucK5.Location = New System.Drawing.Point(0, 25)
        ucK5.Name = "ucK5"
        ucK5.Size = New System.Drawing.Size(678, 236)
        ucK5.TabIndex = 0
        '
        'Kassetten
        '
        AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        ClientSize = New System.Drawing.Size(686, 582)
        ControlBox = False
        Controls.Add(TabControl1)
        Icon = CType(resources.GetObject("$this.Icon"), System.Drawing.Icon)
        Name = "Kassetten"
        ShowInTaskbar = False
        StartPosition = System.Windows.Forms.FormStartPosition.Manual
        Text = "Kassetten anzeigen"
        TabControl1.ResumeLayout(False)
        AKB1.ResumeLayout(False)
        AKB2.ResumeLayout(False)
        AKB3.ResumeLayout(False)
        ResumeLayout(False)

    End Sub

    Friend WithEvents TabControl1 As TabControl
    Friend WithEvents AKB1 As TabPage
    Friend WithEvents AKB2 As TabPage
    Friend WithEvents AKB3 As TabPage
    Friend WithEvents ucK1 As ucKassette
    Friend WithEvents ucK2 As ucKassette
    Friend WithEvents ucK4 As ucKassette
    Friend WithEvents ucK3 As ucKassette
    Friend WithEvents ucK6 As ucKassette
    Friend WithEvents ucK5 As ucKassette
    Friend WithEvents LabelK1 As Label
    Friend WithEvents LabelK2 As Label
    Friend WithEvents Label3 As Label
    Friend WithEvents Label2 As Label
    Friend WithEvents Label5 As Label
    Friend WithEvents Label4 As Label
End Class
