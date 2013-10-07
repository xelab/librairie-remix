@app.factory 'Collection', ['$resource', ($resource) ->

  $resource '/collections/:id', {id: '@id'},
    update:
      method: "PUT"

  ]