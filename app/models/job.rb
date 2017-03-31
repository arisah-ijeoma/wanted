class Job < ActiveRecord::Base
  belongs_to :user

  validates :classification, :description, :title, presence: true

  scope :search_by_title, -> (q) {
    where('LOWER(title) like ?', "%#{q.downcase}%")
  }

  scope :filter_by_type, -> (type) {
    where(classification: type)
  }

  scope :filter_by_remote, -> (val) {
    where(remote: val)
  }

  scope :filter_by_amount_range, -> (a1, a2) {
    where('amount >= ? AND amount <= ?', a1, a2)
  }
end
