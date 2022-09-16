Class {
	#name : #EmptyTileEffect,
	#superclass : #TileEffect,
	#category : #'BoardGame-Tile-Model'
}

{ #category : #'instance creation' }
EmptyTileEffect class >> newEffect [

	^ self new initialize
]

{ #category : #applying }
EmptyTileEffect >> applyEffectOn: aGame beingIn: aPlayerPosition [

	aGame move: aGame currentPlayer to: aPlayerPosition.
]

{ #category : #'private - initialization' }
EmptyTileEffect >> initialize [

	
]

{ #category : #printing }
EmptyTileEffect >> printOn: aStream [

	aStream 
		nextPutAll: 'Empty Tile Effect.'.
		
]
