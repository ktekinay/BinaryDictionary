#tag Interface
Protected Interface DictionaryInterface
	#tag Method, Flags = &h0
		Sub Clear()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasKey(key As Variant) As Boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Keys() As Variant()
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Lookup(key As Variant, defaultValue As Variant) As Variant
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(key As Variant)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Value(key As Variant) As Variant
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Value(key As Variant, Assigns value As Variant)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Values() As Variant()
		  
		End Function
	#tag EndMethod


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
	#tag EndViewBehavior
End Interface
#tag EndInterface
