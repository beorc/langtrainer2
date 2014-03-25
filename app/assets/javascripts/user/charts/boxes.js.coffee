ns = initNamespaces('SITEMPLATE.user.charts.boxes')

ns.init = () ->
  initCharts = ->
    # Callback that creates and populates a data table,
    # instantiates the pie chart, passes in the data and
    # draws it.
    drawChart = ->
      # Create the data table.
      data = new google.visualization.DataTable()

      $.each gon.boxes.columns, (index, column) ->
        data.addColumn(column.type, column.name)

      data.addRows(gon.boxes.rows)

      # Set chart options
      options = gon.boxes.options

      # Instantiate and draw our chart, passing in some options.
      chart = new google.visualization.PieChart($('.chart.boxes').get(0))
      chart.draw(data, options)

    options =
      packages: ['corechart']
      callback: drawChart

    # Load the Visualization API and the piechart package.
    google.load('visualization', '1.0', options)

  $.getScript 'https://www.google.com/jsapi', (data, textStatus) ->
    initCharts()

