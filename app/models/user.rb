class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  after_create :update_access_token!

  validates :full_name, :address, :phone_number, presence: true
  validates :email, format: { with: Devise.email_regexp }
  validates :phone_number, format: { with: /[[:digit:]]{10}/ }, length: {minimum: 11, maximum: 14}

  has_many :jobs

  def send_on_create_confirmation_instructions
    # overwrite devise method to prevent sending confirmation mail
  end

  private

  def update_access_token!
    self.access_token = "#{self.id}:#{Devise.friendly_token}"
    save
  end
end
