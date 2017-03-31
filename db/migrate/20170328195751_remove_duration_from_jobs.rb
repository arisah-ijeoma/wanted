class RemoveDurationFromJobs < ActiveRecord::Migration[5.0]
  def change
    remove_column :jobs, :duration
  end
end
