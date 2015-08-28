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
      redirect_to wiki_path(@wiki)
      flash[:notice] = "Your Wiki has been created"
    else
      render :new
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
  end

  def update
    @wiki = Wiki.find(params[:id])

    if @wiki.update_attributes(wiki_params)
      flash[:notice] = "Wiki updated"
      redirect_to @wiki
    else
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])

    if @wiki.destroy
      flash[:notice] = "Wiki deleted successfully"
      redirect_to @wiki
    else
      render :show
    end

  end

  private

  def wiki_params
    params.require(:wiki).permit(:title, :body, :private)
  end
end
