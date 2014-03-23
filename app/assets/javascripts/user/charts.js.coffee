ns = initNamespaces('SITEMPLATE.user.charts')

ns.init = () ->
  goToSelected = ->
    option = $(@).find('option:selected')
    path = option.data('path')
    window.location = path

  $('select#course').change goToSelected
  $('select#language').change goToSelected
  $('select#unit').change goToSelected
  $('select#period').change goToSelected

