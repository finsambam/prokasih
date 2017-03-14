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

  def save_analytic_as_pdf
    @criteria = Criterium.all
    @selected_criterium = Criterium.find(session[:params]["criterium"])
    @parameter_categories = ParameterCategory.all
    @analytics = Analytic.by_river_name_and_period(session[:params]["river_name"], session[:params]["period_date"])

    respond_to do |format|
      format.pdf do
        render pdf: 'file_name',
               template: 'results/analytics.pdf.erb',
               layout: 'pdf',
               footer: {
                 center: 'Center',
                 left: 'Left',
                 right: 'Right'
               }
      end
    end
  end
end