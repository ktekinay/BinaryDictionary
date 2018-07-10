#tag Class
Protected Class BinaryDictionary_MTC
	#tag Method, Flags = &h21
		Private Function HashOf(key As Variant) As UInt64
		  #if not DebugBuild then
		    #pragma BackgroundTasks false
		    #pragma BoundsChecking false
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		  #endif
		  
		  const kMult as UInt64 = 2 ^ 32
		  
		  dim useType as UInt64 = key.Type
		  
		  dim hash as UInt64 = useType * kMult
		  dim keyHash as UInt32 = key.Hash
		  hash = hash or keyHash
		  
		  return hash
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasKey(key As Variant) As Boolean
		  dim isMatch as boolean
		  call IndexOf( HashOf( key ), isMatch )
		  return isMatch
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function IndexOf(keyHash As UInt64, ByRef IsMatch As Boolean) As Integer
		  //
		  // If there is no match, will return the index of the next highest value
		  //
		  
		  #if not DebugBuild then
		    #pragma BackgroundTasks false
		    #pragma BoundsChecking false
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		  #endif
		  
		  dim lowerbound as integer = 0
		  dim upperbound as integer = KeyHashes.Ubound
		  
		  dim result as integer = upperbound + 1 // Next highest
		  
		  do until lowerbound > upperbound
		    dim targetIndex as integer = ( ( upperbound - lowerbound ) \ 2 ) + lowerbound
		    dim targetHash as UInt64 = KeyHashes( targetIndex )
		    
		    if keyHash = targetHash then
		      isMatch = true
		      return targetIndex
		      
		    elseif keyHash < targetHash then
		      result = targetIndex
		      upperbound = targetIndex - 1
		      
		    else
		      lowerbound = targetIndex + 1
		      
		    end if
		  loop
		  
		  isMatch = false
		  return result
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Keys() As Variant()
		  dim result() as variant
		  redim result( mKeys.Ubound )
		  
		  for i as integer = 0 to mKeys.Ubound
		    result( i ) = mKeys( i )
		  next
		  
		  return result
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Lookup(key As Variant, defaultValue As Variant) As Variant
		  dim isMatch as boolean
		  dim index as integer = IndexOf( HashOf( key ), isMatch )
		  if isMatch then
		    return mValues( index )
		  else
		    return defaultValue
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(key As Variant)
		  dim isMatch as boolean
		  dim index as integer = IndexOf( HashOf( key ), isMatch )
		  if not isMatch then
		    raise new KeyNotFoundException
		  end if
		  
		  KeyHashes.Remove index
		  mKeys.Remove index
		  mValues.Remove index
		  mCount = mCount - 1
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Value(key As Variant) As Variant
		  dim isMatch as boolean
		  dim index as integer = IndexOf( HashOf( key ), isMatch )
		  if not isMatch then
		    raise new KeyNotFoundException
		  end if
		  
		  return mValues( index )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Value(key As Variant, Assigns value As Variant)
		  dim isMatch as boolean
		  dim hash as UInt64 = HashOf( key )
		  
		  dim index as integer = IndexOf( hash, isMatch )
		  if isMatch then
		    mValues( index ) = value
		  elseif index > mKeys.Ubound then
		    KeyHashes.Append hash
		    mKeys.Append key
		    mValues.Append value
		    mCount = mCount + 1
		  else
		    KeyHashes.Insert index, hash
		    mKeys.Insert index, key
		    mValues.Insert index, value
		    mCount = mCount + 1
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Values() As Variant()
		  dim result() as variant
		  redim result( mValues.Ubound )
		  
		  for i as integer = 0 to mValues.Ubound
		    result( i ) = mValues( i )
		  next
		  
		  return result
		  
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mCount
			End Get
		#tag EndGetter
		Count As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private KeyHashes() As UInt64
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCount As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mKeys() As Variant
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mValues() As Variant
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
			Name="Count"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
