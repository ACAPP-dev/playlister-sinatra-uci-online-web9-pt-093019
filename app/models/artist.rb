class Artist < ActiveRecord::Base

    has_many :songs
    has_many :genres, through: :songs

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