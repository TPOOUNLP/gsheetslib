"
*** automatically created by GoogleApiCreator ***


"
Class {
	#name : #GoogleSheetsApiSpreadsheetsSheets,
	#superclass : #GoogleSheetsApiSpreadsheets,
	#category : #GoogleSheetsLib
}

{ #category : #generated }
GoogleSheetsApiSpreadsheetsSheets >> copyTo: spreadsheetId sheetId: sheetId [ 
	"
		Copies a single sheet from a spreadsheet to another spreadsheet.
Returns the properties of the newly created sheet.

		Parameters, * = required, optional parameters in optionsDict

		spreadsheetId (String*): The ID of the spreadsheet containing the sheet to copy.
		sheetId (Integer*): The ID of the sheet to copy.
	"

	| action path values |

	action := #POST.
	values := self argumentsFor: thisContext.
	path := self basePath, ( self 
		replacePlaceholdersIn: 'v4/spreadsheets/{spreadsheetId}/sheets/{sheetId}:copyTo' with: values ).

	^ self makeRequestTo: path usingMethod: action with: nil.
]
