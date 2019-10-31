class SessionsController < ApplicationController

	def new

	end

	def create
	  user = User.find_by(email: params[:email])
	
			if user && user.authenticate(params[:password])
				log_in(user)
				flash[:success] = "Connexion résussie"
				render "welcome/index"
			else 
				flash.now[:danger] = 'Mot de passe ou adresse email erronés'
				render 'new'
			end
	end

	def destroy
    puts "*" * 60
    session.delete(:user_id)
    puts "*" * 60
    flash[:success] = "Deconnexion réussie"
		render "welcome/index"
  end

	
end
