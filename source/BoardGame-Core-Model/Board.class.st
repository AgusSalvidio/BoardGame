Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'tiles',
		'finishTileNumber',
		'startTileNumber'
	],
	#category : #'BoardGame-Core-Model'
}

{ #category : #'private - generating board' }
Board class >> generateBoardWith: aQuantityOfTiles [

	| tiles tilesEffectProbabilities|

	tiles := OrderedCollection new.
	tilesEffectProbabilities := self tilesEffectProbabilities.
		
	1 to: aQuantityOfTiles do: [:index |
		 self generateTileEffectLocatedIn: tilesEffectProbabilities at: self randomTileNumber with: tiles].
		 
	^ tiles
]

{ #category : #'private - generating board' }
Board class >> generateTileEffectLocatedIn: aTileEffectProbabilityDictionary at: aNumber with: aTileCollection [

	^ aTileEffectProbabilityDictionary keysAndValuesDo: [:aRange :aTileEffectClass |
		(aRange includes: aNumber)
			ifTrue: [aTileCollection add: aTileEffectClass newEffect]
			ifFalse: []]
]

{ #category : #'private - generating board' }
Board class >> randomTileNumber [

	^(Random new) nextInteger: 100
]

{ #category : #'private - generating board' }
Board class >> tilesEffectProbabilities [

	| tilesEffectProbabilities |

	tilesEffectProbabilities := Dictionary new
		at: (1 to: 55) put: EmptyTileEffect;
		at: (56 to: 57) put: AtomicBombTileEffect;
		at: (58 to: 62) put: MoonwalkTileEffect;
		at: (63 to: 77) put: SpeedUpTileEffect;
		at: (78 to: 85) put: TimeMachineTileEffect;
		at: (86 to: 100) put: WormholeTileEffect;
		yourself.
		
	^ tilesEffectProbabilities
]

{ #category : #'private - asserting' }
Board class >> validateQuantityOfTiles: aQuantityOfTiles [

	AssertionChecker 
		enforce:[ aQuantityOfTiles >= 2] 
		because:'The board cannot be created with less than 2 tiles.'
		raising: InstanceCreationFailed.

	
]

{ #category : #'instance creation' }
Board class >> withQuantityOfTiles: aQuantityOfTiles [

	self validateQuantityOfTiles: aQuantityOfTiles.
		
	^self new initializeWithTiles: (self generateBoardWith: aQuantityOfTiles)
]

{ #category : #'private - instance creation' }
Board class >> withTiles: aTileCollection [

	self validateQuantityOfTiles: aTileCollection size.

	^self new initializeWithTiles: aTileCollection
]

{ #category : #accessing }
Board >> finishTileNumber [

	^finishTileNumber
]

{ #category : #'private - initialization' }
Board >> initializeWithTiles: aTileCollection [

	tiles := aTileCollection.
	startTileNumber := 1.
	finishTileNumber := aTileCollection size.
]

{ #category : #accessing }
Board >> tileNumbered: aTileNumber [

	^tiles at: aTileNumber
]

{ #category : #'private - accessing' }
Board >> tiles [

	^ tiles
]
