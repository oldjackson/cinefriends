class PostingsController < ApplicationController
  before_action :set_posting, only: [:destroy]
  before_action :user


  def create
    @posting = Posting.new()
    @posting.user = @user
    @posting.show_id = params[:show_time]

    user_movie_postings = @user.postings.select{ |p| p.show.movie_id == @posting.show.movie_id }

    total_postings = user_movie_postings + [@posting]
    total_postings = total_postings.sort_by do |p|
      d = p.show.date
      t = p.show.time

      DateTime.new(d.year, d.month, d.day, t.hour, t.min, 0, t.zone)
    end

    @new_post_ind = total_postings.index(@posting)

    if @posting.save
      respond_to do |format|
        format.html {
          redirect_to movie_path(@posting.show.movie), notice: "Your posting is now active!"
        }
        format.js  # <-- will render `app/views/postings/create.js.erb`
      end
    else
      respond_to do |format|
        format.html {
          redirect_to movie_path(@posting.show.movie), alert: @posting.errors.messages[:show][0]
        }
        format.js
      end
    end

  end

  def destroy
    @posting.destroy
    redirect_to dashboard_path
  end

  private

  def set_posting
    @posting = Posting.find(params[:id])
    unless @posting.user == current_user
      redirect_to dashboard_path, alert: "You cannot act on this posting."
    end
  end

  def set_show
    @show = Show.find(params[:show_id])
  end

  def user
    @user = current_user
  end

end
