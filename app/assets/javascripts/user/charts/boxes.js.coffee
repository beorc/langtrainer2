ns = initNamespaces('SITEMPLATE.user.charts.boxes')

ns.init = () ->
  ctx = $('.chart.boxes').get(0).getContext('2d')
  chart = new Chart(ctx).Bar(gon.boxes)
