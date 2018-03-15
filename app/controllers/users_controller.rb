class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :create]
  def new
  end

  def show
  end

  def create
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
  end


  def dashboard
    if user_signed_in?
      @user = current_user

      respond_to do |format|
        format.html do
          unmatched_postings = []
          pairings = @user.pairings # movies posted by other users accepted by current user

          @user.postings.each do |posting|
            if posting.pairings.nil? || posting.pairings.empty?
              unmatched_postings << posting
            else
              pairings += posting.pairings # movies posted by current user accepted by other users
            end
          end

          @pairings = pairings.sort_by do |p|
            d = p.posting.show.date
            t = p.posting.show.time

            DateTime.new(d.year, d.month, d.day, t.hour, t.min, 0, t.zone)
          end

          @unmatched_postings = unmatched_postings.sort_by do |up|
            d = up.show.date
            t = up.show.time

            DateTime.new(d.year, d.month, d.day, t.hour, t.min, 0, t.zone)
          end
        end

        format.js do
          pairings = @user.pairings # movies posted by other users accepted by current user
          @pairings = pairings.sort_by do |p|
            d = p.posting.show.date
            t = p.posting.show.time

            DateTime.new(d.year, d.month, d.day, t.hour, t.min, 0, t.zone)
          end
        end
      end

    else
      redirect_to root_path, notice: "Please sign in to see your dashboard :)"
    end


  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:title, :director, :photo, :city, :about_me, :fav_quote)
  end

end
