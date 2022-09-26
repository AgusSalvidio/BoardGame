Class {
	#name : #SortingCriterionTest,
	#superclass : #TestCase,
	#category : #'BoardGame-SortingCriterion-Model-Tests'
}

{ #category : #tests }
SortingCriterionTest >> testCreateDescendingCriterion [

	| sortingCriterion |
	sortingCriterion := DescendingSortingCriterion default.

	self
		deny: (sortingCriterion value: 3 value: 4);
		assert: (sortingCriterion value: 4 value: 4);
		assert: (sortingCriterion value: 5 value: 4)
]
