class GistsController < ApplicationController
  before_filter :store_location, :only => [:new, :show]
  before_filter :authenticate_user!, :only => [:update, :destroy, :edit, :index, :vote_up, :vote_down]

  def show
    binding.pry
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
    @gist.liked_by current_user
    render :json => {id: @gist.id, score: @gist.cached_votes_score}
  end

  def vote_down
    @gist = Gist.find(params[:id])
    @gist.disliked_by current_user
    render :json => {id: @gist.id, score: @gist.cached_votes_score}
  end

  def create
    @gist = Gist.new(gist_params[:gist])
    paper = Paper.find_by_identifier(gist_params[:gist][:paper_attributes][:identifier])
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
    if params[:identifier]
      @gist.paper = Paper.find_by_identifier(params[:identifier])
    end
  end

  private
  def gist_params
    params.permit(:id, gist: [:id, {paper_attributes: [:identifier, :title, {metadata: [:authors, :journal]}]}, :content])
  end
end
