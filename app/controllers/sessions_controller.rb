class SessionsController < ApplicationController

	def new

	end

	def create
	  user = User.find_by(email: params[:email])
	
			if user && user.authenticate(params[:password])
				log_in(user)

				#pour enregistrer les cookies à chaque création d'une session (=connexion)
		    remember(user)

				flash[:success] = "Connexion résussie"
				render "welcome/index"
			else 
				flash.now[:danger] = 'Mot de passe ou adresse email erronés'
				render 'new'
			end
	end

	def destroy
    forget(current_user)
    session.delete(:user_id)
    flash[:success] = "Deconnexion réussie"
		render "welcome/index"
  end

	
end
