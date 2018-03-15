class MoviesController < ApplicationController
  before_action :set_movie, only: [:show, :edit, :update, :destroy, :filter_theaters, :filter_shows]

  def index
    @movies = Movie.all
  end

  def show
    # needed to show the posting form along with the existing user postings in the show view
    # @posting = Posting.new

    @dates = @movie.list_available_dates

    postings = @movie.postings.reject { |p| p.user == current_user}
    @postings = postings.sort_by do |p|
      d = p.show.date
      t = p.show.time

      DateTime.new(d.year, d.month, d.day, t.hour, t.min, 0, t.zone)
    end

    your_postings = @movie.postings.select { |p| p.user == current_user}
    @your_postings = your_postings.sort_by do |p|
      d = p.show.date
      t = p.show.time

      DateTime.new(d.year, d.month, d.day, t.hour, t.min, 0, t.zone)
    end
  end

  def new
    if user_signed_in?
      @movie = Movie.new
    else
      redirect_to root_path, alert: "To post a new movie for renting you need to sign in."
    end
  end

  def edit
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      redirect_to movie_path(@movie)
    else
      render :new
    end
  end

  def update
    if @movie.update(movie_params)
      redirect_to @movie
    else
      render :edit
    end
  end

  def destroy
    @movie.destroy
    redirect_to movies_path
  end

  def filter_theaters
    if params[:date]
      @theaters = @movie.find_theaters_by_date(params[:date].to_date)
    end

    render :filter_theaters, as: :json

  end

  def filter_shows
    if params[:date] && params[:theater_id]
      theater = Theater.find(params[:theater_id])
      shows = theater.shows.where(movie: @movie, date: params[:date])

      @shows = shows.sort_by do |s|
        t = s.time
        DateTime.new(1, 1, 1, t.hour, t.min, 0, t.zone)
      end
    end

    render :filter_shows, as: :json

  end


  private

  def set_movie
    @movie = Movie.find(params[:id])
  end

  def movie_params
    params.require(:movie).permit(:title, :director, :photo)
  end
end
