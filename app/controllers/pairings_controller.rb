class PairingsController < ApplicationController
  before_action :user
  before_action :set_posting, only: [:create, :edit]
  before_action :set_pairing, only: [:show, :decline, :accept, :decline]

  def show
    @message = Message.new
    @messages = @pairing.messages
    @sent_messages = @pairing.messages.where(user: current_user)
    @received_messages = @pairing.messages.where.not(user: current_user)
    @theaters = @pairing.posting.show.theater


    #@theaters =  Theater.where.not(latitude: nil, longitude: nil)


    @markers = [
      {
        lat: @theaters.latitude,
        lng: @theaters.longitude
        # infoWindow: { content: render_to_string(partial: "/flats/map_box", locals: { flat: flat }) }
      }]

  end

  def new
    @pairing = Pairing.new
  end

  def create

    @pairing = Pairing.new(posting: @posting, user: @user)
    if @pairing.save
      PairingMailer.creation_confirmation(@pairing).deliver_now
      redirect_to pairing_path(@pairing)
    else
      redirect_to movie_path(@posting.movie)
    end
  end

  def accept
    @pairing.status = 'accepted'
    if @pairing.save
      redirect_to dashboard_path
    else
      redirect_to dashboard_path, alert: "The appointment could not be accepted"
    end
  end

  def decline
    @pairing.status ='declined'
    if @pairing.save
      redirect_to dashboard_path
    else
      redirect_to dashboard_path, alert: "The appointment could not be declined"
    end
  end


  private

  def user
    @user = current_user
  end

  def set_posting
    @posting = Posting.find(params[:posting_id])
  end

  def set_pairing

    @pairing = Pairing.find(params[:id])
    unless @pairing.posting.user == current_user || @pairing.user == current_user
      redirect_to dashboard_path, alert: "You cannot alter this appointment."
    end
  end

end
