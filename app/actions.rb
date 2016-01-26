enable :sessions


# Homepage (Root path)
get '/' do
  erb :index
end

get '/music' do
  session[:user] ||= nil
  @songs = Song.all
  pp @songs
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
    url: params[:url]  
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

  if @user.save
    redirect '/music'
  else
    erb :'/music/signup'
  end
end

post '/music/login' do
  @user = User.new(
    email: params[:email],
    password: params[:password]
  )

  if @user.save
    session[:user] = params[:email]
    redirect '/music'
  else
    erb :'/music/signup'
  end
end

post '/music/logout' do
  session[:user] = nil
  redirect '/music'
end