class Album
  attr_reader :id
  attr_accessor :name, :price

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
    @price = attributes.fetch(:price)
  end

  def ==(album_to_compare)
    self.name() == album_to_compare.name()
  end

  def self.all
    returned_albums = DB.exec("SELECT * FROM albums;")
    albums = []
    returned_albums.each() do |album|
      name = album.fetch("name")
      id = album.fetch("id").to_i
      albums.push(Album.new({:name => name, :id => id}))
    end
    albums
  end

  def save
    result = DB.exec("INSERT INTO albums (name, price) VALUES ('#{@name}', '#{@price}') RETURNING id;")
    @id = result.first().fetch("id").to_i
  end

  def self.clear
    DB.exec("DELETE FROM albums *;")
  end

  def self.find(id)
    album = DB.exec("SELECT * FROM albums WHERE id = #{id};").first
    name = album.fetch("name")
    id = album.fetch("id")
    Album.new ({:name => name, :id => id})
  end

  def update(name)
    @name = name
    DB.exec("UPDATE albums SET name = '#{name}' WHERE id = #{id}")
  end

  def delete 
    DB.exec("DELETE FROM albums WHERE id = #{id}")
    DB.exec("DELETE FROM songs WHERE album_id = #{@id}")
  end

  def self.search(name)
    search_albums = DB.exec("SELECT * FROM albums WHERE name = '#{name}';")
    albums = []
    search_albums.each() do |album|
      name = album.fetch("name")
      id = album.fetch("id").to_i
      albums.push(Album.new({:name => name, :id => id}))
    end
    albums
  end

  def songs
    Song.find_by_album(self.id)
  end

  def self.sort(parameter)
    returned_albums = DB.exec("SELECT * FROM albums;")
    albums = []
    returned_albums.each do |album|
      name = album.fetch("name")
      id = album.fetch("id").to_i
      price = album.fetch("price").to_i
      albums.push(Album.new({:name => name, :id => id, :price => price}))
    end
    albums.sort_by!(&:"#{parameter}")
  end
end