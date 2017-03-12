class ChangePeriodTypeOnAnalyticTable < ActiveRecord::Migration[5.0]
  def change
  	change_column :analytics, :period, :date
  end
end
