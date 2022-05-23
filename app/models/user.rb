class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  after_create :welcome_send
  validates :email, :first_name ,:last_name , presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  has_many :attend_events, foreign_key: 'attendee_id', class_name: "Attendance"
  has_many :admin_events, foreign_key: 'admin_id', class_name: 'Event'
  has_one_attached :avatar

  def welcome_send
    UserMailer.welcome_email(self).deliver_now
  end

  def full_name 
    return self.first_name + " " + self.last_name
  end
  
end
