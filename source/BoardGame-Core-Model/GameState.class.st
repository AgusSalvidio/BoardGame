Class {
	#name : #GameState,
	#superclass : #Object,
	#category : #'BoardGame-Core-Model'
}

{ #category : #'instance creation' }
GameState class >> newGameState [

	^ self subclassResponsibility
]

{ #category : #testing }
GameState >> hasEnded [

	^false
]

{ #category : #testing }
GameState >> isInProgress [

	^ false
]

{ #category : #printing }
GameState >> printOn: aStream [

	^self subclassResponsibility
]

{ #category : #'processing movement' }
GameState >> process: aGame for: aPlayerPosition [

	^self subclassResponsibility
]

{ #category : #updating }
GameState >> update: aGame for: aPlayer beingIn: aPlayerPosition [

	^self subclassResponsibility
]
