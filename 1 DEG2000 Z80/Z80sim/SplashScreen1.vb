﻿Public NotInheritable Class SplashScreen1

    'TODO: Dieses Formular kann einfach als Begrüßungsbildschirm für die Anwendung festgelegt werden, indem Sie zur Registerkarte "Anwendung"
    '  des Projekt-Designers wechseln (Menü "Projekt", Option "Eigenschaften").


    Private Sub SplashScreen1_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Richten Sie den Dialogtext zur Laufzeit gemäß den Assemblyinformationen der Anwendung ein.  

        'TODO: Passen Sie die Assemblyinformationen der Anwendung im Bereich "Anwendung" des Dialogfelds für die 
        '  Projekteigenschaften (im Menü "Projekt") an.

        'Anwendungstitel
        If My.Application.Info.Title <> "" Then
            DEG2000.Text = My.Application.Info.Title
        Else
            'Wenn der Anwendungstitel fehlt, Anwendungsnamen ohne Erweiterung verwenden
            DEG2000.Text = System.IO.Path.GetFileNameWithoutExtension(My.Application.Info.AssemblyName)
        End If

        'Verwenden Sie zum Formatieren der Versionsinformationen den Text, der zur Entwurfszeit in der Versionskontrolle festgelegt wurde, als
        '  Formatierungszeichenfolge. Dies ermöglicht ggf. eine effektive Lokalisierung.
        '  Build- und Revisionsinformationen können durch Verwendung des folgenden Codes und durch Ändern 
        '  des Entwurfszeittexts der Versionskontrolle in "Version {0}.{1:00}.{2}.{3}" oder einen ähnlichen Text eingeschlossen werden. Weitere Informationen erhalten Sie unter
        '  String.Format() in der Hilfe.
        '
        '    Version.Text = System.String.Format(Version.Text, My.Application.Info.Version.Major, My.Application.Info.Version.Minor, My.Application.Info.Version.Build, My.Application.Info.Version.Revision)

        Version.Text = System.String.Format(Version.Text, My.Application.Info.Version.Major, My.Application.Info.Version.Minor)

        'Copyrightinformationen
        Copyright.Text = My.Application.Info.Copyright

        Haupt.SplashScreenStarttime.Interval = 8000             ' Anzeige für 8sec, wenn nicht mit Maus auf SplashScreen geklickt wird.
        Haupt.SplashScreenStarttime.Enabled = True
    End Sub

    Private Sub DEG2000_Click(sender As System.Object, e As System.EventArgs) Handles DEG2000.Click, MainLayoutPanel.Click, Version.Click, DetailsLayoutPanel.Click, Copyright.Click
        Haupt.SplashScreenStarttime.Enabled = False
        Haupt.TestbildChange.Enabled = False
        Hide()
        BWS.TestBild(0)
    End Sub
End Class
