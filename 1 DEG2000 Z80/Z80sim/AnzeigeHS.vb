Imports System
Imports System.Windows.Controls
Imports System.Windows.Forms
Imports System.Windows.Input

Public Class AnzeigeHS

    Private AnzeigeSeg As UShort
    Private AnzeigeStart As Integer
    Private BereichsIndex As Byte

    Private Sub AnzeigeHS_Load(sender As System.Object, e As System.EventArgs) Handles MyBase.Load
        Dim segAdr As UShort
        Dim j As UShort
        Dim hilf As String
        Dim hilf1() As String
        Dim c As New NumericUpDownColumn

        segAdr = 0 * 1024 * 4
        Call COMMON.initGrid(HSanzeige, System.Drawing.Color.LightGray, System.Drawing.Color.LightGray, System.Drawing.Color.Black, System.Drawing.Color.Black)
        With Me.HSanzeige
            For j = 0 To 15
                hilf1 = {HexAnzeige_WordByte(segAdr + j * 16, "B"),
                                             "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "",
                                             " ",
                                             ""}
                .Rows.Add(hilf1)
                .Rows(.Rows.Count - 1).Height = 20
            Next
            AddHandler .MouseWheel, AddressOf HSanzeige_MouseWheel
            .Columns(18).DefaultCellStyle.Font = New System.Drawing.Font("DEG", 12, System.Drawing.FontStyle.Regular)
        End With

        c.HeaderText = "Bereich"
        c.Width = 60
        c.SortMode = DataGridViewColumnSortMode.NotSortable
        Me.BereichsWahl.Columns.Add(c)

        Call COMMON.initGrid(BereichsWahl, System.Drawing.Color.LightGray, System.Drawing.Color.LightGray, System.Drawing.Color.Black, System.Drawing.Color.Black)
        With Me.BereichsWahl
            For j = 0 To 15
                Select Case j
                    Case 10
                        hilf = "10 A"
                    Case 11
                        hilf = "11 B"
                    Case 12
                        hilf = "12 C"
                    Case 13
                        hilf = "13 D"
                    Case 14
                        hilf = "14 E"
                    Case 15
                        hilf = "15 F"
                    Case Else
                        hilf = j
                End Select

                hilf1 = {hilf, vZ80cpu.Seg_HS(j)}
                'If j = 3 Then
                '    hilf1 = {j, 1}
                'Else
                '    hilf1 = {j, 0}
                'End If
                .Rows.Add(hilf1)
                .Rows(.Rows.Count - 1).Height = 20
            Next
        End With

        Call COMMON.initGrid(BereichAll, System.Drawing.Color.LightGray, System.Drawing.Color.LightGray, System.Drawing.Color.Black, System.Drawing.Color.Black)
        With Me.BereichAll
            For j = 0 To Z80cpu.cSeg_HS + 3
                Select Case j
                    Case Z80cpu.cSeg_HS + 1
                        hilf = "Global"
                    Case Z80cpu.cSeg_HS + 2
                        hilf = "S4      System"
                    Case Z80cpu.cSeg_HS + 3
                        hilf = "S4 Anwender"
                    Case Else
                        hilf = j
                End Select
                hilf1 = {hilf}
                .Rows.Add(hilf1)
                .Rows(.Rows.Count - 1).Height = 20
            Next
        End With
    End Sub ' AnzeigeHS_Load

    Public Sub Repaint()
        Call SpeicherAnzeigen(AnzeigeSeg)
    End Sub

    Public Sub SpeicherAnzeigen(Optional ByVal AnzeigeSeg1 As UShort = 100)
        Dim i As UShort
        Dim j As UShort
        Dim b As Byte
        Dim hilf2 As String

        Select Case AnzeigeSeg1
            Case 100
            Case Else
                AnzeigeSeg = AnzeigeSeg1
                AnzeigeStart = AnzeigeSeg * 1024 * 4
                BereichsIndex = Convert.ToByte(BereichsWahl.Rows(AnzeigeSeg).Cells(1).Value)
        End Select

        With Me.HSanzeige
            .Enabled = True

            Try
                For j = 0 To 15
                    .Rows(j).Cells(0).Value = HexAnzeige_WordByte(AnzeigeStart + j * 16, "B")
                    hilf2 = ""
                    For i = 0 To 15
                        b = COMMON.vZ80cpu.Speicher_lesen_Byte1(AnzeigeStart + j * 16 + i, BereichsIndex)
                        .Rows(j).Cells(i + 1).Value = COMMON.vZ80cpu.HexAnzeigeByte(b)
                        hilf2 = hilf2 + Chr(b)
                    Next
                    .Rows(j).Cells(18).Value = hilf2
                Next
            Catch ex As Exception

            End Try
            '.Enabled = False
            .Refresh()
        End With

        'Call COMMON.vZ80cpu.BWS_anzeigen()
    End Sub

    Private Sub HSanzeige_MouseWheel(ByVal sender As Object, ByVal e As Windows.Forms.MouseEventArgs)
        Me.HSanzeige.Select()

        If e.Delta < 0 Then
            '+
            Me.AnzeigeStart = Me.AnzeigeStart + &H100
            If Me.AnzeigeStart > &HFFFF Then Me.AnzeigeStart = Me.AnzeigeStart And &HFFFF
        Else
            '-
            Me.AnzeigeStart = Me.AnzeigeStart - &H100
            If Me.AnzeigeStart < 0 Then Me.AnzeigeStart = &H10000 + Me.AnzeigeStart
        End If
        Call Me.SpeicherAnzeigen(100)
    End Sub

    Private Sub HSanzeige_KeyDown(sender As Object, e As System.Windows.Forms.KeyEventArgs) Handles HSanzeige.KeyDown
        Select Case e.Control
            Case True
                Select Case e.KeyCode
                    Case Windows.Forms.Keys.Up
                        Me.AnzeigeStart = Me.AnzeigeStart - 16
                        If Me.AnzeigeStart < 0 Then Me.AnzeigeStart = &H10000 + Me.AnzeigeStart
                    Case Windows.Forms.Keys.Down
                        Me.AnzeigeStart = Me.AnzeigeStart + 16
                        If Me.AnzeigeStart > &HFFFF Then Me.AnzeigeStart = Me.AnzeigeStart And &HFFFF

                    Case Windows.Forms.Keys.D0
                        Me.AnzeigeStart = &H1000 * 0
                    Case Windows.Forms.Keys.D1
                        Me.AnzeigeStart = &H1000 * 1
                    Case Windows.Forms.Keys.D2
                        Me.AnzeigeStart = &H1000 * 2
                    Case Windows.Forms.Keys.D3
                        Me.AnzeigeStart = &H1000 * 3
                    Case Windows.Forms.Keys.D4
                        Me.AnzeigeStart = &H1000 * 4
                    Case Windows.Forms.Keys.D5
                        Me.AnzeigeStart = &H1000 * 5
                    Case Windows.Forms.Keys.D6
                        Me.AnzeigeStart = &H1000 * 6
                    Case Windows.Forms.Keys.D7
                        Me.AnzeigeStart = &H1000 * 7
                    Case Windows.Forms.Keys.D8
                        Me.AnzeigeStart = &H1000 * 8
                    Case Windows.Forms.Keys.D9
                        Me.AnzeigeStart = &H1000 * 9
                    Case Windows.Forms.Keys.A
                        Me.AnzeigeStart = &H1000 * 10
                    Case Windows.Forms.Keys.B
                        Me.AnzeigeStart = &H1000 * 11
                    Case Windows.Forms.Keys.C
                        Me.AnzeigeStart = &H1000 * 12
                    Case Windows.Forms.Keys.D
                        Me.AnzeigeStart = &H1000 * 13
                    Case Windows.Forms.Keys.E
                        Me.AnzeigeStart = &H1000 * 14
                    Case Windows.Forms.Keys.F
                        Me.AnzeigeStart = &H1000 * 15
                End Select
            Case False
                Select Case e.KeyCode
                    Case Windows.Forms.Keys.PageUp
                        Me.AnzeigeStart = Me.AnzeigeStart - 256
                        If Me.AnzeigeStart < 0 Then Me.AnzeigeStart = &H10000 + Me.AnzeigeStart
                    Case Windows.Forms.Keys.PageDown
                        Me.AnzeigeStart = Me.AnzeigeStart + 256
                        If Me.AnzeigeStart > &HFFFF Then Me.AnzeigeStart = Me.AnzeigeStart And &HFFFF
                End Select
        End Select
        '
        Call Me.SpeicherAnzeigen(100)
    End Sub ' HSanzeige_KeyDown

    Private Sub HSanzeige_CellClick(sender As Object, e As System.Windows.Forms.DataGridViewCellEventArgs) Handles HSanzeige.CellClick
        HSanzeige.BeginEdit(True)
    End Sub ' HSanzeige_CellClick

    Private Sub HSanzeige_CellEndEdit(sender As Object, e As System.Windows.Forms.DataGridViewCellEventArgs) Handles HSanzeige.CellEndEdit
    End Sub ' HSanzeige_CellEndEdit

    Private Sub BereichAll_CellContentClick(sender As Object, e As DataGridViewCellEventArgs) Handles BereichAll.CellContentClick
        Dim i As Integer

        If e.RowIndex < 0 Then Exit Sub
        Select Case e.ColumnIndex
            Case 0
                Select Case e.RowIndex
                    Case Z80cpu.cSeg_HS + 1                                             ' Global
                        For i = 0 To 15
                            With Me.BereichsWahl
                                .Rows(i).Cells(1).Value = COMMON.vZ80cpu.Seg_HS(i)
                            End With
                        Next i
                    Case Z80cpu.cSeg_HS + 2                                             ' SYS4 System
                        For i = 0 To 15
                            With Me.BereichsWahl
                                .Rows(i).Cells(1).Value = Haupt.IOsim.UM1(i)
                            End With
                        Next i
                    Case Z80cpu.cSeg_HS + 3                                             ' SYS3 Anwender
                        For i = 0 To 15
                            With Me.BereichsWahl
                                .Rows(i).Cells(1).Value = Haupt.IOsim.UM2(i)
                            End With
                        Next i
                    Case Else
                        For i = 0 To 15
                            With Me.BereichsWahl
                                .Rows(i).Cells(1).Value = e.RowIndex
                            End With
                        Next
                End Select
                Call SpeicherAnzeigen(AnzeigeSeg)
        End Select
    End Sub

    Private Sub BereichsWahl_CellContentClick(sender As Object, e As DataGridViewCellEventArgs) Handles BereichsWahl.CellContentClick
        If e.RowIndex < 0 Then Exit Sub
        Select Case e.ColumnIndex
            Case 0                                                              'HS-Sektor
                Call SpeicherAnzeigen(e.RowIndex)
            Case 1                                                              'Bereich
                BereichsWahl.CurrentCell = BereichsWahl.Rows(e.RowIndex).Cells(e.ColumnIndex)
                BereichsWahl.BeginEdit(False)
        End Select
    End Sub

    Private Sub BereichsWahl_CellEndEdit(sender As Object, e As DataGridViewCellEventArgs) Handles BereichsWahl.CellEndEdit
        If e.RowIndex < 0 Then Exit Sub
        Select Case e.ColumnIndex
            Case 1                                                              'Bereich
                Call SpeicherAnzeigen(e.RowIndex)
        End Select
    End Sub

    Private Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click
        Dim i As Integer
        If MsgBox("Sollen die aktuellen Bereichseinstellungen als Global übernommen werden?",
                  MsgBoxStyle.YesNo,
                 "Bereichsübernahme ===> Global") = MsgBoxResult.Yes Then
            For i = 0 To 15
                COMMON.vZ80cpu.Seg_HS(i) = Me.BereichsWahl.Rows(i).Cells(1).Value
            Next
        End If
    End Sub

    Private Sub Button2_Click(sender As Object, e As EventArgs) Handles Button2.Click
        Dim i As Integer

        If MsgBox("Soll der Start von 0100H aktiviert werden?", MsgBoxStyle.YesNo, "SYS4 Anwender-Start") = MsgBoxResult.Yes Then

            '1) Z80 Abarbeitung anhalten
            Call Haupt.CPUbreak()

            '2) HS-Speicher Global auf SYS4 "Anwender" ("Anwender"-TRAM) schalten
            For i = 0 To 15
                COMMON.vZ80cpu.Seg_HS(i) = Haupt.IOsim.UM2(i)
            Next

            '3) PC auf 0100H stellen
            COMMON.vZ80cpu.PC = &H100

            '4) Register-Anzeige ausschalten
            Haupt.RegisterAnzeigen.Checked = False
            Call Haupt.RegisterAnzeigenChange()
            Call Haupt.PrintReg()
        End If
    End Sub
End Class

Public Class NumericUpDownColumn
    Inherits DataGridViewColumn

    Public Sub New()
        MyBase.New(New NumericUpDownCell())
    End Sub

    Public Overrides Property CellTemplate() As DataGridViewCell
        Get
            Return MyBase.CellTemplate
        End Get
        Set(ByVal value As DataGridViewCell)
            If Not (value Is Nothing) AndAlso Not value.GetType().IsAssignableFrom(GetType(NumericUpDownCell)) Then
                Throw New InvalidCastException("Must be a Number")
            End If

            MyBase.CellTemplate = value
        End Set
    End Property
End Class

Public Class NumericUpDownCell
    Inherits DataGridViewTextBoxCell

    Public Sub New()
        Me.Style.Format = "F0"           '"#.##"
    End Sub

    Public Overrides Sub InitializeEditingControl(ByVal rowIndex As Integer,
                                                  ByVal initialFormattedValue As Object,
                                                  ByVal dataGridViewCellStyle As DataGridViewCellStyle)
        MyBase.InitializeEditingControl(rowIndex, initialFormattedValue, dataGridViewCellStyle)

        Dim ctl As NumericUpDownEditingControl = CType(DataGridView.EditingControl, NumericUpDownEditingControl)

        ctl.Value = CType(Me.Value, Decimal)
    End Sub

    Public Overrides ReadOnly Property EditType() As Type
        Get
            ' Return the type of the editing contol that CalendarCell uses.
            Return GetType(NumericUpDownEditingControl)
        End Get
    End Property

    Public Overrides ReadOnly Property ValueType() As Type
        Get
            ' Return the type of the value that CalendarCell contains.
            Return GetType(Decimal)
        End Get
    End Property

    Public Overrides ReadOnly Property DefaultNewRowValue() As Object
        Get
            ' Use the current date and time as the default value.
            Return 0
        End Get
    End Property
End Class

Class NumericUpDownEditingControl
    Inherits NumericUpDown
    Implements IDataGridViewEditingControl

    Private dataGridViewControl As DataGridView
    Private valueIsChanged As Boolean
    Private rowIndexNum As Integer

    Public Sub New()
        Me.DecimalPlaces = 0                '2
        Me.Minimum = 0
        Me.Maximum = Z80cpu.cSeg_HS
    End Sub

    Public Property EditingControlFormattedValue() As Object Implements IDataGridViewEditingControl.EditingControlFormattedValue
        Get
            Return Me.Value.ToString("F0")      '"#.##'
        End Get
        Set(ByVal value As Object)
            If TypeOf value Is Decimal Then
                Me.Value = Decimal.Parse(value) 'value.ToString() 
            End If
        End Set
    End Property

    Public Function GetEditingControlFormattedValue(ByVal context As DataGridViewDataErrorContexts) As Object _
        Implements IDataGridViewEditingControl.GetEditingControlFormattedValue
        Return Me.Value.ToString()          '"#.##'
    End Function

    Public Sub ApplyCellStyleToEditingControl(ByVal dataGridViewCellStyle As DataGridViewCellStyle) _
        Implements IDataGridViewEditingControl.ApplyCellStyleToEditingControl

        Me.Font = dataGridViewCellStyle.Font
        Me.ForeColor = dataGridViewCellStyle.ForeColor
        Me.BackColor = dataGridViewCellStyle.BackColor
    End Sub

    Public Property EditingControlRowIndex() As Integer Implements IDataGridViewEditingControl.EditingControlRowIndex
        Get
            Return rowIndexNum
        End Get
        Set(ByVal value As Integer)
            rowIndexNum = value
        End Set
    End Property

    Public Function EditingControlWantsInputKey(ByVal key As Keys, dataGridViewWantsInputKey As Boolean) As Boolean _
        Implements IDataGridViewEditingControl.EditingControlWantsInputKey

        ' Let the DateTimePicker handle the keys listed.
        Select Case key And Keys.KeyCode
            Case Keys.Left, Keys.Up, Keys.Down, Keys.Right, Keys.Home, Keys.End, Keys.PageDown, Keys.PageUp
                Return True
            Case Else
                Return False
        End Select
    End Function

    Public Sub PrepareEditingControlForEdit(selectAll As Boolean) Implements IDataGridViewEditingControl.PrepareEditingControlForEdit
        ' No preparation needs to be done.
    End Sub

    Public ReadOnly Property RepositionEditingControlOnValueChange As Boolean Implements IDataGridViewEditingControl.RepositionEditingControlOnValueChange
        Get
            Return False
        End Get
    End Property

    Public Property EditingControlDataGridView() As DataGridView Implements IDataGridViewEditingControl.EditingControlDataGridView
        Get
            Return dataGridViewControl
        End Get
        Set(ByVal value As DataGridView)
            dataGridViewControl = value
        End Set
    End Property

    Public Property EditingControlValueChanged() As Boolean Implements IDataGridViewEditingControl.EditingControlValueChanged
        Get
            Return valueIsChanged
        End Get
        Set(ByVal value As Boolean)
            valueIsChanged = value
        End Set
    End Property

    Public ReadOnly Property EditingPanelCursor() As Windows.Forms.Cursor Implements IDataGridViewEditingControl.EditingPanelCursor
        Get
            Return MyBase.Cursor
        End Get
    End Property

    Protected Overrides Sub OnValueChanged(ByVal eventargs As EventArgs)
        ' Notify the DataGridView that the contents of the cell have changed.
        valueIsChanged = True
        Me.EditingControlDataGridView.NotifyCurrentCellDirty(True)
        MyBase.OnValueChanged(eventargs)
    End Sub
End Class
