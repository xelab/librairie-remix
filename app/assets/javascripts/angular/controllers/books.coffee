@app.filter "arrayDisplay", ->
  (dataArray) ->
    domEls = ""
    i = 0
    len = dataArray.length

    while i < len
      unless (i + 1) is len
        domEls += dataArray[i] + ", "
      else
        domEls += dataArray[i]
      i++
    domEls

@BooksCtrl = ['$scope', '$http', '$timeout', 'Author', 'Publisher', 'Collection', 'Distributor', 'Tag', ($scope, $http, $timeout, Author, Publisher, Collection, Distributor, Tag) ->

  $scope.pagingOptions = 
    pageSizes: [50, 200, 500, 1000]
    pageSize: 50
    currentPage: 1

  $scope.filterType = 'title'

  $scope.filterOptions =
    filterText: ''

  $scope.selectedRows=[]
  $scope.gridOptions = 
    data: 'books'
    rowHeight: 30
    # rowTemplate: '<div ng-style="{ \'cursor\': row.cursor }" ng-repeat="col in renderedColumns" ng-class="col.colIndex()" class="ngCell {{col.cellClass}}"><div class="ngVerticalBar" ng-style="{height: rowHeight}" ng-class="{ ngVerticalBarVisible: !$last }">&nbsp;</div><div ng-cell ng-click="open(row)"></div></div>'
    columnDefs: [{field:'title', displayName: 'Titre'},
                {field:'buy', displayName: 'Stock achats fermes'},
                {field:'deposit', displayName: 'Stock dépôts'},
                {field:'isbn', displayName: 'ISBN'},
                {field:'price', displayName: 'Prix'},
                {field:'release', displayName: 'Date édition', visible: false},
                {field:'authors', displayName: 'Auteurs', cellTemplate: '<div class="ngCellText">{{row.getProperty(col.field) | arrayDisplay}}</div>'},
                {field:'tags', displayName: 'Catégories', cellTemplate: '<div class="ngCellText">{{row.getProperty(col.field) | arrayDisplay}}</div>'}]
    showColumnMenu: true
    enablePaging: true
    pagingOptions: $scope.pagingOptions
    showFooter: true
    # showFilter: true
    # showGroupPanel: true
    jqueryUIDraggable: true
    multiSelect: false
    selectedItems: $scope.selectedRows
    filterOptions: $scope.filterOptions
    afterSelectionChange: (rowItem, event) -> $scope.open(rowItem, event)

  $scope.$watch "filterGrid", (newText) ->
    if newText
      switch $scope.filterType
        when 'title'
          $scope.filterOptions.filterText = "title: " + newText
        when 'author'
          $scope.filterOptions.filterText = "authors: " + newText
        when 'tag'
          $scope.filterOptions.filterText = "tags: " + newText
        when 'isbn'
          $scope.filterOptions.filterText = "isbn: " + newText 
    else
      $scope.filterOptions.filterText = ''
  
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


  $scope.publishers = []
  $scope.books = []
  $scope.fullBooks = []
  $scope.authors = []
  $scope.distributors = []
  $scope.tags = []

  $http.get("/books.json").success (data) ->
    $scope.publishers = data.publishers
    $scope.books = data.books
    $scope.fullBooks = data.books
    $scope.authors = data.authors
    $scope.distributors = data.distributors
    $scope.tags = data.tags

  $scope.open = ->
    $scope.edit = yes
    $scope.currentBook = angular.copy($scope.selectedRows[0])
    console.log $scope.selectedRows
    $scope.currentBook.author_ids = _.map($scope.currentBook.author_ids, (id) -> id.toString()) if $scope.currentBook.author_ids
    $scope.currentBook.distributor_ids = _.map($scope.currentBook.distributor_ids, (id) -> id.toString()) if $scope.currentBook.distributor_ids
    $scope.currentBook.tag_ids = _.map($scope.currentBook.tag_ids, (id) -> id.toString()) if $scope.currentBook.tag_ids
    $scope.setPublisher()

    $timeout ->
      # waiting for working ng-select2...
      $("#author").select2()
      $("#tag").select2()
      $('#editModal').modal()
      

  $scope.createBook = ->
    $http.post('/books', book: $scope.book).success (data) ->
      $scope.book.id = data
      if $scope.book.author_ids.length > 0
        authorsBook = []
        authors = _.filter($scope.authors, (author) -> _.contains($scope.book.author_ids, "" + author.id))
        for author in authors
          if author.firstname?
            authorsBook.push author.lastname + " " + author.firstname
          else
            authorsBook.push author.lastname
        $scope.book.authors = authorsBook
      if $scope.book.tag_ids.length > 0
        tagsBook = []
        tags = _.filter($scope.tags, (tag) -> _.contains($scope.book.tag_ids, "" + tag.id))
        (tagsBook.push(tag.name)) for tag in tags
        $scope.book.tags = tagsBook

      $scope.books.push $scope.book
      $timeout ->
        $scope.initializeBook()

  $scope.updateBook = ->
    $http.put('/books/' + $scope.currentBook.id, book: $scope.currentBook).success (data) ->
      $scope.edit = no
      $('#editModal').modal('hide')
      if $scope.currentBook.author_ids.length > 0
        $scope.currentBook.author_ids = _.map($scope.currentBook.author_ids, (id) -> parseInt(id))
        authorsBook = []
        authors = _.filter($scope.authors, (author) -> _.contains($scope.currentBook.author_ids, author.id))
        for author in authors
          if author.firstname?
            authorsBook.push author.lastname + " " + author.firstname
          else
            authorsBook.push author.lastname
        $scope.currentBook.authors = authorsBook

      if $scope.currentBook.tag_ids.length > 0
        $scope.currentBook.tag_ids = _.map($scope.currentBook.tag_ids, (id) -> parseInt(id))
        tagsBook = []
        tags = _.filter($scope.tags, (tag) -> _.contains($scope.currentBook.tag_ids, tag.id))
        (tagsBook.push(tag.name)) for tag in tags
        $scope.currentBook.tags = tagsBook

      (oldBook = book if book.id is $scope.currentBook.id) for book in $scope.books
      # Problem in ng-grid, not watching deep changes
      books = angular.copy($scope.books)
      books[_.indexOf($scope.books, oldBook)] = $scope.currentBook
      $scope.books = books

      $timeout ->
        $scope.$emit('ngGridEventEndCellEdit')
        $scope.initializeBook()

  $scope.createAuthor = ->
    $('.portBox').trigger('portBox:close')
    Author.save {}, author: $scope.author, (data) ->
      $scope.author.id = data.id
      $scope.authors.push $scope.author
      if $scope.edit
        $scope.currentBook.author_ids.push $scope.author.id
      else
        $scope.book.author_ids.push $scope.author.id
      $scope.author = {}

  $scope.$watch 'book.publisher_id', -> $scope.setPublisher()

  $scope.setPublisher = ->
    if $scope.currentBook.publisher_id || $scope.book.publisher_id
      if $scope.edit
        $scope.currentBook.publisher = _.findWhere($scope.publishers, {id: $scope.currentBook.publisher_id})
        unless $scope.currentBook.publisher.collections?
          $scope.currentBook.publisher.collections = []
      else
        $scope.book.publisher = _.findWhere($scope.publishers, {id: $scope.book.publisher_id})
        unless $scope.book.publisher.collections?
          $scope.book.publisher.collections = []

  $scope.createPublisher = ->
    $('.portBox').trigger('portBox:close')
    Publisher.save {}, publisher: $scope.publisher, (data) ->
      $scope.publisher.id = data.id
      $scope.publishers.push $scope.publisher
      if $scope.edit
        $scope.currentBook.publisher_id = $scope.publisher.id
      else
        $scope.book.publisher_id = $scope.publisher.id
      $scope.publisher = {}

  $scope.createCollection = ->
    $('.portBox').trigger('portBox:close')
    if $scope.edit
      $scope.collection.publisher_id = $scope.currentBook.publisher_id
    else
      $scope.collection.publisher_id = $scope.book.publisher_id
    Collection.save {}, collection: $scope.collection, (data) ->
      $scope.collection.id = data.id
      $scope.book.publisher.collections.push $scope.collection
      if $scope.edit
        $scope.currentBook.collection_id = $scope.collection.id
      else
        $scope.book.collection_id = $scope.collection.id
      $scope.collection = {}

  $scope.createDistributor = ->
    $('.portBox').trigger('portBox:close')
    Distributor.save {}, distributor: $scope.distributor, (data) ->
      $scope.distributor.id = data.id
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
        $scope.currentBook.tag_ids.push $scope.tag.id
      else
        $scope.book.tag_ids.push $scope.tag.id
      $scope.tag = {}

]