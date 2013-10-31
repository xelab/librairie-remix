@app = angular.module 'Librairie', ['ngResource', 'ui.bootstrap', 'ui.select2', 'ngGrid']

@app
  .config(['$httpProvider', ($httpProvider) ->
    $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
  ])

$(document).on('ready page:load', ->
  angular.bootstrap("body", ['Librairie'])
)