class WikisController < ApplicationController
  def index
    @wikis = policy_scope(Wiki)
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
      redirect_to wiki_path(@wiki, current_user)
      flash[:notice] = "Your Wiki has been created"
    else
      render :new
    end
  end

  def edit
    @users = User.all_except(current_user)
    @wiki = Wiki.find(params[:id])
    authorize @wiki
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
    # authorize @wiki
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
