class Song < ActiveRecord::Base
    
    belongs_to :artist
    has_many :song_genres
    has_many :genres, through: :song_genres

    def slug
        split_name = self.name.split(" ")
        split_name.map {|word| word.downcase}.join("-")  
    end

    def self.find_by_slug(input)
        split_input = input.split("-")
        input_name = split_input.map {|word| word.downcase}.join(" ")
        instance = self.find_by("LOWER(name)= ?", input_name)
    end
end