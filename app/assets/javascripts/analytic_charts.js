//= require chart.js/dist/Chart.bundle

// Init datepicker
var dateElement = $('.datepicker').datepicker({
  format: "yyyy",
  startView: 2,
  minViewMode: 2,
  maxViewMode: 2
});

// set timestamp hiden element and hide datepicker when user change months
dateElement.on("changeYear", function(e){
  var elementId = e.target.id;
  if (elementId === "start_period") {
    $('#end_period').datepicker("update", e.date);
  }
  // $('#'+elementId+'_date').val(e.date);
  $(e.target).datepicker("hide");
});

var dynamicColors = function() {
  var r = Math.floor(Math.random() * 255);
  var g = Math.floor(Math.random() * 255);
  var b = Math.floor(Math.random() * 255);
  return "rgb(" + r + "," + g + "," + b + ")";
}

var isAllFieldFilled = function(){
  var result = false;
  var river = $("#river_name").val();
  var parameter = $("#parameter").val();
  var startPeriod = $("#start_period").val();
  var endPeriod = $("#end_period").val();
  var criterium = $("#criterium").val();
  if (river !== "" && parameter !== "" && startPeriod != "" && endPeriod != "" && criterium !== "") {
    
    $("#error_explanation").addClass("hidden");
    result = true;
    
    if (parseInt(startPeriod) > parseInt(endPeriod)) {
      showError("Akhir periode tidak boleh kurang dari awal periode");
      result = false;
    };
  }

  return result;
}

var isValidPeriod = function(){
  var startPeriod = parseInt($("#start_period").val());
  var endPeriod = parseInt($("#end_period").val());

  if (startPeriod < endPeriod) {return true;}
  return false;
}

var showError = function(message){
  $("#error_explanation .alert ul").html("<li>" + message + "</li>");
  $("#error_explanation").removeClass("hidden");
}

var getChartData = function(){
  $.ajax({
    url: '/results/get_analytic_charts',
    type: "GET",
    data: {
      river: $('#river_name option:selected').text(), 
      parameter: $('#parameter option:selected').val(), 
      start: $('#start_period').val(), 
      end: $('#end_period').val(),
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
  if (response.data.length === 0) {
    $("#myChart").hide();
    $("table#table-empty").show();
    $("#download-chart-pdf").addClass("disabled");
    $('#download-chart-pdf').prop('disabled', true);
    $('a#download-chart-pdf').attr("disabled", true);
    $('a#download-chart-pdf').click(function(event){
      event.preventDefault();
    });
    return;  
  };

  var chartTitle = response.title;
  var chartXLabel = response.xLabels;
  var unit = response.unit;
  var datasets = [];
  $("#download-chart-pdf").removeClass("disabled");
  $('#download-chart-pdf').prop('disabled', false);
  $('a#download-chart-pdf').removeAttr("disabled");
  for (var i = 0; i < response.data.length; i++) {
    var choosedColor = dynamicColors();
    var dataset = {
        label: response.data[i].period,
        fill: false,
        lineTension: 0.1,
        backgroundColor: choosedColor,
        borderColor: choosedColor,
        borderCapStyle: 'round',
        borderDash: [],
        borderDashOffset: 0.0,
        borderJoinStyle: 'miter',
        pointStyle:'circle',
        pointHoverRadius: 5,
        pointRadius: 3,
        pointHitRadius: 5,
        data: response.data[i].values,
        spanGaps: false,
      };
      datasets.push(dataset);
  };
  $("table#table-empty").hide();
  // Init chart.js
  if (window.myLine != null) {window.myLine.destroy();};
  
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
        fontSize:20
      },
      tooltips: {
        mode: 'index',
        intersect: false,
      },
      legend: {
          position: 'top',
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
          },
          ticks:{
            min: 0
          }
        }]
      }
    }
  });

  window.myLine = myChart;
}

$("#river_name").change(function(){
  if (isAllFieldFilled()) {
    getChartData();
  }
})

$("#parameter").change(function(){
  if (isAllFieldFilled()) {
    getChartData();
  }
})

$("#start_period").change(function(){
  if (isAllFieldFilled()) {
    getChartData();
  }
})

$("#end_period").change(function(){
  if (isAllFieldFilled()) {
    getChartData();
  }
})

$("#criterium").change(function(){
  if (isAllFieldFilled()) {
    getChartData();
  }
})