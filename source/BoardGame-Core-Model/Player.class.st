Class {
	#name : #Player,
	#superclass : #Object,
	#instVars : [
		'name'
	],
	#category : #'BoardGame-Core-Model'
}

{ #category : #'private - asserting' }
Player class >> assertIsValidName: aName [

	AssertionChecker 
		enforce:[aName notEmpty ] 
		because:'The players name cannot be empty.'
		raising: InstanceCreationFailed. 
		
]

{ #category : #'instance creation' }
Player class >> named: aName [

	self assertIsValidName: aName.

	^self new initializeNamed: aName
]

{ #category : #'private - initialization' }
Player >> initializeNamed: aName [

	name := aName
]

{ #category : #accessing }
Player >> name [

	^ name
	
	

]

{ #category : #printing }
Player >> printOn: aStream [

	aStream nextPutAll: self name
]
