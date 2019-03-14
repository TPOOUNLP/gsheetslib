"
*** automatically created by GoogleApiCreator ***


"
Class {
	#name : #GoogleSheetsApiSpreadsheetsValues,
	#superclass : #GoogleSheetsApiSpreadsheets,
	#category : #GoogleSheetsLib
}

{ #category : #generated }
GoogleSheetsApiSpreadsheetsValues >> append: range spreadsheetId: spreadsheetId [ 

	^ self append: range spreadsheetId: spreadsheetId options: ( Dictionary new )

]

{ #category : #generated }
GoogleSheetsApiSpreadsheetsValues >> append: range spreadsheetId: spreadsheetId options: optionsDict [
	"
		Appends values to a spreadsheet. The input range is used to search for
existing data and find a ""table"" within that range. Values will be
appended to the next row of the table, starting with the first column of
the table. See the
[guide](/sheets/guides/values#appending_values)
and
[sample code](/sheets/samples/writing#append_values)
for specific details of how tables are detected and data is appended.

The caller must specify the spreadsheet ID, range, and
a valueInputOption.  The `valueInputOption` only
controls how the input data will be added to the sheet (column-wise or
row-wise), it does not influence what cell the data starts being written
to.

		Parameters, * = required, optional parameters in optionsDict

		insertDataOption (String): How the input data should be inserted.
		valueInputOption (String): How the input data should be interpreted.
		range (String*): The A1 notation of a range to search for a logical table of data.
Values will be appended after the last row of the table.
		spreadsheetId (String*): The ID of the spreadsheet to update.
	"

	| action path values |

	action := #POST.
	values := self argumentsFor: thisContext.
	path := self basePath, ( self 
		replacePlaceholdersIn: 'v4/spreadsheets/{spreadsheetId}/values/{range}:append' with: values ).

	^ self makeRequestTo: path usingMethod: action with: optionsDict.
]

{ #category : #generated }
GoogleSheetsApiSpreadsheetsValues >> batchGet: spreadsheetId [ 

	^ self batchGet: spreadsheetId options: ( Dictionary new )

]

{ #category : #generated }
GoogleSheetsApiSpreadsheetsValues >> batchGet: spreadsheetId options: optionsDict [
	"
		Returns one or more ranges of values from a spreadsheet.
The caller must specify the spreadsheet ID and one or more ranges.

		Parameters, * = required, optional parameters in optionsDict

		spreadsheetId (String*): The ID of the spreadsheet to retrieve data from.
		ranges (String): The A1 notation of the values to retrieve.
		valueRenderOption (String): How values should be represented in the output.
		majorDimension (String): The major dimension that results should use.

For example, if the spreadsheet data is: `A1=1,B1=2,A2=3,B2=4`,
then requesting `range=A1:B2,majorDimension=ROWS` will return
`[[1,2],[3,4]]`,
whereas requesting `range=A1:B2,majorDimension=COLUMNS` will return
`[[1,3],[2,4]]`.
		dateTimeRenderOption (String): How dates, times, and durations should be represented in the output.
This is ignored if value_render_option is
FORMATTED_VALUE.
	"

	| action path values params |
	action := #GET.
	"	params := '?majorDimension=COLUMNS&ranges=A1%3AB4&valueRenderOption=FORMATTED_VALUE'."
	values := self argumentsFor: thisContext.
	values := path := self basePath
		,
			(self
				replacePlaceholdersIn: 'v4/spreadsheets/{spreadsheetId}/values:batchGet{optionsDict}'
				with: values).
	^ self makeRequestTo: path usingMethod: action with: Dictionary new
]

{ #category : #generated }
GoogleSheetsApiSpreadsheetsValues >> batchUpdate: spreadsheetId [
	"
		Sets values in one or more ranges of a spreadsheet.
The caller must specify the spreadsheet ID,
a valueInputOption, and one or more
ValueRanges.

		Parameters, * = required, optional parameters in optionsDict

		spreadsheetId (String*): The ID of the spreadsheet to update.
	"

	| action path values |
	action := #POST.
	values := self argumentsFor: thisContext.
	path := self basePath
		, (self replacePlaceholdersIn: 'v4/spreadsheets/{spreadsheetId}/values:batchUpdate' with: values).
	^ self
		makeRequestTo: path
		usingMethod: action
		with: (NeoJSONReader fromString: '{}')
]

{ #category : #generated }
GoogleSheetsApiSpreadsheetsValues >> batchUpdate: spreadsheetId data: aDataDic [
	"
		Sets values in one or more ranges of a spreadsheet.
The caller must specify the spreadsheet ID,
a valueInputOption, and one or more
ValueRanges.

		Parameters, * = required, optional parameters in optionsDict

		spreadsheetId (String*): The ID of the spreadsheet to update.
		
		
		
		with: (NeoJSONReader fromString: '{}')
	"

	| action path values |
	action := #POST.
	values := self argumentsFor: thisContext.
	path := self basePath
		, (self replacePlaceholdersIn: 'v4/spreadsheets/{spreadsheetId}/values:batchUpdate' with: values).
	^ self
		makeRequestTo: path
		usingMethod: action
		with: aDataDic
]

{ #category : #generated }
GoogleSheetsApiSpreadsheetsValues >> get: range spreadsheetId: spreadsheetId [ 

	^ self get: range spreadsheetId: spreadsheetId options: ( Dictionary new )

]

{ #category : #generated }
GoogleSheetsApiSpreadsheetsValues >> get: range spreadsheetId: spreadsheetId options: optionsDict [
	"
		Returns a range of values from a spreadsheet.
The caller must specify the spreadsheet ID and a range.

		Parameters, * = required, optional parameters in optionsDict

		range (String*): The A1 notation of the values to retrieve.
		spreadsheetId (String*): The ID of the spreadsheet to retrieve data from.
		valueRenderOption (String): How values should be represented in the output.
		majorDimension (String): The major dimension that results should use.

For example, if the spreadsheet data is: `A1=1,B1=2,A2=3,B2=4`,
then requesting `range=A1:B2,majorDimension=ROWS` will return
`[[1,2],[3,4]]`,
whereas requesting `range=A1:B2,majorDimension=COLUMNS` will return
`[[1,3],[2,4]]`.
		dateTimeRenderOption (String): How dates, times, and durations should be represented in the output.
This is ignored if value_render_option is
FORMATTED_VALUE.
	"

	| action path values |

	action := #GET.
	values := self argumentsFor: thisContext.
	path := self basePath, ( self 
		replacePlaceholdersIn: 'v4/spreadsheets/{spreadsheetId}/values/{range}' with: values ).

	^ self makeRequestTo: path usingMethod: action with: optionsDict.
]

{ #category : #generated }
GoogleSheetsApiSpreadsheetsValues >> update: range spreadsheetId: spreadsheetId [ 

	^ self update: range spreadsheetId: spreadsheetId options: ( Dictionary new )

]

{ #category : #generated }
GoogleSheetsApiSpreadsheetsValues >> update: range spreadsheetId: spreadsheetId options: optionsDict [
	" Se le pasa el JSON 	con los cambios que se quieren hacer 
"

	| action path values param request |
	param := Dictionary new.
	request := Dictionary new.
	param at: 'range' put: range.
	param at: 'majorDimension' put: 'COLUMNS'.
	param at: 'values' put: optionsDict.
	action := #PUT.
	values := self argumentsFor: thisContext.
	path := self basePath
		,
			(self
				replacePlaceholdersIn: 'v4/spreadsheets/{spreadsheetId}/values/{range}?valueInputOption=USER_ENTERED'
				with: values).
	^ self makeRequestTo: path usingMethod: action with: param
]
