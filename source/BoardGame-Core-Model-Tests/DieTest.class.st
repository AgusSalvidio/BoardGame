Class {
	#name : #DieTest,
	#superclass : #TestCase,
	#category : #'BoardGame-Core-Model-Tests'
}

{ #category : #tests }
DieTest >> testADieWithLessThanTwoSidesShouldRaiseException [

	self
		should: [
			Die withSides: 1.]
		raise: InstanceCreationFailed
		withMessageText: 'The die cannot be created with less than 2 sides.'

]

{ #category : #tests }
DieTest >> testRollDie [

	| die |

	die := Die withSides: 6.

	self assert: (1 to: 6) includes: die roll
]

{ #category : #tests }
DieTest >> testRollFixedDie [

	 | die |

	die := Die withSides: 6 using: (FixedNumberProvider workingWith: #( 4 1 5)).

	self 
		assert: die roll equals: 4;
		assert: die roll equals: 1;
		assert: die roll equals: 5
]
