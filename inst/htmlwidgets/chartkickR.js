HTMLWidgets.widget({

  name: 'chartkickR',

  type: 'output',

  factory: function(el, width, height) {

    // TODO: define shared variables for this instance

    return {

      renderValue: function(x) {

        // TODO: code to render the widget, e.g.
        switch(x.type) {
            case 'LineChart':
              new Chartkick.LineChart(el, x.data,
              x.options)
              break;
            case 'PieChart':
              new Chartkick.PieChart(el, x.data,
              x.options)
              break;
            case 'DonutChart':
              new Chartkick.PieChart(el, x.data,
              x.options)
              break;
            case 'ColumnChart':
              new Chartkick.ColumnChart(el, x.data,
              x.options)
              break;
            case 'BarChart':
              new Chartkick.BarChart(el, x.data,
              x.options)
              break;
            case 'AreaChart':
              new Chartkick.AreaChart(el, x.data,
              x.options)
              break;
            case 'ScatterChart':
              new Chartkick.ScatterChart(el, x.data,
              x.options)
              break;
            case 'BubbleChart':
              new Chartkick.BubbleChart(el,x.data,
              x.options)
              break;
            case 'GeoChart':
              new Chartkick.GeoChart(el, x.data,
              x.options)
              break;
            case 'Timeline':
              new Chartkick.Timeline(el, x.data,
              x.options)
              break;
            default:
              console.log('No type matched');
          }


      },

      resize: function(width, height) {

        // TODO: code to re-render the widget with a new size

      }

    };
  }
});
