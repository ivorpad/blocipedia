class WikisController < ApplicationController
  def index
    @query = policy_scope(Wiki).search do
      fulltext params[:search]
    end

    @wikis = @query.results

    # Added a search feature but lost the capability to
    # filter private content for standard users.
    # @wikis =
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new
    authorize @wiki
  end

  def create
    @wiki = Wiki.new(wiki_params)
    @wiki.user = current_user
    authorize @wiki
    if @wiki.save
      redirect_to wikis_path
      flash[:notice] = "Your Wiki has been created"
    else
      render :new
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def update
    @wiki = Wiki.find(params[:id])
    authorize @wiki
    if @wiki.update_attributes(wiki_params)
      flash[:notice] = "Wiki updated"
      redirect_to @wiki
    else
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])
    #@wiki = policy_scope(Wiki).find(params[:id])
    authorize @wiki
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
