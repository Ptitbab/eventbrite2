class AttendancesController < ApplicationController
  before_action :set_attendance, only: %i[ show edit update destroy ]
  before_action :authenticate_user
  skip_before_action :verify_authenticity_token

  # # GET /attendances or /attendances.json
  # def index
  #   @attendances = Attendance.all
  # end

  # # GET /attendances/1 or /attendances/1.json
  # def show
  # end

  # # GET /attendances/new
  # def new
  #   @attendance = Attendance.new
  # end

  # # GET /attendances/1/edit
  # def edit
  # end

  # POST /attendances or /attendances.json
  def create
    @attendance = Attendance.new(event: Event.find(params[:event_id]), attendee: current_user)


      if @attendance.save
        redirect_back(fallback_location: root_path)
      else
        redirect_back(fallback_location: root_path)
      end
    end

  # # PATCH/PUT /attendances/1 or /attendances/1.json
  # def update
  #   respond_to do |format|
  #     if @attendance.update(attendance_params)
  #       format.html { redirect_to attendance_url(@attendance), notice: "Attendance was successfully updated." }
  #       format.json { render :show, status: :ok, location: @attendance }
  #     else
  #       format.html { render :edit, status: :unprocessable_entity }
  #       format.json { render json: @attendance.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /attendances/1 or /attendances/1.json
  def destroy
    puts "#" * 50
    puts params
    puts "#" * 50
    Attendance.find(params[:id]).destroy
    redirect_back(fallback_location: root_path)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_attendance
    puts "#" * 50
    puts params
    puts "#" * 50
      @attendance = Attendance.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def attendance_params
      params.require(:attendance).permit(:stripe_customer_id)
    end

    def authenticate_user
      unless current_user
        flash[:danger] = "Please log in."
        redirect_to new_user_registration_path 
      end
    end
end
