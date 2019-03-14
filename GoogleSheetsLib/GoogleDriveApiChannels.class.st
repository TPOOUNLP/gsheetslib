"
*** automatically created by GoogleApiCreator ***


"
Class {
	#name : #GoogleDriveApiChannels,
	#superclass : #GoogleDriveApi,
	#category : #GoogleSheetsLib
}

{ #category : #generated }
GoogleDriveApiChannels >> stop [
	"
		Stop watching resources through this channel
	"

	| action path values |

	action := #POST.
	values := self argumentsFor: thisContext.
	path := self basePath, ( self 
		replacePlaceholdersIn: 'channels/stop' with: values ).

	^ self makeRequestTo: path usingMethod: action with: nil.
]
