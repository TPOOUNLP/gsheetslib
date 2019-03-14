"
*** automatically created by GoogleApiCreator ***

Obtains end-user authorization grants for use with other Google APIs.

Source: https://www.googleapis.com/discovery/v1/apis/oauth2/v2/rest
Version: v2
Documentation: https://developers.google.com/accounts/docs/OAuth2

"
Class {
	#name : #GoogleOauth2Api,
	#superclass : #GoogleApiProxy,
	#category : #GoogleSheetsLib
}

{ #category : #generated }
GoogleOauth2Api >> apiName [
	^ 'oauth2'
]

{ #category : #generated }
GoogleOauth2Api >> basePath [
	^ 'https://www.googleapis.com/'
]

{ #category : #generated }
GoogleOauth2Api >> rootPath [
	^ 'https://www.googleapis.com/'
]

{ #category : #generated }
GoogleOauth2Api >> scopes [
	^ OrderedCollection withAll: #(
		'https://www.googleapis.com/auth/userinfo.email'
		'https://www.googleapis.com/auth/plus.me'
		'https://www.googleapis.com/auth/userinfo.profile'
		'https://www.googleapis.com/auth/plus.login'
	)

]
