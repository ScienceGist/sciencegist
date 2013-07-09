class GistsController < ApplicationController
  before_filter :authenticate_user!, :only => [:update, :destroy, :edit, :index]

  def show
    @gist = Gist.find(params[:id])
  end

  def update
    @gist = current_user.gists.where(id: params[:id]).first
    @gist.assign_attributes(params[:gist])
    paper = Paper.find_by_identifier(params[:gist][:paper_attributes][:identifier])
    @gist.paper = paper if paper
    @gist.save
    redirect_to gists_path
  end

  def index
    @gists = current_user.gists
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
    @gist = current_user.gists.where(id: params[:id]).first
  end

  def new
    unless current_user
      @user = User.new
    end
    @gist = Gist.new
    @gist.build_paper
  end
end
