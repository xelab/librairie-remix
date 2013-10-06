@BooksCtrl = ['$scope', '$http', '$timeout', ($scope, $http, $timeout) ->

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

  $http.get("/books.json").success (data) ->
    $scope.publishers = data.publishers
    $scope.books = data.books
    $scope.authors = data.authors
    $scope.distributors = data.distributors

  $scope.book = {}
  $scope.select2Options =
    allowClear: true
    multiple: true


  $scope.createBook = ->
    $http.post('/books', book: $scope.book).success (data) ->
      $scope.book.id = data
      $scope.books.push $scope.book
      $scope.book = {}

]