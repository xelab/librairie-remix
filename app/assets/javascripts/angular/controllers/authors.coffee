@AuthorsCtrl = ['$scope', '$http', '$timeout', 'Author', ($scope, $http, $timeout, Author) ->

  $http.get('/authors.json').success (data) ->
    $scope.authors = data.authors

]