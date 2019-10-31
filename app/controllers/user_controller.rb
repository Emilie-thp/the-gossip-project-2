class UserController < ApplicationController
  
  def show
  	@user = User.find(params[:id])
  	@city = City.find(@user.city_id)
  end

  def new
  	@user = User.new
  end

  def create 
    @city = City.find_by(name: params[:city_name])
      if @city == nil 
        @city = City.create(name:params[:city_name], zip_code:"53270")
      else
    @user = User.new('first_name' => params[:first_name],
  									 'last_name' => params[:last_name],
  									 'description' => params[:description],
  									 'age' => params[:age],
  									 'city_id' => @city.id,
  									 'email' => params[:email],
  									 'password' => params[:password_digest])
      end

  		if @user.save
         log_in(@user)
         flash[:success] = "Inscription réussie !"
  			 render "welcome/index"
  		else
  		  render "new"
  		end
  
  end

end
