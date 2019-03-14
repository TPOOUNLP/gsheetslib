"
The base class of all created Google API proxy classes 
"
Class {
	#name : #GoogleApiProxy,
	#superclass : #Object,
	#instVars : [
		'id',
		'session',
		'registrationCredentialsFile',
		'authenticationCredentialsFile',
		'methodAction'
	],
	#category : #'Google-API'
}

{ #category : #'as yet unclassified' }
GoogleApiProxy class >> newWithId: aString [
	^ self new
		id: aString;
		yourself
]

{ #category : #api }
GoogleApiProxy >> apiName [
	self subclassResponsibility
]

{ #category : #utilities }
GoogleApiProxy >> argumentsFor: aMethodContext [
	| temps arguments |
	
	arguments := Dictionary new.
	temps := aMethodContext tempNames.
	1 to: temps size do: [ :i | 
		arguments at: ( temps at: i ) put: ( aMethodContext tempAt: i ) ].
		
	^ arguments
	
]

{ #category : #authentication }
GoogleApiProxy >> authenticate [
	| authJson regUrl |
	
	regUrl := self register.
			
	" try to read authentication json file, if missing start authentication process "
	[ authJson := self authenticationCredentials ] 
		on: Error do: [ | code |			
			"
				display dialog asking the user to browse to auth url for requesting an authentication code.
				requests auth code from user. 
				If no code was entered or dialog canceld do nothing
				if code was entered create tokens and save in authentication json file for
				later use
			"
			code := GoogleApiAuthDialog open: regUrl asString.
			code ifNil: [ ^false ].	
			authJson := self register: code ].

	session accessToken: ( authJson at: 'access_token' ifAbsent: [ nil ] ).
	session refreshToken: ( authJson at: 'refresh_token' ifAbsent: [ nil ] ).
	"session tokenType: ( authJson at: 'token_type' ifAbsent: [ nil ] )."

	^ true
	
]

{ #category : #registration }
GoogleApiProxy >> authenticate: parameterDictionary [
	| fn |

	fn := self authenticationCredentialsFile asFileReference.
	fn writeStreamDo: [ :stream | 
		stream nextPutAll: ( 
			NeoJSONWriter toString: parameterDictionary ) ].

	^ parameterDictionary
	
]

{ #category : #authentication }
GoogleApiProxy >> authenticateRefresh [
	| isAuthOK parameterDictionary |

	isAuthOK := self authenticate.
	isAuthOK ifFalse: [ ^false ].
	
	session handleTokenRefresh.
	
	parameterDictionary := Dictionary new.
	parameterDictionary at: 'access_token' put: session accessToken.
	parameterDictionary at: 'refresh_token' put: session refreshToken.
	parameterDictionary at: 'token_type' put: session tokenType.
	
	self authenticate: parameterDictionary.
	
	^ true
	
]

{ #category : #authentication }
GoogleApiProxy >> authenticationCredentials [
	| fn authJson |
	
	fn := self authenticationCredentialsFile asFileReference.
	fn exists ifFalse: [ 
		self error: 'API not registered. Authentication file (', fn fullName, ') missing' ].	
	
	authJson := ( fn readStream ) contents.	
	authJson := NeoJSONReader fromString: authJson.	
		
	^ authJson
]

{ #category : #authentication }
GoogleApiProxy >> authenticationCredentialsFile [
	authenticationCredentialsFile ifNil: [ | dir fn |
		dir := FileSystem workingDirectory.
		fn := ( GoogleApiTools replaceInvalidPathChars: self apiName ), '.', self id, '.auth.json'.
		fn := dir / 'google_api_data' / fn.
		authenticationCredentialsFile := fn fullName ].
	
	^ authenticationCredentialsFile

]

{ #category : #authentication }
GoogleApiProxy >> authenticationCredentialsFile: aFileName [
	authenticationCredentialsFile := aFileName

]

{ #category : #api }
GoogleApiProxy >> basePath [
	self subclassResponsibility 
]

{ #category : #accessing }
GoogleApiProxy >> id [
	id ifNil: [ id := 'default' ].
	
	^ id
]

{ #category : #accessing }
GoogleApiProxy >> id: aString [
	id := GoogleApiTools replaceInvalidPathChars: aString.

]

{ #category : #'as yet unclassified' }
GoogleApiProxy >> initialize [
	super initialize.
	
	methodAction := Dictionary new.
	
	methodAction at: #GET put: [ :apiUrl :token || url req |
		url := ( ZnUrl fromString: apiUrl )
			queryAt: 'access_token' put: token;
			yourself.		
		req := ( ZnRequest get: url ).
		req ].
	
	methodAction at: #PUT put: [ :apiUrl :token || url req |
		url := ( ZnUrl fromString: apiUrl )
			queryAt: 'access_token' put: token;
			yourself.		
		req := ( ZnRequest put: url ).
		req ].
	
	methodAction at: #POST put: [ :apiUrl :token || url req |
		url := ( ZnUrl fromString: apiUrl )
			queryAt: 'access_token' put: token;
			yourself.		
		req := ( ZnRequest post: url ).
		req ].


]

{ #category : #api }
GoogleApiProxy >> makeRequestTo: aUrl usingMethod: httpMethod with: aParamDictionary [
	| a req res client returnCode auth content auxcontent|
	session ifNil: [ self error: 'Authenticate API first with #authenticate' ].
	a := methodAction at: httpMethod ifAbsent: [ self error: 'Unsupported http method (' , httpMethod , ')' ].
	client := ZnClient new.
	req := a value: aUrl value: session accessToken.

	" create request "
	"aParamDictionary size = 0
		ifTrue: [ client
				request: req;
				method: req method ]
		ifFalse: [ client
				request: req;
				method: req method;
				contents: aParamDictionary ]."
	client
		request: req;
		method: req method.
	(aParamDictionary isNotNil and: [ aParamDictionary notEmpty ])
		ifTrue: [ client
				contentWriter: [ :object | 
					ZnEntity
						with:
							(String
								streamContents: [ :stream | 
									STON jsonWriter
										on: stream;
										nextPut: object ])
						type: ZnMimeType applicationJson ];
				contentReader: [ :entity | STON fromString: entity contents ];
				yourself ].
	client contents: aParamDictionary.
	
	auxcontent:= client contents.
	" client
				entity:
					(ZnStringEntity
						with: aParamDictionary
						type: (ZnMimeType main: 'application' sub: 'json')) "
	res := client execute.
	returnCode := client response statusLine code.

	" if we get a 401 return and have a refresh token try a refreshAuthenticate and repeat request "
	returnCode = 401
		ifTrue: [ session refreshToken
				ifNotNil: [ auth := self authenticateRefresh.

					" recreate url with frefreshed tokens and repeat request "
					req := a value: aUrl value: session accessToken.
					res := client
						request: req;
						execute.
					returnCode := client response statusLine code ] ].

	" if request was not successfull throw erro with result in tag "
	(returnCode < 200 or: [ returnCode > 299 ])
		ifTrue: [ Error new
				tag: res;
				signal: 'Request returns non OK status code (' , returnCode asString , ')' ].
	content := res.
	(client response entity contentType matches: ZnMimeType applicationJson)
		ifTrue: [ content := NeoJSONReader fromString: client response entity string ].
	^ {client response.
	content}
]

{ #category : #registration }
GoogleApiProxy >> register [
	| url |
	
	" try to read configuration json file to construct authentication url "
	
	session := ZnGoogleOAuth2Session google: self registrationCredentials.
	session beOfflineAccessType;
		forceApprovalPrompt;
		scopes: ( self scopes ).

	url := session authenticationUrl.
	
	^ url
	
]

{ #category : #registration }
GoogleApiProxy >> register: aRegistrationCode [
	|  parameterDictionary |
	
	" Accepts the code from registration url request "

	session ifNil: [ 
		self error: 'Start registration with #register' ].
	
	( parameterDictionary := Dictionary new ) 
		add: 'code' -> aRegistrationCode.
	
	session handleAuthenticationCallback: parameterDictionary.
	
	"
		If we come here without errors registration was OK
		save session accessToken & session refreshToken & session tokenType 
		in authenticationCredentials json file
	"
	
	parameterDictionary := Dictionary new.
	parameterDictionary at: 'access_token' put: session accessToken.
	parameterDictionary at: 'refresh_token' put: session refreshToken.
	parameterDictionary at: 'token_type' put: session tokenType.

	self authenticate: parameterDictionary.
	
	^ parameterDictionary
	
]

{ #category : #registration }
GoogleApiProxy >> registrationCredentials [
	|  fn cfgJson client_id client_secret redirect_url |

	" reads a json file with registration credentials. use Google api console to create one "

	fn := self registrationCredentialsFile asFileReference.
	fn exists ifFalse: [ self error: 'API registration credentials file (', fn fullName, ') missing.' ].	
	
	cfgJson := ( fn readStream ) contents.	
	cfgJson := NeoJSONReader fromString: cfgJson.
	cfgJson := cfgJson at: 'installed' ifAbsent: [ {} ].
	
	client_id := cfgJson at: 'client_id' ifAbsent: [ '' ].
	client_secret := cfgJson at: 'client_secret' ifAbsent: [ '' ].
	redirect_url := cfgJson at: 'redirect_uris' ifAbsent: [ #() ].
	redirect_url := redirect_url at: 1 ifAbsent: [ '' ].
	
	^ ZnOAuth2ConsumerData 
			key: client_id
			secret: client_secret
			redirectUrl: redirect_url

]

{ #category : #registration }
GoogleApiProxy >> registrationCredentialsFile [
	registrationCredentialsFile ifNil: [ | dir fn |
		dir := FileSystem workingDirectory.
		fn := ( GoogleApiTools replaceInvalidPathChars: self apiName ), '.', self id, '.config.json'.
		fn := dir / 'google_api_data' / fn.
		registrationCredentialsFile := fn fullName ].
	
	^ registrationCredentialsFile

]

{ #category : #registration }
GoogleApiProxy >> registrationCredentialsFile: aFileName [
	registrationCredentialsFile := aFileName

]

{ #category : #utilities }
GoogleApiProxy >> replacePlaceholdersIn: aTemplateString with: aDictionary [ 
	| template params w reg |
	
	" 
	GoogleApiTools replacePlaceholders: 'I am a {param}' 
		with: { 'param' -> 'test' } asDictionary 
	"
	
	template := aTemplateString.
	template ifNil: [ template := '' ]
			ifNotNil: [ template := template asString ].
	
	params := aDictionary.
	params ifNil: [ params := Dictionary new ].
	
	reg := '({([a-zA-Z0-9_]+)})' asRegex.
	w := aTemplateString 
			copyWithRegex: '{[a-zA-Z0-9_]+}' 
			matchesTranslatedUsing: [ :placeholder || key value |
				reg matchesPrefix: placeholder.
				key := reg subexpression: 3.
				value := aDictionary at: key ifAbsent: [ reg subexpression: 2 ].
				value asString
			].
	^ w
]

{ #category : #api }
GoogleApiProxy >> scopes [
	self subclassResponsibility
]

{ #category : #accessing }
GoogleApiProxy >> session [
	^ session
]
