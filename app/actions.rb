# Homepage (Root path)
get '/' do
  erb :index
end

get '/music' do
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