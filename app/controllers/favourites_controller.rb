require 'faker'
require 'net/http'
require 'uri'
require 'json'

class FavouritesController < ApplicationController
  def index
    faker = Faker::LoremFlickr.image
    first_part = faker.slice"http://loremflickr.com"
    second_part = get_response_with_redirect(URI.parse(faker))
    @url = first_part + second_part
  end

  def get_response_with_redirect(uri)
    r = Net::HTTP.get_response(uri)
    if r.code == "301"
      r = Net::HTTP.get_response(URI.parse(r.header['location']))
      part_url = r.header['location']
    end
    part_url
  end

  def new
    image_url = params['q']
    puts "Your image URL: #{image_url}"
  end

  def create
    @image = Image.new(url:params['q'])
    respond_to do |format|
      if @image.save
        format.html { redirect_to "/favourites", notice: 'Comment was successfully created.' }
        format.json { render json: @image, status: :created, location: @image }
      else
        format.html { render action: "new" }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  def show

  end
end