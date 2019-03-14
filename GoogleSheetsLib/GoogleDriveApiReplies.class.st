"
*** automatically created by GoogleApiCreator ***


"
Class {
	#name : #GoogleDriveApiReplies,
	#superclass : #GoogleDriveApi,
	#category : #GoogleSheetsLib
}

{ #category : #generated }
GoogleDriveApiReplies >> create: commentId fileId: fileId [ 
	"
		Creates a new reply to a comment.

		Parameters, * = required, optional parameters in optionsDict

		commentId (String*): The ID of the comment.
		fileId (String*): The ID of the file.
	"

	| action path values |

	action := #POST.
	values := self argumentsFor: thisContext.
	path := self basePath, ( self 
		replacePlaceholdersIn: 'files/{fileId}/comments/{commentId}/replies' with: values ).

	^ self makeRequestTo: path usingMethod: action with: nil.
]

{ #category : #generated }
GoogleDriveApiReplies >> delete: commentId fileId: fileId replyId: replyId [ 
	"
		Deletes a reply.

		Parameters, * = required, optional parameters in optionsDict

		commentId (String*): The ID of the comment.
		fileId (String*): The ID of the file.
		replyId (String*): The ID of the reply.
	"

	| action path values |

	action := #DELETE.
	values := self argumentsFor: thisContext.
	path := self basePath, ( self 
		replacePlaceholdersIn: 'files/{fileId}/comments/{commentId}/replies/{replyId}' with: values ).

	^ self makeRequestTo: path usingMethod: action with: nil.
]

{ #category : #generated }
GoogleDriveApiReplies >> get: commentId fileId: fileId replyId: replyId [ 

	^ self get: commentId fileId: fileId replyId: replyId options: ( Dictionary new )

]

{ #category : #generated }
GoogleDriveApiReplies >> get: commentId fileId: fileId replyId: replyId options: optionsDict [
	"
		Gets a reply by ID.

		Parameters, * = required, optional parameters in optionsDict

		commentId (String*): The ID of the comment.
		fileId (String*): The ID of the file.
		includeDeleted (Boolean): Whether to return deleted replies. Deleted replies will not include their original content.
		replyId (String*): The ID of the reply.
	"

	| action path values |

	action := #GET.
	values := self argumentsFor: thisContext.
	path := self basePath, ( self 
		replacePlaceholdersIn: 'files/{fileId}/comments/{commentId}/replies/{replyId}' with: values ).

	^ self makeRequestTo: path usingMethod: action with: optionsDict.
]

{ #category : #generated }
GoogleDriveApiReplies >> list: fileId commentId: commentId [ 

	^ self list: fileId commentId: commentId options: ( Dictionary new )

]

{ #category : #generated }
GoogleDriveApiReplies >> list: fileId commentId: commentId options: optionsDict [
	"
		Lists a comment's replies.

		Parameters, * = required, optional parameters in optionsDict

		pageSize (Integer): The maximum number of replies to return per page.
		pageToken (String): The token for continuing a previous list request on the next page. This should be set to the value of 'nextPageToken' from the previous response.
		fileId (String*): The ID of the file.
		commentId (String*): The ID of the comment.
		includeDeleted (Boolean): Whether to include deleted replies. Deleted replies will not include their original content.
	"

	| action path values |

	action := #GET.
	values := self argumentsFor: thisContext.
	path := self basePath, ( self 
		replacePlaceholdersIn: 'files/{fileId}/comments/{commentId}/replies' with: values ).

	^ self makeRequestTo: path usingMethod: action with: optionsDict.
]

{ #category : #generated }
GoogleDriveApiReplies >> update: commentId fileId: fileId replyId: replyId [ 
	"
		Updates a reply with patch semantics.

		Parameters, * = required, optional parameters in optionsDict

		commentId (String*): The ID of the comment.
		fileId (String*): The ID of the file.
		replyId (String*): The ID of the reply.
	"

	| action path values |

	action := #PATCH.
	values := self argumentsFor: thisContext.
	path := self basePath, ( self 
		replacePlaceholdersIn: 'files/{fileId}/comments/{commentId}/replies/{replyId}' with: values ).

	^ self makeRequestTo: path usingMethod: action with: nil.
]
