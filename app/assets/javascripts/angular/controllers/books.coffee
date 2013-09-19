@BooksCtrl = ['$scope', '$http', '$timeout', ($scope, $http, $timeout) ->

  $http.get("/books/index.json").success (data) ->
    $scope.publishers = data.publishers
    $scope.books = data.books
    $scope.gridOptions = 
      data: '$scope.books'
]