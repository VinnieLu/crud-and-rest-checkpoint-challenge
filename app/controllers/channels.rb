get "/channel/:channel_id" do
	@channel = Channel.find_by(id: params[:channel_id])
	@subscribers = @channel.users
	@user = User.find_by(id: session[:user_id])
	@user_channel = @user.channels.find_by(id: params[:channel_id])
	erb :channel
end

post "/channel/update/:channel_id" do
	if params[:unsubscribe]
		@subscription = Subscription.find_by({user_id: session[:user_id], channel_id: params[:channel_id]})
		Subscription.destroy(@subscription.id)
	elsif params[:subscribe]
		@subscription = Subscription.create({user_id: session[:user_id], channel_id: params[:channel_id]})
	end
	redirect "/channel/#{params[:channel_id]}"
end