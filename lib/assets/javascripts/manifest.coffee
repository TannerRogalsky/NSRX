@ManifestHelper =
  cache: window.applicationCache

  update_if_needed: ->
    return if ManifestHelper.cache.status == ManifestHelper.cache.UNCACHED
    try
      console.log 'Updating cache manifest...'
      ManifestHelper.cache.update()
    catch e
      console.log 'Failed cache manifest update', e
