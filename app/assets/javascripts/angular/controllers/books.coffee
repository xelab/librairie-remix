@BooksCtrl = ['$scope', '$http', '$timeout', ($scope, $http, $timeout) ->

  $http.get("/books/index.json").success (data) ->
    $scope.publishers = data.publishers
    $scope.books = data.books
    $scope.authors = data.authors
    $scope.gridOptions = 
      data: '$scope.books'

  $scope.book = {}
  $scope.select2Options =
    allowClear: true
    multiple: true

]