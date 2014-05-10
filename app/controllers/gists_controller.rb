class GistsController < ApplicationController
  before_filter :store_location, :only => [:new, :show]
  before_filter :authenticate_user!, :only => [:update, :destroy, :edit, :create, :new, :index, :vote_up, :vote_down]

  def show
    @gist = Gist.find(params[:id])
  end

  def update
    @gist = current_user.gists.where(id: params[:id]).first
    @gist.assign_attributes(gist_params[:gist])
    paper = Paper.find_by_identifier(params[:gist][:paper_attributes][:identifier])
    if paper
      paper.assign_attributes(gist_params[:gist][:paper_attributes])
      paper.save if paper.changed?
      @gist.paper = paper
    else
      @gist.paper = Paper.new(gist_params[:gist][:paper_attributes])
    end
    @gist.save
    redirect_to gist_path(@gist)
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
    if @gist.save
      redirect_to @gist.paper.identifier_path
    else
      render 'new'

    end
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
    params.permit(:id, gist: [:id, {paper_attributes: [:identifier, :title, :authors, :journal, :tag_list]}, :content])
  end
end
