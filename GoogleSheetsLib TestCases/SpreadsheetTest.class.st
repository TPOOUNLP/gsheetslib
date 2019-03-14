Class {
	#name : #SpreadsheetTest,
	#superclass : #TestCase,
	#instVars : [
		'myApi',
		'id',
		'mySpreadsheet'
	],
	#category : #'GoogleSheetsLib TestCases'
}

{ #category : #running }
SpreadsheetTest >> setUp [
	id := 'ADD_SPREADSHEET_ID'.
	myApi := GoogleSheetsApiSpreadsheets new.
	myApi authenticate.
	mySpreadsheet := Spreadsheet new.
	mySpreadsheet spreadsheetid: id
]

{ #category : #basicTest }
SpreadsheetTest >> testCreate [
	"comment stating purpose of message"

	myApi := Spreadsheet new create.
	self assert: myApi isNotNil
]

{ #category : #basicTest }
SpreadsheetTest >> testGet [
	"comment stating purpose of message"

	mySpreadsheet := mySpreadsheet get.
	self assert: mySpreadsheet isNotNil.
]

{ #category : #'as yet unclassified' }
SpreadsheetTest >> testGetValues [
	"comment stating purpose of message"

	| value cell hoja |
	cell := 'A1'.
	hoja := 'Hoja 1'.
	mySpreadsheet get.
	mySpreadsheet loadSheet: hoja range: cell.
	value := (mySpreadsheet sheetAtTitle: hoja) getValue: cell.
	[ value notNil ] assert
]

{ #category : #'as yet unclassified' }
SpreadsheetTest >> testSetValues [
	"comment stating purpose of message"

	| value cell hoja mySheet |
	cell := 'A1'.
	hoja := 'Hoja 1'.
	mySpreadsheet get.

	"Obtener el valor de la celda"
	mySpreadsheet := mySpreadsheet loadSheet: hoja range: cell.
	mySheet := mySpreadsheet sheetAtTitle: hoja.
	value := mySheet getValue: cell.
	self assert: value key equals: 'A1'.

	"Actualizar la celda"
	mySheet updateValue: 'A1' with: 'cambio valor'.
	mySheet update: 'A1:A1'.

	"Obtener el nuevo resultado"
	mySpreadsheet := mySpreadsheet loadSheet: hoja range: cell.
	mySheet := mySpreadsheet sheetAtTitle: hoja.
	value := mySheet getValue: cell.
	self assert: value valor equals: 'cambio valor'
]
