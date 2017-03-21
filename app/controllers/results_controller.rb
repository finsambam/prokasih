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
    parameter = Parameter.find(params["parameter"])
    label_chart = "Grafik #{parameter.name} #{params['river']} Tahun #{params['start']}"
    label_chart = label_chart + "-#{params['end']}" if params["end"].present?
    x_label_chart = Location.by_river_name(params["river"]).sort_by{|l| l.id}.map { |l| l.spot_name }
    data = [{
      :period => "JAN 2017",
      :values => [25, 30, 55]
      },
      {
      :period => "FEB 2017",
      :values => [66, 55, 30]
      }]

    respond_to do |format|
      format.json { render :json => {:title => label_chart, :xLabels => x_label_chart, :data => data } }
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
end