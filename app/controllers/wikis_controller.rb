class WikisController < ApplicationController
  def index
    @wikis = Wiki.all
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new
  end

  def create
    @wiki = Wiki.new(wiki_params)

    if @wiki.save
      redirect_to :back
      flash[:notice] = "Your Wiki has been created"
    else
      render 'new'
    end
  end

  def edit
  end

  private

  def wiki_params
    params.require(:wiki).permit(:title, :body, :private)
  end
end
