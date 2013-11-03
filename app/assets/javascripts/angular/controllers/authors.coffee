@AuthorsCtrl = ['$scope', '$http', '$timeout', 'Author', ($scope, $http, $timeout, Author) ->

  $scope.authorPage = yes

  $http.get('/authors.json').success (data) ->
    $scope.authors = data


  $scope.pagingOptions = 
    pageSizes: [50, 200, 500, 1000]
    pageSize: 50
    currentPage: 1

  $scope.filterOptions =
    filterText: ''

  $scope.selectedRows = []

  $scope.gridOptions = 
    data: 'authors'
    rowHeight: 30
    rowTemplate: '<div ng-style="{ \'cursor\': row.cursor }" ng-repeat="col in renderedColumns" ng-class="col.colIndex()" class="ngCell {{col.cellClass}}"><div class="ngVerticalBar" ng-style="{height: rowHeight}" ng-class="{ ngVerticalBarVisible: !$last }">&nbsp;</div><div ng-cell data-display="authorBox""></div></div>'
    columnDefs: [{field:'lastname', displayName: 'Nom'},
                {field:'firstname', displayName: 'Prénom'},
                {field:'birthdate', displayName: 'Date naissance'},
                {field:'deathdate', displayName: 'Date décès'}
              ]
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

  $scope.open = ->
    # $('#authorBox').trigger('portBox:open')
    # $('.portBox').css {'display':'block'}
    $scope.author = angular.copy($scope.selectedRows[0])
]