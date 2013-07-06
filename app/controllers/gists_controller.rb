class GistsController < ApplicationController
  before_filter :authenticate_user!, :only => [:update, :destroy, :edit]

  def show

  end

  def update

  end

  def vote_up
    @gist = Gist.find(params[:id])
    @gist.score = @gist.score + 1
    @gist.save
    render :json => @gist
  end

  def vote_down
    @gist = Gist.find(params[:id])
    @gist.score = @gist.score - 1
    @gist.save
    render :json => @gist
  end

  def create
    @gist = Gist.new(params[:gist])
    paper = Paper.find_by_identifier(params[:gist][:paper_attributes][:identifier])
    @gist.paper = paper if paper
    @gist.user = current_user

    @gist.save
    redirect_to paper_path(@gist.paper_id)
  end

  def destroy

  end

  def edit

  end

  def new
    unless current_user
      @user = User.new
    end
    @gist = Gist.new
    @gist.build_paper
  end
end
