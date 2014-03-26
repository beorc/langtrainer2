ns = initNamespaces('SITEMPLATE.user.charts.boxes')

ns.init = ->
  $.getScript 'https://www.google.com/jsapi', (data, textStatus) ->
    drawer = new SITEMPLATE.lib.chart.PieChartDrawer($('.chart.boxes'))

