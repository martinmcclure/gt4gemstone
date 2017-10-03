private
todeServerCreationStringWithOptions: withOptions
	| str |
	str := '(GsSession currentSession symbolList 
		objectNamed: #''GtGsBareTopezServer'') 
		  ifNil: [ 
			 "In case gt4gemstone is not installed on the server side do not trigger an error.
			 The client should still work with limited functionality."
			 ^ nil ]
		  ifNotNil: [ :cls |
	       SessionTemps current
		      at: #''Gt4gemstone_Topez_Class_Name'' put: cls name.
	       cls createFor: 1' .
	str := withOptions
		ifTrue: [ str , ' options: #(#transcript) ]' ]
		ifFalse: [ str , ']' ].
	^ str