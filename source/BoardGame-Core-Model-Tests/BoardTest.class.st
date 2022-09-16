Class {
	#name : #BoardTest,
	#superclass : #TestCase,
	#category : #'BoardGame-Core-Model-Tests'
}

{ #category : #tests }
BoardTest >> testBoardWithLessThanTwoTilesShouldRaiseException [

	self
		should: [Board withQuantityOfTiles: 1]
		raise: InstanceCreationFailed
		withMessageText: 'The board cannot be created with less than 2 tiles.'
]

{ #category : #tests }
BoardTest >> testCreateABoard [

	| board quantityOfTiles |

	quantityOfTiles := 30.

	board := Board withQuantityOfTiles: quantityOfTiles.

	self assert: board tiles size equals: 30
]

{ #category : #tests }
BoardTest >> testCreateABoardWithAnAtomicBomb [

	| tileCollectionWithAnAtomicBomb board atomicBombTile emptyTileEffect |

	atomicBombTile := AtomicBombTileEffect newEffect.
	emptyTileEffect :=  EmptyTileEffect newEffect.

	tileCollectionWithAnAtomicBomb :=
		OrderedCollection with: emptyTileEffect with: atomicBombTile with: emptyTileEffect.

	board := Board withTiles: tileCollectionWithAnAtomicBomb.

	self assert: board tiles includes: atomicBombTile


]
