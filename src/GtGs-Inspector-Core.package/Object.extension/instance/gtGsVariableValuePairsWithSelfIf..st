*GtGs-Inspector-Core
gtGsVariableValuePairsWithSelfIf: aBoolean
  | instVarNames bindings indexedVarsSize |
  instVarNames := self class allInstVarNames.
  indexedVarsSize := self basicSize - instVarNames size.
  bindings := OrderedCollection new: instVarNames size + 1.
  aBoolean
    ifTrue: [ bindings add: 'self' -> self ].
  self gtGsIsGemstone
    ifTrue: [ 
      bindings add: '(oop)' -> self asOop.
      (DependencyList for: self)
        ifNotNil: [ :depList | bindings add: '(dependents)' -> depList ] ].
  instVarNames
    gtGsWithIndexDo: [ :each :index | bindings add: each -> (self instVarAt: index) ].
  1 to: (indexedVarsSize min: 21) do: [ :index | bindings add: index asString -> (self _at: index) ].
  (indexedVarsSize - 20 max: 22) to: indexedVarsSize do: [ :index | bindings add: index asString -> (self _at: index) ].
  ^ bindings