Class {
	#name : #SpeedUpTileEffect,
	#superclass : #TileEffect,
	#instVars : [
		'numberOfTiles'
	],
	#category : #'BoardGame-Tile-Model'
}

{ #category : #'private - defaults' }
SpeedUpTileEffect class >> defaultAmount [

	^4
]

{ #category : #'instance creation' }
SpeedUpTileEffect class >> newEffect [

	^self new initializeWithNumberOfTiles: self defaultAmount
]

{ #category : #applying }
SpeedUpTileEffect >> applyEffectOn: aGame beingIn: aPlayerPosition [
	
	aGame move: aGame currentPlayer on: aPlayerPosition forward: numberOfTiles
]

{ #category : #'private - initialization' }
SpeedUpTileEffect >> initializeWithNumberOfTiles: aNumberOfTiles [

	numberOfTiles := aNumberOfTiles
]

{ #category : #accessing }
SpeedUpTileEffect >> numberOfTiles [

	^numberOfTiles
]

{ #category : #printing }
SpeedUpTileEffect >> printOn: aStream [

	aStream 
		nextPutAll: 'Speed Up Tile Effect with ';
		print: numberOfTiles;
		nextPutAll: ' tiles to move forward.'
]
