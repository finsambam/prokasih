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
    locations = Location.by_river_name(params["river"]).sort_by{|l| l.id}.map { |l| l.code }
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
    session[:location_params] = params
    @locations = Location.by_river_name(params[:river_name])
    respond_to do |format|
      format.js
    end
  end

  def save_map_image_as_pdf
    @locations = Location.by_river_name(session[:location_params]["river_name"])
    filename = "peta analisa #{session[:params]['river_name']}"
    if @locations.any?
      save_download_information(params, "map_location")
    end
    
    render_as_pdf('results/maps.pdf.erb', filename)
  end

  def save_analytic_as_pdf
    byebug
    @criteria = Criterium.all
    @selected_criterium = Criterium.find(session[:params]["criterium"])
    @parameter_categories = ParameterCategory.all
    @analytics = Analytic.by_river_name_and_period(session[:params]["river_name"], session[:params]["period_date"])
    
    filename = "hasil analisa #{session[:params]['river_name']}-#{session[:params]['period_date'].to_date.strftime('%d-%m-%Y')}"
    
    if @analytics.any?
      save_download_information(params, filename)  
    end

    render_as_pdf('results/analytics.pdf.erb', filename)
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
    filename = "grafik analisa #{session[:chart]['parameter']}-#{session[:chart]['river']}-#{start_date.strftime('%d-%m-%Y')}-#{end_date.strftime('%d-%m-%Y')}"
    if gon.data.any?
      save_download_information(params, "analytic_chart")
    end
    render_as_pdf('results/analytic_chart.pdf.erb', filename)
  end

  private

  def save_download_information(params, result_type)
    email = params[:email]
    purpose_of_download = params[:purpose_of_download]
    if current_user.present?
      email = current_user.email
      purpose_of_download = "download_by_operator"
    end
    DownloadHistoryService.new(email, purpose_of_download, result_type).save_to_DB
  end

  def render_as_pdf(template, filename)
    respond_to do |format|
      format.pdf do
        render pdf: "#{filename}",
               template: template,
               layout: 'layouts/pdf.html.erb',
               javascript_delay: 1000,
               show_as_html: params.key?('debug')
      end
    end
  end
end