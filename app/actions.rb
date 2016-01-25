# Homepage (Root path)
get '/' do
  erb :index
end

get '/music' do
  @songs = Song.all
  erb :'music/index'
end

get '/music/new' do
  erb :'music/new'
end

post '/music' do
  @artist = Artist.create(
    name: params[:artist]
    )
  @song = Song.new(
    title: params[:title],
    artist: @artist,
    url: params[:url]  
  )
  if @song.save
    redirect '/music'
  else
    erb :'messages/new'
  end
end