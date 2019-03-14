"
Extension to ZnMultiPartFormDataEntity to use a mimetype of multipart/mixed



"
Class {
	#name : #ZnMultiPartMixedEntity,
	#superclass : #ZnMultiPartFormDataEntity,
	#category : #'Google-API'
}

{ #category : #'as yet unclassified' }
ZnMultiPartMixedEntity class >> designatedMimeType [
	^ ZnMimeType main: 'multipart' sub: 'mixed'
]
