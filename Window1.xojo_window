#tag Window
Begin Window Window1
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   CloseButton     =   True
   Compatibility   =   ""
   Composite       =   False
   Frame           =   0
   FullScreen      =   False
   FullScreenButton=   False
   HasBackColor    =   False
   Height          =   400
   ImplicitInstance=   True
   LiveResize      =   True
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   False
   MaxWidth        =   32000
   MenuBar         =   410277764
   MenuBarVisible  =   True
   MinHeight       =   64
   MinimizeButton  =   True
   MinWidth        =   64
   Placement       =   0
   Resizeable      =   True
   Title           =   "Untitled"
   Visible         =   True
   Width           =   1088
   Begin PushButton btnRun
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   "0"
      Cancel          =   False
      Caption         =   "Run"
      Default         =   False
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   14
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin Listbox lbResult
      AutoDeactivate  =   True
      AutoHideScrollbars=   True
      Bold            =   False
      Border          =   True
      ColumnCount     =   5
      ColumnsResizable=   False
      ColumnWidths    =   "80"
      DataField       =   ""
      DataSource      =   ""
      DefaultRowHeight=   -1
      Enabled         =   True
      EnableDrag      =   False
      EnableDragReorder=   False
      GridLinesHorizontal=   0
      GridLinesVertical=   0
      HasHeading      =   True
      HeadingIndex    =   -1
      Height          =   334
      HelpTag         =   ""
      Hierarchical    =   False
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   "Count	Insert Dict	Insert Binary	Value Dict	Value Binary"
      Italic          =   False
      Left            =   20
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      RequiresSelection=   False
      Scope           =   0
      ScrollbarHorizontal=   False
      ScrollBarVertical=   True
      SelectionType   =   0
      ShowDropIndicator=   False
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "Menlo"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   46
      Transparent     =   False
      Underline       =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   1048
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
   End
   Begin Timer tmrTest
      Index           =   -2147483648
      LockedInPosition=   False
      Mode            =   0
      Period          =   10
      Scope           =   2
      TabPanelIndex   =   0
   End
End
#tag EndWindow

#tag WindowCode
	#tag Property, Flags = &h21
		Private Keys() As Variant
	#tag EndProperty

	#tag Property, Flags = &h21
		Private ThisCount As Integer
	#tag EndProperty


	#tag Constant, Name = kUbound, Type = Double, Dynamic = False, Default = \"1000000", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events btnRun
	#tag Event
		Sub Action()
		  if tmrTest.Mode <> Timer.ModeOff then
		    
		    tmrTest.Mode = Timer.ModeOff
		    
		  else
		    
		    if Keys.Ubound = -1 then
		      for i as integer = 0 to kUbound
		        Keys.Append str( i )
		      next
		      Keys.Shuffle
		    end if
		    
		    lbResult.DeleteAllRows
		    for col as integer = 0 to 4
		      lbResult.ColumnAlignment( col ) = ListBox.AlignRight
		    next
		    
		    ThisCount = 25
		    tmrTest.Mode = Timer.ModeMultiple
		    
		  end if
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events lbResult
	#tag Event
		Function CellTextPaint(g As Graphics, row As Integer, column As Integer, x as Integer, y as Integer) As Boolean
		  if column = 0 then
		    return false
		  end if
		  
		  dim isEven as boolean = ( column mod 2 ) = 0
		  
		  dim thisMicroSecs as double = me.CellTag( row, column ).DoubleValue
		  dim otherMicrosecs as double = if( isEven, me.CellTag( row, column - 1 ).DoubleValue, me.CellTag( row, column + 1 ).DoubleValue )
		  
		  if thisMicroSecs < otherMicrosecs then
		    g.ForeColor = Color.Green
		    g.Bold = true
		  end if
		  
		  
		End Function
	#tag EndEvent
	#tag Event
		Function CellBackgroundPaint(g As Graphics, row As Integer, column As Integer) As Boolean
		  if me.Selected( row ) then
		    return false
		  end if
		  
		  if ( row mod 2 ) <> 0 then
		    g.ForeColor = &cE2EDFF00
		    g.FillRect 0, 0, g.Width, g.Height
		    return true
		  end if
		End Function
	#tag EndEvent
	#tag Event
		Function CompareRows(row1 as Integer, row2 as Integer, column as Integer, ByRef result as Integer) As Boolean
		  dim d1 as double = me.CellTag( row1, column ).DoubleValue
		  dim d2 as double = me.CellTag( row2, column ).DoubleValue
		  
		  if d1 < d2 then
		    result = -1
		  elseif d1 > d2 then
		    result = 1
		  else
		    result = 0
		  end if
		  
		  return true
		  
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events tmrTest
	#tag Event
		Sub Action()
		  const kFormat as string = "#,0.000"
		  
		  #if DebugBuild then
		    dim thisCountDebug as integer = self.ThisCount
		    #pragma unused thisCountDebug
		  #endif
		  
		  dim thisCountDouble as double = ThisCount
		  
		  lbResult.AddRow format( ThisCount, "#,0" )
		  dim row as integer = lbResult.LastIndex
		  lbResult.CellTag( row, 0 ) = ThisCount
		  
		  dim swb as new Stopwatch_MTC
		  dim swd as new Stopwatch_MTC
		  
		  swd.Start
		  dim d as new Dictionary
		  swd.Stop
		  
		  swb.Start
		  dim b as new BinaryDictionary_MTC
		  swb.Stop
		  
		  System.DebugLog "Create Dictionary took " + _
		  format( swd.ElapsedMilliseconds, kFormat ) + _
		  "ms, BinaryDictionary_MTC took " + _
		  format( swb.ElapsedMilliseconds, kFormat ) + _
		  "ms"
		  
		  swb.Reset
		  swd.Reset
		  
		  for i as integer = 1 to ThisCount
		    dim key as variant = Keys( i )
		    
		    swd.Start
		    d.Value( key ) = nil
		    swd.Stop
		    
		    if UserCancelled then
		      me.Mode = Timer.ModeOff
		      return
		    end if
		    
		    swb.Start
		    b.Value( key ) = nil
		    swb.Stop
		    
		    if UserCancelled then
		      me.Mode = Timer.ModeOff
		      return
		    end if
		  next
		  
		  lbResult.Cell( row, 1 ) = format( swd.ElapsedMilliseconds, kFormat ) + _
		  " (" + format( swd.ElapsedMicroseconds / thisCountDouble, kFormat ) + ")"
		  lbResult.CellTag( row, 1 ) = swd.ElapsedMicroseconds
		  lbResult.Cell( row, 2 ) = format( swb.ElapsedMilliseconds, kFormat ) + _
		  " (" + format( swb.ElapsedMicroseconds / thisCountDouble, kFormat ) + ")"
		  lbResult.CellTag( row, 2 ) = swb.ElapsedMicroseconds
		  
		  swd.Reset
		  swb.Reset
		  
		  for i as integer = 1 to ThisCount
		    dim key as variant = Keys( i )
		    
		    swd.Start
		    call d.Value( key )
		    swd.Stop
		    
		    if UserCancelled then
		      me.Mode = Timer.ModeOff
		      return
		    end if
		    
		    swb.Start
		    call b.Value( key )
		    swb.Stop
		    
		    if UserCancelled then
		      me.Mode = Timer.ModeOff
		      return
		    end if
		  next
		  
		  lbResult.Cell( row, 3 ) = format( swd.ElapsedMilliseconds, kFormat ) + _
		  " (" + format( swd.ElapsedMicroseconds / thisCountDouble, kFormat ) + ")"
		  lbResult.CellTag( row, 3 ) = swd.ElapsedMicroseconds
		  lbResult.Cell( row, 4 ) = format( swb.ElapsedMilliseconds, kFormat ) + _
		  " (" + format( swb.ElapsedMicroseconds / thisCountDouble, kFormat ) + ")"
		  lbResult.CellTag( row, 4 ) = swb.ElapsedMicroseconds
		  
		  dim counts() as integer = b.GetDistribution
		  dim minCount as integer = 2 ^ 31
		  dim maxCount as integer
		  dim isZeroCount as integer
		  dim hasValueCount as integer
		  
		  for each count as integer in counts
		    if count > maxCount then
		      maxCount = count
		    end if
		    if count = 0 then
		      isZeroCount = isZeroCount + 1
		    else
		      hasValueCount = hasValueCount + 1
		      if count < minCount then
		        minCount = count
		      end if
		    end if
		  next
		  
		  counts = counts // A place to break
		  
		  if UserCancelled or ThisCount = kUbound then
		    me.Mode = Timer.ModeOff
		    return
		  end if
		  
		  self.ThisCount = ThisCount + ThisCount
		  
		  if self.ThisCount > kUbound then
		    self.ThisCount = kUbound
		  end if
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="FullScreenButton"
		Visible=true
		Group="Appearance"
		InitialValue="False"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Name"
		Visible=true
		Group="ID"
		Type="String"
		EditorType="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Interfaces"
		Visible=true
		Group="ID"
		Type="String"
		EditorType="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Super"
		Visible=true
		Group="ID"
		Type="String"
		EditorType="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Placement"
		Visible=true
		Group="Position"
		InitialValue="0"
		Type="Integer"
		EditorType="Enum"
		#tag EnumValues
			"0 - Default"
			"1 - Parent Window"
			"2 - Main Screen"
			"3 - Parent Window Screen"
			"4 - Stagger"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="Width"
		Visible=true
		Group="Position"
		InitialValue="600"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=true
		Group="Position"
		InitialValue="400"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinWidth"
		Visible=true
		Group="Position"
		InitialValue="64"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinHeight"
		Visible=true
		Group="Position"
		InitialValue="64"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaxWidth"
		Visible=true
		Group="Position"
		InitialValue="32000"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaxHeight"
		Visible=true
		Group="Position"
		InitialValue="32000"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Frame"
		Visible=true
		Group="Appearance"
		InitialValue="0"
		Type="Integer"
		EditorType="Enum"
		#tag EnumValues
			"0 - Document"
			"1 - Movable Modal"
			"2 - Modal Dialog"
			"3 - Floating Window"
			"4 - Plain Box"
			"5 - Shadowed Box"
			"6 - Rounded Window"
			"7 - Global Floating Window"
			"8 - Sheet Window"
			"9 - Metal Window"
			"11 - Modeless Dialog"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="Composite"
		Visible=true
		Group="Appearance"
		InitialValue="False"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasBackColor"
		Visible=true
		Group="Appearance"
		InitialValue="False"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="BackColor"
		Visible=true
		Group="Appearance"
		InitialValue="&hFFFFFF"
		Type="Color"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Backdrop"
		Visible=true
		Group="Appearance"
		Type="Picture"
		EditorType="Picture"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Title"
		Visible=true
		Group="Appearance"
		InitialValue="Untitled"
		Type="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Visible"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="FullScreen"
		Visible=true
		Group="Appearance"
		InitialValue="False"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBarVisible"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="CloseButton"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Resizeable"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LiveResize"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaximizeButton"
		Visible=true
		Group="Appearance"
		InitialValue="False"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimizeButton"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MacProcID"
		Visible=true
		Group="Appearance"
		InitialValue="0"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBar"
		Visible=true
		Group="Appearance"
		Type="MenuBar"
		EditorType="MenuBar"
	#tag EndViewProperty
	#tag ViewProperty
		Name="ImplicitInstance"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
#tag EndViewBehavior
