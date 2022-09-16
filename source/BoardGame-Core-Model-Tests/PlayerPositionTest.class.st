Class {
	#name : #PlayerPositionTest,
	#superclass : #TestCase,
	#category : #'BoardGame-Core-Model-Tests'
}

{ #category : #tests }
PlayerPositionTest >> testCreateAPlayerPosition [

	self
		assert: (PlayerPosition inLap: 5 inTileNumber: 10) hash
			equals: (PlayerPosition inLap: 5 inTileNumber: 10) hash
]

{ #category : #tests }
PlayerPositionTest >> testEquals [

	self
		assert: (PlayerPosition inLap: 5 inTileNumber: 10)	= (PlayerPosition inLap: 5 inTileNumber: 10);
		deny: (PlayerPosition inLap: 5 inTileNumber: 10)  = (PlayerPosition inLap: 4 inTileNumber: 10);
		deny: (PlayerPosition inLap: 5 inTileNumber: 10) = (PlayerPosition inLap: 4 inTileNumber: 11)
		
		
		
		
		
]

{ #category : #tests }
PlayerPositionTest >> testGreaterThan [

	self
		assert: (PlayerPosition inLap: 5 inTileNumber: 10)	>= (PlayerPosition inLap: 5 inTileNumber: 5);
		assert: (PlayerPosition inLap: 5 inTileNumber: 10) >= (PlayerPosition inLap: 4 inTileNumber: 10);
		assert: (PlayerPosition inLap: 5 inTileNumber: 1) >= (PlayerPosition inLap: 4 inTileNumber: 10)
		
		
		
]

{ #category : #tests }
PlayerPositionTest >> testHash [

	self
		assert: (PlayerPosition inLap: 5 inTileNumber: 10) hash
			equals: (PlayerPosition inLap: 5 inTileNumber: 10) hash;

		deny: (PlayerPosition inLap: 5 inTileNumber: 10) hash
			equals: (PlayerPosition inLap: 4 inTileNumber: 10) hash;

		deny: (PlayerPosition inLap: 4 inTileNumber: 11) hash
			equals: (PlayerPosition inLap: 5 inTileNumber: 10) hash
]

{ #category : #tests }
PlayerPositionTest >> testModule [

	self
		assert: ((PlayerPosition inLap: 1 inTileNumber: 5) + 3 module: 15)
			equals: (PlayerPosition inLap: 1 inTileNumber: 8);
		assert: ((PlayerPosition inLap: 1 inTileNumber: 10) + 5 module: 15)
			equals: (PlayerPosition inLap: 1 inTileNumber: 15);
		assert: ((PlayerPosition inLap: 1 inTileNumber: 5) + 20 module: 15)
			equals: (PlayerPosition inLap: 2 inTileNumber: 10);
		assert: ((PlayerPosition inLap: 1 inTileNumber: 10) + 20 module: 15)
			equals: (PlayerPosition inLap: 2 inTileNumber: 15);
		assert: ((PlayerPosition inLap: 1 inTileNumber: 10) + 21 module: 15)
			equals: (PlayerPosition inLap: 3 inTileNumber: 1).

	self
		assert: ((PlayerPosition inLap: 1 inTileNumber: 10) - 4 module: 15)
			equals: (PlayerPosition inLap: 1 inTileNumber: 6);
		assert: ((PlayerPosition inLap: 1 inTileNumber: 10) - 9 module: 15)
			equals: (PlayerPosition inLap: 1 inTileNumber: 1);
		assert: ((PlayerPosition inLap: 1 inTileNumber: 10) - 10 module: 15)
			equals: (PlayerPosition inLap: 0 inTileNumber: 15);
		assert: ((PlayerPosition inLap: 1 inTileNumber: 10) - 20 module: 15)
			equals: (PlayerPosition inLap: 0 inTileNumber: 5);
		assert: ((PlayerPosition inLap: 0 inTileNumber: 10) - 21 module: 15)
			equals: (PlayerPosition inLap: -1 inTileNumber: 4)








]

{ #category : #tests }
PlayerPositionTest >> testPrinting [

	| playerPosition |
	playerPosition := PlayerPosition inLap: 5 inTileNumber: 10.

	self
		assert: playerPosition asString
		equals: 'Player position in tile number 10 and lap number 5'
]

{ #category : #tests }
PlayerPositionTest >> testStrictlyGreaterThan [

	self
		assert: (PlayerPosition inLap: 5 inTileNumber: 10)	> (PlayerPosition inLap: 5 inTileNumber: 5);
		assert: (PlayerPosition inLap: 6 inTileNumber: 1) > (PlayerPosition inLap: 4 inTileNumber: 10);
		deny: (PlayerPosition inLap: 5 inTileNumber: 1) > (PlayerPosition inLap: 7 inTileNumber: 10);
		deny: (PlayerPosition inLap: 5 inTileNumber: 1) > (PlayerPosition inLap: 5 inTileNumber: 10);
		deny: (PlayerPosition inLap: 5 inTileNumber: 10) > (PlayerPosition inLap: 5 inTileNumber: 10)
		
		
		
]

{ #category : #tests }
PlayerPositionTest >> testSubstract [

	self
		assert: (PlayerPosition inLap: 1 inTileNumber: 10 ) - 5 equals: (PlayerPosition inLap: 1 inTileNumber: 5);
		assert: (PlayerPosition inLap: 4 inTileNumber: 5) - 15  equals: (PlayerPosition inLap: 4 inTileNumber: -10)
		
		
		
		
		
]

{ #category : #tests }
PlayerPositionTest >> testSum [

	self
		assert: (PlayerPosition inLap: 1 inTileNumber: 4) + 10 equals: (PlayerPosition inLap: 1 inTileNumber: 14);
		assert: (PlayerPosition inLap: -1 inTileNumber: 10) + 5  equals: (PlayerPosition inLap: -1 inTileNumber: 15)
		
		
		
		
		
]
