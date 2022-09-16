Class {
	#name : #TileEffectTest,
	#superclass : #TestCase,
	#category : #'BoardGame-Tile-Model-Tests'
}

{ #category : #tests }
TileEffectTest >> testCreateAnAtomicBombTileEffect [

	| tileEffect |

	tileEffect := AtomicBombTileEffect newEffect.

	self assert: (tileEffect isA: AtomicBombTileEffect)
]

{ #category : #tests }
TileEffectTest >> testCreateAnEmptyTileEffect [

	| tileEffect |

	tileEffect := EmptyTileEffect newEffect.

	self assert: (tileEffect isA: EmptyTileEffect)
]

{ #category : #tests }
TileEffectTest >> testPrinting [

	self 
		assert: AtomicBombTileEffect newEffect asString equals:'Atomic Bomb Tile Effect.';
		assert: EmptyTileEffect  newEffect asString equals:'Empty Tile Effect.';
		assert: (MoonwalkTileEffect  newEffectUsing: 4) asString equals:'Moonwalk Tile Effect with 4 tiles to move backwards.';
		assert: SpeedUpTileEffect  newEffect asString equals:'Speed Up Tile Effect with 4 tiles to move forward.';
		assert: TimeMachineTileEffect  newEffect asString equals:'Time Machine Tile Effect.';
		assert: WormholeTileEffect  newEffect asString equals:'Wormhole Tile Effect with 4 tiles to move backwards.'
		
		
]
