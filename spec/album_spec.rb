require 'spec_helper'

describe('#Album') do

  describe('.all') do
    it("returns an empty array when there are no albums") do
      expect(Album.all).to(eq([]))
    end
  end

  describe('#==') do
    it('is the same album if it has the same attributes as another album') do
      album = Album.new({:name => 'Blue', :id => nil, :price => 5})
      album2 = Album.new({:name => 'Blue', :id => nil, :price => 5})
      expect(album).to(eq(album2))
    end
  end


  describe('#save') do
    it("saves an album") do
      album = Album.new({:name => 'Giant Steps', :id => nil, :price => 5})
      album.save()
      album2 = Album.new({:name => 'Blue', :id => nil, :price => 5})
      album2.save()
      expect(Album.all).to(eq([album, album2]))
    end
  end

  describe('.clear') do
    it('clears all albums') do
      album = Album.new({:name => 'Giant Steps', :id => nil, :price => 5})
      album.save()
      album2 = Album.new({:name => 'Blue', :id => nil, :price => 5})
      album2.save()
      Album.clear()
      expect(Album.all).to(eq([]))
    end
  end

  describe('.find') do
    it("finds an album by id") do
      album = Album.new({:name => 'Giant Steps', :id => nil, :price => 5})
      album.save()
      album2 = Album.new({:name => 'Blue', :id => nil, :price => 5})
      album2.save()
      expect(Album.find(album.id)).to(eq(album))
    end
  end

  describe('#update') do
    it("updates an album by id") do
      album = Album.new({:name => 'Giant Steps', :id => nil, :price => 5})
      album.save()
      album.update("A Love Supreme")
      expect(album.name).to(eq("A Love Supreme"))
    end
  end

  describe('#delete') do
    it("deletes an album by id") do
      album = Album.new({:name => 'Giant Steps', :id => nil, :price => 5})
      album.save()
      album2 = Album.new({:name => 'Blue', :id => nil, :price => 5})
      album2.save()
      album2.delete()
      expect(Album.all).to(eq([album]))
    end
    it("deletes all songs belonging to a deleted album") do
      album = Album.new({:name => "A Love Supreme", :id => nil, :price => 5})
      album.save()
      song = Song.new({:name => "Naima", :album_id => album.id, :id => nil, :price => 5})
      song.save()
      album.delete()
      expect(Song.find(song.id)).to(eq(nil))
    end
  end

  describe('.search') do
    it('provides an album with the given name') do
      album = Album.new({:name => 'Giant Steps', :id => nil, :price => 5})
      album.save()
      album2 = Album.new({:name => 'Blue', :id => nil, :price => 5})
      album2.save()
      expect(Album.search('Giant Steps')).to(eq([album]))
    end
  end

  describe('.sort') do
    it('sorts albums by the name') do
      album = Album.new({:name => 'Giant Steps', :id => nil, :price => 5})
      album.save()
      album2 = Album.new({:name => 'Blue', :id => nil, :price => 5})
      album2.save()
      album3 = Album.new({:name => 'Camp', :id => nil, :price => 5})
      album3.save()
      expect(Album.sort('name')).to(eq([album2, album3, album]))
    end
    it('sorts albums by the price') do
      album = Album.new({:name => 'Giant Steps', :price => 2, :id => nil})
      album.save()
      album2 = Album.new({:name => 'Blue', :price => 3, :id => nil})
      album2.save()
      album3 = Album.new({:name => 'Camp', :price => 1, :id => nil})
      album3.save()
      expect(Album.sort('price')).to(eq([album3, album, album2]))
    end
  end
end