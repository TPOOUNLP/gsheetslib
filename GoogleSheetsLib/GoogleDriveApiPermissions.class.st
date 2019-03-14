"
*** automatically created by GoogleApiCreator ***


"
Class {
	#name : #GoogleDriveApiPermissions,
	#superclass : #GoogleDriveApi,
	#category : #GoogleSheetsLib
}

{ #category : #generated }
GoogleDriveApiPermissions >> create: fileId [ 

	^ self create: fileId options: ( Dictionary new )

]

{ #category : #generated }
GoogleDriveApiPermissions >> create: fileId options: optionsDict [
	"
		Creates a permission for a file.

		Parameters, * = required, optional parameters in optionsDict

		emailMessage (String): A custom message to include in the notification email.
		fileId (String*): The ID of the file.
		sendNotificationEmail (Boolean): Whether to send a notification email when sharing to users or groups. This defaults to true for users and groups, and is not allowed for other requests. It must not be disabled for ownership transfers.
		transferOwnership (Boolean): Whether to transfer ownership to the specified user and downgrade the current owner to a writer. This parameter is required as an acknowledgement of the side effect.
	"

	| action path values |

	action := #POST.
	values := self argumentsFor: thisContext.
	path := self basePath, ( self 
		replacePlaceholdersIn: 'files/{fileId}/permissions' with: values ).

	^ self makeRequestTo: path usingMethod: action with: optionsDict.
]

{ #category : #generated }
GoogleDriveApiPermissions >> delete: fileId permissionId: permissionId [ 
	"
		Deletes a permission.

		Parameters, * = required, optional parameters in optionsDict

		fileId (String*): The ID of the file.
		permissionId (String*): The ID of the permission.
	"

	| action path values |

	action := #DELETE.
	values := self argumentsFor: thisContext.
	path := self basePath, ( self 
		replacePlaceholdersIn: 'files/{fileId}/permissions/{permissionId}' with: values ).

	^ self makeRequestTo: path usingMethod: action with: nil.
]

{ #category : #generated }
GoogleDriveApiPermissions >> get: fileId permissionId: permissionId [ 
	"
		Gets a permission by ID.

		Parameters, * = required, optional parameters in optionsDict

		fileId (String*): The ID of the file.
		permissionId (String*): The ID of the permission.
	"

	| action path values |

	action := #GET.
	values := self argumentsFor: thisContext.
	path := self basePath, ( self 
		replacePlaceholdersIn: 'files/{fileId}/permissions/{permissionId}' with: values ).

	^ self makeRequestTo: path usingMethod: action with: nil.
]

{ #category : #generated }
GoogleDriveApiPermissions >> list: fileId [ 
	"
		Lists a file's permissions.

		Parameters, * = required, optional parameters in optionsDict

		fileId (String*): The ID of the file.
	"

	| action path values |

	action := #GET.
	values := self argumentsFor: thisContext.
	path := self basePath, ( self 
		replacePlaceholdersIn: 'files/{fileId}/permissions' with: values ).

	^ self makeRequestTo: path usingMethod: action with: nil.
]

{ #category : #generated }
GoogleDriveApiPermissions >> update: fileId permissionId: permissionId [ 

	^ self update: fileId permissionId: permissionId options: ( Dictionary new )

]

{ #category : #generated }
GoogleDriveApiPermissions >> update: fileId permissionId: permissionId options: optionsDict [
	"
		Updates a permission with patch semantics.

		Parameters, * = required, optional parameters in optionsDict

		fileId (String*): The ID of the file.
		permissionId (String*): The ID of the permission.
		transferOwnership (Boolean): Whether to transfer ownership to the specified user and downgrade the current owner to a writer. This parameter is required as an acknowledgement of the side effect.
		removeExpiration (Boolean): Whether to remove the expiration date.
	"

	| action path values |

	action := #PATCH.
	values := self argumentsFor: thisContext.
	path := self basePath, ( self 
		replacePlaceholdersIn: 'files/{fileId}/permissions/{permissionId}' with: values ).

	^ self makeRequestTo: path usingMethod: action with: optionsDict.
]
