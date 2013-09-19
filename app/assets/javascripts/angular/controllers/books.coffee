@BooksCtrl = ['$scope', '$http', '$timeout', ($scope, $http, $timeout) ->

  $http.get("/books/index.json").success (data) ->
    $scope.books = data.books
]