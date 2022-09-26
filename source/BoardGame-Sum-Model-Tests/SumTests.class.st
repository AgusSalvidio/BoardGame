Class {
	#name : #SumTests,
	#superclass : #TestCase,
	#category : #'BoardGame-Sum-Model-Tests'
}

{ #category : #tests }
SumTests >> testCreateASum [

	|sum numberCollection|
	
	numberCollection := #( 1 2 3 4 ).
	
	sum := (Sum collecting: [ :number | number + 1 ] ofAll: numberCollection).

	self
		assert: sum value equals: 14;
		assert: sum typeDescription equals: 'Sumatoria';
		assert: sum operands equals: (OrderedCollection with: 3 with: 4 with: 5)
]

{ #category : #tests }
SumTests >> testInvalidCreation [

	self 
		should: [Sum ofAll: #()]
		raise: InstanceCreationFailed 
		description: 'No se especificó la cantidad mínima de operandos requeridos por una fórmula'
]
