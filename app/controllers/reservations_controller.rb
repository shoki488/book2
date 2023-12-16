class ReservationsController < ApplicationController
  before_action only: [:edit, :update, :destroy]
  def index
    @reservations = current_user.reservations.all

  end

  def new 
    @reservation = Reservation.new
  end

  def create 
    @reservation = Reservation.new(params.require(:reservation).permit(:check_in, :check_out, :stay, :person, :totle, :room_id, :user_id))
    if @reservation.save
      redirect_to :reservations
    else
      render "confirm", status: :unprocessable_entity
    end
  end


  def confirm 
     @reservation = current_user.reservations.new(
     check_in: params[:check_in],
     check_out: params[:check_out],
     stay: params[:stay],
     person: params[:person],
     totle: params[:totle],
     room_id: params[:room_id])
     @room = Room.find_by(id: params[:room_id])

     @room = @reservation.room
    
     @user = User.find_by(id:@reservation.user_id)
   if@reservation.check_in.present? && @reservation.check_out.present? && @reservation.person.present?
     @reservation.stay = (@reservation.check_out - @reservation.check_in).to_i
     @reservation.totle = @reservation.stay * @reservation.person * @room.price

    if @reservation.check_in < Date.today
      flash[:alert] = "本日より後の日付を選んでください"
      redirect_to room_path(@reservation.room_id)
    elsif @reservation.check_in == @reservation.check_out
      flash[:alert] = "チェックイン日とチェックアウト日が一緒になっています"
      redirect_to room_path(@reservation.room_id)
    elsif @reservation.person <= 0
        flash[:alert] = "人数は１人以上にしてください"
        redirect_to room_path(@reservation.room_id)
    elsif @reservation.stay < 0
      flash[:alert] = "終了日は開始日以降にしてください"
      redirect_to room_path(@reservation.room_id)
    end
  else
    flash[:alert] = "空欄もしくは適切でない欄があります"
    render "rooms/show"
  end
end


  def edit
    @reservation = Reservation.find(params[:id])
  end

  def update
   @reservation = Reservation.find(params[:id])
   if @reservation.update(reservation_params)
      flash[:notice] = "正常に更新しました"
      redirect_to :reservations
   else
      render "edit", status: :unprocessable_entity
    end
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    @reservation.destroy
      flash[:notice] = "予約を削除しました"
      redirect_to :reservations
  end
 
private

  def reservation_params
    params.require(:reservation).permit(:check_in, :check_out, :stay, :person, :totle, :room_id, :user_id)
  end
end
