class PapersController < ApplicationController
  def show
    @paper = Paper.find(params[:id])
  end
end
