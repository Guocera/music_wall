enable :sessions


# Homepage (Root path)
get '/' do
    session[:email] ||= nil
  erb :index
end

get '/music' do
  session[:expires] = 1.week.from_now
  @songs = Song.all
  erb :'music/index'
end

get '/music/new' do
  @artist = Artist.new
  @song = Song.new
  @song.artist = @artist
  erb :'music/new'
end

get '/music/signup' do
  @user = User.new
  erb :'music/signup'
end

get '/music/login' do
  @user = User.new
  erb :'music/login'
end

post '/music/new' do
  @artist = Artist.find_or_initialize_by(
    name: params[:artist]
  )

  @song = @artist.songs.new(
    title: params[:title],
    url: params[:url],
    user: User.find_by(email: session[:email])
  )

  if @artist.save
    @song.save
    redirect '/music'
  else
    erb :'/music/new'
  end
end

post '/music/signup' do
  @user = User.new(
    email: params[:email],
    password: params[:password]
  )
  if User.find_by(email: params[:email])
    @user.errors.add(:email, 'already taken.')
  else
    redirect '/music' if @user.save
  end
  erb :'/music/signup'
end

post '/music/login' do
  @user = User.find_by(email: params[:email])

  if @user 
    if params[:password] == @user.password
      session[:email] = params[:email]
      redirect '/music'
    else
      @user = User.new(
        email: params[:email],
        password: params[:password]
      )
      @user.errors.add(:email, 'or Password was incorrect.')
      erb :'/music/login'
    end
  else
    @user = User.new(
      email: params[:email],
      password: params[:password]
    )
    @user.errors.add(:email, 'or Password was incorrect.')  
    erb :'/music/login'
  end
end

post '/music/logout' do
  session.clear
  redirect '/music'
end