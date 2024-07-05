Imports System.Data
Imports System.Drawing
Imports System.IO
Imports Microsoft.Win32
Imports System.Windows.Forms
Imports System.Windows.Forms.VisualStyles

Public Class Laufwerke

    Public Sub New()
        ' Dieser Aufruf ist für den Designer erforderlich.
        InitializeComponent()

        ' Fügen Sie Initialisierungen nach dem InitializeComponent()-Aufruf hinzu.
    End Sub

    Private Sub Laufwerke_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        'Call COMMON.initGrid(Kassetten1, Drawing.Color.LightBlue, Drawing.Color.LightBlue, Drawing.Color.Black, Drawing.Color.Black)
        'Call COMMON.initGrid(MiniDisk, Drawing.Color.LemonChiffon, Drawing.Color.LemonChiffon, Drawing.Color.Black, Drawing.Color.Black)
        'Call COMMON.initGrid(StandardDisk, Drawing.Color.LightYellow, Drawing.Color.LightYellow, Drawing.Color.Black, Drawing.Color.Black)

        Call AddCols(Kassetten1)
        Call AddCols(MiniDisk)
        Call AddCols(StandardDisk)
    End Sub


    Private Sub AddCols(obj As Object) ', Name As String, Width As Integer) ', CTemp As CellTemplate)
        Dim i As Int16

        Dim c1 As New DataGridViewDisableButtonColumn
        Dim c2 As New DataGridViewDisableButtonColumn
        Dim c3 As New DataGridViewCheckBoxColumn
        Dim c4 As New DataGridViewCheckBoxColumn

        With obj
            .Columns.Clear()
            .ColumnHeadersDefaultCellStyle.BackColor = Drawing.SystemColors.ActiveBorder
            .DefaultCellStyle.Alignment = Windows.Forms.DataGridViewContentAlignment.MiddleCenter
            .DefaultCellStyle.BackColor = Drawing.SystemColors.Control
            .DefaultCellStyle.ForeColor = Drawing.Color.Black

            For i = 0 To 6
                Select Case i
                    Case 0
                        .Columns.Add("Nr", "Nr")
                        .Columns(i).Width = 20
                    Case 1
                        .Columns.Add("SYS4", "SYS4")
                        .Columns(i).Width = 50
                    Case 2
                        .Columns.Add("DateinameK", "Host - Dateiname")
                        .Columns(i).Width = 430
                    Case 3
                        c1.HeaderText = "Change"
                        c1.Name = "ChangeK"
                        c1.Width = 70
                        c1.SortMode = DataGridViewColumnSortMode.NotSortable
                        .Columns.Add(c1)
                    Case 4
                        c2.HeaderText = "Create"
                        c2.Name = "CreateK"
                        c2.Width = 70
                        c2.SortMode = DataGridViewColumnSortMode.NotSortable
                        .Columns.Add(c2)
                    Case 5
                        c3.HeaderText = "CrK"
                        c3.Name = "CheckCreateK"
                        c3.Width = 0
                        c3.SortMode = DataGridViewColumnSortMode.NotSortable
                        c3.Visible = False
                        .Columns.Add(c3)
                    Case 6
                        c4.HeaderText = "ChK"
                        c4.Name = "CheckChangeK"
                        c4.Width = 0
                        c4.SortMode = DataGridViewColumnSortMode.NotSortable
                        c4.Visible = False
                        .Columns.Add(c4)
                End Select

                Select Case i
                    Case 0, 1, 3, 4
                        .Columns(i).DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleCenter
                    Case 2
                        .Columns(i).DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleLeft
                End Select

                .Columns(i).ReadOnly = True
                .Columns(i).Resizable = False
            Next
        End With

        Select Case UCase(obj.name)
            Case UCase("Kassetten1")
                Call COMMON.PrintGrid(Kassetten1, {"1", "B", "Keine Zuordnung", "Open", "Create"}, 22)
                Call COMMON.PrintGrid(Kassetten1, {"2", "C", "Keine Zuordnung", "Open", "Create"}, 22)
                Call COMMON.PrintGrid(Kassetten1, {"3", "D", "Keine Zuordnung", "Open", "Create"}, 22)
                Call COMMON.PrintGrid(Kassetten1, {"4", "E", "Keine Zuordnung", "Open", "Create"}, 22)
                Call COMMON.PrintGrid(Kassetten1, {"5", "F", "Keine Zuordnung", "Open", "Create"}, 22)
                Call COMMON.PrintGrid(Kassetten1, {"6", "G", "Keine Zuordnung", "Open", "Create"}, 22)

                Kassetten1.RowsDefaultCellStyle.BackColor = System.Drawing.Color.LightBlue
                Kassetten1.RowsDefaultCellStyle.ForeColor = System.Drawing.Color.Black
                Kassetten1.DefaultCellStyle.SelectionBackColor = System.Drawing.Color.LightBlue
                Kassetten1.DefaultCellStyle.SelectionForeColor = System.Drawing.Color.Black
            Case UCase("MiniDisk")
                Call COMMON.PrintGrid(MiniDisk, {"1", "H", "Keine Zuordnung", "Open", "Create"}, 22)
                Call COMMON.PrintGrid(MiniDisk, {"2", "I", "Keine Zuordnung", "Open", "Create"}, 22)
                Call COMMON.PrintGrid(MiniDisk, {"3", "J", "Keine Zuordnung", "Open", "Create"}, 22)
                Call COMMON.PrintGrid(MiniDisk, {"4", "K", "Keine Zuordnung", "Open", "Create"}, 22)

                MiniDisk.RowsDefaultCellStyle.BackColor = System.Drawing.Color.LemonChiffon
                MiniDisk.RowsDefaultCellStyle.ForeColor = System.Drawing.Color.Black
                MiniDisk.DefaultCellStyle.SelectionBackColor = System.Drawing.Color.LemonChiffon
                MiniDisk.DefaultCellStyle.SelectionForeColor = System.Drawing.Color.Black
            Case UCase("StandardDisk")

                Call COMMON.PrintGrid(StandardDisk, {"1", "L", "Keine Zuordnung", "Open", "Create"}, 22)
                Call COMMON.PrintGrid(StandardDisk, {"2", "M", "Keine Zuordnung", "Open", "Create"}, 22)

                StandardDisk.RowsDefaultCellStyle.BackColor = System.Drawing.Color.LightGoldenrodYellow
                StandardDisk.RowsDefaultCellStyle.ForeColor = System.Drawing.Color.Black
                StandardDisk.DefaultCellStyle.SelectionBackColor = System.Drawing.Color.LightGoldenrodYellow
                StandardDisk.DefaultCellStyle.SelectionForeColor = System.Drawing.Color.Black
        End Select
    End Sub ' AddCols

    'Private Sub Kassetten1_CellContentClick(sender As Object, e As DataGridViewCellEventArgs) Handles Kassetten1.CellContentClick

    '    Select Case e.ColumnIndex
    '        Case 3                                                  ' bestehende Kassettendatei öffnen
    '        Case 4                                                  ' Neue Kassettendatei erstellen
    '            If Me.Kassetten1.Rows(e.RowIndex).Cells("CheckCreateK").Value = False Then
    '            End If
    '    End Select
    'End Sub

    Private Sub Click_AnzeigeKassetten(sender As Object, e As EventArgs) Handles AnzeigeKassetten.Click
        Haupt.KassetteAnzeigen.Checked = Not Haupt.KassetteAnzeigen.Checked
        Call Haupt.KassetteAnzeigenChange()
        If Haupt.KassetteAnzeigen.Checked Then
            AnzeigeKassetten.Text = "Aus"
        Else
            AnzeigeKassetten.Text = "An"
        End If
    End Sub

    Private Sub Kassetten1_CellClick(sender As Object, e As DataGridViewCellEventArgs) Handles Kassetten1.CellClick
        '## Call ShowKassette()
        If e.RowIndex >= 0 Then
            Select Case e.ColumnIndex
                Case 3                                                                                      ' bestehende Kassettendatei öffnen
                    If Kassetten1.Columns(e.ColumnIndex).Name = "ChangeK" Then
                        Dim buttonCell As DataGridViewDisableButtonCell = CType(Kassetten1.Rows(e.RowIndex).Cells("ChangeK"), DataGridViewDisableButtonCell)

                        If buttonCell.Enabled Then
                            Select Case e.RowIndex
                                Case 0
                                    Call Kassetten.ucK1.OpenKassette2(Me.Kassetten1.Rows(e.RowIndex).Cells("ChangeK").Value, e.RowIndex, 1)
                                Case 1
                                    Call Kassetten.ucK2.OpenKassette2(Me.Kassetten1.Rows(e.RowIndex).Cells("ChangeK").Value, e.RowIndex, 1)
                                Case 2
                                    Call Kassetten.ucK3.OpenKassette2(Me.Kassetten1.Rows(e.RowIndex).Cells("ChangeK").Value, e.RowIndex, 2)
                                Case 3
                                    Call Kassetten.ucK4.OpenKassette2(Me.Kassetten1.Rows(e.RowIndex).Cells("ChangeK").Value, e.RowIndex, 2)
                                Case 4
                                    Call Kassetten.ucK5.OpenKassette2(Me.Kassetten1.Rows(e.RowIndex).Cells("ChangeK").Value, e.RowIndex, 3)
                                Case 5
                                    Call Kassetten.ucK6.OpenKassette2(Me.Kassetten1.Rows(e.RowIndex).Cells("ChangeK").Value, e.RowIndex, 3)
                            End Select
                        End If
                    End If
                Case 4                                                                                      ' Neue Kassettendatei erstellen
                    If Kassetten1.Columns(e.ColumnIndex).Name = "CreateK" Then
                        Dim buttonCell As DataGridViewDisableButtonCell = CType(Kassetten1.Rows(e.RowIndex).Cells("CreateK"), DataGridViewDisableButtonCell)

                        If buttonCell.Enabled Then
                            Select Case e.RowIndex
                                Case 0
                                    Call Kassetten.ucK1.CreateKassette2(Me.Kassetten1.Rows(e.RowIndex).Cells("CreateK").Value, e.RowIndex, 1)
                                Case 1
                                    Call Kassetten.ucK1.CreateKassette2(Me.Kassetten1.Rows(e.RowIndex).Cells("CreateK").Value, e.RowIndex, 1)
                                Case 2
                                    Call Kassetten.ucK1.CreateKassette2(Me.Kassetten1.Rows(e.RowIndex).Cells("CreateK").Value, e.RowIndex, 2)
                                Case 3
                                    Call Kassetten.ucK1.CreateKassette2(Me.Kassetten1.Rows(e.RowIndex).Cells("CreateK").Value, e.RowIndex, 2)
                                Case 4
                                    Call Kassetten.ucK1.CreateKassette2(Me.Kassetten1.Rows(e.RowIndex).Cells("CreateK").Value, e.RowIndex, 3)
                                Case 5
                                    Call Kassetten.ucK1.CreateKassette2(Me.Kassetten1.Rows(e.RowIndex).Cells("CreateK").Value, e.RowIndex, 3)
                            End Select
                        End If
                    End If
            End Select
        End If
    End Sub

    Private Sub Kassetten1_CurrentCellDirtyStateChanged(sender As Object, e As EventArgs) Handles Kassetten1.CurrentCellDirtyStateChanged
        If Kassetten1.IsCurrentCellDirty Then
            Kassetten1.CommitEdit(DataGridViewDataErrorContexts.Commit)
        End If
    End Sub

    Public Sub Kassetten1_CellValueChanged(sender As Object, e As DataGridViewCellEventArgs) Handles Kassetten1.CellValueChanged
        If Kassetten1.Columns(e.ColumnIndex).Name = "CheckCreateK" Then
            Dim buttonCell As DataGridViewDisableButtonCell = CType(Kassetten1.Rows(e.RowIndex).Cells("CreateK"), DataGridViewDisableButtonCell)
            Dim checkCell As DataGridViewCheckBoxCell = CType(Kassetten1.Rows(e.RowIndex).Cells("CheckCreateK"), DataGridViewCheckBoxCell)

            buttonCell.Enabled = Not CType(checkCell.Value, [Boolean])

            Kassetten1.Invalidate()
        End If
        If Kassetten1.Columns(e.ColumnIndex).Name = "CheckChangeK" Then
            Dim buttonCell As DataGridViewDisableButtonCell = CType(Kassetten1.Rows(e.RowIndex).Cells("ChangeK"), DataGridViewDisableButtonCell)
            Dim checkCell As DataGridViewCheckBoxCell = CType(Kassetten1.Rows(e.RowIndex).Cells("CheckChangeK"), DataGridViewCheckBoxCell)

            buttonCell.Enabled = Not CType(checkCell.Value, [Boolean])

            Kassetten1.Invalidate()
        End If
    End Sub

    Public Sub ShowKassette()
        If Kassetten.Visible = False Then
            Haupt.KassetteAnzeigen.Checked = True
            With Kassetten
                .Show()
                .Top = Haupt.Top
                If BWS.Visible Then
                    .Top = .Top + BWS.Height - 7
                End If
                If Me.Visible Then
                    .Top = .Top + Me.Height
                End If
                .Left = Haupt.Left + Haupt.Width - 14
            End With
        End If
    End Sub
End Class

Public Class DataGridViewDisableButtonColumn
    Inherits DataGridViewButtonColumn

    Public Sub New()
        Me.CellTemplate = New DataGridViewDisableButtonCell()
    End Sub
End Class

Public Class DataGridViewDisableButtonCell
    Inherits DataGridViewButtonCell

    Private Property enabledValue As Boolean

    Public Property Enabled() As Boolean
        Get
            Return enabledValue
        End Get
        Set(ByVal value As Boolean)
            enabledValue = value
        End Set
    End Property

    Public Overrides Function Clone() As Object
        Dim cell As DataGridViewDisableButtonCell = CType(MyBase.Clone(), DataGridViewDisableButtonCell)
        cell.Enabled = Me.Enabled
        Return cell
    End Function

    Public Sub New()
        Me.enabledValue = True
    End Sub

    Protected Overrides Sub Paint(ByVal graphics As Graphics,
                                  ByVal clipBounds As Rectangle,
                                  ByVal cellBounds As Rectangle,
                                  ByVal rowIndex As Integer,
                                  ByVal elementState As DataGridViewElementStates,
                                  ByVal value As Object,
                                  ByVal formattedValue As Object,
                                  ByVal errorText As String,
                                  ByVal cellStyle As DataGridViewCellStyle,
                                  ByVal advancedBorderStyle As DataGridViewAdvancedBorderStyle,
                                  ByVal paintParts As DataGridViewPaintParts)
        If Not Me.enabledValue Then
            If (paintParts And DataGridViewPaintParts.Background) = DataGridViewPaintParts.Background Then
                Dim cellBackground As SolidBrush = New SolidBrush(cellStyle.BackColor)
                graphics.FillRectangle(cellBackground, cellBounds)
                cellBackground.Dispose()
            End If

            If (paintParts And DataGridViewPaintParts.Border) = DataGridViewPaintParts.Border Then
                PaintBorder(graphics, clipBounds, cellBounds, cellStyle, advancedBorderStyle)
            End If

            Dim buttonArea As Rectangle = cellBounds
            Dim buttonAdjustment As Rectangle = Me.BorderWidths(advancedBorderStyle)
            buttonArea.X += buttonAdjustment.X
            buttonArea.Y += buttonAdjustment.Y
            buttonArea.Height -= buttonAdjustment.Height
            buttonArea.Width -= buttonAdjustment.Width
            ButtonRenderer.DrawButton(graphics, buttonArea, PushButtonState.Disabled)
            If TypeOf Me.FormattedValue Is String Then
                TextRenderer.DrawText(graphics, CStr(Me.FormattedValue), Me.DataGridView.Font, buttonArea, SystemColors.GrayText)
            End If
        Else
            MyBase.Paint(graphics, clipBounds, cellBounds, rowIndex, elementState, value,
                         formattedValue, errorText, cellStyle, advancedBorderStyle, paintParts)
        End If
    End Sub

End Class