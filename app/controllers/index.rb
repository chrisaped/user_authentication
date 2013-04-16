enable :sessions

get '/' do
  # Look in app/views/index.erb
  erb :index
end

get '/sign_up' do
	erb :sign_up
end

post '/sign_up' do
	@user = User.create(params[:user])
	session[:id] = @user.id
	erb :profile
end

get '/sessions/new' do
	erb :sign_in
end

post '/sessions' do
	@user = User.find_by_email(params[:user][:email])
	if @user
		if @user.password == params[:user][:password]
		session[:id] = @user.id
		redirect '/profile'
		end
	end
	@error = "Invalid email or password."
	erb :sign_in
end

get '/sign_out' do
	session.clear 
	redirect '/'
end

get '/profile' do
	@user = User.find(session[:id])
	erb :profile
end
