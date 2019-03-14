"
*** automatically created by GoogleApiCreator ***


"
Class {
	#name : #GoogleDriveApiAbout,
	#superclass : #GoogleDriveApi,
	#category : #GoogleSheetsLib
}

{ #category : #generated }
GoogleDriveApiAbout >> get [
	"
		Gets information about the user, the user's Drive, and system capabilities.
	"

	| action path values |

	action := #GET.
	values := self argumentsFor: thisContext.
	path := self basePath, ( self 
		replacePlaceholdersIn: 'about' with: values ).

	^ self makeRequestTo: path usingMethod: action with: nil.
]
