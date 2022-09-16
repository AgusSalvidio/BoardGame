Class {
	#name : #BaselineOfBoardGame,
	#superclass : #BaselineOf,
	#category : #BaselineOfBoardGame
}

{ #category : #baselines }
BaselineOfBoardGame >> baseline: spec [

	<baseline>
	spec for: #pharo do: [ 
		self
			setUpDependenciesIn: spec;
			setUpPackagesIn: spec;
			setUpGroupsIn: spec
		]
]

{ #category : #'private - dependencies set up' }
BaselineOfBoardGame >> baselineNameOf: aDependencyRepresentation [

	^ aDependencyRepresentation at: #baselineName
]

{ #category : #'private - dependencies accessing' }
BaselineOfBoardGame >> buoyDependency [

	^ self dependencyTo: 'Buoy' hostedIn: 'github://ba-st/Buoy:v6/source'
]

{ #category : #'private - dependencies set up' }
BaselineOfBoardGame >> configure: aDependency asDependencyIn: aSpec [

	aSpec
		baseline: (self baselineNameOf: aDependency)
		with: [ aSpec repository: (self repositoryOf: aDependency) ]
]

{ #category : #'private - packages set up' }
BaselineOfBoardGame >> configure: aPackage asPackageIn: aSpec [

	aSpec
		package: (self packageNameOf: aPackage)
		with: [ aSpec requires: (self requirementNamesOf: aPackage) ]
]

{ #category : #'private - model package accessing' }
BaselineOfBoardGame >> coreModelPackage [

	^ self
		  packageNamed: 'BoardGame-Core-Model'
		  requiring: #('Buoy' 'BoardGame-Sum-Model' 'BoardGame-SortingCriterion-Model')
]

{ #category : #'private - test package accessing' }
BaselineOfBoardGame >> coreTestPackage [

	^ self
		  packageNamed: 'BoardGame-Core-Model-Tests'
		  requiring: 'BoardGame-Core-Model'
]

{ #category : #'private - dependencies set up' }
BaselineOfBoardGame >> dependencies [

	^ OrderedCollection new
		  add: self buoyDependency;
		  yourself
]

{ #category : #'private - dependencies set up' }
BaselineOfBoardGame >> dependencyTo: aBaselineName hostedIn: aRepository [

	^ Dictionary new
		  at: #baselineName put: aBaselineName;
		  at: #repository put: aRepository;
		  yourself
]

{ #category : #'private - groups set up' }
BaselineOfBoardGame >> modelPackageNames [

	^ self packageNamesFrom: self modelPackages
]

{ #category : #'private - accessing' }
BaselineOfBoardGame >> modelPackages [

	^ OrderedCollection 
		with: self coreModelPackage
		with: self tileModelPackage
]

{ #category : #'private - packages set up' }
BaselineOfBoardGame >> packageNameOf: aPackageRepresentation [

	^ aPackageRepresentation at: #packageName
]

{ #category : #'private - packages set up' }
BaselineOfBoardGame >> packageNamed: aPackageName requiring: aRequirementNameCollection [

	^ Dictionary new
		  at: #packageName put: aPackageName;
		  at: #requirementNames put: aRequirementNameCollection;
		  yourself
]

{ #category : #'private - groups set up' }
BaselineOfBoardGame >> packageNamesFrom: aPackageRepresentationCollection [

	^ aPackageRepresentationCollection collect: [ :aPackageRepresentation | 
		  self packageNameOf: aPackageRepresentation ]
]

{ #category : #'private - accessing' }
BaselineOfBoardGame >> packages [

	^ OrderedCollection new
		  addAll: self modelPackages;
		  addAll: self testPackages;
		  yourself
]

{ #category : #baselines }
BaselineOfBoardGame >> projectClass [

	^ MetacelloCypressBaselineProject
]

{ #category : #'private - dependencies set up' }
BaselineOfBoardGame >> repositoryOf: aDependency [

	^ aDependency at: #repository
]

{ #category : #'private - packages set up' }
BaselineOfBoardGame >> requirementNamesOf: aPackageRepresentation [

	^ aPackageRepresentation at: #requirementNames
]

{ #category : #'private - dependencies set up' }
BaselineOfBoardGame >> setUpDependenciesIn: spec [

	self dependencies do: [ :dependency | 
		self configure: dependency asDependencyIn: spec ]
]

{ #category : #'private - groups set up' }
BaselineOfBoardGame >> setUpGroupsIn: spec [

	spec
		group: 'Deployment' with: self modelPackageNames;
		group: 'Tests' with: self testPackageNames;
		group: 'CI' with: 'Tests';
		group: 'Tools' with: #(  );
		group: 'Dependent-SUnit-Extensions' with: #(  );
		group: 'Development' with: #( 'Tools' 'Tests' )
]

{ #category : #'private - packages set up' }
BaselineOfBoardGame >> setUpPackagesIn: aSpec [

	self packages do: [ :package | 
		self configure: package asPackageIn: aSpec ]
]

{ #category : #'private - test package accessing' }
BaselineOfBoardGame >> sortingCriterionTestPackage [

	^ self
		  packageNamed: 'BoardGame-SortingCriterion-Model-Tests'
		  requiring: 'BoardGame-SortingCriterion-Model'
]

{ #category : #'private - test package accessing' }
BaselineOfBoardGame >> sumTestPackage [

	^ self
		  packageNamed: 'BoardGame-Sum-Model-Tests'
		  requiring: 'BoardGame-Sum-Model'
]

{ #category : #'private - packages set up' }
BaselineOfBoardGame >> testPackageNames [

	^ self packageNamesFrom: self testPackages
]

{ #category : #'private - packages set up' }
BaselineOfBoardGame >> testPackages [

	^ OrderedCollection 
		with: self coreTestPackage
		with: self tileTestPackage
		with: self sumTestPackage
		with: self sortingCriterionTestPackage
]

{ #category : #'private - model package accessing' }
BaselineOfBoardGame >> tileModelPackage [

	^ self
		  packageNamed: 'BoardGame-Tile-Model'
		  requiring: #('BoardGame-Core-Model')
]

{ #category : #'private - test package accessing' }
BaselineOfBoardGame >> tileTestPackage [

	^ self
		  packageNamed: 'BoardGame-Tile-Model-Tests'
		  requiring: 'BoardGame-Tile-Model'
]
