//= require chart.js/dist/Chart.bundle

$( document ).on('turbolinks:load', function() {
  // Init datepicker
  var dateElement = $('.datepicker').datepicker({
    format: "MM yyyy",
    startView: 1,
    minViewMode: 1,
    maxViewMode: 2
  });

  // set timestamp hiden element and hide datepicker when user change months
  dateElement.on("changeMonth", function(e){
    var elementId = e.target.id;
    $('#'+elementId+'_date').val(e.date);
    $(e.target).datepicker("hide");
  });

  $("#river_name").change(function(){
    if (isAllFieldFilled()) {
      getChartData();
    };
  })

  $("#parameter").change(function(){
    if (isAllFieldFilled()) {
      getChartData();
    };
  })

  $("#start_period").change(function(){
    if (isAllFieldFilled()) {
      getChartData();
    };
  })

  $("#end_period").change(function(){
    if (isAllFieldFilled()) {
      getChartData();
    };
  })

  $("#criterium").change(function(){
    if (isAllFieldFilled()) {
      getChartData();
    };
  })
});

var dynamicColors = function() {
  var r = Math.floor(Math.random() * 255);
  var g = Math.floor(Math.random() * 255);
  var b = Math.floor(Math.random() * 255);
  return "rgb(" + r + "," + g + "," + b + ")";
}

var isAllFieldFilled = function(){
  var river = $("#river_name").val();
  var parameter = $("#parameter").val();
  var startPeriod = $("#start_period").val();
  var endPeriod = $("#end_period").val();
  var criterium = $("#criterium").val();
  if (river !== "" && parameter !== "" && startPeriod != "" && endPeriod != "" && criterium !== "") {
    return true;
  };
  return false;
}

var getChartData = function(){
  $.ajax({
    url: '/results/get_analytic_charts',
    type: "GET",
    data: {
      river: $('#river_name option:selected').text(), 
      parameter: $('#parameter option:selected').val(), 
      start: $('#start_period_date').val(), 
      end: $('#end_period_date').val(),
      criterium: $('#criterium option:selected').val()
    },
    beforeSend: (function(){
      // TODO: add loading layer
    }),
    success: (generateChart),
    complete: (function(){
      // TODO: remove loading
    })
  })
}

var generateChart = function(response){
  var chartTitle = response.title;
  var chartXLabel = response.xLabels;
  var unit = response.unit;
  var datasets = [];
  for (var i = 0; i < response.data.length; i++) {
    var dataset = {
        label: response.data[i].period,
        fill: false,
        lineTension: 0.1,
        backgroundColor: dynamicColors(),
        borderColor: dynamicColors(),
        borderCapStyle: 'round',
        borderDash: [],
        borderDashOffset: 0.0,
        borderJoinStyle: 'miter',
        pointBorderColor: dynamicColors(),
        pointBackgroundColor: "#fff",
        pointBorderWidth: 1,
        pointHoverRadius: 5,
        pointHoverBackgroundColor: dynamicColors(),
        pointHoverBorderColor: dynamicColors(),
        pointHoverBorderWidth: 2,
        pointRadius: 1,
        pointHitRadius: 10,
        data: response.data[i].values,
        spanGaps: false,
      };
      datasets.push(dataset);
  };
  $("table#table-empty").hide();
  // Init chart.js
  var ctx = document.getElementById("myChart");
  ctx.style.display="";
  var myChart = new Chart(ctx, {
    type: 'line',
    data: {
      labels: chartXLabel,
      datasets: datasets
    },
    options: {
      responsive: true,
        title:{
          display:true,
          text:chartTitle,
          fullWidth:true,
          fontSize:24
        },
        tooltips: {
          mode: 'index',
          intersect: false,
        },
        hover: {
          mode: 'nearest',
          intersect: true
        },
        scales: {
          xAxes: [{
            display: true,
            scaleLabel: {
              display: true,
              labelString: 'Lokasi'
            }
          }],
          yAxes: [{
            display: true,
            scaleLabel: {
              display: true,
              labelString: unit
            }
          }]
        }
    }
  });
}