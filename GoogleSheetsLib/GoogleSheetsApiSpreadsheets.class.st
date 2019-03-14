"
*** automatically created by GoogleApiCreator ***


"
Class {
	#name : #GoogleSheetsApiSpreadsheets,
	#superclass : #GoogleSheetsApi,
	#category : #GoogleSheetsLib
}

{ #category : #generated }
GoogleSheetsApiSpreadsheets >> batchUpdate: spreadsheetId [
	"
		Applies one or more updates to the spreadsheet.

Each request is validated before
being applied. If any request is not valid then the entire request will
fail and nothing will be applied.

Some requests have replies to
give you some information about how
they are applied. The replies will mirror the requests.  For example,
if you applied 4 updates and the 3rd one had a reply, then the
response will have 2 empty replies, the actual reply, and another empty
reply, in that order.

Due to the collaborative nature of spreadsheets, it is not guaranteed that
the spreadsheet will reflect exactly your changes after this completes,
however it is guaranteed that the updates in the request will be
applied together atomically. Your changes may be altered with respect to
collaborator changes. If there are no collaborators, the spreadsheet
should reflect your changes.

		Parameters, * = required, optional parameters in optionsDict

		spreadsheetId (String*): The spreadsheet to apply the updates to.
	"

	| action path values |
	action := #POST.
	values := self argumentsFor: thisContext.
	path := self basePath
		,
			(self
				replacePlaceholdersIn: 'v4/spreadsheets/{spreadsheetId}:batchUpdate'
				with: values).
	^ self makeRequestTo: path usingMethod: action with: (NeoJSONReader fromString: '{}')
]

{ #category : #generated }
GoogleSheetsApiSpreadsheets >> batchUpdate: spreadsheetId sheetId: sheetId range: range data: aDataDictionary with: aParamDictionary [
    "
   	 Applies one or more updates to the spreadsheet.


   	 Parameters, * = required, optional parameters in optionsDict


   	 spreadsheetId   	(String*): The spreadsheet to apply the updates to.
   	 aSheetId        	(String*): The sheet to apply the updates to.
   	 range           	           (String*): The range to wich apply the changes.
   	 aDataDictionary 	(Dictionary*): The dictionary with the values to apply.
   	 aParamDictionary	(Dictionary*): the optional parameters
   	 valueInputOption	(String): How to interpret the data
   	 majorDimension  	(String): wether the data is interpreted as ROWS or COLUMNS
    "


    | action path values bodyDic dataDic|
    bodyDic := Dictionary new.
    dataDic := Dictionary new.
    
    action := #POST.
    values := self argumentsFor: thisContext.
    path := self basePath
   	 , (self replacePlaceholdersIn: 'v4/spreadsheets/{spreadsheetId}/values:batchUpdate' with: values).
    "dataDic at: 'range' put: sheetId , '!' , range ."
    dataDic at: 'range' put: range .

    dataDic at: 'majorDimension' put: 'ROWS'.
    dataDic at: 'values' put: aDataDictionary.
    
    bodyDic at: 'data' put: dataDic.
    bodyDic at: 'valueInputOption' put: 'USER_ENTERED'.
    ^ self makeRequestTo: path usingMethod: action with: bodyDic.

]

{ #category : #generated }
GoogleSheetsApiSpreadsheets >> batchUpdate: spreadsheetId sheetId: sheetId range: range with: aParamDictionary [
	"
		Applies one or more updates to the spreadsheet.

Each request is validated before
being applied. If any request is not valid then the entire request will
fail and nothing will be applied.

Some requests have replies to
give you some information about how
they are applied. The replies will mirror the requests.  For example,
if you applied 4 updates and the 3rd one had a reply, then the
response will have 2 empty replies, the actual reply, and another empty
reply, in that order.

Due to the collaborative nature of spreadsheets, it is not guaranteed that
the spreadsheet will reflect exactly your changes after this completes,
however it is guaranteed that the updates in the request will be
applied together atomically. Your changes may be altered with respect to
collaborator changes. If there are no collaborators, the spreadsheet
should reflect your changes.

		Parameters, * = required, optional parameters in optionsDict

		spreadsheetId       (String*): The spreadsheet to apply the updates to.
		aSheetId            (String*): The sheet to apply the updates to.
		range               (String*): The range to wich apply the changes.
		aParamDictionary    (Dictionary): The dictionary with the values to apply.
	"

	| action path values bodyDic dataDic|
	bodyDic := Dictionary new.
	dataDic := Dictionary new.
	
	action := #POST.
	values := self argumentsFor: thisContext.
	path := self basePath
		, (self replacePlaceholdersIn: 'v4/spreadsheets/{spreadsheetId}:batchUpdate' with: values).
	
	^ self makeRequestTo: path usingMethod: action with: aParamDictionary
]

{ #category : #generated }
GoogleSheetsApiSpreadsheets >> batchUpdate: spreadsheetId with: aParamDictionary [
	"
		Applies one or more updates to the spreadsheet.

Each request is validated before
being applied. If any request is not valid then the entire request will
fail and nothing will be applied.

Some requests have replies to
give you some information about how
they are applied. The replies will mirror the requests.  For example,
if you applied 4 updates and the 3rd one had a reply, then the
response will have 2 empty replies, the actual reply, and another empty
reply, in that order.

Due to the collaborative nature of spreadsheets, it is not guaranteed that
the spreadsheet will reflect exactly your changes after this completes,
however it is guaranteed that the updates in the request will be
applied together atomically. Your changes may be altered with respect to
collaborator changes. If there are no collaborators, the spreadsheet
should reflect your changes.

		Parameters, * = required, optional parameters in optionsDict

		spreadsheetId (String*): The spreadsheet to apply the updates to.
	"

	| action path values |
	action := #POST.
	values := self argumentsFor: thisContext.
	path := self basePath
		, (self replacePlaceholdersIn: 'v4/spreadsheets/{spreadsheetId}:batchUpdate' with: values).
	^ self makeRequestTo: path usingMethod: action with: aParamDictionary
]

{ #category : #generated }
GoogleSheetsApiSpreadsheets >> batchUpdate: spreadsheetId withTitle: aTitle [
	"
		Parameters, * = required, optional parameters in optionsDict
		spreadsheetId (String*): The spreadsheet to apply the updates to.
	"

	| action path values request change |
	request := Dictionary new.
	request
		at: 'updateSpreadsheetProperties'
		put: (Dictionary with: 'properties' -> (Dictionary with: 'title' -> aTitle) with: 'fields' -> 'title').
	change := Dictionary with: 'requests' -> (Array with: request).
	"----------*----------"
	action := #POST.
	values := self argumentsFor: thisContext.
	path := self basePath
		, (self replacePlaceholdersIn: 'v4/spreadsheets/{spreadsheetId}:batchUpdate' with: values).
	^ self makeRequestTo: path usingMethod: action with: change.
]

{ #category : #generated }
GoogleSheetsApiSpreadsheets >> create [
	"
		Creates a spreadsheet, returning the newly created spreadsheet.
	"

	| action path values request |
	request := NeoJSONReader
		fromString:
			' {
      "properties": {
        "title": "titulo del doc4"
      }
    }'.
	action := #POST.
	values := self argumentsFor: thisContext.
	path := self basePath , (self replacePlaceholdersIn: 'v4/spreadsheets' with: values).
	^ self makeRequestTo: path usingMethod: action with: (NeoJSONReader fromString: '{}')
]

{ #category : #generated }
GoogleSheetsApiSpreadsheets >> get: spreadsheetId [
	^ self get: spreadsheetId options: Dictionary new
]

{ #category : #generated }
GoogleSheetsApiSpreadsheets >> get: spreadsheetId options: optionsDict [
	"
		Returns the spreadsheet at the given ID.
The caller must specify the spreadsheet ID.

By default, data within grids will not be returned.
You can include grid data one of two ways:

* Specify a field mask listing your desired fields using the `fields` URL
parameter in HTTP

* Set the includeGridData
URL parameter to true.  If a field mask is set, the `includeGridData`
parameter is ignored

For large spreadsheets, it is recommended to retrieve only the specific
fields of the spreadsheet that you want.

To retrieve only subsets of the spreadsheet, use the
ranges URL parameter.
Multiple ranges can be specified.  Limiting the range will
return only the portions of the spreadsheet that intersect the requested
ranges. Ranges are specified using A1 notation.

		Parameters, * = required, optional parameters in optionsDict

		ranges (String): The ranges to retrieve from the spreadsheet.
		includeGridData (Boolean): True if grid data should be returned.
This parameter is ignored if a field mask was set in the request.
		spreadsheetId (String*): The spreadsheet to request.
	"

	| action path values includeGridData |
	action := #GET.
	includeGridData := false.
	values := self argumentsFor: thisContext.
	path := self basePath
		,
			(self
				replacePlaceholdersIn:
					'v4/spreadsheets/{spreadsheetId}?includeGridData={includeGridData}'
				with: values).
	"	replacePlaceholdersIn: 'v4/spreadsheets/{spreadsheetId}?includeGridData=true'"
	^ self
		makeRequestTo: path
		usingMethod: action
		with: optionsDict
]
