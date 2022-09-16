Class {
	#name : #FixedNumberProvider,
	#superclass : #Object,
	#instVars : [
		'index',
		'numbers'
	],
	#category : #'BoardGame-Core-Model'
}

{ #category : #'instance creation' }
FixedNumberProvider class >> workingWith: aFixedNumberCollection [

	^ self new initializeWorkingWith: aFixedNumberCollection
]

{ #category : #'private - initialization' }
FixedNumberProvider >> initializeWorkingWith: aFixedNumberCollection [

	numbers := aFixedNumberCollection.
	index := 1
]

{ #category : #accessing }
FixedNumberProvider >> nextInt: aNumberOfSides [

	|result|
	
	result := numbers at: index.
	index := index + 1.
	
	^result
	
]
