Class {
	#name : #DescendingSortingCriterion,
	#superclass : #SortingCriterion,
	#instVars : [
		'criterionBlock'
	],
	#category : #'BoardGame-SortingCriterion-Model'
}

{ #category : #'instance creation' }
DescendingSortingCriterion class >> default [

	^self sending: #yourself
]

{ #category : #'instance creation' }
DescendingSortingCriterion class >> sending: aSymbol [

	^self using: [:anObject | anObject perform: aSymbol]
]

{ #category : #'instance creation' }
DescendingSortingCriterion class >> using: aMonadicBlock [

	^self new initializeUsing: aMonadicBlock
]

{ #category : #'private - initialization' }
DescendingSortingCriterion >> initializeUsing: aMonadicBlock [

	criterionBlock := aMonadicBlock
]

{ #category : #evaluating }
DescendingSortingCriterion >> value: anObject value: anotherObject [

	^(criterionBlock value: anObject) >= (criterionBlock value: anotherObject)
]
