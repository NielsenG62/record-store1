require 'spec_helper'

describe('#Artist') do

  describe('.all') do
    it("returns an empty array when there are no artists") do
      expect(Artist.all).to(eq([]))
    end
  end

  describe('#==') do
    it('is the same artist if it has the same attributes as another artist') do
      artist = Artist.new({:name => 'Blue', :id => nil})
      artist2 = Artist.new({:name => 'Blue', :id => nil})
      expect(artist).to(eq(artist2))
    end
  end


  describe('#save') do
    it("saves an artist") do
      artist = Artist.new({:name => 'Giant Steps', :id => nil})
      artist.save()
      artist2 = Artist.new({:name => 'Blue', :id => nil})
      artist2.save()
      expect(Artist.all).to(eq([artist, artist2]))
    end
  end

  describe('.clear') do
    it('clears all artists') do
      artist = Artist.new({:name => 'Giant Steps', :id => nil})
      artist.save()
      artist2 = Artist.new({:name => 'Blue', :id => nil})
      artist2.save()
      Artist.clear()
      expect(Artist.all).to(eq([]))
    end
  end

  describe('.find') do
    it("finds an artist by id") do
      artist = Artist.new({:name => 'Giant Steps', :id => nil})
      artist.save()
      artist2 = Artist.new({:name => 'Blue', :id => nil})
      artist2.save()
      expect(Artist.find(artist.id)).to(eq(artist))
    end
  end

  describe('#update') do
    it("updates an artist by id") do
      artist = Artist.new({:name => 'Giant Steps', :id => nil})
      artist.save()
      artist.update({:name => "A Love Supreme"})
      expect(artist.name).to(eq("A Love Supreme"))
    end
    it("adds an album to an artist") do
      artist = Artist.new({:name => "John Coltrane", :id => nil})
      artist.save()
      album = Album.new({:name => "A Love Supreme", :id => nil})
      album.save()
      artist.update({:album_name => "A Love Supreme"})
      expect(artist.albums).to(eq([album]))
    end
  end

  describe('#delete') do
    it("deletes an artist by id") do
      artist = Artist.new({:name => 'Giant Steps', :id => nil})
      artist.save()
      artist2 = Artist.new({:name => 'Blue', :id => nil})
      artist2.save()
      artist2.delete()
      expect(Artist.all).to(eq([artist]))
    end
  end

  describe('.search') do
    it('provides an artist with the given name') do
      artist = Artist.new({:name => 'Giant Steps', :id => nil})
      artist.save()
      artist2 = Artist.new({:name => 'Blue', :id => nil})
      artist2.save()
      expect(Artist.search('Giant Steps')).to(eq([artist]))
    end
  end

  describe('.sort') do
    it('sorts artists by the name') do
      artist = Artist.new({:name => 'Giant Steps', :id => nil})
      artist.save()
      artist2 = Artist.new({:name => 'Blue', :id => nil})
      artist2.save()
      artist3 = Artist.new({:name => 'Camp', :id => nil})
      artist3.save()
      expect(Artist.sort('name')).to(eq([artist2, artist3, artist]))
    end
  end

end