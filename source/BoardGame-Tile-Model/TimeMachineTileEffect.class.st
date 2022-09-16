Class {
	#name : #TimeMachineTileEffect,
	#superclass : #TileEffect,
	#category : #'BoardGame-Tile-Model'
}

{ #category : #'instance creation' }
TimeMachineTileEffect class >> newEffect [

	^ self new initialize
]

{ #category : #applying }
TimeMachineTileEffect >> applyEffectOn: aGame beingIn: aPlayerPosition [

	aGame moveCurrentPlayerToPreviousTurn
]

{ #category : #'private - initialization' }
TimeMachineTileEffect >> initialize [
]

{ #category : #printing }
TimeMachineTileEffect >> printOn: aStream [

	aStream 
		nextPutAll: 'Time Machine Tile Effect.'.

]
