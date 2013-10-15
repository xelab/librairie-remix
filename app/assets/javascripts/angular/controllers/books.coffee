@BooksCtrl = ['$scope', '$http', '$timeout', 'Author', 'Publisher', 'Collection', 'Distributor', 'Tag', ($scope, $http, $timeout, Author, Publisher, Collection, Distributor, Tag) ->


  $scope.pagingOptions = 
    pageSizes: [50, 200, 500, 1000]
    pageSize: 50
    currentPage: 1

  $scope.selectedRows=[]
  $scope.gridOptions = 
    data: 'books'
    rowHeight: 35
    # rowTemplate: '<div ng-style="{ \'cursor\': row.cursor }" ng-repeat="col in renderedColumns" ng-class="col.colIndex()" class="ngCell {{col.cellClass}}"><div class="ngVerticalBar" ng-style="{height: rowHeight}" ng-class="{ ngVerticalBarVisible: !$last }">&nbsp;</div><div ng-cell ng-click="open(row)"></div></div>'
    columnDefs: [{field:'title', displayName: 'Titre'},
                {field:'buy', displayName: 'Stock achats fermes'},
                {field:'deposit', displayName: 'Stock dépôts'},
                {field:'isbn', displayName: 'ISBN'},
                {field:'price', displayName: 'Prix'},
                {field:'release', displayName: 'Date édition', visible: false},
                {field:'authors', displayName: 'Auteurs', cellTemplate: '<div class="ngCellText"><span ng-repeat="author in row.entity[col.field]">{{author.lastname}} {{author.firstname}}<span ng-hide="$last">, </span></span></div>'},
                {field:'tags', displayName: 'Catégories', cellTemplate: '<div class="ngCellText"><span ng-repeat="tag in row.entity[col.field]">{{tag.name}}<span ng-hide="$last">, </span></span></div>'  }]
    showColumnMenu: true
    enablePaging: true
    pagingOptions: $scope.pagingOptions
    showFooter: true
    # showFilter: true
    # showGroupPanel: true
    jqueryUIDraggable: true
    multiSelect: false
    selectedItems: $scope.selectedRows
    afterSelectionChange: (rowItem, event) -> $scope.open(rowItem, event)


  
  $scope.select2Options =
    allowClear: true
    multiple: true

  $scope.initializeBook = ->
    $scope.book = {}
    $scope.book.author_ids = []
    $scope.book.tag_ids = []
    $scope.book.tags = []
    $scope.book.authors = []
    $scope.currentBook = {}
    $scope.currentBook.author_ids = []
    $scope.currentBook.tag_ids = []
    $scope.currentBook.tags = []
    $scope.currentBook.authors = []

  $scope.initializeBook()

  $http.get("/books.json").success (data) ->
    $scope.publishers = data.publishers
    $scope.books = data.books
    $scope.authors = data.authors
    $scope.distributors = data.distributors
    $scope.tags = data.tags

  $scope.open = ->
    $scope.currentBook = angular.copy($scope.selectedRows[0])
    $scope.edit = yes
    $('#editModal').modal()

  $scope.createBook = ->
    $http.post('/books', book: $scope.book).success (data) ->
      $scope.book.id = data
      if $scope.book.author_ids.length > 0
        $scope.book.authors = _.filter($scope.authors, (author) -> _.contains($scope.book.author_ids, "" + author.id))

      if $scope.book.tag_ids.length > 0
        $scope.book.tags = _.filter($scope.tags, (tag) -> _.contains($scope.book.tag_ids, "" + tag.id))

      $scope.books.push $scope.book
      $timeout ->
        $scope.initializeBook()

  $scope.updateBook = ->
    $http.put('/books/' + $scope.currentBook.id, book: $scope.currentBook).success (data) ->
      $scope.edit = no
      $('#editModal').modal('hide')
      if $scope.currentBook.author_ids.length > 0
        $scope.currentBook.author_ids = _.map($scope.currentBook.author_ids, (id) -> parseInt(id))
        $scope.currentBook.authors = _.filter($scope.authors, (author) -> _.contains($scope.currentBook.author_ids, author.id))

      if $scope.currentBook.tag_ids.length > 0
        $scope.currentBook.tag_ids = _.map($scope.currentBook.tag_ids, (id) -> parseInt(id))
        $scope.currentBook.tags = _.filter($scope.tags, (tag) -> _.contains($scope.currentBook.tag_ids, tag.id))

      console.log  $scope.currentBook
      (oldBook = book if book.id is $scope.currentBook.id) for book in $scope.books
      # books = $scope.books.splice(_.indexOf($scope.books, oldBook), 2, $scope.currentBook)
      # Problem in ng-grid, not watching changes
      i = _.indexOf($scope.books, oldBook)
      books = angular.copy($scope.books)
      books.splice(i, 1, $scope.currentBook)
      $scope.books = books
      $timeout ->
        $scope.$emit('ngGridEventEndCellEdit')
        $scope.initializeBook()

  $scope.createAuthor = ->
    $('.portBox').trigger('portBox:close')
    $scope.author.id = Author.save({}, author: $scope.author)
    $scope.authors.push $scope.author
    if $scope.edit
      $scope.currentBook.author_ids.push $scope.author.id
    else
      $scope.book.author_ids.push $scope.author.id
    $scope.author = {}

  $scope.createPublisher = ->
    $('.portBox').trigger('portBox:close')
    $scope.publisher.id = Publisher.save({}, publisher: $scope.publisher)
    $scope.publishers.push $scope.publisher
    if $scope.edit
      $scope.currentBook.publisher_id = $scope.publisher.id
    else
      $scope.book.publisher_id = $scope.publisher.id
    $scope.publisher = {}

  $scope.createCollection = ->
    $('.portBox').trigger('portBox:close')
    $scope.collection.publisher_id = $scope.publisher.id
    $scope.collection.id = Collection.save({}, collection: $scope.collection)
    $scope.publisher.collections.push $scope.collection
    if $scope.edit
      $scope.currentBook.collection_id = $scope.collection.id
    else
      $scope.book.collection_id = $scope.collection.id
    $scope.collection = {}

  $scope.createDistributor = ->
    $('.portBox').trigger('portBox:close')
    $scope.distributor.id = Distributor.save({}, distributor: $scope.distributor)
    $scope.distributors.push $scope.distributor
    if $scope.edit
      $scope.currentBook.distributor_id = $scope.distributor.id
    else
      $scope.book.distributor_id = $scope.distributor.id
    $scope.distributor = {}

  $scope.createTag = ->
    $('.portBox').trigger('portBox:close')
    Tag.save {}, tag: $scope.tag, (data) ->
      $scope.tag.id = data.id
      $scope.tags.push $scope.tag
      if $scope.edit
        $scope.currentBook.tag_ids.push "" + $scope.tag.id
      else
        $scope.book.tag_ids.push "" + $scope.tag.id
      $scope.tag = {}

]