accessing - remote
codeExecutionOopType

	^ className 
		ifNil: [ nil ]
		ifNotNil: [ |classOop|
			classOop := [ :currentClassName | 
			(GsSession currentSession symbolList 
				objectNamed: currentClassName asSymbol) asOop ] 	
					gtGsBarePerformRemotelyOn: self gemstoneClient 
					withArguments: {className}.
			self gemstoneClient session asOopType: classOop ]