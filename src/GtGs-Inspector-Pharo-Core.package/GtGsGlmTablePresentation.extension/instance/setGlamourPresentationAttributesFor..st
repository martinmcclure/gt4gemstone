*GtGs-Inspector-Pharo-Core
setGlamourPresentationAttributesFor: aPresentation 
	super setGlamourPresentationAttributesFor: aPresentation.
	aPresentation gtGsPresentation: self.

	self columns withIndexDo: [ :aGsColumn :index | 
		aPresentation addColumn: (GLMTableColumn new
			title: aGsColumn titleCache;
			width: aGsColumn width;
			computation: [ :aTableNode | aTableNode columnValues at: index ]) ]
	