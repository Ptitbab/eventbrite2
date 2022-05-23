module AttendancesHelper

  def participate?(event,user)
    Attendance.find_by(event: event, attendee: user)
  end

  def find_attendance(event,user)
    Attendance.find_by(event: event, attendee: user)
  end

end
