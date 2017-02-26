class ChangeColumnTypeInJobs < ActiveRecord::Migration
  def change
    rename_column :jobs, :type, :classification
  end
end
