class AddNewFieldsToJobs < ActiveRecord::Migration[5.0]
  def change
    add_column :jobs, :title, :string
    add_column :jobs, :amount, :integer
  end
end
