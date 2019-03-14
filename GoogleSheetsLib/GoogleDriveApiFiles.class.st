"
*** automatically created by GoogleApiCreator ***


"
Class {
	#name : #GoogleDriveApiFiles,
	#superclass : #GoogleDriveApi,
	#category : #GoogleSheetsLib
}

{ #category : #generated }
GoogleDriveApiFiles >> copy: fileId [ 

	^ self copy: fileId options: ( Dictionary new )

]

{ #category : #generated }
GoogleDriveApiFiles >> copy: fileId options: optionsDict [
	"
		Creates a copy of a file and applies any requested updates with patch semantics.

		Parameters, * = required, optional parameters in optionsDict

		ocrLanguage (String): A language hint for OCR processing during image import (ISO 639-1 code).
		fileId (String*): The ID of the file.
		ignoreDefaultVisibility (Boolean): Whether to ignore the domain's default visibility settings for the created file. Domain administrators can choose to make all uploaded files visible to the domain by default; this parameter bypasses that behavior for the request. Permissions are still inherited from parent folders.
		keepRevisionForever (Boolean): Whether to set the 'keepForever' field in the new head revision. This is only applicable to files with binary content in Drive.
	"

	| action path values |

	action := #POST.
	values := self argumentsFor: thisContext.
	path := self basePath, ( self 
		replacePlaceholdersIn: 'files/{fileId}/copy' with: values ).

	^ self makeRequestTo: path usingMethod: action with: optionsDict.
]

{ #category : #generated }
GoogleDriveApiFiles >> create [

	^ self create: ( Dictionary new )

]

{ #category : #generated }
GoogleDriveApiFiles >> create: optionsDict [
	"
		Creates a new file.

		Parameters, * = required, optional parameters in optionsDict

		ocrLanguage (String): A language hint for OCR processing during image import (ISO 639-1 code).
		useContentAsIndexableText (Boolean): Whether to use the uploaded content as indexable text.
		ignoreDefaultVisibility (Boolean): Whether to ignore the domain's default visibility settings for the created file. Domain administrators can choose to make all uploaded files visible to the domain by default; this parameter bypasses that behavior for the request. Permissions are still inherited from parent folders.
		keepRevisionForever (Boolean): Whether to set the 'keepForever' field in the new head revision. This is only applicable to files with binary content in Drive.
	"

	| action path values |

	action := #POST.
	values := self argumentsFor: thisContext.
	path := self rootPath, ( self 
		replacePlaceholdersIn: '/upload/drive/v3/files' with: values ).

	^ self makeRequestTo: path usingMethod: action with: optionsDict.
]

{ #category : #generated }
GoogleDriveApiFiles >> delete: fileId [ 
	"
		Permanently deletes a file owned by the user without moving it to the trash. If the target is a folder, all descendants owned by the user are also deleted.

		Parameters, * = required, optional parameters in optionsDict

		fileId (String*): The ID of the file.
	"

	| action path values |

	action := #DELETE.
	values := self argumentsFor: thisContext.
	path := self basePath, ( self 
		replacePlaceholdersIn: 'files/{fileId}' with: values ).

	^ self makeRequestTo: path usingMethod: action with: nil.
]

{ #category : #generated }
GoogleDriveApiFiles >> emptyTrash [
	"
		Permanently deletes all of the user's trashed files.
	"

	| action path values |

	action := #DELETE.
	values := self argumentsFor: thisContext.
	path := self basePath, ( self 
		replacePlaceholdersIn: 'files/trash' with: values ).

	^ self makeRequestTo: path usingMethod: action with: nil.
]

{ #category : #generated }
GoogleDriveApiFiles >> export: fileId mimeType: mimeType [ 
	"
		Exports a Google Doc to the requested MIME type and returns the exported content.

		Parameters, * = required, optional parameters in optionsDict

		fileId (String*): The ID of the file.
		mimeType (String*): The MIME type of the format requested for this export.
	"

	| action path values |

	action := #GET.
	values := self argumentsFor: thisContext.
	path := self basePath, ( self 
		replacePlaceholdersIn: 'files/{fileId}/export' with: values ).

	^ self makeRequestTo: path usingMethod: action with: nil.
]

{ #category : #generated }
GoogleDriveApiFiles >> generateIds [

	^ self generateIds: ( Dictionary new )

]

{ #category : #generated }
GoogleDriveApiFiles >> generateIds: optionsDict [
	"
		Generates a set of file IDs which can be provided in create requests.

		Parameters, * = required, optional parameters in optionsDict

		count (Integer): The number of IDs to return.
		space (String): The space in which the IDs can be used to create new files. Supported values are 'drive' and 'appDataFolder'.
	"

	| action path values |

	action := #GET.
	values := self argumentsFor: thisContext.
	path := self basePath, ( self 
		replacePlaceholdersIn: 'files/generateIds' with: values ).

	^ self makeRequestTo: path usingMethod: action with: optionsDict.
]

{ #category : #generated }
GoogleDriveApiFiles >> get: fileId [ 

	^ self get: fileId options: ( Dictionary new )

]

{ #category : #generated }
GoogleDriveApiFiles >> get: fileId options: optionsDict [
	"
		Gets a file's metadata or content by ID.

		Parameters, * = required, optional parameters in optionsDict

		fileId (String*): The ID of the file.
		acknowledgeAbuse (Boolean): Whether the user is acknowledging the risk of downloading known malware or other abusive files. This is only applicable when alt=media.
	"

	| action path values |

	action := #GET.
	values := self argumentsFor: thisContext.
	path := self basePath, ( self 
		replacePlaceholdersIn: 'files/{fileId}' with: values ).

	^ self makeRequestTo: path usingMethod: action with: optionsDict.
]

{ #category : #generated }
GoogleDriveApiFiles >> list [

	^ self list: ( Dictionary new )

]

{ #category : #generated }
GoogleDriveApiFiles >> list: optionsDict [
	"
		Lists or searches files.

		Parameters, * = required, optional parameters in optionsDict

		pageSize (Integer): The maximum number of files to return per page.
		pageToken (String): The token for continuing a previous list request on the next page. This should be set to the value of 'nextPageToken' from the previous response.
		corpus (String): The source of files to list.
		q (String): A query for filtering the file results. See the ""Search for Files"" guide for supported syntax.
		orderBy (String): A comma-separated list of sort keys. Valid keys are 'createdTime', 'folder', 'modifiedByMeTime', 'modifiedTime', 'name', 'quotaBytesUsed', 'recency', 'sharedWithMeTime', 'starred', and 'viewedByMeTime'. Each key sorts ascending by default, but may be reversed with the 'desc' modifier. Example usage: ?orderBy=folder,modifiedTime desc,name. Please note that there is a current limitation for users with approximately one million files in which the requested sort order is ignored.
		spaces (String): A comma-separated list of spaces to query within the corpus. Supported values are 'drive', 'appDataFolder' and 'photos'.
	"

	| action path values |

	action := #GET.
	values := self argumentsFor: thisContext.
	path := self basePath, ( self 
		replacePlaceholdersIn: 'files' with: values ).

	^ self makeRequestTo: path usingMethod: action with: optionsDict.
]

{ #category : #generated }
GoogleDriveApiFiles >> update: fileId [ 

	^ self update: fileId options: ( Dictionary new )

]

{ #category : #generated }
GoogleDriveApiFiles >> update: fileId options: optionsDict [
	"
		Updates a file's metadata and/or content with patch semantics.

		Parameters, * = required, optional parameters in optionsDict

		keepRevisionForever (Boolean): Whether to set the 'keepForever' field in the new head revision. This is only applicable to files with binary content in Drive.
		ocrLanguage (String): A language hint for OCR processing during image import (ISO 639-1 code).
		useContentAsIndexableText (Boolean): Whether to use the uploaded content as indexable text.
		addParents (String): A comma-separated list of parent IDs to add.
		fileId (String*): The ID of the file.
		removeParents (String): A comma-separated list of parent IDs to remove.
	"

	| action path values |

	action := #PATCH.
	values := self argumentsFor: thisContext.
	path := self rootPath, ( self 
		replacePlaceholdersIn: '/upload/drive/v3/files/{fileId}' with: values ).

	^ self makeRequestTo: path usingMethod: action with: optionsDict.
]

{ #category : #generated }
GoogleDriveApiFiles >> watch: fileId [ 

	^ self watch: fileId options: ( Dictionary new )

]

{ #category : #generated }
GoogleDriveApiFiles >> watch: fileId options: optionsDict [
	"
		Subscribes to changes to a file

		Parameters, * = required, optional parameters in optionsDict

		fileId (String*): The ID of the file.
		acknowledgeAbuse (Boolean): Whether the user is acknowledging the risk of downloading known malware or other abusive files. This is only applicable when alt=media.
	"

	| action path values |

	action := #POST.
	values := self argumentsFor: thisContext.
	path := self basePath, ( self 
		replacePlaceholdersIn: 'files/{fileId}/watch' with: values ).

	^ self makeRequestTo: path usingMethod: action with: optionsDict.
]
