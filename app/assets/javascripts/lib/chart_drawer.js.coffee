ns = initNamespaces('SITEMPLATE.lib.chart')

class ChartDrawer
  constructor: (@selector) ->
    self = this

    options =
      packages: ['corechart']
      callback: -> self.draw()

    # Load the Visualization API and the piechart package.
    google.load('visualization', '1.0', options)

  draw: ->
    # Create the data table.
    data = new google.visualization.DataTable()

    $.each gon.boxes.columns, (index, column) ->
      data.addColumn(column.type, column.name)

    data.addRows(gon.boxes.rows)

    # Set chart options
    options = gon.boxes.options

    # Instantiate and draw our chart, passing in some options.
    @getChart().draw(data, options)

class PieChartDrawer extends ChartDrawer
  getChart: ->
    return @chart if @chart?
    @chart = new google.visualization.PieChart(@selector.get(0))

class BarChartDrawer extends ChartDrawer
  getChart: ->
    return @chart if @chart?
    @chart = new google.visualization.BarChart(@selector.get(0))

ns.ChartDrawer = ChartDrawer
ns.PieChartDrawer = PieChartDrawer
ns.BarChartDrawer = BarChartDrawer
