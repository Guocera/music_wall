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

post '/music' do
  @artist = Artist.new(
    name: params[:artist]
  )
  artist_saved = @artist.save
  pp artist_saved, @artist
  @song = Song.new(
    title: params[:title],
    artist: @artist,
    url: params[:url]  
  )
  song_saved = @song.save
  pp song_saved, @song
  
  if artist_saved && song_saved
    redirect '/music'
  else
    erb :'/music/new'
  end
end