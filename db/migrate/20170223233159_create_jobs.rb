class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :type
      t.boolean :remote, null: false, default: false
      t.string :duration
      t.text :description
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
