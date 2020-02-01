class Genre < ActiveRecord::Base
    
    has_many :song_genres
    has_many :songs, through: :song_genres
    has_many :artists, through: :songs
    
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