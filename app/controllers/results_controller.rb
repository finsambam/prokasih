class ResultsController < ApplicationController
  
  def analytics
    @rivers = Location::RIVERS
    @criteria = Criterium.all
  end

  def get_analytics
    session[:params] = params
    @criteria = Criterium.all
    @selected_criterium = Criterium.find(params[:criterium])
    @parameter_categories = ParameterCategory.all
    @analytics = Analytic.by_river_name_and_period(params[:river_name], params[:period_date])

    respond_to do |format|
      format.js
    end
  end

  def analytic_charts
    @rivers = Location::RIVERS
    @parameters = Parameter.for_select
    @criteria = Criterium.all
  end

  def get_analytic_charts
    start_date = DateTime.new(params["start"].to_f, 1, 1)
    end_date = DateTime.new(params["end"].to_f, 12, 31) 
    parameter = Parameter.find(params["parameter"])
    label_chart = "Grafik #{parameter.name} #{params['river']} Tahun #{start_date.strftime("%Y")}"
    label_chart = label_chart + "-#{end_date.strftime("%Y")}" if params["end"] != params["start"]
    locations = Location.by_river_name(params["river"]).sort_by{|l| l.id}.map { |l| l.spot_name }
    data = AnalyticParameter.chart_data(params["river"], start_date, end_date, params["parameter"])
    criterium_data = CriteriumParameter.chart_data(params["parameter"], params["criterium"], locations.length)
    data << criterium_data
    session[:chart] = params
    respond_to do |format|
      format.json { render :json => {:title => label_chart, :xLabels => locations, :data => data, :unit =>  parameter.unit} }
    end
  end

  def location
    @rivers = Location::RIVERS
  end

  def get_all_location
    @locations = Location.by_river_name(params[:river_name])
    respond_to do |format|
      format.js
    end
  end

  def save_analytic_as_pdf
    @criteria = Criterium.all
    @selected_criterium = Criterium.find(session[:params]["criterium"])
    @parameter_categories = ParameterCategory.all
    @analytics = Analytic.by_river_name_and_period(session[:params]["river_name"], session[:params]["period_date"])
    respond_to do |format|
      format.pdf do
        render pdf: 'file_name',
               template: 'results/analytics.pdf.erb',
               layout: 'layouts/pdf.html.erb',
               footer: {
                 center: 'Center',
                 left: 'Left',
                 right: 'Right'
               }
      end
    end
  end

  def save_analytic_chart_as_pdf
    start_date = DateTime.new(session[:chart]["start"].to_f, 1, 1)
    end_date = DateTime.new(session[:chart]["end"].to_f, 12, 31) 
    parameter = Parameter.find(session[:chart]["parameter"])
    gon.label_chart = "Grafik #{parameter.name} #{session[:chart]['river']} Tahun #{start_date.strftime("%Y")}"
    gon.label_chart = gon.label_chart + "-#{end_date.strftime("%Y")}" if session[:chart]["end"] != session[:chart]["start"]
    gon.locations = Location.by_river_name(session[:chart]["river"]).sort_by{|l| l.id}.map { |l| l.spot_name }
    gon.data = AnalyticParameter.chart_data(session[:chart]["river"], start_date, end_date, session[:chart]["parameter"])
    criterium_data = CriteriumParameter.chart_data(session[:chart]["parameter"], session[:chart]["criterium"], gon.locations.length)
    gon.data << criterium_data
    gon.unit = parameter.unit
    respond_to do |format|
      format.pdf do
        render pdf: 'file_name',
               template: 'results/analytic_chart.pdf.erb',
               layout: 'layouts/pdf.html.erb',
               javascript_delay: 1000
      end
    end
  end
end