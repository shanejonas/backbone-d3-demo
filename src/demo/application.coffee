$ = require 'jquery'
Backbone = require('backbone')
Backbone.setDomLibrary($)
d3 = require 'd3'

dataset = [ 55, 122, 141, 208, 250, 306, 351, 401, 451, 501, 552, 500, 450, 410 ]
dataset = dataset.map (number) -> dataPoint: number

collection = new Backbone.Collection
collection.reset dataset

class BarChart extends Backbone.View

  initialize: (options)->
    @$vis = d3.select(@el)
    @collection.on 'reset', @render, @
    Grid.on 'change', @render, @
    @title = options.title || 'MyBarChart'
    @multiplier = options.multiplier || 1

  render: ->
    @$el.empty()
    @$el.append("<h1>#{@title}</h1>")
    boundary = Grid.get('boundary')
    if boundary is Infinity then boundary = window.innerWidth
    chart = @$vis.selectAll('div').data(@collection.toJSON())
    chart.enter()
      .append('div')
      .text (data) ->
        parseInt(data.dataPoint)
      .attr('class', 'bar')
      .style "width", (data) => "#{((boundary * .01) || 5) / @multiplier * data.dataPoint}px"
    chart.exit()
    @

barChart = new BarChart {
  collection
  title: 'SUP RESPONSIVE CHART'
  multiplier: 10
}

module.exports = barChart
