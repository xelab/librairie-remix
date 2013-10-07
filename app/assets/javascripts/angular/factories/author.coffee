@app.factory 'Author', ['$resource', ($resource) ->

  $resource '/authors/:id', {id: '@id'},
    update:
      method: "PUT"

  ]