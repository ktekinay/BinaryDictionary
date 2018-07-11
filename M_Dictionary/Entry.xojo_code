#tag Class
Protected Class Entry
Implements Xojo.Core.Iterator
	#tag Method, Flags = &h0
		Sub Constructor(keys() As Variant, values() As Variant)
		  self.Keys = keys
		  self.Values = values
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function MoveNext() As Boolean
		  ItemIndex = ItemIndex + 1
		  return ItemIndex <= Keys.Ubound
		  
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
			  if ItemIndex = -1 or ItemIndex > Keys.Ubound then
			    return nil
			  else
			    return Keys( ItemIndex )
			  end if
			  
			End Get
		#tag EndGetter
		Key As Variant
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private Keys() As Variant
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  if ItemIndex = -1 or ItemIndex > Values.Ubound then
			    return nil
			  else
			    return Values( ItemIndex )
			  end if
			  
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
