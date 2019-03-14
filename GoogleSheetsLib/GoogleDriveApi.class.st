"
*** automatically created by GoogleApiCreator ***

Manages files in Drive including uploading, downloading, searching, detecting changes, and updating sharing permissions.

Source: https://www.googleapis.com/discovery/v1/apis/drive/v3/rest
Version: v3
Documentation: https://developers.google.com/drive/

"
Class {
	#name : #GoogleDriveApi,
	#superclass : #GoogleApiProxy,
	#category : #GoogleSheetsLib
}

{ #category : #generated }
GoogleDriveApi >> apiName [
	^ 'drive'
]

{ #category : #generated }
GoogleDriveApi >> basePath [
	^ 'https://www.googleapis.com/drive/v3/'
]

{ #category : #generated }
GoogleDriveApi >> rootPath [
	^ 'https://www.googleapis.com/'
]

{ #category : #generated }
GoogleDriveApi >> scopes [
	^ OrderedCollection withAll: #(
		'https://www.googleapis.com/auth/drive.metadata.readonly'
		'https://www.googleapis.com/auth/drive.appdata'
		'https://www.googleapis.com/auth/drive.readonly'
		'https://www.googleapis.com/auth/drive.photos.readonly'
		'https://www.googleapis.com/auth/drive.scripts'
		'https://www.googleapis.com/auth/drive'
		'https://www.googleapis.com/auth/drive.file'
		'https://www.googleapis.com/auth/drive.metadata'
	)

]
