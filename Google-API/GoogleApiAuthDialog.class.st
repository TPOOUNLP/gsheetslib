"
Opens a Diallog to enter Google API authentication credentials
"
Class {
	#name : #GoogleApiAuthDialog,
	#superclass : #Object,
	#instVars : [
		'authUrl',
		'window',
		'code'
	],
	#category : #'Google-API'
}

{ #category : #'as yet unclassified' }
GoogleApiAuthDialog class >> open: anUrl [
	Smalltalk garbageCollect.
	^ self new
		authUrl: anUrl;
		openAsMorph

]

{ #category : #accessing }
GoogleApiAuthDialog >> authUrl [
	^ authUrl
]

{ #category : #accessing }
GoogleApiAuthDialog >> authUrl: anObject [
	authUrl := anObject
]

{ #category : #accessing }
GoogleApiAuthDialog >> btnCancelClick [
	code := nil.
	window delete

	
]

{ #category : #accessing }
GoogleApiAuthDialog >> btnCancelLabel [
	^ 'Cancel'
	
]

{ #category : #accessing }
GoogleApiAuthDialog >> btnCopyClick [
	authUrl ifNotNil: [
		Clipboard default clipboardText: authUrl ].
]

{ #category : #accessing }
GoogleApiAuthDialog >> btnCopyLabel [
	^ 'Copy URL'
]

{ #category : #accessing }
GoogleApiAuthDialog >> btnOkClick [
	window delete
]

{ #category : #accessing }
GoogleApiAuthDialog >> btnOkLabel [
	^ 'OK'
	
]

{ #category : #accessing }
GoogleApiAuthDialog >> code [
	^ code
]

{ #category : #accessing }
GoogleApiAuthDialog >> code: anObject [
	code := anObject
]

{ #category : #accessing }
GoogleApiAuthDialog >> infoText [
	^ (
			( Text withAll: 'Use your browser to go to this URL:', String cr, String cr ) , 
			( Text string: 'http://www.google.at' 
				attribute: ( TextURL new url: 'http://philippeback.eu' ) ),
			( Text withAll: String cr, String cr, 'and enter the code here:' )
		).
]

{ #category : #accessing }
GoogleApiAuthDialog >> initialExtent [
	^ 500@260
]

{ #category : #accessing }
GoogleApiAuthDialog >> openAsMorph [ 
	| m |
	
	window := (SystemWindow labelled: 'Google API authentication')
				model: self.
				
	window
		addMorph: ( m := LabelMorph new 
			contents: 'Browse to the following authentication URL:' )
		fullFrame: (LayoutFrame 
			fractions: (0@0 corner: 1@0)
			offsets: (0@0 corner: 0@20)).

	" auth url browser notice "
	window
		addMorph: ( m := PluggableTextMorph
			on: self
			text: #authUrl
			accept: nil
			readSelection: nil
			menu: nil)
		fullFrame: (LayoutFrame 
			fractions: (0@0 corner: 1@0)
			offsets: (0@20 corner: 0@120)).
		m disable.
		
	window
		addMorph: ( m := LabelMorph new 
			contents: 'Enter authentication code here:' )
		fullFrame: (LayoutFrame 
			fractions: (0@0 corner: 1@0)
			offsets: (0@130 corner: 0@150)).
	
	" code text field "
	window
		addMorph: ( m := PluggableTextMorph
			on: self
			text: #code
			accept: #code:
			readSelection: nil
			menu: nil)
		fullFrame: (LayoutFrame 
			fractions: (0@0 corner: 1@0)
			offsets: (0@150 corner: 0@180)).
	m autoAccept: true.
	m acceptOnCR: true.			

	" copy button "
	window
		addMorph: (PluggableButtonMorph
				on: self 
				getState: nil
				action: #btnCopyClick
				label: #btnCopyLabel)
			fullFrame: (LayoutFrame 
				fractions: (0@0 corner: 0.33@0)
				offsets: (0@190 corner: 0@220)).

	" Cancel Button "
	window
		addMorph: (PluggableButtonMorph
				on: self 
				getState: nil
				action: #btnOkClick
				label: #btnOkLabel)
			fullFrame: (LayoutFrame 
				fractions: (0.33@0 corner: 0.66@0)
				offsets: (0@190 corner: 0@220)).

	" OK button "
	window
		addMorph: (PluggableButtonMorph
				on: self 
				getState: nil
				action: #btnCancelClick
				label: #btnCancelLabel)
			fullFrame: (LayoutFrame 
				fractions: (0.66@0 corner: 1@0)
				offsets: (0@190 corner: 0@220)).
	
	window openModal.
	
	^ code

]
