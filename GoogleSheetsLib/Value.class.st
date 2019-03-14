Class {
	#name : #Value,
	#superclass : #Object,
	#instVars : [
		'valor',
		'key',
		'sheet',
		'row',
		'column'
	],
	#category : #GoogleSheetsLib
}

{ #category : #accessing }
Value >> column [
	^ column
]

{ #category : #accessing }
Value >> key [
	"comment stating purpose of message"

	| temporary variable names |
	^ key
]

{ #category : #accessing }
Value >> key: aKey [
	"comment stating purpose of message"


	key := aKey.
]

{ #category : #accessing }
Value >> row [
	^ row
]

{ #category : #accessing }
Value >> valor [
	^ valor
]

{ #category : #accessing }
Value >> valor: anObject [
	valor := anObject
]

{ #category : #creation }
Value >> with: aKey val: aValue sheet: aSheet [
	"comment stating purpose of message"

	key := aKey .
	column := (aKey at: 1) asString.
	row := aKey allButFirst.
	valor := aValue	.
   sheet := aSheet.
]
