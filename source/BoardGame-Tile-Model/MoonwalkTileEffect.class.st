Class {
	#name : #MoonwalkTileEffect,
	#superclass : #TileEffect,
	#instVars : [
		'numberOfTiles'
	],
	#category : #'BoardGame-Tile-Model'
}

{ #category : #'instance creation' }
MoonwalkTileEffect class >> newEffect [

	^ self newEffectUsing: self randomNumber
]

{ #category : #'instance creation' }
MoonwalkTileEffect class >> newEffectUsing: aNumber [

	^ self new initializeNewEffectUsing: aNumber
]

{ #category : #'private - defaults' }
MoonwalkTileEffect class >> randomNumber [

	^(Random new) nextInteger: 20
]

{ #category : #applying }
MoonwalkTileEffect >> applyEffectOn: aGame beingIn: aPlayerPosition [

	| allPlayersExceptCurrentOne currentPlayer |

	currentPlayer := aGame currentPlayer.
	allPlayersExceptCurrentOne := aGame players copyWithout: currentPlayer.
	
	aGame move: currentPlayer to: aPlayerPosition.
	
	allPlayersExceptCurrentOne
		do: [:selectedPlayer |	aGame move: selectedPlayer on: (aGame currentPlayerPositionOf: selectedPlayer) backwards: numberOfTiles]
]

{ #category : #'private - initialization' }
MoonwalkTileEffect >> initializeNewEffectUsing: aNumberOfTiles [

	numberOfTiles := aNumberOfTiles.

]

{ #category : #accessing }
MoonwalkTileEffect >> numberOfTiles [

	^numberOfTiles
]

{ #category : #printing }
MoonwalkTileEffect >> printOn: aStream [

	aStream 
		nextPutAll: 'Moonwalk Tile Effect with ';
		print: numberOfTiles;
		nextPutAll: ' tiles to move backwards.'

]
