Class {
	#name : #Sheet,
	#superclass : #Object,
	#instVars : [
		'sheetId',
		'sheetTittle',
		'sheetType',
		'columnsCount',
		'rowsCount',
		'values',
		'spreadSheet'
	],
	#category : #GoogleSheetsLib
}

{ #category : #'as yet unclassified' }
Sheet class >> newSheet [

	^(super new)
		initialize.
]

{ #category : #'as yet unclassified' }
Sheet class >> newSheet: aSheet [

	^(super new)
		sheetId: ((aSheet at: #properties) at: #sheetId);
		sheetTittle: ((aSheet at: #properties) at: #tittle);
		sheetType: ((aSheet at: #properties) at: #sheetType);
		columnsCount: (((aSheet at: #properties) at: #gridProperties) at: #columns);
		rowsCount: (((aSheet at: #properties) at: #gridProperties) at: #rows).
]

{ #category : #'adding elements' }
Sheet >> add: aValue key: aKey [
	"add value to sheet"

	(self getValue: aKey)
		ifNil: [ values add: (Value new with: aKey val: aValue sheet: self) ]
		ifNotNil: [ self updateValue: aKey with: aValue ]
]

{ #category : #accessing }
Sheet >> columnsCount [
	^ columnsCount
]

{ #category : #accessing }
Sheet >> columnsCount: anObject [
	columnsCount := anObject
]

{ #category : #accessing }
Sheet >> getColumn: aColumn [

 ^self values select: [ :value | value column = aColumn  ].
]

{ #category : #accessing }
Sheet >> getColumn: aColumn between: first and: last [

^ (self getColumn: aColumn) select: [ :val | (val row) asInteger between: first and: last   ].
]

{ #category : #accessing }
Sheet >> getRow: aRow [

 ^self values select: [ :value | value row = aRow  ].
]

{ #category : #accessing }
Sheet >> getValue: aKey [
	"Obtiene el valor que hay en key, si no devuelve nil"

	| val |
	val := self values
		detect: [ :value | value key = aKey ]
		ifNone: nil.
	^ val 
]

{ #category : #accessing }
Sheet >> initialize [
	self
		sheetId: 0;
		sheetTittle: 'New Sheet';
		sheetType: 'GRID';
		columnsCount: 5;
		rowsCount: 5
]

{ #category : #creation }
Sheet >> initialize: aProperties [
	"comment stating purpose of message"

	sheetId := aProperties at: 'sheetId'.
	sheetType := aProperties at: 'sheetType'.
	sheetTittle := aProperties at: 'title'.
	columnsCount := (aProperties at: 'gridProperties') at: 'columnCount' .
	rowsCount := (aProperties at: 'gridProperties') at: 'rowCount' .
	spreadSheet := aProperties at: 'spreadSheet'.
	self values: OrderedCollection new
]

{ #category : #creation }
Sheet >> initialize: aProperties spreadSheet: aSpreadSheet [
	"comment stating purpose of message"

	sheetId := aProperties at: 'sheetId'.
	sheetType := aProperties at: 'sheetType'.
	sheetTittle := aProperties at: 'title'.
	columnsCount := (aProperties at: 'gridProperties') at: 'columnCount' .
	rowsCount := (aProperties at: 'gridProperties') at: 'rowCount' .
	spreadSheet := aSpreadSheet.
	self values: OrderedCollection new
]

{ #category : #accessing }
Sheet >> rowsCount [
	^ rowsCount
]

{ #category : #accessing }
Sheet >> rowsCount: anObject [
	rowsCount := anObject
]

{ #category : #accessing }
Sheet >> setSheet: aSheet [
	^ self
		sheetId: ((aSheet at: #properties) at: #sheetId);
		sheetTittle: ((aSheet at: #properties) at: #title);
		sheetType: ((aSheet at: #properties) at: #sheetType);
		columnsCount: (((aSheet at: #properties) at: #gridProperties) at: #columnCount);
		rowsCount: (((aSheet at: #properties) at: #gridProperties) at: #rowCount)
]

{ #category : #accessing }
Sheet >> sheetId [
	^ sheetId
]

{ #category : #accessing }
Sheet >> sheetId: anObject [
	sheetId := anObject
]

{ #category : #accessing }
Sheet >> sheetTittle [
	^ sheetTittle
]

{ #category : #accessing }
Sheet >> sheetTittle: anObject [
	sheetTittle := anObject
]

{ #category : #accessing }
Sheet >> sheetType [
	^ sheetType
]

{ #category : #accessing }
Sheet >> sheetType: anObject [
	sheetType := anObject
]

{ #category : #accessing }
Sheet >> spreadSheet [
	^ spreadSheet
]

{ #category : #accessing }
Sheet >> spreadSheet: anObject [
	spreadSheet := anObject
]

{ #category : #updating }
Sheet >> update: aRange [
	"Hace el update de una sheet
   	 Parameters, * = required, optional parameters in optionsDict
   	 spreadsheetId   	(String*): The spreadsheet to apply the updates to.
   	 aSheetId        	(String*): The sheet to apply the updates to.
   	 range           	           (String*): The range to wich apply the changes.
   	 aDataDictionary 	(Dictionary*): The dictionary with the values to apply.
   	 aParamDictionary	(Dictionary*): the optional parameters
   	 valueInputOption	(String): How to interpret the data
   	 majorDimension  	(String): wether the data is interpreted as ROWS or COLUMNS
    "

	| dataColl apiValue |
	dataColl := (self valuesAt: aRange) asArray .
	apiValue := GoogleSheetsApiSpreadsheetsValues new.
	apiValue authenticate.
	apiValue
		update: self sheetTittle , '!' , aRange
		spreadsheetId: self spreadSheet spreadsheetid
		options: dataColl
]

{ #category : #updating }
Sheet >> updateValue: aKey with: val [
	"actualizar un value"

	| value |
	value := self getValue: aKey.
	value ifNotNil: [ value valor: val ]
]

{ #category : #accessing }
Sheet >> values [
	"comment stating purpose of message"
	^ values
]

{ #category : #accessing }
Sheet >> values: aValues [
	"comment stating purpose of message"

	values := aValues .
]

{ #category : #'as yet unclassified' }
Sheet >> valuesAt: aRange [
	"comment stating purpose of message"

	| index startChar startPos lastChar lastPos firstP dataColl selColumns selRow columData |
	dataColl := OrderedCollection new.
	index := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.
	firstP := aRange splitOn: ':'.
	startChar := ((firstP at: 1) at: 1) asString.
	lastChar := ((firstP at: 2) at: 1) asString.
	startPos := (firstP at: 1) allButFirst asInteger.
	lastPos := (firstP at: 2) allButFirst asInteger.
	selColumns := index asArray
		select: [ :val | startChar <= val asString & (lastChar >= val asString) ].
	selRow := Interval from: startPos to: lastPos.
	selColumns
		do: [ :letra | 
			columData := OrderedCollection new.
			selRow
				do: [ :x | columData add: (self getValue: letra asString , x asString) valor ].
			dataColl add: (columData asArray) ].
	^ dataColl
]
