"
*** automatically created by GoogleApiCreator ***


"
Class {
	#name : #GoogleDriveApiRevisions,
	#superclass : #GoogleDriveApi,
	#category : #GoogleSheetsLib
}

{ #category : #generated }
GoogleDriveApiRevisions >> delete: fileId revisionId: revisionId [ 
	"
		Permanently deletes a revision. This method is only applicable to files with binary content in Drive.

		Parameters, * = required, optional parameters in optionsDict

		fileId (String*): The ID of the file.
		revisionId (String*): The ID of the revision.
	"

	| action path values |

	action := #DELETE.
	values := self argumentsFor: thisContext.
	path := self basePath, ( self 
		replacePlaceholdersIn: 'files/{fileId}/revisions/{revisionId}' with: values ).

	^ self makeRequestTo: path usingMethod: action with: nil.
]

{ #category : #generated }
GoogleDriveApiRevisions >> get: fileId revisionId: revisionId [ 

	^ self get: fileId revisionId: revisionId options: ( Dictionary new )

]

{ #category : #generated }
GoogleDriveApiRevisions >> get: fileId revisionId: revisionId options: optionsDict [
	"
		Gets a revision's metadata or content by ID.

		Parameters, * = required, optional parameters in optionsDict

		fileId (String*): The ID of the file.
		acknowledgeAbuse (Boolean): Whether the user is acknowledging the risk of downloading known malware or other abusive files. This is only applicable when alt=media.
		revisionId (String*): The ID of the revision.
	"

	| action path values |

	action := #GET.
	values := self argumentsFor: thisContext.
	path := self basePath, ( self 
		replacePlaceholdersIn: 'files/{fileId}/revisions/{revisionId}' with: values ).

	^ self makeRequestTo: path usingMethod: action with: optionsDict.
]

{ #category : #generated }
GoogleDriveApiRevisions >> list: fileId [ 

	^ self list: fileId options: ( Dictionary new )

]

{ #category : #generated }
GoogleDriveApiRevisions >> list: fileId options: optionsDict [
	"
		Lists a file's revisions.

		Parameters, * = required, optional parameters in optionsDict

		fileId (String*): The ID of the file.
		pageSize (Integer): The maximum number of revisions to return per page.
		pageToken (String): The token for continuing a previous list request on the next page. This should be set to the value of 'nextPageToken' from the previous response.
	"

	| action path values |

	action := #GET.
	values := self argumentsFor: thisContext.
	path := self basePath, ( self 
		replacePlaceholdersIn: 'files/{fileId}/revisions' with: values ).

	^ self makeRequestTo: path usingMethod: action with: optionsDict.
]

{ #category : #generated }
GoogleDriveApiRevisions >> update: fileId revisionId: revisionId [ 
	"
		Updates a revision with patch semantics.

		Parameters, * = required, optional parameters in optionsDict

		fileId (String*): The ID of the file.
		revisionId (String*): The ID of the revision.
	"

	| action path values |

	action := #PATCH.
	values := self argumentsFor: thisContext.
	path := self basePath, ( self 
		replacePlaceholdersIn: 'files/{fileId}/revisions/{revisionId}' with: values ).

	^ self makeRequestTo: path usingMethod: action with: nil.
]
