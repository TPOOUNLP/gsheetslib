"
Opens a window allowing the user to discover all available Google services and to create proxy classes for a selected service API in a given package.
"
Class {
	#name : #GoogleApiBrowser,
	#superclass : #ComposableMorph,
	#instVars : [
		'discoverUrl',
		'apiListIndex',
		'selectedApi',
		'apiList',
		'apiNameList',
		'keyEventsDict',
		'categoryListIndex',
		'selectedCategory',
		'window'
	],
	#category : #'Google-API'
}

{ #category : #'as yet unclassified' }
GoogleApiBrowser class >> open [
	Smalltalk garbageCollect.
	^ self new openAsMorph
]

{ #category : #accesing }
GoogleApiBrowser >> apiList [
	^ apiList
]

{ #category : #accesing }
GoogleApiBrowser >> apiListIndex [
	^ apiListIndex
]

{ #category : #accesing }
GoogleApiBrowser >> apiListIndex: index [ 
	apiListIndex := index.
	selectedApi := apiList
				at: index
				ifAbsent: [].
	self changed: #apiListIndex.
	self changed: #selectedApiDescription.
]

{ #category : #accesing }
GoogleApiBrowser >> apiNameList [
	^ apiNameList
]

{ #category : #'event handling' }
GoogleApiBrowser >> btnCancelClick [
	window delete
]

{ #category : #'user interface' }
GoogleApiBrowser >> btnCancelLabel [
	^ 'Cancel'
]

{ #category : #'event handling' }
GoogleApiBrowser >> btnDiscoverClick [
	self updateApiList.
]

{ #category : #'user interface' }
GoogleApiBrowser >> btnDiscoverLabel [
	^ 'Discover URL:'
]

{ #category : #'event handling' }
GoogleApiBrowser >> btnGenerateClick [
	| apiDiscoverObj apiName category |

	category := ''.
	selectedCategory ifNotNil: [
		category := selectedCategory asString ].
	( category size < 1 ) ifTrue: [ 
		self abort: 'You must provide either an existing or a new category', String cr,
		'where the proxy classes should be generated' title: 'Unable to generate API'.
		^ nil ].
	
	( apiListIndex < 1) ifTrue: [ 
		self abort: 'You must select an API definition' title: 'Unable to generate API'.
		^ nil ].

	apiDiscoverObj := apiList at: apiListIndex ifAbsent: [ 
		self abort: 'Internal error. Selected API not found.' title: 'Unable to generate API'.
		^ nil ].

"apiDiscoverObj inspect."


	"apiName := apiDiscoverObj at: 'name' ifAbsent: [ 'unknown' ]."
	apiName := apiNameList at: apiListIndex ifAbsent: [ 'unknown' ].
	
	( self questionWithoutCancel: 
			'Generate Google API (', apiName, ')', String cr,
			'proxy classes in category (', category, ')' 
		title: 'Are you sure' ) ifTrue: [ 
			GoogleApiCreator createApi: apiDiscoverObj inCategory: category ].
	
]

{ #category : #'user interface' }
GoogleApiBrowser >> btnGenerateLabel [
	^ 'Generate'
]

{ #category : #accesing }
GoogleApiBrowser >> categoryListIndex [
	^ categoryListIndex
]

{ #category : #accesing }
GoogleApiBrowser >> categoryListIndex: index [ 
	categoryListIndex := index.
	selectedCategory := self categoryNameList
				at: index
				ifAbsent: [ nil ].
	self changed: #categoryListIndex.
	self changed: #txtCategory.
]

{ #category : #accesing }
GoogleApiBrowser >> categoryNameList [
	^ SystemOrganizer default categories sorted: [ :a :b | a < b ].
]

{ #category : #'as yet unclassified' }
GoogleApiBrowser >> initialize [
	super initialize.
	apiListIndex := 0.
	categoryListIndex := 0.
	discoverUrl := 'https://www.googleapis.com/discovery/v1/apis'.
	self
		updateApiList;
		apiListIndex: 1	.
]

{ #category : #'user interface' }
GoogleApiBrowser >> openAsMorph [ 
	| m |
	window := (SystemWindow labelled: 'Google API''s')
				model: self.

	"self deferredMessageRecipient: WorldState."

	" Discover URL & button "		
	window
		addMorph: ( m := self uiDiscoverUrl )
		fullFrame: (LayoutFrame
			fractions: (0@0 corner: 1@0)
			offsets: (0@0 corner: 0@30)).
	m color: window color.
	
	
	
	
	" API List "
	window 
		addMorph: ( m := self uiApiList )
		fullFrame: (LayoutFrame 
			fractions: (0@0 corner: 0.5@0.45)
			offsets: (0@30 corner: 0@0)).
	m color: window color.

	" API Description "
	window 
		addMorph: ( m := self uiApiDescription )
		fullFrame: (LayoutFrame 
			fractions: (0.5@0 corner: 1@0.45)
			offsets: (0@30 corner: 0@0)).	
	m color: window color.

	" Categoriy List "		
	window 
		addMorph: ( m := self uiCategoryList )
		fullFrame: (LayoutFrame 
			fractions: (0.0@0.45 corner: 0.5@1)
			offsets: (0@30 corner: 0@30 negated)).	
	m color: window color.
	
	" Action Panel "
	window 
		addMorph: ( m := self uiActionPanel )
		fullFrame: (LayoutFrame 
			fractions: (0.5@0.45 corner: 1@1)
			offsets: (0@30 corner: 0@30 negated)).	
	m color: window color.

	window setUpdatablePanesFrom: #(#processNameList #stackNameList ).
	(window setLabel: 'Google API''s') openInWorld.

	^ window
	
]

{ #category : #'as yet unclassified' }
GoogleApiBrowser >> processListKey: aKey from: aView [ 
	self perform: (self keyEventsDict at: aKey ifAbsent: [ ^ self ])
]

{ #category : #'as yet unclassified' }
GoogleApiBrowser >> processListMenu: menu [
	^menu addAllFromPragma: 'processBrowserProcessListMenu' target: self
]

{ #category : #'as yet unclassified' }
GoogleApiBrowser >> readApiDef: aUrl [
	| apiDef apiDefObj |
	
	apiNameList := OrderedCollection new.
	apiList := {}.
		
	[ apiDef := ZnEasy get: aUrl.
		( apiDef entity isKindOf: ZnStringEntity ) ifFalse: [
			self error: 'Invalid content received' ] 
	] on: Error do: [ :ex || msg |
		msg := ( ex messageText = String empty )
				ifTrue: [ ex asString ]
				ifFalse: [ ex messageText ].
		self abort: msg title: 'Unable to discover API'.
		 ^ nil ].
	
	( ( apiDef statusLine code < 200 ) or: [ apiDef statusLine code > 299 ] ) ifTrue: [ 
		UIManager default 
			abort: aUrl asString, String cr, 'returns ', apiDef statusLine code asString, ' ',
			apiDef statusLine reason title: 'Unable to discover API'.
		^ nil ].
	
	apiDefObj := NeoJSONReader fromString: apiDef entity string.

	apiList := apiDefObj at: 'items' ifAbsent: [ Array new ].

	( apiList isKindOf: Array ) ifFalse: [ Array new ].
	apiNameList := OrderedCollection new.
	apiList do: [ :i || title ver pref |
		title := i at: 'title' ifAbsent: [ nil ].
		ver := i at: 'version' ifAbsent: [ nil ].
		pref := i at: 'preferred' ifAbsent: [ false ].
		title ifNotNil: [ | w |
			w := title.
			ver ifNotNil: [ w := w, ' (', ver, ')' ].
			pref ifTrue: [ w := w, '*' ].
			apiNameList add: w ] ].


]

{ #category : #accesing }
GoogleApiBrowser >> selectedApiDescription [
	| txt desc title ver pref docLnk |
	
	txt := ''.
	selectedApi ifNil: [ ^txt ].
	
	desc := selectedApi at: 'description' ifAbsent: [ '' ].
	docLnk := selectedApi at: 'documentationLink' ifAbsent: [ '' ].
	
	title := selectedApi at: 'title' ifAbsent: [].
	ver := selectedApi at: 'version' ifAbsent: [].
	pref := selectedApi at: 'preferred' ifAbsent: [ false ].
	title ifNotNil: [ | w |
		w := title.
		ver ifNotNil: [ w := w, ' (', ver, ')' ].
		pref ifTrue: [ w := w, '*' ].
		apiNameList add: w ].
	
	txt := title.
	( txt size > 0) ifTrue: [ txt := txt, String cr, String cr ].
	
	( desc size > 0 ) ifTrue: [
		txt := txt, desc ].
	( txt size > 0) ifTrue: [ txt := txt, String cr, String cr ].
	
	txt := txt, 'Preferred: ', ( pref ifTrue: [ 'Yes' ] ifFalse: [ 'No' ] ).
	( txt size > 0) ifTrue: [ txt := txt, String cr, String cr ].
	
	(docLnk size > 0 ) ifTrue: [
		txt := txt, 'Link: ', docLnk ].
	
	
	^ txt
	
]

{ #category : #accesing }
GoogleApiBrowser >> txtCategory [
	^ selectedCategory
	
]

{ #category : #accesing }
GoogleApiBrowser >> txtCategory: aStringOrText [
	| index |
	
	selectedCategory := aStringOrText asString trimBoth.
	selectedCategory = String empty ifTrue: [ selectedCategory := nil ].
	
	index := self categoryNameList indexOf: selectedCategory ifAbsent: [ 0 ]. 	
	categoryListIndex := index.
	self changed: #categoryListIndex "]."

]

{ #category : #accesing }
GoogleApiBrowser >> txtDiscoverUrl [
	^ discoverUrl.
	
]

{ #category : #accesing }
GoogleApiBrowser >> txtDiscoverUrl: aUrl [
	discoverUrl := aUrl asString.
	
]

{ #category : #'user interface' }
GoogleApiBrowser >> uiActionPanel [
	| m |
	
	m := Morph new layoutPolicy: ProportionalLayout new.

	" Category label and txtbox "	
	m addMorph: (TextMorph new 
			contents: ' Actions')
		fullFrame: (LayoutFrame 
			fractions: (0@0 corner: 1@0)
			offsets: (0@7 corner: 100@30)).
			
	m addMorph: (self uiCategoryInput)
		fullFrame: (LayoutFrame 
			fractions: (0@0 corner: 1@0)
			offsets: (0@30 corner: 0@60)).
	
	" Generate and Cancel buttons "
	m addMorph: (PluggableButtonMorph
				on: self 
				getState: nil
				action: #btnGenerateClick
				label: #btnGenerateLabel)
			fullFrame: (LayoutFrame 
				fractions: (0@0 corner: 0.5@0)
				offsets: (0@80 corner: 0@110)).
		
	m addMorph: (PluggableButtonMorph
				on: self 
				getState: nil
				action: #btnCancelClick
				label: #btnCancelLabel)
			fullFrame: (LayoutFrame 
				fractions: (0.5@0 corner: 1@0)
				offsets: (0@80 corner: 0@110)).

	^ m

]

{ #category : #'user interface' }
GoogleApiBrowser >> uiApiDescription [
	| m dm |
	
	m := Morph new layoutPolicy: ProportionalLayout new.
	
	m addMorph: (TextMorph new 
			contents: ' Description')
		fullFrame: (LayoutFrame 
			fractions: (0@0 corner: 1@0)
			offsets: (0@7 corner: 100@30)).
		
	m addMorph: (dm := PluggableTextMorph
			on: self
			text: #selectedApiDescription
			accept: nil
			readSelection: nil
			menu: nil)
		fullFrame: (LayoutFrame 
			fractions: (0@0 corner: 1@1)
			offsets: (0@30 corner: 0@30)).
	dm disable.

	^ m
	
]

{ #category : #'user interface' }
GoogleApiBrowser >> uiApiList [
	| m |
	
	m := Morph new layoutPolicy: ProportionalLayout new.	
		
	m addMorph: (TextMorph new 
				contents: ' API''s')
			fullFrame: (LayoutFrame 
				fractions: (0@0 corner: 1@0)
				offsets: (0@7 corner: 100@30)).
				
	m addMorph: ((PluggableListMorph
				on: self
				list: #apiNameList
				selected: #apiListIndex
				changeSelected: #apiListIndex:
				menu: #apiListMenu:
				keystroke: #apiListKey:from:)
				enableDragNDrop: false)
			fullFrame: (LayoutFrame 
				fractions: (0@0 corner: 1@1)
				offsets: (0@30 corner: 0@30)).
				
	^ m.

]

{ #category : #'user interface' }
GoogleApiBrowser >> uiCategoryInput [
	| m dm |
	
	m := Morph new layoutPolicy: ProportionalLayout new.	
		
	"m addMorph: (PluggableButtonMorph
				on: self 
				getState: nil
				action: #btnDiscoverClick
				label: #btnDiscoverLabel)
			fullFrame: (LayoutFrame 
				fractions: (0@0 corner: 0@0)
				offsets: (0@0 corner: 100@30))."
	m addMorph: (StringMorph new 
			contents: ' Category:')
		fullFrame: (LayoutFrame 
			fractions: (0@0 corner: 0@0)
			offsets: (0@6 corner: 70@30)).
	m color: window color.
		
	m addMorph: (dm := PluggableTextMorph
				on: self
				text: #txtCategory
				accept: #txtCategory:
				readSelection: nil
				menu: nil)
			"frame: (0.0 @ 0.0 extent: 1 @ 0.1)."
			"fullFrame: (LayoutFrame offsets: (0@0 corner: 100@50))."
			fullFrame: (LayoutFrame 
				fractions: (0@0 corner: 1@0)
				offsets: (70@0 corner: 0@30)).
	dm autoAccept: true.
	dm acceptOnCR: true.

	^ m
	
]

{ #category : #'user interface' }
GoogleApiBrowser >> uiCategoryList [
	| m |
	
	m := Morph new layoutPolicy: ProportionalLayout new.
	
	m addMorph: (TextMorph new 
			contents: ' Categories')
		fullFrame: (LayoutFrame 
			fractions: (0@0 corner: 1@0)
			offsets: (0@7 corner: 100@30)).

	m addMorph: ((PluggableListMorph
				on: self
				list: #categoryNameList
				selected: #categoryListIndex
				changeSelected: #categoryListIndex:
				menu: nil
				keystroke: nil)
				enableDragNDrop: false)
			fullFrame: (LayoutFrame 
				fractions: (0@0 corner: 1@1)
				offsets: (0@30 corner: 0@30)).

	^ m

]

{ #category : #'user interface' }
GoogleApiBrowser >> uiDiscoverUrl [
	| m dm |
	
	m := Morph new layoutPolicy: ProportionalLayout new.	
		
	m addMorph: (PluggableButtonMorph
				on: self 
				getState: nil
				action: #btnDiscoverClick
				label: #btnDiscoverLabel)
			fullFrame: (LayoutFrame 
				fractions: (0@0 corner: 0@0)
				offsets: (0@0 corner: 100@30)).
		
	m addMorph: (dm := PluggableTextFieldMorph
				on: self
				text: #txtDiscoverUrl
				accept: #txtDiscoverUrl:
				readSelection: nil
				menu: nil)
			"frame: (0.0 @ 0.0 extent: 1 @ 0.1)."
			"fullFrame: (LayoutFrame offsets: (0@0 corner: 100@50))."
			fullFrame: (LayoutFrame 
				fractions: (0@0 corner: 1@0)
				offsets: (100@0 corner: 0@30)).
	dm autoAccept: true.
	dm acceptOnCR: true.
	
	^ m
	
]

{ #category : #'as yet unclassified' }
GoogleApiBrowser >> updateApiList [
	| oldSelectedApi newIndex |

	oldSelectedApi := selectedApi.
	apiList := selectedApi := nil.

	self readApiDef: discoverUrl.
		
	newIndex := apiList
				indexOf: oldSelectedApi
				ifAbsent: [ ( apiList size > 0 )
					ifTrue: [ 1 ]
					ifFalse: [ 0 ] ].
				
	self changed: #apiNameList.
	self apiListIndex: newIndex

]
