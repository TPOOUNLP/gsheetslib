"
*** automatically created by GoogleApiCreator ***


"
Class {
	#name : #GoogleDriveApiChanges,
	#superclass : #GoogleDriveApi,
	#category : #GoogleSheetsLib
}

{ #category : #generated }
GoogleDriveApiChanges >> getStartPageToken [
	"
		Gets the starting pageToken for listing future changes.
	"

	| action path values |

	action := #GET.
	values := self argumentsFor: thisContext.
	path := self basePath, ( self 
		replacePlaceholdersIn: 'changes/startPageToken' with: values ).

	^ self makeRequestTo: path usingMethod: action with: nil.
]

{ #category : #generated }
GoogleDriveApiChanges >> list: pageToken [ 

	^ self list: pageToken options: ( Dictionary new )

]

{ #category : #generated }
GoogleDriveApiChanges >> list: pageToken options: optionsDict [
	"
		Lists changes for a user.

		Parameters, * = required, optional parameters in optionsDict

		pageSize (Integer): The maximum number of changes to return per page.
		pageToken (String*): The token for continuing a previous list request on the next page. This should be set to the value of 'nextPageToken' from the previous response or to the response from the getStartPageToken method.
		includeRemoved (Boolean): Whether to include changes indicating that items have left the view of the changes list, for example by deletion or lost access.
		restrictToMyDrive (Boolean): Whether to restrict the results to changes inside the My Drive hierarchy. This omits changes to files such as those in the Application Data folder or shared files which have not been added to My Drive.
		spaces (String): A comma-separated list of spaces to query within the user corpus. Supported values are 'drive', 'appDataFolder' and 'photos'.
	"

	| action path values |

	action := #GET.
	values := self argumentsFor: thisContext.
	path := self basePath, ( self 
		replacePlaceholdersIn: 'changes' with: values ).

	^ self makeRequestTo: path usingMethod: action with: optionsDict.
]

{ #category : #generated }
GoogleDriveApiChanges >> watch: pageToken [ 

	^ self watch: pageToken options: ( Dictionary new )

]

{ #category : #generated }
GoogleDriveApiChanges >> watch: pageToken options: optionsDict [
	"
		Subscribes to changes for a user.

		Parameters, * = required, optional parameters in optionsDict

		pageSize (Integer): The maximum number of changes to return per page.
		pageToken (String*): The token for continuing a previous list request on the next page. This should be set to the value of 'nextPageToken' from the previous response or to the response from the getStartPageToken method.
		includeRemoved (Boolean): Whether to include changes indicating that items have left the view of the changes list, for example by deletion or lost access.
		restrictToMyDrive (Boolean): Whether to restrict the results to changes inside the My Drive hierarchy. This omits changes to files such as those in the Application Data folder or shared files which have not been added to My Drive.
		spaces (String): A comma-separated list of spaces to query within the user corpus. Supported values are 'drive', 'appDataFolder' and 'photos'.
	"

	| action path values |

	action := #POST.
	values := self argumentsFor: thisContext.
	path := self basePath, ( self 
		replacePlaceholdersIn: 'changes/watch' with: values ).

	^ self makeRequestTo: path usingMethod: action with: optionsDict.
]
