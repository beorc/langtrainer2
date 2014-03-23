ns = initNamespaces('SITEMPLATE.user.charts.answers')

ns.init = () ->
  ctx = $('.chart.right_answers').get(0).getContext('2d')
  chart = new Chart(ctx).Bar(gon.right_answers)

  #ctx = $('.chart.wrong_answers').get(0).getContext('2d')
  #chart = new Chart(ctx).Bar(gon.wrong_answers)
