class Artist
  attr_reader :id
  attr_accessor :name

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  def ==(artist_to_compare)
    self.name() == artist_to_compare.name()
  end

  def self.all
    returned_artists = DB.exec("SELECT * FROM artists;")
    artists = []
    returned_artists.each() do |artist|
      name = artist.fetch("name")
      id = artist.fetch("id").to_i
      artists.push(Artist.new({:name => name, :id => id}))
    end
    artists
  end

  def save
    result = DB.exec("INSERT INTO artists (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i
  end

  def self.clear
    DB.exec("DELETE FROM artists *;")
  end

  def self.find(id)
    artist = DB.exec("SELECT * FROM artists WHERE id = #{id};").first
    name = artist.fetch("name")
    id = artist.fetch("id")
    Artist.new ({:name => name, :id => id})
  end

  def update(attributes)
    if (attributes.has_key?(:name)) && (attributes.fetch(:name) != nil)
      @name = attributes.fetch(:name)
      DB.exec("UPDATE artists SET name = '#{@name}' WHERE id = #{@id};")
    elsif (attributes.has_key?(:album_name)) && (attributes.fetch(:album_name) != nil)
      album_name = attributes.fetch(:album_name)
      album = DB.exec("SELECT * FROM albums WHERE lower(name)='#{album_name.downcase}';").first
      if album != nil
        DB.exec("INSERT INTO albums_artists (album_id, artist_id) VALUES (#{album['id'].to_i}, #{@id});")
      end
    end
  end

  def delete 
    DB.exec("DELETE FROM albums_artists WHERE artist_id = #{@id}")
    DB.exec("DELETE FROM artists WHERE id = #{@id}")
  end

  def self.search(name)
    search_artists = DB.exec("SELECT * FROM artists WHERE name = '#{name}';")
    artists = []
    search_artists.each() do |artist|
      name = artist.fetch("name")
      id = artist.fetch("id").to_i
      artists.push(Artist.new({:name => name, :id => id}))
    end
    artists
  end

  def songs
    Song.find_by_artist(self.id)
  end

  def self.sort(parameter)
    returned_artists = DB.exec("SELECT * FROM artists;")
    artists = []
    returned_artists.each do |artist|
      name = artist.fetch("name")
      id = artist.fetch("id").to_i
      artists.push(Artist.new({:name => name, :id => id}))
    end
    artists.sort_by!(&:"#{parameter}")
  end

  def albums
    albums = []
    results = DB.exec("SELECT album_id FROM albums_artists WHERE artist_id = #{@id};")
    albums_id = results.values.join.to_i
    album_id = DB.exec("SELECT * FROM albums where ID in (#{albums_id});")
    album_id.each() do |album|
      name = album.fetch("name")
      id = album.fetch("id")
      albums.push(Album.new({:name => name, :id => id}))
    end
    albums
  end
end