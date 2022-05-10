class Album
  attr_reader :name, :artist, :year, :genre, :id
  @@albums = {}
  @@total_rows = 0

  def initialize(name, artist, year, genre, id)
    @name = name
    @artist = artist
    @year = year
    @genre = genre
    @id = id || @@total_rows += 1
  end

  def ==(album_to_compare)
    self.name() == album_to_compare.name()
    self.artist() == album_to_compare.artist()
    self.year() == album_to_compare.year()
    self.genre() == album_to_compare.genre()
  end

  def self.all
    @@albums.values()
  end

  def save
    @@albums[self.id] = Album.new(self.name, self.artist, self.year, self.genre, self.id)
  end

  def self.clear
    @@albums = {}
    @@total_rows = 0
  end

  def self.find(id)
    @@albums[id]
  end

  def update(name)
    @name = name
    @artist = artist
    @year = year
    @genre = genre
  end

  def delete 
    @@albums.delete(self.id)
  end

  def self.search(name)
    @@albums.each do |album|
      if album[1].name == name
        return album[1]
      end
    end
  end
end