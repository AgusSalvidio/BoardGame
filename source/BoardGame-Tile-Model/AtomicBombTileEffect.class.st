Class {
	#name : #AtomicBombTileEffect,
	#superclass : #TileEffect,
	#category : #'BoardGame-Tile-Model'
}

{ #category : #'instance creation' }
AtomicBombTileEffect class >> newEffect [

	^ self new initialize
]

{ #category : #applying }
AtomicBombTileEffect >> applyEffectOn: aGame beingIn: aPlayerPosition [

	| allPlayersExceptCurrentOne currentPlayer |

	currentPlayer := aGame currentPlayer.
	allPlayersExceptCurrentOne := aGame players copyWithout: currentPlayer.
		
	allPlayersExceptCurrentOne
		do: [:aPlayer | |currentLap|
			currentLap := (aGame historicalPlayerPositions at: aPlayer) last lapNumber.
			aGame move: aPlayer to: (PlayerPosition inLap: currentLap inTileNumber: 1)].
			
	aGame move: currentPlayer to: (PlayerPosition inLap: aPlayerPosition lapNumber inTileNumber: 1)
	
]

{ #category : #'private - initialization' }
AtomicBombTileEffect >> initialize [
]

{ #category : #printing }
AtomicBombTileEffect >> printOn: aStream [

	aStream 
		nextPutAll: 'Atomic Bomb Tile Effect.'.

]
