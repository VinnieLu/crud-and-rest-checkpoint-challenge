get "/user/create" do
	erb :create
end

post "/user/create" do
	if params[:email] == ""
		@error = "Please enter an email."
		erb :create
	elsif params[:password] == ""
		@error = "Please enter a password."
		erb :create
	else
		@user = User.create({first_name: params[:first_name], last_name: params[:last_name], email: params[:email], password: params[:hashed_password]})
		redirect "/"
	end
end

get "/user/login" do
	erb :login
end

post "/user/login" do
	@user = User.find_by(email: params[:email])
	if @user.password == params[:password]
		session[:user_id] = @user.id
		redirect "/user/profile/#{session[:user_id]}"
	else
		@error = "Incorrect user name or password."
		erb :login
	end
end

get "/user/logout" do
	session[:user_id] = nil
	redirect "/"
end

get "/user/profile/:user_id" do
	@user = User.find_by(id: session[:user_id])
	@channels = @user.channels
	erb :profile
end