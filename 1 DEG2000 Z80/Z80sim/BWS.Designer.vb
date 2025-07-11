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
        components = New System.ComponentModel.Container()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(BWS))
        tCursor = New System.Windows.Forms.Timer(components)
        Uhrzeit = New System.Windows.Forms.Timer(components)
        tError = New System.Windows.Forms.Timer(components)
        SuspendLayout()
        '
        'tCursor
        '
        '
        'Uhrzeit
        '
        Uhrzeit.Interval = 1000
        '
        'tError
        '
        '
        'BWS
        '
        AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        ClientSize = New System.Drawing.Size(934, 561)
        ControlBox = False
        FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedToolWindow
        Icon = CType(resources.GetObject("$this.Icon"), System.Drawing.Icon)
        Location = New System.Drawing.Point(840, 0)
        MaximizeBox = False
        MinimizeBox = False
        Name = "BWS"
        StartPosition = System.Windows.Forms.FormStartPosition.Manual
        Text = "DEG2000 Bildschirm"
        ResumeLayout(False)

    End Sub
    Friend WithEvents tCursor As System.Windows.Forms.Timer
    Friend WithEvents Uhrzeit As Timer
    Friend WithEvents tError As Timer
End Class
