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
        Me.TabControl1 = New System.Windows.Forms.TabControl()
        Me.AKB1 = New System.Windows.Forms.TabPage()
        Me.LabelK2 = New System.Windows.Forms.Label()
        Me.LabelK1 = New System.Windows.Forms.Label()
        Me.AKB2 = New System.Windows.Forms.TabPage()
        Me.Label3 = New System.Windows.Forms.Label()
        Me.Label2 = New System.Windows.Forms.Label()
        Me.AKB3 = New System.Windows.Forms.TabPage()
        Me.Label5 = New System.Windows.Forms.Label()
        Me.Label4 = New System.Windows.Forms.Label()
        Me.ucK2 = New DEG2000.ucKassette()
        Me.ucK1 = New DEG2000.ucKassette()
        Me.ucK4 = New DEG2000.ucKassette()
        Me.ucK3 = New DEG2000.ucKassette()
        Me.ucK6 = New DEG2000.ucKassette()
        Me.ucK5 = New DEG2000.ucKassette()
        Me.TabControl1.SuspendLayout()
        Me.AKB1.SuspendLayout()
        Me.AKB2.SuspendLayout()
        Me.AKB3.SuspendLayout()
        Me.SuspendLayout()
        '
        'TabControl1
        '
        Me.TabControl1.Controls.Add(Me.AKB1)
        Me.TabControl1.Controls.Add(Me.AKB2)
        Me.TabControl1.Controls.Add(Me.AKB3)
        Me.TabControl1.Location = New System.Drawing.Point(0, 0)
        Me.TabControl1.Name = "TabControl1"
        Me.TabControl1.SelectedIndex = 0
        Me.TabControl1.Size = New System.Drawing.Size(687, 582)
        Me.TabControl1.TabIndex = 0
        '
        'AKB1
        '
        Me.AKB1.Controls.Add(Me.LabelK2)
        Me.AKB1.Controls.Add(Me.LabelK1)
        Me.AKB1.Controls.Add(Me.ucK2)
        Me.AKB1.Controls.Add(Me.ucK1)
        Me.AKB1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.AKB1.Location = New System.Drawing.Point(4, 22)
        Me.AKB1.Name = "AKB1"
        Me.AKB1.Padding = New System.Windows.Forms.Padding(3)
        Me.AKB1.Size = New System.Drawing.Size(679, 556)
        Me.AKB1.TabIndex = 0
        Me.AKB1.Text = "Kassette 1,2 AKB=30H"
        Me.AKB1.UseVisualStyleBackColor = True
        '
        'LabelK2
        '
        Me.LabelK2.BackColor = System.Drawing.Color.LightBlue
        Me.LabelK2.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.LabelK2.Font = New System.Drawing.Font("Arial Rounded MT Bold", 12.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LabelK2.Location = New System.Drawing.Point(0, 300)
        Me.LabelK2.Name = "LabelK2"
        Me.LabelK2.Size = New System.Drawing.Size(677, 23)
        Me.LabelK2.TabIndex = 3
        Me.LabelK2.Text = "Kassette 2 - C for SYS 4"
        Me.LabelK2.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
        '
        'LabelK1
        '
        Me.LabelK1.BackColor = System.Drawing.Color.LightBlue
        Me.LabelK1.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.LabelK1.Font = New System.Drawing.Font("Arial Rounded MT Bold", 12.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LabelK1.Location = New System.Drawing.Point(0, 2)
        Me.LabelK1.Name = "LabelK1"
        Me.LabelK1.Size = New System.Drawing.Size(677, 23)
        Me.LabelK1.TabIndex = 2
        Me.LabelK1.Text = "Kassette 1 - B for SYS 4"
        Me.LabelK1.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
        '
        'AKB2
        '
        Me.AKB2.Controls.Add(Me.Label3)
        Me.AKB2.Controls.Add(Me.Label2)
        Me.AKB2.Controls.Add(Me.ucK4)
        Me.AKB2.Controls.Add(Me.ucK3)
        Me.AKB2.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.AKB2.Location = New System.Drawing.Point(4, 22)
        Me.AKB2.Name = "AKB2"
        Me.AKB2.Padding = New System.Windows.Forms.Padding(3)
        Me.AKB2.Size = New System.Drawing.Size(679, 556)
        Me.AKB2.TabIndex = 1
        Me.AKB2.Text = "Kassette 3,4 AKB=38H"
        Me.AKB2.UseVisualStyleBackColor = True
        '
        'Label3
        '
        Me.Label3.BackColor = System.Drawing.Color.LightBlue
        Me.Label3.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.Label3.Font = New System.Drawing.Font("Arial Rounded MT Bold", 12.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label3.Location = New System.Drawing.Point(0, 300)
        Me.Label3.Name = "Label3"
        Me.Label3.Size = New System.Drawing.Size(677, 23)
        Me.Label3.TabIndex = 5
        Me.Label3.Text = "Kassette 4 - E for SYS 4"
        Me.Label3.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
        '
        'Label2
        '
        Me.Label2.BackColor = System.Drawing.Color.LightBlue
        Me.Label2.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.Label2.Font = New System.Drawing.Font("Arial Rounded MT Bold", 12.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label2.Location = New System.Drawing.Point(0, 2)
        Me.Label2.Name = "Label2"
        Me.Label2.Size = New System.Drawing.Size(677, 23)
        Me.Label2.TabIndex = 4
        Me.Label2.Text = "Kassette 3 - D for SYS 4"
        Me.Label2.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
        '
        'AKB3
        '
        Me.AKB3.Controls.Add(Me.Label5)
        Me.AKB3.Controls.Add(Me.Label4)
        Me.AKB3.Controls.Add(Me.ucK6)
        Me.AKB3.Controls.Add(Me.ucK5)
        Me.AKB3.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.AKB3.Location = New System.Drawing.Point(4, 22)
        Me.AKB3.Name = "AKB3"
        Me.AKB3.Size = New System.Drawing.Size(679, 556)
        Me.AKB3.TabIndex = 2
        Me.AKB3.Text = "Kassette 5,6 AKB=58H"
        Me.AKB3.UseVisualStyleBackColor = True
        '
        'Label5
        '
        Me.Label5.BackColor = System.Drawing.Color.LightBlue
        Me.Label5.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.Label5.Font = New System.Drawing.Font("Arial Rounded MT Bold", 12.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label5.Location = New System.Drawing.Point(0, 300)
        Me.Label5.Name = "Label5"
        Me.Label5.Size = New System.Drawing.Size(677, 23)
        Me.Label5.TabIndex = 5
        Me.Label5.Text = "Kassette 6 - G for SYS 4"
        Me.Label5.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
        '
        'Label4
        '
        Me.Label4.BackColor = System.Drawing.Color.LightBlue
        Me.Label4.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.Label4.Font = New System.Drawing.Font("Arial Rounded MT Bold", 12.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label4.Location = New System.Drawing.Point(0, 2)
        Me.Label4.Name = "Label4"
        Me.Label4.Size = New System.Drawing.Size(677, 23)
        Me.Label4.TabIndex = 4
        Me.Label4.Text = "Kassette 5 - F for SYS 4"
        Me.Label4.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
        '
        'ucK2
        '
        Me.ucK2.Location = New System.Drawing.Point(0, 323)
        Me.ucK2.Name = "ucK2"
        Me.ucK2.Size = New System.Drawing.Size(678, 236)
        Me.ucK2.TabIndex = 1
        '
        'ucK1
        '
        Me.ucK1.Location = New System.Drawing.Point(0, 25)
        Me.ucK1.Name = "ucK1"
        Me.ucK1.Size = New System.Drawing.Size(678, 236)
        Me.ucK1.TabIndex = 0
        '
        'ucK4
        '
        Me.ucK4.Location = New System.Drawing.Point(0, 323)
        Me.ucK4.Name = "ucK4"
        Me.ucK4.Size = New System.Drawing.Size(678, 236)
        Me.ucK4.TabIndex = 1
        '
        'ucK3
        '
        Me.ucK3.Location = New System.Drawing.Point(0, 25)
        Me.ucK3.Name = "ucK3"
        Me.ucK3.Size = New System.Drawing.Size(678, 236)
        Me.ucK3.TabIndex = 0
        '
        'ucK6
        '
        Me.ucK6.Location = New System.Drawing.Point(0, 323)
        Me.ucK6.Name = "ucK6"
        Me.ucK6.Size = New System.Drawing.Size(678, 236)
        Me.ucK6.TabIndex = 1
        '
        'ucK5
        '
        Me.ucK5.Location = New System.Drawing.Point(0, 25)
        Me.ucK5.Name = "ucK5"
        Me.ucK5.Size = New System.Drawing.Size(678, 236)
        Me.ucK5.TabIndex = 0
        '
        'Kassetten
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(686, 582)
        Me.ControlBox = False
        Me.Controls.Add(Me.TabControl1)
        Me.Icon = CType(resources.GetObject("$this.Icon"), System.Drawing.Icon)
        Me.Name = "Kassetten"
        Me.ShowInTaskbar = False
        Me.StartPosition = System.Windows.Forms.FormStartPosition.Manual
        Me.Text = "Kassetten anzeigen"
        Me.TabControl1.ResumeLayout(False)
        Me.AKB1.ResumeLayout(False)
        Me.AKB2.ResumeLayout(False)
        Me.AKB3.ResumeLayout(False)
        Me.ResumeLayout(False)

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
