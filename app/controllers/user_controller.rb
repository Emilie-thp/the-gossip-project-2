class UserController < ApplicationController
  
  def show
  	@user = User.find(params[:id])
  	@city = City.find(@user.city_id)
  end

  def new
  	@user = User.new
  end

  def create 
  	@user = User.new('first_name' => params[:first_name],
  									 'last_name' => params[:last_name],
  									 'description' => params[:description],
  									 'age' => params[:age],
  									 'city_id' => City.first.id,
  									 'email' => params[:email],
  									 'password' => params[:password_digest])
  		if @user.save
  			render "welcome/index"
  		else
  		  render "new"
  		end
  end

end
