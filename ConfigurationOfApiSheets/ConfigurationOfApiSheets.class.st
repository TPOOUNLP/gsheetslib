"
Please comment me using the following template inspired by Class Responsibility Collaborator (CRC) design:

For the Class part:  State a one line summary. For example, ""I represent a paragraph of text"".

For the Responsibility part: Three sentences about my main responsibilities - what I do, what I know.

For the Collaborators Part: State my main collaborators and one line about how I interact with them. 

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	project:		<Object>


    Implementation Points
"
Class {
	#name : #ConfigurationOfApiSheets,
	#superclass : #Object,
	#instVars : [
		'project'
	],
	#classVars : [
		'LastVersionLoad'
	],
	#category : #ConfigurationOfApiSheets
}

{ #category : #'development support' }
ConfigurationOfApiSheets class >> DevelopmentSupport [

"See the methods in the 'development support' category on the class-side of MetacelloBaseConfiguration. Decide what development support methods you would like to use and copy them the the class-side of your configuration."
	<apiDocumentation>
]

{ #category : #private }
ConfigurationOfApiSheets class >> baseConfigurationClassIfAbsent: aBlock [

	^Smalltalk
		at: #'ConfigurationOf'
		ifAbsent: [ 
			self ensureMetacelloBaseConfiguration.
			Smalltalk at: #'ConfigurationOf' ifAbsent: aBlock ].
]

{ #category : #private }
ConfigurationOfApiSheets class >> ensureMetacello [

	(self baseConfigurationClassIfAbsent: []) ensureMetacello
]

{ #category : #private }
ConfigurationOfApiSheets class >> ensureMetacelloBaseConfiguration [
  Smalltalk
    at: #'ConfigurationOf'
    ifAbsent: [ 
      | repository version |
      repository := MCHttpRepository
        location: 'http://smalltalkhub.com/mc/dkh/metacello/main'
        user: ''
        password: ''.
      repository
        versionReaderForFileNamed: 'Metacello-Base-dkh.107'
        do: [ :reader | 
          version := reader version.
          version load.
          version workingCopy repositoryGroup addRepository: repository ] ]
]

{ #category : #'metacello tool support' }
ConfigurationOfApiSheets class >> isMetacelloConfig [
	"Answer true and the Metacello tools will operate on you"
	
	^true
]

{ #category : #loading }
ConfigurationOfApiSheets class >> load [
	"Load the #stable version defined for this platform. The #stable version is the version that is recommended to be used on this platform."

	"self load"

	<apiDocumentation>
	^(self project version: #stable) load
]

{ #category : #loading }
ConfigurationOfApiSheets class >> loadBleedingEdge [
	"Load the latest versions of the mcz files defined for this project. It is not likely that the #bleedingEdge has been tested."

	"self loadBleedingEdge"

	<apiDocumentation>
	^(self project version: #bleedingEdge) load
]

{ #category : #loading }
ConfigurationOfApiSheets class >> loadDevelopment [
	"Load the #development version defined for this platform. The #development version will change over time and is not expected to be stable."

	"self loadDevelopment"

	<apiDocumentation>
	^(self project version: #development) load
]

{ #category : #accessing }
ConfigurationOfApiSheets class >> project [

	^self new project
]

{ #category : #'development support' }
ConfigurationOfApiSheets class >> validate [
	"Check the configuration for Errors, Critical Warnings, and Warnings (see class comment for MetacelloMCVersionValidator for more information). 
	Errors identify specification issues that will result in unexpected behaviour when you load the configuration. 
	Critical Warnings identify specification issues that may result in unexpected behavior when you load the configuration.
	Warnings identify specification issues that are technically correct, but are worth take a look at."

	"self validate"

	<apiDocumentation>
	self ensureMetacello.
	^ ((Smalltalk at: #MetacelloToolBox) validateConfiguration: self debug: #() recurse: false) explore
]

{ #category : #accessing }
ConfigurationOfApiSheets >> baseline01: spec [
  <version: '0.1-baseline'>

  spec for: #common do: [ 
    spec blessing: #baseline.
    spec repository: 'https://catedras.lifia.info.unlp.edu.ar/monticello'.

    spec
      package: 'Google-API';
		package: 'GoogleSheet-TPOO2016' with: [ 
			spec requires: 'Google-API' ];
      package: 'GoogleSheet TestCases-TPOO2016' with: [ 
			spec requires: 'GoogleSheet-TPOO2016' ].
	]
]

{ #category : #accessing }
ConfigurationOfApiSheets >> customProjectAttributes [
    "Edit to return a collection of any custom attributes e.g. for conditional loading: Array with: #'Condition1' with: #'Condition2.
	For more information see: http://code.google.com/p/metacello/wiki/CustomProjectAttrributes "

    ^ #()
]

{ #category : #accessing }
ConfigurationOfApiSheets >> development: spec [
  <symbolicVersion: #'development'>

  spec for: #'common' version: '0.1-baseline'
]

{ #category : #accessing }
ConfigurationOfApiSheets >> project [
    ^ project
        ifNil: [ 
            "Bootstrap Metacello if it is not already loaded"
            self class ensureMetacello.
            project := MetacelloMCProject new projectAttributes: self customProjectAttributes.	"Create the Metacello project"
            (Smalltalk at: #'MetacelloVersionConstructor') on: self project: project.	"Construct the project"
            project loadType: #'linear'.	"change to #atomic if desired"
            project ]
]

{ #category : #accessing }
ConfigurationOfApiSheets >> version02: spec [
  <version: '0.2'>

  spec for: #common do: [ 
    spec blessing: #release.
    spec repository: 'https://catedras.lifia.info.unlp.edu.ar/monticello'.

    spec
		package: 'Google-API' with: 'Google-API-NicolasBrusasca.4';
      package: 'GoogleSheet-TPOO2016' with: [ 
			spec file: 'GoogleSheet-TPOO2016-NicolasBrusasca.11';
				  requires: 'Google-API' ];
      package: 'GoogleSheet TestCases-TPOO2016' with: [ 
			spec file: 'GoogleSheet TestCases-TPOO2016-NicolasBrusasca.6';
				  requires: 'GoogleSheet-TPOO2016' ].
	]
]
