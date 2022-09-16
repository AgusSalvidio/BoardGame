Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'historicalPlayerPositions',
		'board',
		'state',
		'playersTurn',
		'winnerOfTheGameOptional',
		'gameOverPosition',
		'laps',
		'players',
		'dice',
		'playersRanking'
	],
	#category : #'BoardGame-Core-Model'
}

{ #category : #'instance creation' }
Game class >> newGameFor: aListOfPlayers playingWith: aListOfDice and: aBoard withNumberOfLapsBeing: aNumberOfLaps [

	self validatePlayers: aListOfPlayers.
	
	^self new
		initializeNewGameFor: aListOfPlayers
		playingWith: aListOfDice
		and: aBoard
		withNumbersOfLapsBeing: aNumberOfLaps
]

{ #category : #'private - asserting' }
Game class >> validatePlayers: aListOfPlayers [

	AssertionChecker 
		enforce:[aListOfPlayers size >1] 
		because:'Cannot start a game with less than 2 players.'
		raising: InstanceCreationFailed.
		
]

{ #category : #'private - updating' }
Game >> add: aPlayerPosition to: aPlayer [

	(historicalPlayerPositions at: aPlayer)
		add: aPlayerPosition.
]

{ #category : #'private - applying' }
Game >> applyTileEffectOn: aPlayerPosition [

	| tileEffect |

	tileEffect := board tileNumbered: aPlayerPosition tileNumber.
	tileEffect applyEffectOn: self beingIn: aPlayerPosition
]

{ #category : #'private - state transitions' }
Game >> asEnded [

	state := EndedState newGameState.
]

{ #category : #calculating }
Game >> calculatePreviousTurnPositionWith: historicalCurrentPlayerPositions [

	| previousTurnNumber previousTurnPosition |

	previousTurnNumber := (historicalCurrentPlayerPositions size) - 1.

	(previousTurnNumber <= 0)
		ifTrue: [
			previousTurnPosition := PlayerPosition starting.
			historicalCurrentPlayerPositions removeAll]
		ifFalse: [
			previousTurnPosition := historicalCurrentPlayerPositions at: previousTurnNumber.
			1 to: 2 do: [:index | historicalCurrentPlayerPositions removeLast]].

	^previousTurnPosition
]

{ #category : #accessing }
Game >> currentLapOf: aPlayer [

	^ (historicalPlayerPositions at: aPlayer) last lapNumber
]

{ #category : #accessing }
Game >> currentPlayer [

	^playersTurn current
]

{ #category : #accessing }
Game >> currentPlayerPositionOf: aPlayer [

	^(historicalPlayerPositions at: aPlayer) last
]

{ #category : #'private - updating' }
Game >> currentPositionOfPlayers [

	| currentPositionByPlayer |

	currentPositionByPlayer := Dictionary new.
	historicalPlayerPositions keysAndValuesDo: [:aPlayer :positions |
		currentPositionByPlayer at: aPlayer put: positions last].

	^self sortCurrentPositionOfPlayers: currentPositionByPlayer
]

{ #category : #accessing }
Game >> currentRankingOf: aPlayer [

	^ self playersRanking at: aPlayer

]

{ #category : #'private - state transitions' }
Game >> endGameFor: aPlayer [ 

	self asEnded.
	winnerOfTheGameOptional := aPlayer.
	self add: gameOverPosition to: aPlayer
]

{ #category : #'private - accessing' }
Game >> finishTileNumber [

	^board finishTileNumber
]

{ #category : #'private - accessing' }
Game >> gameOverPosition [

	^gameOverPosition
]

{ #category : #testing }
Game >> hasEnded [

	^state hasEnded
]

{ #category : #'private - accessing' }
Game >> historicalPlayerPositions [

	^ historicalPlayerPositions 
]

{ #category : #'private - initialization' }
Game >> initializeGameStatus [


	gameOverPosition := PlayerPosition inLap: laps - 1  inTileNumber: self finishTileNumber.
	state := InProgressState newGameState.
	winnerOfTheGameOptional := Optional unusedBecause: 'No hay ganador'.
]

{ #category : #'private - initialization' }
Game >> initializeGameTurn [

	playersTurn := CircularIterator cyclingOver: players.
]

{ #category : #'private - initialization' }
Game >> initializeHistoricalPlayerPositions [

	historicalPlayerPositions :=
		players
			inject: Dictionary new
			into: [:historyByPlayer :aPlayer |
				historyByPlayer	at: aPlayer	put: (OrderedCollection with: (PlayerPosition starting));
				yourself]
]

{ #category : #'private - initialization' }
Game >> initializeNewGameFor: aListOfPlayers
	playingWith: aListOfDice
	and: aBoard
	withNumbersOfLapsBeing: aNumberOfLaps [
	
	laps := aNumberOfLaps.
	players := aListOfPlayers.
	dice := aListOfDice.
	board := aBoard.
	
	self 
		initializeHistoricalPlayerPositions;
		initializePlayersRanking;
		initializeGameTurn;
		initializeGameStatus.
	
	
	
	
]

{ #category : #'private - initialization' }
Game >> initializePlayersRanking [

	playersRanking := 
		players
			inject: Dictionary new
			into: [:playerRanking :aPlayer | 
				playerRanking at: aPlayer put: 1;
				yourself].
]

{ #category : #testing }
Game >> isInProgress [

	^ state isInProgress
]

{ #category : #'private - moving player' }
Game >> move: aPlayer on: aPlayerPosition backwards: aNumberOfTiles [

	self move: aPlayer on: aPlayerPosition forward: aNumberOfTiles negated
]

{ #category : #'private - moving player' }
Game >> move: aPlayer on: aPlayerPosition forward: aNumberOfTiles [

	self move: aPlayer to: aPlayerPosition + aNumberOfTiles
]

{ #category : #'private - moving player' }
Game >> move: aPlayer to: aPlayerPosition [

	state update: self for: aPlayer beingIn: (self normalize: aPlayerPosition)
]

{ #category : #'private - moving player' }
Game >> moveCurrentPlayerToPreviousTurn [

	| currentPlayer historicalCurrentPlayerPositions |

	currentPlayer := self currentPlayer.
	historicalCurrentPlayerPositions := (historicalPlayerPositions at: currentPlayer).

	self move: currentPlayer to: (self calculatePreviousTurnPositionWith: historicalCurrentPlayerPositions)
]

{ #category : #'private - turn' }
Game >> nextTurn [

	playersTurn next
]

{ #category : #calculating }
Game >> normalize: aPlayerPosition [

	^aPlayerPosition module: self finishTileNumber
]

{ #category : #accessing }
Game >> players [

	^ players
]

{ #category : #'private - accessing' }
Game >> playersRanking [

	^playersRanking
]

{ #category : #'roll dice' }
Game >> rollDice [

	| anAmountOfMovements normalizedPlayerPosition currentPlayer|

	self validateGameIsNotOver.
	
	currentPlayer := self currentPlayer.
	anAmountOfMovements := (Sum collecting: #roll ofAll: dice) value.
	normalizedPlayerPosition := self normalize: (self currentPlayerPositionOf: currentPlayer)+ anAmountOfMovements.

	state process: self for: normalizedPlayerPosition.
	
	self
		updateRanking;
		nextTurn
]

{ #category : #'private - updating' }
Game >> sortCurrentPositionOfPlayers: aCurrentPositionByPlayer [

	| groupedCurrentPositionByPlayer |


	groupedCurrentPositionByPlayer :=
		((aCurrentPositionByPlayer associations sorted: (DescendingSortingCriterion sending: #value))
			groupedBy: #value)
				values.

	^ groupedCurrentPositionByPlayer sort: [:aCollectionOfAssociations :anotherCollectionOfAssociations |
		aCollectionOfAssociations first value >= anotherCollectionOfAssociations first value]
]

{ #category : #'private - updating' }
Game >> updateRanking [

	| rankingPosition |

	rankingPosition := 1.

	self currentPositionOfPlayers do: [:aCollectionOfAssociations |

		aCollectionOfAssociations value do: [:anotherAssociation |
			playersRanking at: anotherAssociation key put: rankingPosition].

		rankingPosition := rankingPosition + aCollectionOfAssociations size]
]

{ #category : #'private - asserting' }
Game >> validateGameIsNotOver [

	AssertionChecker
		enforce: [state isInProgress]
		because: 'Cannot roll dice because the game is over.'
		raising: AssertionFailed
]

{ #category : #accessing }
Game >> winnerOfTheGame [

	^winnerOfTheGameOptional
]
