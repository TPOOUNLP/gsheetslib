"
*** automatically created by GoogleApiCreator ***


"
Class {
	#name : #GoogleOauth2ApiUserinfo,
	#superclass : #GoogleOauth2Api,
	#category : #GoogleSheetsLib
}

{ #category : #generated }
GoogleOauth2ApiUserinfo >> get [
	| action path values |

	action := #GET.
	values := self argumentsFor: thisContext.
	path := self basePath, ( self 
		replacePlaceholdersIn: 'oauth2/v2/userinfo' with: values ).

	^ self makeRequestTo: path usingMethod: action with: nil.
]
