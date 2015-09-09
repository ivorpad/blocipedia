class CollaboratorsController < ApplicationController

  def create
    @wiki = Wiki.find(params[:wiki_id])

    if params[:collab_ids]
      @wiki.users = User.find(params[:collab_ids])
      flash[:notice] = "Collaborators added"
    else
      @wiki.users = []
      flash[:error] = "Collaborators removed"
    end
      redirect_to edit_wiki_path(@wiki)
  end

end
