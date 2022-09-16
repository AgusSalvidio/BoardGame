Class {
	#name : #WormholeTileEffect,
	#superclass : #TileEffect,
	#instVars : [
		'numberOfTiles'
	],
	#category : #'BoardGame-Tile-Model'
}

{ #category : #'private - defaults' }
WormholeTileEffect class >> defaultAmount [

	^4
]

{ #category : #'instance creation' }
WormholeTileEffect class >> newEffect [

	^self new initializeWithNumberOfTiles: self defaultAmount
]

{ #category : #applying }
WormholeTileEffect >> applyEffectOn: aGame beingIn: aPlayerPosition [

	| currentPlayer |

	currentPlayer := aGame currentPlayer.
	aGame move: currentPlayer on: aPlayerPosition backwards: numberOfTiles
]

{ #category : #'private - initialization' }
WormholeTileEffect >> initializeWithNumberOfTiles: aNumberOfTiles [

	numberOfTiles := aNumberOfTiles
]

{ #category : #accessing }
WormholeTileEffect >> numberOfTiles [

	^numberOfTiles
]

{ #category : #printing }
WormholeTileEffect >> printOn: aStream [

	aStream 
		nextPutAll: 'Wormhole Tile Effect with ';
		print: numberOfTiles;
		nextPutAll: ' tiles to move backwards.'
]
