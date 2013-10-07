@BooksCtrl = ['$scope', '$http', '$timeout', 'Author', 'Publisher', 'Collection', 'Distributor', 'Tag', ($scope, $http, $timeout, Author, Publisher, Collection, Distributor, Tag) ->

  $scope.gridOptions = 
    data: 'books'
    columnDefs: [{field:'title', displayName: 'Titre'},
                {field:'buy', displayName: 'Ferme'},
                {field:'deposit', displayName: 'Dépôt'},
                {field:'isbn', displayName: 'ISBN'},
                {field:'price', displayName: 'Prix'},
                {field:'release', displayName: 'Date édition', visible: false},
                {field:'summary', displayName: 'Résumé', visible: false}]
    showColumnMenu: true

  $scope.book = {}
  $scope.book.authors = []
  $scope.book.tags = []
  $scope.select2Options =
    allowClear: true
    multiple: true

  $http.get("/books.json").success (data) ->
    $scope.publishers = data.publishers
    $scope.books = data.books
    $scope.authors = data.authors
    $scope.distributors = data.distributors

  $scope.createBook = ->
    $http.post('/books', book: $scope.book).success (data) ->
      $scope.book.id = data
      $scope.books.push $scope.book
      $scope.book = {}

  $scope.createAuthor = ->
    $('.portBox').trigger('portBox:close')
    $scope.author.id = Author.save({}, author: $scope.author)
    $scope.authors.push $scope.author
    $scope.book.authors.push $scope.author.id
    $scope.author = {}

  $scope.createPublisher = ->
    $scope.publisher.id = Publisher.save({}, publisher: $scope.publisher)
    $scope.publishers.push $scope.publisher
    $scope.book.publisher_id = $scope.publisher.id

  $scope.createCollection = ->
    $scope.collection.id = Collection.save({}, collection: $scope.collection)
    $scope.collections.push $scope.collection
    $scope.book.collection_id = $scope.collection.id

  $scope.createDistributor = ->
    $scope.distributor.id = Distributor.save({}, distributor: $scope.distributor)
    $scope.distributors.push $scope.distributor
    $scope.book.distributor_id = $scope.distributor.id

  $scope.createTag = ->
    $scope.tag.id = Tag.save({}, tag: $scope.tag)
    $scope.tags.push $scope.tag
    $scope.book.tags.push $scope.tag.id

]