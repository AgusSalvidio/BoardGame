Class {
	#name : #PlayerPosition,
	#superclass : #Object,
	#instVars : [
		'lapNumber',
		'tileNumber'
	],
	#category : #'BoardGame-Core-Model'
}

{ #category : #'instance creation' }
PlayerPosition class >> inLap: aLapNumber inTileNumber: aTileNumber [

	^self new initializeInLap: aLapNumber inTileNumber: aTileNumber
]

{ #category : #'instance creation' }
PlayerPosition class >> starting [

	^self new initializeInLap: 0 inTileNumber: 1
]

{ #category : #arithmetic }
PlayerPosition >> + aNumberOfTiles [

	^ self class inLap: self lapNumber  inTileNumber: self tileNumber + aNumberOfTiles.
]

{ #category : #arithmetic }
PlayerPosition >> - aNumberOfTiles [

	^ self + aNumberOfTiles negated
]

{ #category : #'private - comparing' }
PlayerPosition >> = aPlayerPosition [

	^(aPlayerPosition isA: self class) and: [
		self lapNumber = aPlayerPosition lapNumber
			and: [self tileNumber = aPlayerPosition tileNumber]]
]

{ #category : #'private - comparing' }
PlayerPosition >> > aPlayerPosition [

	^(aPlayerPosition isA: PlayerPosition) and: [
		self lapNumber > aPlayerPosition lapNumber
				or: [
					(self lapNumber = aPlayerPosition lapNumber
						and: [self tileNumber > aPlayerPosition tileNumber])]]
]

{ #category : #'private - comparing' }
PlayerPosition >> >= aPlayerPosition [

	^(aPlayerPosition isA: PlayerPosition) and: [
		self lapNumber > aPlayerPosition lapNumber
				or: [
					(self lapNumber = aPlayerPosition lapNumber
						and: [self tileNumber >= aPlayerPosition tileNumber])]]
]

{ #category : #'private - comparing' }
PlayerPosition >> hash [

	^	(self lapNumber hash hashMultiply + self tileNumber hash) hashMultiply
]

{ #category : #'private - initialization' }
PlayerPosition >> initializeInLap: aLapNumber inTileNumber: aTileNumber [

	lapNumber := aLapNumber.
	tileNumber := aTileNumber
]

{ #category : #accessing }
PlayerPosition >> lapNumber [

	^lapNumber
]

{ #category : #arithmetic }
PlayerPosition >> module: aTileNumbered [

	| tileZeroBased |

	tileZeroBased := self tileNumber - 1.

	^self class
		inLap: (self lapNumber + (tileZeroBased // aTileNumbered))
		inTileNumber: (tileZeroBased \\ aTileNumbered) + 1
]

{ #category : #printing }
PlayerPosition >> printOn: aStream [

	aStream
		nextPutAll: 'Player position in tile number ';
		print: self tileNumber;
		nextPutAll: ' and lap number ';
		print: self lapNumber
]

{ #category : #accessing }
PlayerPosition >> tileNumber [

	^tileNumber
]
