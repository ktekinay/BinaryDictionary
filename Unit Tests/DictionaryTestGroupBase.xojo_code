#tag Class
Protected Class DictionaryTestGroupBase
Inherits TestGroup
	#tag Method, Flags = &h0
		Sub LongStringTest()
		  const kStringLen as integer = 10000
		  
		  dim s as string = "Some really really long string with zzz various characters "
		  while s.LenB <= ( kStringLen \ 2 )
		    s = s + s
		  wend
		  s = s + s.LeftB( kStringLen - s.LenB )
		  
		  dim d as M_Dictionary.DictionaryInterface = NewDictionary
		  
		  for i as integer = 0 to kStringLen
		    dim testString as string = s.Left( i )
		    d.Value( testString ) = i
		    Assert.AreEqual i, d.Value( s.Left( i ) ).IntegerValue
		  next
		  
		  //
		  // Let's add some randomness
		  //
		  
		  'd = NewDictionary
		  
		  dim r as new Random
		  
		  dim keys() as string
		  dim values() as integer
		  
		  for i as integer = 0 to 1000
		    dim start as integer = r.InRange( 1, kStringLen )
		    dim len as integer = r.InRange( 1, kStringLen )
		    dim key as string = s.MidB( start, len )
		    if keys.IndexOf( key ) = -1 then
		      keys.Append key
		      values.Append i
		      d.Value( key ) = i
		    end if
		  next
		  
		  for i as integer = 0 to keys.Ubound
		    Assert.AreEqual values( i ), d.Value( keys( i ) ).IntegerValue
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function NewDictionary() As M_Dictionary.DictionaryInterface
		  return RaiseEvent ReturnNewDictionary
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ValueTest()
		  dim d as M_Dictionary.DictionaryInterface = NewDictionary
		  
		  d.Value( 1 ) = 1
		  d.Value( "1" ) = 2
		  d.Value( 1.0 ) = 3
		  d.Value( "1.0" ) = 4
		  d.Value( 0 ) = 5
		  d.Value( "0" ) = 6
		  d.Value( nil ) = 7
		  d.Value( false ) = 8
		  d.Value( true ) = 9
		  d.Value( 0.0 ) = 10
		  
		  Assert.AreEqual 1, d.Value( 1 ).IntegerValue
		  Assert.AreEqual 2, d.Value( "1" ).IntegerValue
		  Assert.AreEqual 3, d.Value( 1.0 ).IntegerValue
		  Assert.AreEqual 4, d.Value( "1.0" ).IntegerValue
		  Assert.AreEqual 5, d.Value( 0 ).IntegerValue
		  Assert.AreEqual 6, d.Value( "0" ).IntegerValue
		  Assert.AreEqual 7, d.Value( nil ).IntegerValue
		  Assert.AreEqual 8, d.Value( false ).IntegerValue
		  Assert.AreEqual 9, d.Value( true ).IntegerValue
		  Assert.AreEqual 10, d.Value( 0.0 ).IntegerValue
		  
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event ReturnNewDictionary() As M_Dictionary.DictionaryInterface
	#tag EndHook


	#tag ViewBehavior
		#tag ViewProperty
			Name="Duration"
			Group="Behavior"
			Type="Double"
		#tag EndViewProperty
		#tag ViewProperty
			Name="FailedTestCount"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="IncludeGroup"
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsRunning"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="NotImplementedCount"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="PassedTestCount"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="RunTestCount"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="SkippedTestCount"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="StopTestOnFail"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TestCount"
			Group="Behavior"
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
End Class
#tag EndClass
