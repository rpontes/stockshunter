document.addEventListener("turbolinks:load", function() {
  if(!$('.js-dashboard-charts').length) { return; }

  function drawLineChart() {
    var backgroundLineColors = {
        BTC: 'rgba(255, 159, 64, 0.2)',
        USD: 'rgba(255, 99, 132, 0.2)',
        EUR: 'rgba(54, 162, 235, 0.2)'
    };

    var borderLineColors = {
        BTC: 'rgba(255, 159, 64, 1)',
        USD: 'rgba(255,99,132,1)',
        EUR: 'rgba(54, 162, 235, 1)'
    };

    var jsonData = $.ajax({
        url: '/quotations',
        dataType: 'json',
      }).done(function (results) {
        var labels = [], data=[], datasets=[];

        results['data'].forEach(function(currency) {
          labels = currency.labels;

          var object = { label: currency.name,
                         data: currency.data,
                         fill: false,
                         yAxisID: 'y-axis',
                         backgroundColor: backgroundLineColors[currency.acronym],
                         borderColor: borderLineColors[currency.acronym],
                         borderWidth: 1 };

          datasets.push(object);
        });

        // Create the chart.js data structure using 'labels' and 'data'
        var tempData = {
          labels : labels,
          datasets : datasets
        };

        // Get the context of the canvas element we want to select
        var ctx = document.getElementById('js-quotations-chart');

        // Instantiate a new chart
        var myLineChart = new Chart(ctx, {
          type: 'line',
          data: tempData,
          options: {
            responsive: true,
            scales: {
              yAxes: [{
                type: "linear",
                display: true,
                position: "left",
                id: "y-axis"
              }]
            }
          }
      });
    });
  };

  drawLineChart();
});
