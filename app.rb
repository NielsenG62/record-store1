require('sinatra')
require('sinatra/reloader')
require('./lib/album')
require('./lib/song')
require('./lib/artist')
require('pry')
also_reload('lib/**/*.rb')
require('pg')

DB = PG.connect({:dbname => "record_store"})

get('/test') do
  @something = "this is a variable"
  erb(:whatever)
end

get('/') do
  redirect to('/index')
end

get('/index') do
  @albums = Album.all
  @artists = Artist.all
  erb(:index)
end

get('/albums') do
  @albums = Album.all
  erb(:albums)
end

get('/albums/new') do
  erb(:new_album)
end

get('/artists/new') do
  erb(:new_artist)
end

get('/artists/:id') do
  @artist = Artist.find(params[:id].to_i())
  erb(:artist)
end

post('/index') do
  album_name = params[:album_name]
  artist_name = params[:artist_name]
  album = Album.new({:name => album_name, :artist => artist_name :id => nil})
  album.save()
  artist = Artist.new({:name => artist_name, :id => nil})
  artist.save()
  redirect to('/index')
end

get('/albums/:id') do
  @album = Album.find(params[:id].to_i())
  erb(:album)
end

get('/albums/:id/edit') do 
  @album = Album.find(params[:id].to_i())
  erb(:edit_album)
end

patch('/albums/:id') do
  @album = Album.find(params[:id].to_i())
  @album.update(params[:name])
  @albums = Album.all
  erb(:albums)
end

delete('/albums/:id') do
  @album = Album.find(params[:id].to_i())
  @album.delete()
  @albums = Album.all
  erb(:albums)
end

get('/albums/search') do
  @album = Album.find(params[:id].to_i())
  erb(:album)
end

get('/albums/:id/songs/:song_id') do
  @song = Song.find(params[:song_id].to_i())
  erb(:song)
end

post('/albums/:id/songs') do
  @album = Album.find(params[:id].to_i())
  song = Song.new({:name => params[:song_name], :album_id => @album.id, :id => nil})
  song.save()
  erb(:album)
end

patch('/albums/:id/songs/:song_id') do
  @album = Album.find(params[:id].to_i())
  song = Song.find(params[:song_id].to_i())
  song.update(params[:name], @album.id)
  erb(:album)
end

delete('/albums/:id/songs/:song_id') do
  song = Song.find(params[:song_id].to_i())
  song.delete
  @album = Album.find(params[:id].to_i())
  erb(:album)
end