#tag Class
Protected Class DictionaryTests
Inherits TestGroup
	#tag Method, Flags = &h0
		Sub ValueTest()
		  dim d as new Dictionary
		  d.Value( 1 ) = 1
		  d.Value( "2" ) = 2
		  d.Value( false ) = 3
		  d.Value( nil ) = 4
		  d.Value( 0.0 ) = 5
		  d.Value( 0 ) = 6
		  d.Value( "" ) = 7
		  
		  dim v as variant
		  
		  v = 1
		  Assert.AreEqual 1, d.Value( v ).IntegerValue
		  
		  v = "2"
		  Assert.AreEqual 2, d.Value( v ).IntegerValue
		  
		  v = false
		  Assert.AreEqual 3, d.Value( v ).IntegerValue
		  
		  v = nil
		  Assert.AreEqual 4, d.Value( v ).IntegerValue
		  
		  v = 0.0
		  Assert.AreEqual 5, d.Value( v ).IntegerValue
		  
		  v = 0
		  Assert.AreEqual 6, d.Value( v ).IntegerValue
		  
		  v = ""
		  Assert.AreEqual 7, d.Value( v ).IntegerValue
		  
		  v = 111
		  Assert.IsFalse d.HasKey( v )
		End Sub
	#tag EndMethod


End Class
#tag EndClass
