ns = initNamespaces('SITEMPLATE.user.charts.hints')

ns.init = ->
  $.getScript 'https://www.google.com/jsapi', (data, textStatus) ->
    drawer = new SITEMPLATE.lib.chart.BarChartDrawer($('.chart.hints'), gon.hints)
