Class {
	#name : #InProgressState,
	#superclass : #GameState,
	#category : #'BoardGame-Core-Model'
}

{ #category : #'instance creation' }
InProgressState class >> newGameState [

	^ self new initializeInProgressState
]

{ #category : #'private - initialization' }
InProgressState >> initializeInProgressState [

	
]

{ #category : #testing }
InProgressState >> isInProgress [

	^true
]

{ #category : #printing }
InProgressState >> printOn: aStream [

	aStream 
		nextPutAll: 'In progress Game State'.
]

{ #category : #'processing movement' }
InProgressState >> process: aGame for: aPlayerPosition [

	(aPlayerPosition > aGame gameOverPosition)
	ifTrue:[aGame endGameFor: aGame currentPlayer]
	ifFalse:[aGame applyTileEffectOn: aPlayerPosition ]
]

{ #category : #updating }
InProgressState >> update: aGame for: aPlayer beingIn: aPlayerPosition [

	aPlayerPosition > aGame gameOverPosition
		ifTrue: [aGame endGameFor: aPlayer]
		ifFalse: [aGame add: aPlayerPosition to: aPlayer]
]
