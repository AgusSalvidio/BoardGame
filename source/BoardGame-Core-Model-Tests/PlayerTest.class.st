Class {
	#name : #PlayerTest,
	#superclass : #TestCase,
	#category : #'BoardGame-Core-Model-Tests'
}

{ #category : #tests }
PlayerTest >> testCreatePlayer [

	| player |

	player := Player named: 'Juan'.

	self assert: player name equals: 'Juan'
]

{ #category : #tests }
PlayerTest >> testPrinting [

	| player |

	player := Player named: 'Juan'.

	self assert: player asString equals: 'Juan'
]

{ #category : #tests }
PlayerTest >> testWhenCreatingAPlayerWithNoNameShouldRaiseException [

	self 
		should: [ Player named:'' ]
		raise: InstanceCreationFailed 
		withMessageText:'The players name cannot be empty.'.
]
