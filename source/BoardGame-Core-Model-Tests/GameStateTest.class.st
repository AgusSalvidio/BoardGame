Class {
	#name : #GameStateTest,
	#superclass : #TestCase,
	#instVars : [
		'game'
	],
	#category : #'BoardGame-Core-Model-Tests'
}

{ #category : #generating }
GameStateTest >> generateDieOf: aNumberOfSides using: anArrayOfNumbersOfSides [

	^ (Die withSides: aNumberOfSides using: (FixedNumberProvider workingWith: anArrayOfNumbersOfSides ))	
]

{ #category : #generating }
GameStateTest >> generateEmptyTileEffectCollectionOf: aNumberOfTiles [

	|emptyTileCollection|
	
	emptyTileCollection := OrderedCollection new.	
	1 to: aNumberOfTiles do:[: index | emptyTileCollection add: EmptyTileEffect newEffect ].
	
	^emptyTileCollection

]

{ #category : #'private - running' }
GameStateTest >> setUp [

	game := Game
			newGameFor: (OrderedCollection with: (Player named: 'Juan') with: (Player named: 'Jose'))
			playingWith: (OrderedCollection with: (self generateDieOf: 6 using: #(2 6 5)))
			and: (Board withTiles: (self generateEmptyTileEffectCollectionOf: 10 ))
			withNumberOfLapsBeing: 1.

]

{ #category : #tests }
GameStateTest >> testHasGameStateEnded [

	|endedState|
	
	endedState := EndedState newGameState.
	
	self 
		assert: endedState hasEnded;
		deny: endedState isInProgress
		
]

{ #category : #tests }
GameStateTest >> testIsGameStateInProgress [

	|inProgressState|
	
	inProgressState := InProgressState newGameState.

	self 
		assert: inProgressState isInProgress;
		deny: inProgressState hasEnded
]

{ #category : #tests }
GameStateTest >> testPrintingGameState [

	self 
		assert: InProgressState newGameState asString equals: 'In progress Game State';
		assert: EndedState  newGameState asString equals: 'Ended Game State'
]

{ #category : #tests }
GameStateTest >> testWhenGameStateHasEndedAndTriesToProcessAMovementThenRaiseException [

		
	self
		should: [
			|state|
			state := EndedState newGameState.
			state process: game for: (game currentPlayerPositionOf: game currentPlayer)]
		raise: AssertionFailed
		withMessageText: 'The game has ended.'
]

{ #category : #tests }
GameStateTest >> testWhenGameStateHasEndedAndTriesToUpdateAMovementThenRaiseException [

		
	self
		should: [
			|state|
			state := EndedState newGameState.
			state update: game for: game currentPlayer beingIn: (game currentPlayerPositionOf: game currentPlayer)]
		raise: AssertionFailed
		withMessageText: 'The game has ended.'
]
