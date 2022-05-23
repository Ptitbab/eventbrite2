class Attendance < ApplicationRecord
  belongs_to :attendee, class_name: "User"
  belongs_to :event
  
  # after_create :attendance_send, :admin_attend_send
  after_create :admin_attend_send

  def attendance_send
    UserMailer.attendance_email(self).deliver_now
  end

  def admin_attend_send
    UserMailer.admin_attend_email(self).deliver_now
  end

end
