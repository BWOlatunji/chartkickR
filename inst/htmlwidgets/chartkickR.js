HTMLWidgets.widget({
  name: "chartkickR",
  type: "output",

  factory: function(el, width, height) {
    let chart = null;

    return {
      renderValue: function(x) {
        if (chart && typeof chart.destroy === "function") {
          chart.destroy();
        }

        switch (x.type) {
          case "LineChart":
            chart = new Chartkick.LineChart(el, x.data, x.options);
            break;

          case "PieChart":
            chart = new Chartkick.PieChart(el, x.data, x.options);
            break;

          case "ColumnChart":
            chart = new Chartkick.ColumnChart(el, x.data, x.options);
            break;

          case "BarChart":
            chart = new Chartkick.BarChart(el, x.data, x.options);
            break;

          case "AreaChart":
            chart = new Chartkick.AreaChart(el, x.data, x.options);
            break;

          case "ScatterChart":
            chart = new Chartkick.ScatterChart(el, x.data, x.options);
            break;

          case "BubbleChart":
            chart = new Chartkick.BubbleChart(el, x.data, x.options);
            break;

          case "GeoChart":
            chart = new Chartkick.GeoChart(el, x.data, x.options);
            break;

          case "Timeline":
            chart = new Chartkick.Timeline(el, x.data, x.options);
            break;

          default:
            throw new Error("Unsupported chart type: " + x.type);
        }
      },

      resize: function(width, height) {
        if (chart && typeof chart.redraw === "function") {
          chart.redraw();
        }
      }
    };
  }
});
