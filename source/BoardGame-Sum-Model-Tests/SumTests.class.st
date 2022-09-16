Class {
	#name : #SumTests,
	#superclass : #TestCase,
	#category : #'BoardGame-Sum-Model-Tests'
}

{ #category : #tests }
SumTests >> testCollecting [

	self
		assert:
		(Sum collecting: [ :number | number + 1 ] ofAll: #( 1 2 3 4 )) value
		equals: 14
]

{ #category : #tests }
SumTests >> testInvalidCreation [

	self 
		should: [Sum ofAll: #()]
		raise: InstanceCreationFailed 
		description: 'No se especificó la cantidad mínima de operandos requeridos por una fórmula'
]
