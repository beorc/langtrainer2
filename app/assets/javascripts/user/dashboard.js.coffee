ns = initNamespaces('SITEMPLATE.user.dashboard')

ns.init = ->
  $.getScript 'https://www.google.com/jsapi', (data, textStatus) ->
    $('.course').each ->
      course = $(@)
      id = course.data('id')
      drawer = new SITEMPLATE.lib.chart.BarChartDrawer(course.find('.chart'), gon.answers[id])

