Class {
	#name : #TileEffect,
	#superclass : #Object,
	#category : #'BoardGame-Tile-Model'
}

{ #category : #'instance creation' }
TileEffect class >> newEffect [

	self subclassResponsibility
]

{ #category : #applying }
TileEffect >> applyEffectOn: aGame beingIn: aPlayerPosition [

	self subclassResponsibility
]

{ #category : #printing }
TileEffect >> printOn: aStream [

	self subclassResponsibility
]
