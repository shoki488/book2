class RoomsController < ApplicationController
  def index
    @rooms= Room.all
    @users = User.all
  end

  def new 
    @room = Room.new
  end

  def create
    @room = current_user.rooms.new(params.require(:room).permit(:facility_name, :price, :address, :introduction, :image))
    if @room.save
      redirect_to :rooms
    else
      render "new"
    end
  end

  def show
    @room = Room.find(params[:id])
  end
  def edit
    @room = Room.find(params[:id])
  end

  def update
    @room = Room.find(params[:id])
    if @room.update(room_params)
      flash[:notice] ="正常に更新しました"
      redirect_to :rooms
    else
      render "edit"
    end
  end

  def destroy
      @room = Room.find(params[:id])
      @room.destroy
      flash[:notice] = "Roomを削除しました。"
      redirect_to :rooms
  end

  def own
    @rooms = Room.all
    
  end

  def search
    @rooms = Room.all
    if params[:address].present?
      @rooms = @rooms.where('address LIKE ?', "%#{params[:address]}%")
    end
    if params[:keyword].present?
      @rooms = @rooms.where('facility_name LIKE ? or introduction LIKE ?', "%#{params[:keyword]}%","%#{params[:keyword]}%")
    end
  end

  private

  def room_params
    params.require(:room).permit(:facility_name, :price, :address, :introduction, :image).merge(user_id: current_user.id)
  end
end
