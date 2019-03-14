"
*** automatically created by GoogleApiCreator ***


"
Class {
	#name : #GoogleOauth2ApiUserinfoV2Me,
	#superclass : #GoogleOauth2ApiUserinfoV2,
	#category : #GoogleSheetsLib
}

{ #category : #generated }
GoogleOauth2ApiUserinfoV2Me >> get [
	| action path values |

	action := #GET.
	values := self argumentsFor: thisContext.
	path := self basePath, ( self 
		replacePlaceholdersIn: 'userinfo/v2/me' with: values ).

	^ self makeRequestTo: path usingMethod: action with: nil.
]
