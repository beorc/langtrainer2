ns = initNamespaces('SITEMPLATE.user.charts.hints')

ns.init = () ->
  ctx = $('.chart.words_helped').get(0).getContext('2d')
  chart = new Chart(ctx).Bar(gon.words_helped)

  ctx = $('.chart.steps_helped').get(0).getContext('2d')
  chart = new Chart(ctx).Bar(gon.steps_helped)
