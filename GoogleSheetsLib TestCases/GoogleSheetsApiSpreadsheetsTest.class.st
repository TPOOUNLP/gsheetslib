Class {
	#name : #GoogleSheetsApiSpreadsheetsTest,
	#superclass : #TestCase,
	#instVars : [
		'apiSpreadsheets',
		'apiSpreadsheetsSheets',
		'apiSpreadsheetsValues',
		'id'
	],
	#category : #'GoogleSheetsLib TestCases'
}

{ #category : #initialization }
GoogleSheetsApiSpreadsheetsTest >> setUp [
	apiSpreadsheets := GoogleSheetsApiSpreadsheets new.
	id := 'ADD_SPREADSHEET_ID'.
	apiSpreadsheets authenticate
]

{ #category : #abm }
GoogleSheetsApiSpreadsheetsTest >> testBatchUpdate [
	self assert: (apiSpreadsheets batchUpdate: id) code equals: 200
]

{ #category : #'connection open/close' }
GoogleSheetsApiSpreadsheetsTest >> testConnection [
	"Test if connection can be established"

self assert: apiSpreadsheets authenticate .
]

{ #category : #abm }
GoogleSheetsApiSpreadsheetsTest >> testCreate [
	"Test the creation of a spreadsheet"

	self assert: (apiSpreadsheets create at: 1) code equals: 200
]

{ #category : #abm }
GoogleSheetsApiSpreadsheetsTest >> testGet [
	"Test the getting of a spreadsheet"

	self assert: ((apiSpreadsheets get: id) at: 1) code equals: 200
]

{ #category : #abm }
GoogleSheetsApiSpreadsheetsTest >> testGetOptions [
	"Test the getting of a spreadsheet"

	| aDictionary |
	aDictionary := Dictionary new.
	self assert: ((apiSpreadsheets get: id options: aDictionary) at: 1) code equals: 200
]

{ #category : #values }
GoogleSheetsApiSpreadsheetsTest >> testGetValueRange [
	"Test getting a ValueRange"

	| response range optionsDict |
	range := 'A1:A3'.
	optionsDict := Dictionary new.
	"apiSpreadsheetsValues authenticate."
	response := apiSpreadsheetsValues
		get: range
		spreadsheetId: id
		options: optionsDict.
	self assert: (response at: 1) code equals: 200
]

{ #category : #abm }
GoogleSheetsApiSpreadsheetsTest >> testUpdateSpreadsheet [
	"Test the update of a spreadsheet"
|temp|

temp := nil.
apiSpreadsheets authenticate .
self assert: (apiSpreadsheets update: temp).
]
