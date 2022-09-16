Class {
	#name : #Die,
	#superclass : #Object,
	#instVars : [
		'sides',
		'numberProvider'
	],
	#category : #'BoardGame-Core-Model'
}

{ #category : #'private - defaults' }
Die class >> defaultNumberProvider [

	^Random new
]

{ #category : #'private - asserting' }
Die class >> validateSides: aNumberOfSides [

	AssertionChecker 
		enforce:[ aNumberOfSides >= 2] 
		because:'The die cannot be created with less than 2 sides.'
		raising: InstanceCreationFailed.


]

{ #category : #'instance creation' }
Die class >> withSides: aNumberOfSides [

	^self  withSides: aNumberOfSides using: self defaultNumberProvider
]

{ #category : #'instance creation' }
Die class >> withSides: aNumberOfSides using: aNumberProvider [

	self validateSides: aNumberOfSides.

	^self new initializeWithSides: aNumberOfSides withProvider: aNumberProvider
]

{ #category : #'private - initialization' }
Die >> initializeWithSides: aNumberOfSides withProvider: aNumberProvider [

	sides := aNumberOfSides.
	numberProvider := aNumberProvider
]

{ #category : #printing }
Die >> printOn: aStream [

	aStream 
		nextPutAll: 'Die of ';
		print: sides;
		nextPutAll: ' sides.'
]

{ #category : #'rolling dice' }
Die >> roll [

	^ numberProvider nextInt: self sides
]

{ #category : #'private - accessing' }
Die >> sides [

	^ sides
]
