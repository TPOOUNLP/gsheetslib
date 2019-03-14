"
*** automatically created by GoogleApiCreator ***


"
Class {
	#name : #GoogleDriveApiComments,
	#superclass : #GoogleDriveApi,
	#category : #GoogleSheetsLib
}

{ #category : #generated }
GoogleDriveApiComments >> create: fileId [ 
	"
		Creates a new comment on a file.

		Parameters, * = required, optional parameters in optionsDict

		fileId (String*): The ID of the file.
	"

	| action path values |

	action := #POST.
	values := self argumentsFor: thisContext.
	path := self basePath, ( self 
		replacePlaceholdersIn: 'files/{fileId}/comments' with: values ).

	^ self makeRequestTo: path usingMethod: action with: nil.
]

{ #category : #generated }
GoogleDriveApiComments >> delete: commentId fileId: fileId [ 
	"
		Deletes a comment.

		Parameters, * = required, optional parameters in optionsDict

		commentId (String*): The ID of the comment.
		fileId (String*): The ID of the file.
	"

	| action path values |

	action := #DELETE.
	values := self argumentsFor: thisContext.
	path := self basePath, ( self 
		replacePlaceholdersIn: 'files/{fileId}/comments/{commentId}' with: values ).

	^ self makeRequestTo: path usingMethod: action with: nil.
]

{ #category : #generated }
GoogleDriveApiComments >> get: commentId fileId: fileId [ 

	^ self get: commentId fileId: fileId options: ( Dictionary new )

]

{ #category : #generated }
GoogleDriveApiComments >> get: commentId fileId: fileId options: optionsDict [
	"
		Gets a comment by ID.

		Parameters, * = required, optional parameters in optionsDict

		commentId (String*): The ID of the comment.
		fileId (String*): The ID of the file.
		includeDeleted (Boolean): Whether to return deleted comments. Deleted comments will not include their original content.
	"

	| action path values |

	action := #GET.
	values := self argumentsFor: thisContext.
	path := self basePath, ( self 
		replacePlaceholdersIn: 'files/{fileId}/comments/{commentId}' with: values ).

	^ self makeRequestTo: path usingMethod: action with: optionsDict.
]

{ #category : #generated }
GoogleDriveApiComments >> list: fileId [ 

	^ self list: fileId options: ( Dictionary new )

]

{ #category : #generated }
GoogleDriveApiComments >> list: fileId options: optionsDict [
	"
		Lists a file's comments.

		Parameters, * = required, optional parameters in optionsDict

		pageSize (Integer): The maximum number of comments to return per page.
		pageToken (String): The token for continuing a previous list request on the next page. This should be set to the value of 'nextPageToken' from the previous response.
		fileId (String*): The ID of the file.
		startModifiedTime (String): The minimum value of 'modifiedTime' for the result comments (RFC 3339 date-time).
		includeDeleted (Boolean): Whether to include deleted comments. Deleted comments will not include their original content.
	"

	| action path values |

	action := #GET.
	values := self argumentsFor: thisContext.
	path := self basePath, ( self 
		replacePlaceholdersIn: 'files/{fileId}/comments' with: values ).

	^ self makeRequestTo: path usingMethod: action with: optionsDict.
]

{ #category : #generated }
GoogleDriveApiComments >> update: commentId fileId: fileId [ 
	"
		Updates a comment with patch semantics.

		Parameters, * = required, optional parameters in optionsDict

		commentId (String*): The ID of the comment.
		fileId (String*): The ID of the file.
	"

	| action path values |

	action := #PATCH.
	values := self argumentsFor: thisContext.
	path := self basePath, ( self 
		replacePlaceholdersIn: 'files/{fileId}/comments/{commentId}' with: values ).

	^ self makeRequestTo: path usingMethod: action with: nil.
]
