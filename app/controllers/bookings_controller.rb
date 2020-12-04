class BookingsController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  
  def new
  end 

  def create
    @booking = Booking.new(booking_params)

    if @booking.save
      flash[:success] = "Votre réservation a bien été prise en compte"
      redirect_to(root_path)
    else
      flash[:danger] = "Votre réservation n'a pas pu aboutir"
      redirect_back(fallback_location: root_path)
    end
  end 

  def destroy
    @booking.destroy
    respond_to do |format|
      format.html { redirect_to @cart, notice: "Le cours a bien été annulé" }
      format.json { head :no_content }
      format.js {}
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :duration)
  end

end