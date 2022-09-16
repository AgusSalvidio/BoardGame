Class {
	#name : #EndedState,
	#superclass : #GameState,
	#category : #'BoardGame-Core-Model'
}

{ #category : #'instance creation' }
EndedState class >> newGameState [

	^ self new initializeEndedState
]

{ #category : #testing }
EndedState >> hasEnded [

	^true
]

{ #category : #'private - initialization' }
EndedState >> initializeEndedState [
]

{ #category : #printing }
EndedState >> printOn: aStream [

	aStream 
		nextPutAll: 'Ended Game State'.
]

{ #category : #'processing movement' }
EndedState >> process: aGame for: aPlayerPosition [

	AssertionFailed signal:'The game has ended.'
]

{ #category : #updating }
EndedState >> update: aGame for: aPlayer beingIn: aPlayerPosition [

	AssertionFailed signal:'The game has ended.'
]
