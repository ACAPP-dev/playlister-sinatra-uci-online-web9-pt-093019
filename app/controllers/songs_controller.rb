require 'sinatra/base'
require 'rack-flash'


class SongsController < ApplicationController

    use Rack::Flash
    
    get '/songs' do
        @songs = Song.all 
        erb :'songs/index'
    end

    get '/songs/new' do
        @genres = Genre.all
        erb :'songs/new'
    end

    get '/songs/:slug' do
        @song = Song.find_by_slug(params[:slug])
        erb :'songs/show'
    end

    get '/songs/:slug/edit' do
        @song = Song.find_by_slug(params[:slug])
        @genres = Genre.all
        erb :'songs/edit'
    end

    post '/songs' do
        @song = Song.create(params[:song])
        artist_find = Artist.find_by_slug(params[:artist][:name])
        if !artist_find
            artist = Artist.create(params[:artist])
            @song.artist = artist
            @song.save
        else
            @song.artist = artist_find
            @song.save
        end
        params[:genres].each do |genre_id|
            genre_find = Genre.find(genre_id.to_i)
            @song.genres << genre_find
            @song.save
        end
        @song.save
        flash[:message] = "Successfully created song."
        redirect to("/songs/#{@song.slug}")
    end

    patch '/songs' do
        @song = Song.find_by_slug(params[:song][:name])
        Artist.update(params[:artist])
        @song.save
        flash[:message] = "Successfully updated song."
        redirect to("/songs/#{@song.slug}")
    end
end