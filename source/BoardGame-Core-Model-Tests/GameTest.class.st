Class {
	#name : #GameTest,
	#superclass : #TestCase,
	#instVars : [
		'oneLap',
		'threelaps',
		'twoPlayers',
		'fourPlayers',
		'dieFixed',
		'diceFixed',
		'boardWithTenTiles',
		'boardWithTwentyTiles'
	],
	#category : #'BoardGame-Core-Model-Tests'
}

{ #category : #'private - asserting' }
GameTest >> assertCurrentLapsOf: aPlayerCollection in: aGame equalsTo: aLapNumberCollection [

	^ self
		  for: aPlayerCollection
		  in: aGame
		  assert: [ :game :player | game currentLapOf: player ]
		  equalsTo: aLapNumberCollection
]

{ #category : #'private - asserting' }
GameTest >> assertCurrentPositionsOf: aPlayerCollection in: aGame equalsTo: aPositionCollection [

	^ self
		  for: aPlayerCollection
		  in: aGame
		  assert: [ :game :player | (game currentPlayerPositionOf: player) tileNumber]
		  equalsTo: aPositionCollection

]

{ #category : #'private - asserting' }
GameTest >> assertCurrentRankingsOf: aPlayerCollection in: aGame equalsTo: aRankingCollection [

	^ self
		  for: aPlayerCollection
		  in: aGame
		  assert: [ :game :player | game currentRankingOf: player ]
		  equalsTo: aRankingCollection
]

{ #category : #'private - asserting' }
GameTest >> for: aPlayerCollection in: aGame assert: aPerformBlock equalsTo: anObjectCollection [

	^ aPlayerCollection
		  with: anObjectCollection
		  do: [ :aPlayer :aPlayerRankingNumber | 
			  self
				  assert: (aPerformBlock value: aGame value: aPlayer)
				  equals: aPlayerRankingNumber ]
]

{ #category : #'private - generating' }
GameTest >> generateBoardOfSize: aSize withTilesEffect: aCollectionOfTileEffects [

	| tilesEffects |

	tilesEffects := self generateEmptyTileEffectCollectionOf: aSize.
	aCollectionOfTileEffects
		do: [:aTileEffect | tilesEffects at: aTileEffect key put: aTileEffect value].
	^tilesEffects
]

{ #category : #'private - generating' }
GameTest >> generateDieOf: aNumberOfSides using: anArrayOfNumbersOfSides [

	^ (Die withSides: aNumberOfSides using: (FixedNumberProvider workingWith: anArrayOfNumbersOfSides ))	
	

]

{ #category : #'private - generating' }
GameTest >> generateEmptyTileEffectCollectionOf: aNumberOfTiles [

	|emptyTileCollection|
	
	emptyTileCollection := OrderedCollection new.	
	1 to: aNumberOfTiles do:[: index | emptyTileCollection add: EmptyTileEffect newEffect ].
	
	^emptyTileCollection
]

{ #category : #'private - running' }
GameTest >> setUp [

	oneLap := 1.

	threelaps := 3.

	twoPlayers := OrderedCollection with: (Player named: 'Juan') with: (Player named: 'Jose').

	fourPlayers :=
		OrderedCollection
			with: (Player named: 'Juan')
			with: (Player named: 'Jose')
			with: (Player named: 'Antonio')
			with: (Player named: 'Rafael').
	
	dieFixed :=
		OrderedCollection
			with: (self generateDieOf: 6 using: #(2 6 5)).

	diceFixed :=
		OrderedCollection
			with: (self generateDieOf: 6 using: #(1 3 2))
			with: (self generateDieOf: 6 using: #(1 1 4)).

	boardWithTenTiles := Board withTiles: (self generateEmptyTileEffectCollectionOf: 10 ).

	boardWithTwentyTiles := Board withTiles: (self generateEmptyTileEffectCollectionOf: 20).

]

{ #category : #tests }
GameTest >> testBeingInFourthPlaceWhenTwoPlayersAreInSecondPlace [

	| game dieFixedFourRolls |
	dieFixedFourRolls := OrderedCollection with: (self generateDieOf: 6 using: #( 2 4 2 6 )).

	game := Game
		        newGameFor: fourPlayers
		        playingWith: dieFixedFourRolls
		        and: boardWithTwentyTiles
		        withNumberOfLapsBeing: threelaps.

	self
		assertCurrentPositionsOf: fourPlayers in: game equalsTo: #( 1 1 1 1 );
		assertCurrentRankingsOf: fourPlayers in: game	equalsTo: #( 1 1 1 1 ).

	game rollDice. "Sale 2"

	self
		assertCurrentPositionsOf: fourPlayers in: game equalsTo: #( 3 1 1 1 );
		assertCurrentRankingsOf: fourPlayers	in: game	equalsTo: #( 1 2 2 2 ).

	game rollDice. "Sale 4"

	self
		assertCurrentPositionsOf: fourPlayers in: game equalsTo: #( 3 5 1 1 );
		assertCurrentRankingsOf: fourPlayers	in: game	equalsTo: #( 2 1 3 3 ).

	game rollDice. "Sale 2"
	self
		assertCurrentPositionsOf: fourPlayers in: game equalsTo: #( 3 5 3 1 );
		assertCurrentRankingsOf: fourPlayers	in: game	equalsTo: #( 2 1 2 4 )
]

{ #category : #tests }
GameTest >> testMovingAPlayerInGame [

	| game |

	game :=
		Game
			newGameFor: twoPlayers
			playingWith: dieFixed
			and: boardWithTenTiles
			withNumberOfLapsBeing: oneLap.

	self assertCurrentPositionsOf: twoPlayers in: game equalsTo: #(1 1).

	game rollDice. "Sale 2"

	self assertCurrentPositionsOf: twoPlayers in: game equalsTo: #(3 1)
]

{ #category : #tests }
GameTest >> testMovingAPlayerWithMoreThanOneDie [

	| game |

	game :=
		Game
			newGameFor: twoPlayers
			playingWith: diceFixed
			and: boardWithTenTiles
			withNumberOfLapsBeing: oneLap.

	self assertCurrentPositionsOf: twoPlayers in: game equalsTo: #(1 1).

	game rollDice. "Sale 2"

	self assertCurrentPositionsOf: twoPlayers in: game equalsTo: #(3 1)
]

{ #category : #tests }
GameTest >> testMovingMoreThanOnePlayerWithMoreThanOneDie [

	| game |

	game :=
		Game
			newGameFor: twoPlayers
			playingWith: diceFixed
			and: boardWithTwentyTiles
			withNumberOfLapsBeing: oneLap.

	self assertCurrentPositionsOf: twoPlayers in: game equalsTo: #(1 1).

	game rollDice. "Sale 2 en total"

	self assertCurrentPositionsOf: twoPlayers in: game equalsTo: #(3 1).

	game rollDice. "Sale 4 en total"

	self assertCurrentPositionsOf: twoPlayers in: game equalsTo: #(3 5).

	game rollDice. "Sale 6 en total"

	self assertCurrentPositionsOf: twoPlayers in: game equalsTo: #(9 5)
]

{ #category : #tests }
GameTest >> testMovingMoreThanOnePlayerWithOneDie [

	| game |

	game :=
		Game
			newGameFor: twoPlayers
			playingWith: dieFixed
			and: boardWithTwentyTiles
			withNumberOfLapsBeing: oneLap.

	self assertCurrentPositionsOf: twoPlayers in: game equalsTo: #(1 1).

	game rollDice. "Sale 2"

	self assertCurrentPositionsOf: twoPlayers in: game equalsTo: #(3 1).

	game rollDice. "Sale 6"

	self assertCurrentPositionsOf: twoPlayers in: game equalsTo: #(3 7).

	game rollDice. "Sale 5"

	self assertCurrentPositionsOf: twoPlayers in: game equalsTo: #(8 7)
]

{ #category : #tests }
GameTest >> testSecondPlayerBecomesFirst [

	| game |

	game :=
		Game
			newGameFor: twoPlayers
			playingWith: dieFixed
			and: boardWithTwentyTiles
			withNumberOfLapsBeing: threelaps.

	self
		assertCurrentPositionsOf: twoPlayers in: game equalsTo: #(1 1);
		assertCurrentRankingsOf: twoPlayers in: game equalsTo: #(1 1).

	game rollDice. "Sale 2"

	self
		assertCurrentPositionsOf: twoPlayers in: game equalsTo: #(3 1);
		assertCurrentRankingsOf: twoPlayers in: game equalsTo: #(1 2).

	game rollDice. "Sale 6"

	self
		assertCurrentPositionsOf: twoPlayers in: game equalsTo: #(3 7);
		assertCurrentRankingsOf: twoPlayers in: game equalsTo: #(2 1)
]

{ #category : #tests }
GameTest >> testWhenAGameIsInitializedWithLessThanTwoPlayersThenRaiseInstanceCreationFailed [

	self
		should: [| playersList |
			playersList :=
				(OrderedCollection with:(Player named: 'Juan')).
			Game
				newGameFor: playersList
				playingWith: diceFixed
				and: boardWithTenTiles
				withNumberOfLapsBeing: threelaps]
		raise: InstanceCreationFailed
		withMessageText: 'Cannot start a game with less than 2 players.'
]

{ #category : #tests }
GameTest >> testWhenAPlayerArrivesToTheEndOfTheBoardExceedingThreeTilesThenEndTheGame [

	| game diceFixedFiveRolls |

	diceFixedFiveRolls :=
		OrderedCollection
			with: (self generateDieOf: 6 using: #(6 2 5 1 4))
			with: (self generateDieOf: 6 using: #(2 5 3 3 2)).

	game :=
		Game
			newGameFor: twoPlayers
			playingWith: diceFixedFiveRolls
			and: boardWithTwentyTiles
			withNumberOfLapsBeing: oneLap.

	self assertCurrentPositionsOf: twoPlayers in: game equalsTo: #(1 1).

	[game isInProgress] whileTrue: [game rollDice].

	self
		assertCurrentPositionsOf: twoPlayers	in: game	equalsTo: #(20 12);
		assertCurrentRankingsOf: twoPlayers in: game equalsTo: #(1 2);
		assert: game winnerOfTheGame equals: twoPlayers first
]

{ #category : #tests }
GameTest >> testWhenAPlayerArrivesToTheLastTileThenNotEndTheGame [

	| game diceFixedToArriveToTheEndOfTheBoard |

	diceFixedToArriveToTheEndOfTheBoard :=
		OrderedCollection
			with: (self generateDieOf: 6 using: #(1 3 3))
			with: (self generateDieOf: 6 using: #(1 1 4)).

	game :=
		Game
			newGameFor: twoPlayers
			playingWith: diceFixedToArriveToTheEndOfTheBoard
			and: boardWithTenTiles
			withNumberOfLapsBeing: oneLap.

	self
		assertCurrentPositionsOf: twoPlayers in: game equalsTo: #(1 1);
		assertCurrentRankingsOf: twoPlayers in: game equalsTo: #(1 1).

	game rollDice. "Sale 2"

	self
		assertCurrentPositionsOf: twoPlayers in: game equalsTo: #(3 1);
		assertCurrentRankingsOf: twoPlayers in: game equalsTo: #(1 2).

	game rollDice. "Sale 4"

	self
		assertCurrentPositionsOf: twoPlayers in: game equalsTo: #(3 5);
		assertCurrentRankingsOf: twoPlayers in: game equalsTo: #(2 1).

	game rollDice. "Sale 7"

	self
		assertCurrentPositionsOf: twoPlayers in: game equalsTo: #(10 5);
		assertCurrentRankingsOf: twoPlayers in: game equalsTo: #(1 2);
		assert: game isInProgress ;
		assert: game winnerOfTheGame equals: (Optional unusedBecause: 'No hay ganador')
]

{ #category : #tests }
GameTest >> testWhenAPlayerLandsOnAMoonwalkTileThenMoveAllPlayersExceptCurrentOneNPositionsBackwards [

	| game die boardWithMoonwalkTileEffect |

	boardWithMoonwalkTileEffect :=
		Board withTiles:
			(self generateBoardOfSize: 6 withTilesEffect: (OrderedCollection with: 3->(MoonwalkTileEffect newEffectUsing: 2))).
	die := OrderedCollection with: (self generateDieOf: 6 using: #(4 3 4 2)).
	game :=
		Game
			newGameFor: fourPlayers
			playingWith: die
			and: boardWithMoonwalkTileEffect
			withNumberOfLapsBeing: oneLap.
			
	self
		assertCurrentPositionsOf: fourPlayers in: game equalsTo: #(1 1 1 1);
		assertCurrentRankingsOf: fourPlayers in: game equalsTo:#(1 1 1 1);
		assertCurrentLapsOf: fourPlayers in: game equalsTo: #(0 0 0 0).
		
	1 to: 3 do: [:index | game rollDice]. "Sale 4, 3, 4"
	self
		assertCurrentPositionsOf: fourPlayers in: game equalsTo: #(5 4 5 1);
		assertCurrentRankingsOf: fourPlayers in: game equalsTo:#(1 3 1 4);
		assertCurrentLapsOf: fourPlayers in: game equalsTo: #(0 0 0 0).
		
	game rollDice. "Sale 2. El 4to jugador cae en Moonwalk tile, el resto de jugadores debe volver para atras 2 lugares"
	self
		assertCurrentPositionsOf: fourPlayers in: game equalsTo: #(3 2 3 3);
		assertCurrentRankingsOf: fourPlayers in: game equalsTo:#(1 4 1 1);
		assertCurrentLapsOf: fourPlayers in: game equalsTo: #(0 0 0 0)
]

{ #category : #tests }
GameTest >> testWhenAPlayerLandsOnAMoonwalkTileThenMoveAllPlayersExceptCurrentOneNPositionsBackwardsSubstractingLaps [

	| game die boardWithMoonwalkTileEffect |

	boardWithMoonwalkTileEffect :=
		Board withTiles:
			(self generateBoardOfSize: 6 withTilesEffect: (OrderedCollection with: 3->(MoonwalkTileEffect newEffectUsing: 2))).
	die := OrderedCollection with: (self generateDieOf: 6 using: #(5 6 6 2)).
	game :=
		Game
			newGameFor: fourPlayers
			playingWith: die
			and: boardWithMoonwalkTileEffect
			withNumberOfLapsBeing: threelaps.
	self
		assertCurrentPositionsOf: fourPlayers in: game equalsTo: #(1 1 1 1);
		assertCurrentRankingsOf: fourPlayers in: game equalsTo:#(1 1 1 1);
		assertCurrentLapsOf: fourPlayers in: game equalsTo: #(0 0 0 0).
		
	1 to: 3 do: [:index | game rollDice]. "Sale 5, 6, 6"
	self
		assertCurrentPositionsOf: fourPlayers in: game equalsTo: #(6 1 1 1);
		assertCurrentRankingsOf: fourPlayers in: game equalsTo:#(3 1 1 4);
		assertCurrentLapsOf: fourPlayers in: game equalsTo: #(0 1 1 0).
		
	game rollDice. "Sale 2. El 4to jugador cae en Moonwalk tile, el resto de jugadores debe volver para atras 2 lugares"
	self
		assertCurrentPositionsOf: fourPlayers in: game equalsTo: #(4 5 5 3);
		assertCurrentRankingsOf: fourPlayers in: game equalsTo:#(3 1 1 4);
		assertCurrentLapsOf: fourPlayers in: game equalsTo: #(0 0 0 0)
]

{ #category : #tests }
GameTest >> testWhenAPlayerLandsOnASpeedUpTileAndThePlayerIsInANegativeLapThenMovePlayerFourPositionsForwardAddingALap [

| game die boardWithASpeedUpTileEffect |

	boardWithASpeedUpTileEffect :=
		Board withTiles: (self generateBoardOfSize: 5 withTilesEffect: (OrderedCollection with: 3->WormholeTileEffect newEffect with: 5->SpeedUpTileEffect newEffect)).
	die := OrderedCollection with: (self generateDieOf: 6 using: #(2 3 1)).
	game :=
		Game
			newGameFor: twoPlayers
			playingWith: die
			and: boardWithASpeedUpTileEffect
			withNumberOfLapsBeing: threelaps.
	self 
		assertCurrentPositionsOf: twoPlayers in: game equalsTo: #(1 1);
		assertCurrentRankingsOf: twoPlayers in: game equalsTo:#(1 1);
		assertCurrentLapsOf: twoPlayers in: game equalsTo: #(0 0).
		
	game rollDice. "Sale 2"
	self 
		assertCurrentPositionsOf: twoPlayers in: game equalsTo: #(4 1);
		assertCurrentRankingsOf: twoPlayers in: game equalsTo:#(2 1);
		assertCurrentLapsOf: twoPlayers in: game equalsTo: #(-1 0).
		
	game rollDice. "Sale 3"
	self
		assertCurrentPositionsOf: twoPlayers in: game equalsTo: #(4 4);
		assertCurrentRankingsOf: twoPlayers in: game equalsTo:#(2 1);
		assertCurrentLapsOf: twoPlayers in: game equalsTo: #(-1 0).
		
	game rollDice. "Sale 1. Caigo en el 5, donde esta el SpeedUp, avanzo 4 posiciones"
	self
		assertCurrentPositionsOf: twoPlayers in: game equalsTo: #(4 4);
		assertCurrentRankingsOf: twoPlayers in: game equalsTo:#(1 1);
		assertCurrentLapsOf: twoPlayers in: game equalsTo: #(0 0).
]

{ #category : #tests }
GameTest >> testWhenAPlayerLandsOnASpeedUpTileAndThePlayerIsInANegativeLapThenMovePlayerFourPositionsForwardWithoutAddingALap [

| game die boardWithASpeedUpTileEffect tilesEffect|

	tilesEffect := (OrderedCollection 
		with: 2->WormholeTileEffect newEffect 
		with: 9->WormholeTileEffect newEffect 
		with: 5->SpeedUpTileEffect newEffect
		with: 7->SpeedUpTileEffect newEffect).
	
	boardWithASpeedUpTileEffect :=
		Board withTiles: (self generateBoardOfSize: 10 withTilesEffect: tilesEffect ).
	die := OrderedCollection with: (self generateDieOf: 6 using: #(1 3 1 2 2)).
	game :=
		Game
			newGameFor: twoPlayers
			playingWith: die
			and: boardWithASpeedUpTileEffect
			withNumberOfLapsBeing: threelaps.
	self 
		assertCurrentPositionsOf: twoPlayers in: game equalsTo: #(1 1);
		assertCurrentRankingsOf: twoPlayers in: game equalsTo:#(1 1);
		assertCurrentLapsOf: twoPlayers in: game equalsTo: #(0 0).
	
	game rollDice. "Sale 1"
	
	self 
		assertCurrentPositionsOf: twoPlayers in: game equalsTo: #(8 1);
		assertCurrentLapsOf: twoPlayers in: game equalsTo: #(-1 0).
	
	game rollDice. "Sale 3"
	
	self
		assertCurrentPositionsOf: twoPlayers in: game equalsTo: #(8 4);
		assertCurrentRankingsOf: twoPlayers in: game equalsTo:#(2 1);
		assertCurrentLapsOf: twoPlayers in: game equalsTo: #(-1 0).
		
	game rollDice. "Sale 1. Caigo en el 9, donde esta el otro Wormhole retrocedo 4 posiciones"
	
	self
		assertCurrentPositionsOf: twoPlayers in: game equalsTo: #(5 4);
		assertCurrentRankingsOf: twoPlayers in: game equalsTo:#(2 1);
		assertCurrentLapsOf: twoPlayers in: game equalsTo: #(-1 0).
	
	game rollDice. "Sale 2."
	
	self
		assertCurrentPositionsOf: twoPlayers in: game equalsTo: #(5 6);
		assertCurrentRankingsOf: twoPlayers in: game equalsTo:#(2 1);
		assertCurrentLapsOf: twoPlayers in: game equalsTo: #(-1 0).
		
	game rollDice. "Sale 2. Caigo en el SpeedUp avanzo 4 posiciones"
	
	self
		assertCurrentPositionsOf: twoPlayers in: game equalsTo: #(1 6);
		assertCurrentRankingsOf: twoPlayers in: game equalsTo:#(2 1);
		assertCurrentLapsOf: twoPlayers in: game equalsTo: #(0 0).	
]

{ #category : #tests }
GameTest >> testWhenAPlayerLandsOnASpeedUpTileThenMovePlayerFourPositionsForward [

	| game die boardWithASpeedUpTileEffect |

	boardWithASpeedUpTileEffect :=
		Board withTiles: (self generateBoardOfSize: 5 withTilesEffect: (OrderedCollection with: 4->SpeedUpTileEffect newEffect)).
	die := OrderedCollection with: (self generateDieOf: 6 using: #(2 3)).
	game :=
		Game
			newGameFor: twoPlayers
			playingWith: die
			and: boardWithASpeedUpTileEffect
			withNumberOfLapsBeing: threelaps.
			
	self 
		assertCurrentPositionsOf: twoPlayers in: game equalsTo: #(1 1);
		assertCurrentRankingsOf: twoPlayers in: game equalsTo:#(1 1);
		assertCurrentLapsOf: twoPlayers in: game equalsTo: #(0 0).
		
	game rollDice. "Sale 2"
	
	self 
		assertCurrentPositionsOf: twoPlayers in: game equalsTo: #(3 1);
		assertCurrentRankingsOf: twoPlayers in: game equalsTo:#(1 2);
		assertCurrentLapsOf: twoPlayers in: game equalsTo: #(0 0).
		
	game rollDice. "Sale 3, cae en el Tile con el SpeedUp, entonces se desplaza 4 casilleros"
	self
		assertCurrentPositionsOf: twoPlayers in: game equalsTo: #(3 3);
		assertCurrentRankingsOf: twoPlayers in: game equalsTo:#(2 1);
		assertCurrentLapsOf: twoPlayers in: game equalsTo: #(0 1)
]

{ #category : #tests }
GameTest >> testWhenAPlayerLandsOnATimeMachineTileEffectAndThereAreNotAnyPreviousTurnsThenMovePlayerBackToTheStartOfTheBoard [

	| game die boardWithTimeMachineTileEffect |

	boardWithTimeMachineTileEffect :=
		Board
			withTiles: (self generateBoardOfSize: 5 withTilesEffect: (OrderedCollection with: 3->TimeMachineTileEffect newEffect)).
	die := OrderedCollection with: (self generateDieOf: 6 using: #(3 2)).
	game :=
		Game
			newGameFor: twoPlayers
			playingWith: die
			and: boardWithTimeMachineTileEffect
			withNumberOfLapsBeing: threelaps.
			
	self 
		assertCurrentPositionsOf: twoPlayers in: game equalsTo: #(1 1);
		assertCurrentRankingsOf: twoPlayers in: game equalsTo:#(1 1);
		assertCurrentLapsOf: twoPlayers in: game equalsTo: #(0 0).
	
	game rollDice. "Sale 3"
	self 
		assertCurrentPositionsOf: twoPlayers in: game equalsTo: #(4 1);
		assertCurrentRankingsOf: twoPlayers in: game equalsTo:#(1 2);
		assertCurrentLapsOf: twoPlayers in: game equalsTo: #(0 0).
	
	game rollDice. "Sale 2, cae en un TimeMachine, entonces al no tener turno previo, vuelve al inicio del tablero."
	self 
		assertCurrentPositionsOf: twoPlayers in: game equalsTo: #(4 1);
		assertCurrentRankingsOf: twoPlayers in: game equalsTo:#(1 2);
		assertCurrentLapsOf: twoPlayers in: game equalsTo: #(0 0).
]

{ #category : #tests }
GameTest >> testWhenAPlayerLandsOnATimeMachineTileEffectThenMovePlayerBackToThePreviousTurnPosition [

	| game die boardWithTimeMachineTileEffect |

	boardWithTimeMachineTileEffect :=
		Board
			withTiles: (self generateBoardOfSize: 6 withTilesEffect:(OrderedCollection with: 5->TimeMachineTileEffect newEffect)).
	die := OrderedCollection with: (self generateDieOf: 6 using: #(2 3 2)).
	game :=
		Game
			newGameFor: twoPlayers
			playingWith: die
			and: boardWithTimeMachineTileEffect
			withNumberOfLapsBeing: threelaps.
			
	self 
		assertCurrentPositionsOf: twoPlayers in: game equalsTo: #(1 1);
		assertCurrentRankingsOf: twoPlayers in: game equalsTo:#(1 1);
		assertCurrentLapsOf: twoPlayers in: game equalsTo: #(0 0).
		
	game rollDice. "Sale 2"
	self 
		assertCurrentPositionsOf: twoPlayers in: game equalsTo: #(3 1);
		assertCurrentRankingsOf: twoPlayers in: game equalsTo:#(1 2);
		assertCurrentLapsOf: twoPlayers in: game equalsTo: #(0 0).
		
	game rollDice. "Sale 3"
	self
		assertCurrentPositionsOf: twoPlayers in: game equalsTo: #(3 4);
		assertCurrentRankingsOf: twoPlayers in: game equalsTo:#(2 1);
		assertCurrentLapsOf: twoPlayers in: game equalsTo: #(0 0).
		
	game rollDice. "Sale 2, caes en el TimeMachine, vuelve al turno anterior."
	self
		assertCurrentPositionsOf: twoPlayers in: game equalsTo: #(1 4);
		assertCurrentRankingsOf: twoPlayers in: game equalsTo:#(2 1);
		assertCurrentLapsOf: twoPlayers in: game equalsTo: #(0 0)
]

{ #category : #tests }
GameTest >> testWhenAPlayerLandsOnAWormholeTileNearTheStartOfTheBoardOnTheFirstLapThenMovePlayerFourPositionsBackwardsResultingInANegativeLap [

	| game die boardWithWormholeTileEffect |

	boardWithWormholeTileEffect :=
		Board withTiles: (self generateBoardOfSize: 6 withTilesEffect: (OrderedCollection with: 3->WormholeTileEffect newEffect)).
	die := OrderedCollection with: (self generateDieOf: 6 using: #(2 4)).
	game :=
		Game
			newGameFor: twoPlayers
			playingWith: die
			and: boardWithWormholeTileEffect
			withNumberOfLapsBeing: threelaps.
			
	self 
		assertCurrentPositionsOf: twoPlayers in: game equalsTo: #(1 1);
		assertCurrentRankingsOf: twoPlayers in: game equalsTo:#(1 1);
		assertCurrentLapsOf: twoPlayers in: game equalsTo: #(0 0).
	
	game rollDice. "Sale 2"
	self
		assertCurrentPositionsOf: twoPlayers in: game equalsTo: #(5 1);
		assertCurrentRankingsOf: twoPlayers in: game equalsTo:#(2 1);
		assertCurrentLapsOf: twoPlayers in: game equalsTo: #(-1 0)
]

{ #category : #tests }
GameTest >> testWhenAPlayerLandsOnAWormholeTileNearTheStartOfTheBoardThenMovePlayerFourPositionsBackwardsSubstractingALap [

	| game die boardWithWormholeTileEffect |

	boardWithWormholeTileEffect :=
		Board withTiles: (self generateBoardOfSize: 6 withTilesEffect: (OrderedCollection with: 3->WormholeTileEffect newEffect)).
	die := OrderedCollection with: (self generateDieOf: 6 using: #(3 4 4 3 1)).
	game :=
		Game
			newGameFor: twoPlayers
			playingWith: die
			and: boardWithWormholeTileEffect
			withNumberOfLapsBeing: threelaps.
			
	self 
		assertCurrentPositionsOf: twoPlayers in: game equalsTo: #(1 1);
		assertCurrentRankingsOf: twoPlayers in: game equalsTo:#(1 1);
		assertCurrentLapsOf: twoPlayers in: game equalsTo: #(0 0).
	
	1 to: 3 do: [:index | game rollDice]. "Sale 3, 4, 4"
	self
		assertCurrentPositionsOf: twoPlayers in: game equalsTo: #(2 5);
		assertCurrentRankingsOf: twoPlayers in: game equalsTo:#(1 2);
		assertCurrentLapsOf: twoPlayers in: game equalsTo: #(1 0).
		
	game rollDice. "Sale 3"
	self
		assertCurrentPositionsOf: twoPlayers in: game equalsTo: #(2 2);
		assertCurrentRankingsOf: twoPlayers in: game equalsTo:#(1 1);
		assertCurrentLapsOf: twoPlayers in: game equalsTo: #(1 1).
		
	game rollDice. "Sale 1"
	self
		assertCurrentPositionsOf: twoPlayers in: game equalsTo: #(5 2);
		assertCurrentRankingsOf: twoPlayers in: game equalsTo:#(2 1);
		assertCurrentLapsOf: twoPlayers in: game equalsTo: #(0 1)
]

{ #category : #tests }
GameTest >> testWhenAPlayerLandsOnAWormholeTileThenMovePlayerFourPositionsBackwardsWithoutSubstractingALap [

	| game die boardWithWormholeTileEffect |

	boardWithWormholeTileEffect :=
		Board withTiles: (self generateBoardOfSize: 6 withTilesEffect:(OrderedCollection with: 5->WormholeTileEffect newEffect)).
	die := OrderedCollection with: (self generateDieOf: 6 using: #(2 4)).
	game :=
		Game
			newGameFor: twoPlayers
			playingWith: die
			and: boardWithWormholeTileEffect
			withNumberOfLapsBeing: threelaps.
			
	self 
		assertCurrentPositionsOf: twoPlayers in: game equalsTo: #(1 1);
		assertCurrentRankingsOf: twoPlayers in: game equalsTo:#(1 1);
		assertCurrentLapsOf: twoPlayers in: game equalsTo: #(0 0).
	
	game rollDice. "Sale 2"
	self 
		assertCurrentPositionsOf: twoPlayers in: game equalsTo: #(3 1);
		assertCurrentRankingsOf: twoPlayers in: game equalsTo:#(1 2);
		assertCurrentLapsOf: twoPlayers in: game equalsTo: #(0 0).
	
	game rollDice. "Sale 4, cae en el Tile con el Wormhole, entonces se desplaza 4 casilleros hacia atras"
	self
		assertCurrentPositionsOf: twoPlayers in: game equalsTo: #(3 1);
		assertCurrentRankingsOf: twoPlayers in: game equalsTo:#(1 2);
		assertCurrentLapsOf: twoPlayers in: game equalsTo: #(0 0)
]

{ #category : #tests }
GameTest >> testWhenAPlayerLandsOnAnAtomicBombTileAndAllPlayersAreInDifferentLapsThenMoveAllToFirstPositionOfTheBoard [

	| game die boardWithAtomicBombInTileNumberFour |

	boardWithAtomicBombInTileNumberFour :=
		Board
			withTiles: (self generateBoardOfSize: 5 withTilesEffect: (OrderedCollection with: 4->AtomicBombTileEffect newEffect)).
	die := OrderedCollection with: (self generateDieOf: 6 using: #(2 5 4 6 1)).
	game :=
		Game
			newGameFor: fourPlayers
			playingWith: die
			and: boardWithAtomicBombInTileNumberFour
			withNumberOfLapsBeing: threelaps.
	self
		assertCurrentPositionsOf: fourPlayers in: game equalsTo: #(1 1 1 1);
		assertCurrentRankingsOf: fourPlayers in: game equalsTo:#(1 1 1 1);
		assertCurrentLapsOf: fourPlayers in: game equalsTo: #(0 0 0 0).
		
	1 to: 4 do: [:index | game rollDice]. "Sale 2 , 5 , 4 , 6"
	self
		assertCurrentPositionsOf: fourPlayers in: game equalsTo: #(3 1 5 2);
		assertCurrentRankingsOf: fourPlayers in: game equalsTo:#(4 2 3 1);
		assertCurrentLapsOf: fourPlayers in: game equalsTo: #(0 1 0 1).
		
	game rollDice. "Sale un 1, al querer ir a la casilla 4, como en la misma esta el efecto Atomic Bomb. Todos vuelven al origen del tablero."
	self
		assertCurrentPositionsOf: fourPlayers in: game equalsTo: #(1 1 1 1);
		assertCurrentRankingsOf: fourPlayers in: game equalsTo: #(3 1 3 1);
		assertCurrentLapsOf: fourPlayers in: game equalsTo: #(0 1 0 1)
]

{ #category : #tests }
GameTest >> testWhenAPlayerLandsOnAnAtomicBombTileAndAllPlayersAreInTheSameLapThenAllPlayersAreMovedToTheFirstTileOfThatLap [

	| game die boardWithAtomicBombInTileNumberFour |

	boardWithAtomicBombInTileNumberFour :=
		Board
			withTiles: (self generateBoardOfSize: 6 withTilesEffect: (OrderedCollection with: 4->AtomicBombTileEffect newEffect)).
	
	die := OrderedCollection with: (self generateDieOf: 6 using: #(2 1 5 4 1)).
	game :=
		Game
			newGameFor: fourPlayers
			playingWith: die
			and: boardWithAtomicBombInTileNumberFour
			withNumberOfLapsBeing: threelaps.
	self
		assertCurrentPositionsOf: fourPlayers in: game equalsTo: #(1 1 1 1);
		assertCurrentRankingsOf: fourPlayers in: game equalsTo:#(1 1 1 1);
		assertCurrentLapsOf: fourPlayers in: game equalsTo: #(0 0 0 0).
		
	1 to: 4 do: [:index | game rollDice]. "Sale 2 , 1 , 5 , 4"
	self
		assertCurrentPositionsOf: fourPlayers in: game equalsTo: #(3 2 6 5);
		assertCurrentRankingsOf: fourPlayers in: game equalsTo:#(3 4 1 2);
		assertCurrentLapsOf: fourPlayers in: game equalsTo: #(0 0 0 0).
		
	game rollDice. "Sale un 1, al querer ir a la casilla 4, como en la misma esta el efecto Atomic Bomb. Todos vuelven al origen del tablero."
	self
		assertCurrentPositionsOf: fourPlayers in: game equalsTo: #(1 1 1 1);
		assertCurrentRankingsOf: fourPlayers in: game equalsTo: #(1 1 1 1);
		assertCurrentLapsOf: fourPlayers in: game equalsTo: #(0 0 0 0)
]

{ #category : #tests }
GameTest >> testWhenAPlayerLandsOnAnEmptyTileEffectThenContinueWithNextTurnBecauseItDoesntHaveAnyEffect [

	| game die boardWithEmptyTiles |

	boardWithEmptyTiles := Board withTiles: (self generateEmptyTileEffectCollectionOf: 5).
	die := OrderedCollection with: (self generateDieOf: 6 using: #(2 3)).

	game :=
		Game
			newGameFor: twoPlayers
			playingWith: die
			and: boardWithEmptyTiles
			withNumberOfLapsBeing: threelaps.

	self 
		assertCurrentPositionsOf: twoPlayers in: game equalsTo: #(1 1);
		assertCurrentRankingsOf: twoPlayers in: game equalsTo:#(1 1);
		assertCurrentLapsOf: twoPlayers in: game equalsTo: #(0 0).

	game rollDice. "Sale 2"

	self 
		assertCurrentPositionsOf: twoPlayers in: game equalsTo: #(3 1);
		assertCurrentRankingsOf: twoPlayers in: game equalsTo:#(1 2);
		assertCurrentLapsOf: twoPlayers in: game equalsTo: #(0 0).

	game rollDice. "Sale un 3"

	self 
		assertCurrentPositionsOf: twoPlayers in: game equalsTo: #(3 4);
		assertCurrentRankingsOf: twoPlayers in: game equalsTo:#(2 1);
		assertCurrentLapsOf: twoPlayers in: game equalsTo: #(0 0)
]

{ #category : #tests }
GameTest >> testWhenAPlayerWinsTheGameAndAnotherPlayerTriesToRollDiceThenRaiseAssertionFailedException [

	| game diceFixedFiveRolls |

	diceFixedFiveRolls :=
		OrderedCollection
			with: (self generateDieOf: 6 using: #(6 2 5 1 4))
			with: (self generateDieOf: 6 using: #(2 5 3 3 2)).

	game :=
		Game
			newGameFor: twoPlayers
			playingWith: diceFixedFiveRolls
			and: boardWithTwentyTiles
			withNumberOfLapsBeing: oneLap.

	self 
		assertCurrentPositionsOf: twoPlayers in: game equalsTo: #(1 1);
		assertCurrentRankingsOf: twoPlayers in: game equalsTo:#(1 1);
		assertCurrentLapsOf: twoPlayers in: game equalsTo: #(0 0).

	[game isInProgress] whileTrue: [game rollDice].

	self
		assertCurrentPositionsOf: twoPlayers	in: game equalsTo: #(20 12);
		assertCurrentRankingsOf: twoPlayers in: game equalsTo: #(1 2);
		assertCurrentLapsOf: twoPlayers in: game equalsTo: #(0 0);
		assert: game hasEnded;
		assert: game winnerOfTheGame equals: twoPlayers first;
		should: [game rollDice]
			raise: AssertionFailed
			withMessageText: 'Cannot roll dice because the game is over.'
]
