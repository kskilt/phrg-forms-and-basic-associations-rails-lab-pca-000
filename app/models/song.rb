# frozen_string_literal: true

class Song < ActiveRecord::Base
  belongs_to :artist
  belongs_to :genre
  has_many :notes

  def genre_name=(name)
    genre = Genre.find_or_create_by(name: name)
    self.genre = genre
  end

  def genre_name
    try(:genre).try(:name)
  end

  def artist_name
    try(:artist).try(:name)
  end

  def artist_name=(name)
    artist = Artist.find_or_create_by(name: name)
    self.artist = artist
  end

  def note_contents=(notes)
    notes.each do |content|
      self.notes.build(content: content) if content.strip != ""
    end
  end

  def note_contents
    notes.map(&:content)
  end
end
