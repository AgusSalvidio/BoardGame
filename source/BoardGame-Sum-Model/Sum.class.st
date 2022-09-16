Class {
	#name : #Sum,
	#superclass : #Object,
	#instVars : [
		'seed',
		'addends',
		'value'
	],
	#category : #'BoardGame-Sum-Model'
}

{ #category : #'instance creation' }
Sum class >> collecting: aMonadycBlock ofAll: objects [
	"Mando asArray para evitar que se pierdan objetos.
	Si viene un set y se hace collect de algo que devuelve measurements,
	los valores que sean iguales se ignoran del resultado.
	-mtabacman"

	^self ofAll: (objects asArray collect: aMonadycBlock)
]

{ #category : #'instance creation' }
Sum class >> ofAll: aCollectionOfArithmeticObjects [ 
	"Si se quiere usar con una colección vacia enviar of: andAll: con el valor por defecto para este caso.
	Generalmente el neutro de la operación involucrada. - gabriel"

	| orderedCollectionOfArithmeticObjects |
	orderedCollectionOfArithmeticObjects := aCollectionOfArithmeticObjects 
				asOrderedCollection.
	^aCollectionOfArithmeticObjects isEmpty 
		ifTrue: 
			[InstanceCreationFailed  
				signal: #'No se especificó la cantidad mínima de operandos requeridos por una fórmula']
		ifFalse: 
			[self seed: orderedCollectionOfArithmeticObjects first
				operands: orderedCollectionOfArithmeticObjects withoutFirst]
]

{ #category : #'instance creation' }
Sum class >> seed: aSeed operands: aCollection [

	^aCollection isEmpty
		ifTrue: [aSeed]
		ifFalse: [self new initializeSeed: aSeed operands: aCollection]
]

{ #category : #evaluating }
Sum >> calculateValue [
	"Es seguro enviar #first porque nunca puede crearse una instancia del receiver sin al menos dos operandos - luciano"

	^self operandsWithoutCopying
		inject: self seed
		into: [:accumulatedValue :operand | self operate: accumulatedValue and: operand]
]

{ #category : #'private - initialization' }
Sum >> initializeSeed: aSeed operands: aCollection [

	seed := aSeed.
	addends := aCollection.
	value := self calculateValue
]

{ #category : #accessing }
Sum >> operands [

	^addends copy
]

{ #category : #accessing }
Sum >> operandsWithoutCopying [

	^addends
]

{ #category : #evaluating }
Sum >> operate: anAccumulatedValue and: anOperand [

	^anAccumulatedValue + anOperand
]

{ #category : #accessing }
Sum >> seed [

	^seed
]

{ #category : #description }
Sum >> typeDescription [

	^#Sumatoria asString
]

{ #category : #evaluating }
Sum >> value [

	^value
]
