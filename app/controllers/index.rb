get "/" do
  	@channels = Channel.all
  	erb :index
end

