@app.factory 'Tag', ['$resource', ($resource) ->

  $resource '/tags/:id', {id: '@id'},
    update:
      method: "PUT"

  ]