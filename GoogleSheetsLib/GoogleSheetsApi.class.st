"
*** automatically created by GoogleApiCreator ***

Reads and writes Google Sheets.

Source: https://sheets.googleapis.com/$discovery/rest?version=v4
Version: v4
Documentation: https://developers.google.com/sheets/

"
Class {
	#name : #GoogleSheetsApi,
	#superclass : #GoogleApiProxy,
	#category : #GoogleSheetsLib
}

{ #category : #generated }
GoogleSheetsApi >> apiName [
	^ 'sheets'
]

{ #category : #generated }
GoogleSheetsApi >> basePath [
	^ 'https://sheets.googleapis.com/'
]

{ #category : #generated }
GoogleSheetsApi >> rootPath [
	^ 'https://sheets.googleapis.com/'
]

{ #category : #generated }
GoogleSheetsApi >> scopes [
	^ OrderedCollection withAll: #(
		'https://www.googleapis.com/auth/spreadsheets.readonly'
		'https://www.googleapis.com/auth/spreadsheets'
		'https://www.googleapis.com/auth/drive'
		'https://www.googleapis.com/auth/drive.readonly'
	)

]
