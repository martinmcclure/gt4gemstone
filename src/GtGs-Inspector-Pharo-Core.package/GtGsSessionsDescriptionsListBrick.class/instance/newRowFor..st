as yet unclassified
newRowFor: aSessionDescription 

	^ self newRow
		addBrickBack: (self newPageLabel
			textColor: self themer textColor;
			text: (aSessionDescription name));
		addBrickBack: (self newAcceptButtonFor: aSessionDescription);
		when: #onDoubleClicked do: [ self remove. self announce: #createSession event: aSessionDescription ];
		with: [ :aRow | aRow 	
			when: #onMouseHover do: [ self showActionsOf: aRow ];
			when: #onMouseUnhover do: [ self hideActionsOf: aRow ] ];
		yourself