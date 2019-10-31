class GossipsController < ApplicationController
  
  before_action :authenticate_user

	def show 
		@gossip = Gossip.find(params[:id])
    @city = City.find(@gossip.user.city_id)
  end


	def new
		@gossip = Gossip.new
	end


  def create 
 		@gossip = Gossip.new('title' => params[:title],
                  			 'content' => params[:content],
                  			 )
    @gossip.user = current_user
   		if @gossip.save # essaie de sauvegarder en base @gossip
     		 flash[:success] = "Nouveau gossip bien crée !"
         render "welcome/index"
	    else
  		   render "new"
    	end
  end

  def edit 
    @gossip = Gossip.find(params[:id])
  end


  def update
    @gossip = Gossip.find(params[:id])
    if @gossip.update(title: params[:title],
                      content: params[:content])
      redirect_to gossip_path
    else
      render :edit
    end
  end


  def destroy 
    @gossip = Gossip.find(params[:id])
    @gossip.destroy
    render "welcome/index"
  end


  private
  
    def authenticate_user
        unless current_user
            flash[:danger] = "Veuillez-vous connecter pour accéder au contenu."
            redirect_to new_session_path
        end
    end

end
 