#tag Class
Protected Class Entry
Implements Xojo.Core.Iterator
	#tag Method, Flags = &h0
		Sub Constructor(host As Dictionary_MTC)
		  self.Keys = host.Keys
		  self.Values = host.Values
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function MoveNext() As Boolean
		  ItemIndex = ItemIndex + 1
		  
		  if ItemIndex = -1 or ItemIndex > Keys.Ubound then
		    mCurrentKey = nil
		    mCurrentValue = nil
		    return false
		  else
		    mCurrentKey = Keys( ItemIndex )
		    mCurrentValue = Values( ItemIndex )
		    return true
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Value() As Auto
		  return self
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private ItemIndex As Integer = -1
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mCurrentKey
			End Get
		#tag EndGetter
		Key As Variant
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private Keys() As Variant
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCurrentKey As Variant
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCurrentValue As Variant
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mCurrentValue
			End Get
		#tag EndGetter
		Value As Variant
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private Values() As Variant
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ParentDictionary"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
