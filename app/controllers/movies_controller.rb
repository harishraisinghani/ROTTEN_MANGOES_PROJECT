class MoviesController < ApplicationController

  def index
    @movies = Movie.all

    unless params[:q].blank?
      @movies = @movies.search_by_title_or_director(params[:q])
    end

    #Replace with above that combines both title and director searches
    # unless params[:director].blank?
    #   @movies = @movies.search_by_director(params[:director])
    # end

    unless params[:runtime_in_minutes].blank?
      @movies = @movies.less_than_90(params[:runtime_in_minutes]).between_90_120(params[:runtime_in_minutes]).greater_than_120(params[:runtime_in_minutes])
      # @movies = @movies.between_90_120(params[:runtime_in_minutes]) - dont' need these two in lieu of chaining scope methods above
      # @movies = @movies.greater_than_120(params[:runtime_in_minutes])
    end
  end


  def show
    @movie = Movie.find(params[:id])
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    
    if @movie.save
      redirect_to movies_path, notice: "#{@movie.title} was successfully submitted"
    else
      render :new
    end
  end


  def edit
    @movie = Movie.find(params[:id])
  end

  def update
    @movie = Movie.find(params[:id])

    if @movie.update_attributes(movie_params)
      redirect_to movies_path
    else
      render :edit
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movies_path
  end

  protected

  def movie_params
    params.require(:movie).permit(:title, :director, :runtime_in_minutes, :description, :post_image_url, :release_date, :image)
  end
end