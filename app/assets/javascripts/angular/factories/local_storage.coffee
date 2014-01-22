angular.module('nsrx').
factory('local_storage', ['$log', ($log) ->
  get: (key) ->
    try
      val = localStorage.getItem(key)
      val = JSON.parse(val) if val
    catch e
      $log.error e
      @clear()
      null
  set: (key, val) ->
    localStorage.setItem(key, JSON.stringify(val))
  del: (key) ->
    localStorage.removeItem(key) if localStorage.getItem(key)
  clear: ->
    localStorage.clear()
])
