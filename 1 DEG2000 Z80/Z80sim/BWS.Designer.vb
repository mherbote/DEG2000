<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()>
Partial Class BWS
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
        Me.components = New System.ComponentModel.Container()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(BWS))
        Me.tCursor = New System.Windows.Forms.Timer(Me.components)
        Me.Uhrzeit = New System.Windows.Forms.Timer(Me.components)
        Me.tError = New System.Windows.Forms.Timer(Me.components)
        Me.SuspendLayout()
        '
        'tCursor
        '
        '
        'Uhrzeit
        '
        Me.Uhrzeit.Interval = 1000
        '
        'tError
        '
        '
        'BWS
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(934, 561)
        Me.ControlBox = False
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedToolWindow
        Me.Icon = CType(resources.GetObject("$this.Icon"), System.Drawing.Icon)
        Me.Location = New System.Drawing.Point(840, 0)
        Me.MaximizeBox = False
        Me.MinimizeBox = False
        Me.Name = "BWS"
        Me.StartPosition = System.Windows.Forms.FormStartPosition.Manual
        Me.Text = "DEG2000 Bildschirm"
        Me.ResumeLayout(False)

    End Sub
    Friend WithEvents tCursor As System.Windows.Forms.Timer
    Friend WithEvents Uhrzeit As Timer
    Friend WithEvents tError As Timer
End Class
