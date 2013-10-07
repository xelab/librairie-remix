@app.factory 'Distributor', ['$resource', ($resource) ->

  $resource '/distributors/:id', {id: '@id'},
    update:
      method: "PUT"

  ]