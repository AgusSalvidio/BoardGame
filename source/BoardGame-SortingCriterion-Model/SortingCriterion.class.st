Class {
	#name : #SortingCriterion,
	#superclass : #Object,
	#category : #'BoardGame-SortingCriterion-Model'
}

{ #category : #evaluating }
SortingCriterion >> value: anObject value: anotherObject [

	"From asSortedCollection:
The sort order is defined by the two argument block
- Each argument of the block represents an potential Object within the collection.
- The block body contains code returning a `Boolean` which is:
	true if the items need not be exchanged in terms of ordering
	false if they are to be exchanged.
 -jmaestri"

	self subclassResponsibility
]
