class Job < ActiveRecord::Base
  belongs_to :user

  validates :classification, :duration, :description, presence: true
end
