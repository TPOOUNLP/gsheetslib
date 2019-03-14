Class {
	#name : #Spreadsheet,
	#superclass : #Object,
	#instVars : [
		'properties',
		'sheets',
		'spreadsheetid'
	],
	#category : #GoogleSheetsLib
}

{ #category : #creation }
Spreadsheet >> create [
	"comment stating purpose of message"

	| sheetApi response |
	sheetApi := GoogleSheetsApiSpreadsheets new.
	sheetApi authenticate.
	response := sheetApi create.
	"self
		nombre: (((response at: 2) at: 'properties') at: 'title')."
	self
		properties: ((response at: 2) at: 'properties').
	self sheets: ((response at: 2) at: 'sheets').
	self
		spreadsheetid: ((response at: 2) at: 'spreadsheetId').
	^ self
]

{ #category : #accessing }
Spreadsheet >> get [
	"get spreadsheet"

	| sheetApi response aSheets |
	sheetApi := GoogleSheetsApiSpreadsheets new.
	sheetApi authenticate.
	response := sheetApi get: self spreadsheetid.
	properties := (response at: 2) at: 'properties'.
	aSheets := ((response at: 2) at: 'sheets')
		collect: [ :value | 
			Sheet new
				initialize: (value at: 'properties')
				spreadSheet: self. ].
	self sheets: aSheets.
	^ self
	"^
					data: (value at: 'data' ifAbsent: nil) 
	response"
]

{ #category : #initalize }
Spreadsheet >> initialize [
	"comment stating purpose of message"

	super.
	self spreadsheetid: nil.
	self properties: Dictionary new.
	self sheets: Array new
]

{ #category : #'as yet unclassified' }
Spreadsheet >> loadSheet: aSheet range: aRange [
	"comment stating purpose of message"

	| sheetValues request response values index startChar startInt char starPos a_key |
	sheetValues := GoogleSheetsApiSpreadsheetsValues new.
	sheetValues authenticate.
	request := '?majorDimension=COLUMNS&ranges=' , aSheet , '!' , aRange
		, '&valueRenderOption=UNFORMATTED_VALUE'.
	response := sheetValues batchGet: self spreadsheetid options: request.
	"	^ response"
	values := (((response at: 2) at: 'valueRanges') at: 1) at: 'values'.
	index := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.
	startChar := aRange at: 1.
	startInt := (aRange at: 2) asString asInteger - 1.
	starPos := index findString: startChar asString.
	values
		keysAndValuesDo: [ :key_i :value_col | 
			char := index at: starPos + (key_i - 1).
			value_col
				keysAndValuesDo: [ :key :val | 
					a_key := char asString , (startInt + key) asString.
					(self sheetAtTitle: aSheet) add: val key: a_key ] ]
]

{ #category : #accessing }
Spreadsheet >> properties [
	^ properties
]

{ #category : #accessing }
Spreadsheet >> properties: anObject [
	properties := anObject
]

{ #category : #accessing }
Spreadsheet >> sheetAt: index [
	
	^ self sheets at: index . 
]

{ #category : #accessing }
Spreadsheet >> sheetAtTitle: aTitle [
	"comment stating purpose of message"

	^ self sheets
		detect: [ :sheet | sheet sheetTittle = aTitle ]
]

{ #category : #accessing }
Spreadsheet >> sheets [
	^ sheets
]

{ #category : #accessing }
Spreadsheet >> sheets: anObject [
	sheets := anObject
]

{ #category : #accessing }
Spreadsheet >> spreadsheetid [
	"comment stating purpose of message"

	^ spreadsheetid
]

{ #category : #accessing }
Spreadsheet >> spreadsheetid: id [
	"comment stating purpose of message"

	spreadsheetid := id
]

{ #category : #accessing }
Spreadsheet >> title [
	"comment stating purpose of message"

	^ self properties at: 'title'
]

{ #category : #accessing }
Spreadsheet >> title: aTitle [
	"comment stating purpose of message"

	self properties at: 'title' put: aTitle
]
