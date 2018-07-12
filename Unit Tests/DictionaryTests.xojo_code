#tag Class
Protected Class DictionaryTests
Inherits DictionaryTestGroupBase
	#tag Event
		Function ReturnNewDictionary() As M_Dictionary.DictionaryInterface
		  return new NativeDictionary
		End Function
	#tag EndEvent


End Class
#tag EndClass
