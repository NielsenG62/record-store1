class Album
  attr_reader :name, :id
  @@albums = {}
  @@total_rows = 0

  def initialize(name, id)
    @name = name
    @id = id || @@total_rows += 1
  end

  def ==(album_to_compare)
    self.name() == album_to_compare.name()
  end

  def self.all
    @@albums.values()
  end

  def save
    @@albums[self.id] = Album.new(self.name, self.id)
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

  def songs
    Song.find_by_album(self.id)
  end
end