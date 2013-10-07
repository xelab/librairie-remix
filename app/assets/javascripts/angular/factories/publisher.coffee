@app.factory 'Publisher', ['$resource', ($resource) ->

  $resource '/publishers/:id', {id: '@id'},
    update:
      method: "PUT"

  ]