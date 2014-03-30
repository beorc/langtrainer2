ns = initNamespaces('SITEMPLATE.user.charts.answers')

ns.init = ->
  $.getScript 'https://www.google.com/jsapi', (data, textStatus) ->
    drawer = new SITEMPLATE.lib.chart.BarChartDrawer($('.chart.answers'), gon.answers)
