class GistsController < ApplicationController
  before_filter :authenticate_user!, :only => [:update, :destroy, :edit]

  def index

  end

  def show

  end

  def update

  end

  def create
    @gist = Gist.new(params[:gist])
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

  def metadata

  end
end
