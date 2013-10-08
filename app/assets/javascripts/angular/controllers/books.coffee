@BooksCtrl = ['$scope', '$http', '$timeout', 'Author', 'Publisher', 'Collection', 'Distributor', 'Tag', ($scope, $http, $timeout, Author, Publisher, Collection, Distributor, Tag) ->

  $scope.gridOptions = 
    data: 'books'
    rowHeight: 35
    columnDefs: [{field:'title', displayName: 'Titre'},
                {field:'buy', displayName: 'Stock achats fermes'},
                {field:'deposit', displayName: 'Stock dépôts'},
                {field:'isbn', displayName: 'ISBN'},
                {field:'price', displayName: 'Prix'},
                {field:'release', displayName: 'Date édition', visible: false},
                {field:'authors', displayName: 'Auteurs', cellTemplate: '<span ng-repeat="author in row.entity[col.field]">{{author.lastname}} {{author.firstname}}<span ng-hide="$last">, </span></span>'},
                {field:'tags', displayName: 'Catégories', cellTemplate: '<span ng-repeat="tag in row.entity[col.field]">{{tag.name}}<span ng-hide="$last">, </span></span>'  }]
    showColumnMenu: true
    showFilter: true
    showGroupPanel: true
    jqueryUIDraggable: true
    multiSelect: false

  $scope.book = {}
  $scope.book.author_ids = []
  $scope.book.tag_ids = []
  $scope.book.tags = []
  $scope.book.authors = []
  $scope.select2Options =
    allowClear: true
    multiple: true

  $http.get("/books.json").success (data) ->
    $scope.publishers = data.publishers
    $scope.books = data.books
    $scope.authors = data.authors
    $scope.distributors = data.distributors
    $scope.tags = data.tags

  $scope.createBook = ->
    $http.post('/books', book: $scope.book).success (data) ->
      $scope.book.id = data
      $scope.books.push $scope.book
      $scope.book = {}

  $scope.createAuthor = ->
    $('.portBox').trigger('portBox:close')
    $scope.author.id = Author.save({}, author: $scope.author)
    $scope.authors.push $scope.author
    $scope.book.author_ids.push $scope.author.id
    $scope.author = {}

  $scope.createPublisher = ->
    $('.portBox').trigger('portBox:close')
    $scope.publisher.id = Publisher.save({}, publisher: $scope.publisher)
    $scope.publishers.push $scope.publisher
    $scope.book.publisher_id = $scope.publisher.id
    $scope.publisher = {}

  $scope.createCollection = ->
    $('.portBox').trigger('portBox:close')
    $scope.collection.publisher_id = $scope.publisher.id
    $scope.collection.id = Collection.save({}, collection: $scope.collection)
    $scope.publisher.collections.push $scope.collection
    $scope.book.collection_id = $scope.collection.id
    $scope.collection = {}

  $scope.createDistributor = ->
    $('.portBox').trigger('portBox:close')
    $scope.distributor.id = Distributor.save({}, distributor: $scope.distributor)
    $scope.distributors.push $scope.distributor
    $scope.book.distributor_id = $scope.distributor.id
    $scope.distributor = {}

  $scope.createTag = ->
    $('.portBox').trigger('portBox:close')
    Tag.save {}, tag: $scope.tag, (data) ->
      $scope.tag.id = data.id
      $scope.tags.push $scope.tag
      $scope.book.tag_ids.push "" + $scope.tag.id
      $scope.tag = {}

]