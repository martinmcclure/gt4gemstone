*GtGs-Inspector-Core
gtGsInspectorAItemsIn: composite
	<gtInspectorPresentationOrder: 1>
	
	^ composite fastTable
		title: 'Items' ;
		enableLazyLoading;
		display: [ self ];
		iterator: [ GtGsInspectorPluggableCollectionIterator new
			iterationSelector: #associationsDo: ];
		"display: [ | aCollection |
  			aCollection := Array new.
			self associationsDo: [ :assn | aCollection add: assn ].
			aCollection ];"
		"children: [ :anAssociation | 
			(anAssociation value isKindOf:	AbstractDictionary) 
				ifTrue: [ 
					| aCollection |
  					aCollection := Array new.
					anAssociation value  associationsDo: [ :assn | aCollection add: assn ].
					aCollection ] 
				ifFalse: [ #() ] ];"
		column: [ 'Key' ] 
			evaluated: [ :anAssociation | anAssociation key gtGsInspectorName ];
		column: [ 'Value' ]
			evaluated: [ :anAssociation | anAssociation value gtGsInspectorName ];
		send: [ :anAssociation | 
			anAssociation value ]