# frozen_string_literal: true

class UrlsController < ApplicationController
  SHORT_SIZE = 8 # Result will be ~4/3 this size, see SecureRandom.urlsafe_base64 doco for details.

  def index
    @urls = Url.all
  end

  def show
    @url = Url.find_by(short: params[:short])
    redirect_to @url.original, allow_other_host: true unless params['created']
    @url
  end

  def new
    @url = Url.new
  end

  def create
    # Check if the URL already exists in the database
    params = url_parameters
    @url = Url.find_by(original: params[:original])
    if @url.nil?
      create_impl(params)
    else
      # Already exists, redirect to the original
      redirect_to action: 'show', controller: 'urls', short: @url.short, created: true
    end
  end

  private

  def url_parameters
    params.require(:url).permit(:original)
  end

  def create_short
    SecureRandom.urlsafe_base64(SHORT_SIZE)
  end

  def create_impl(params)
    # Add the shorted URL to the parameters
    params[:short] = create_short # TODO: Handle conflicts

    # Create and save the new URL
    @url = Url.new(params)
    if @url.save
      # Redirect to the created object, but pass a query param so we can choose not to redirect
      redirect_to action: 'show', controller: 'urls', short: @url.short, created: true
    else
      # Render the "new" object again, showing the errors
      render action: 'new', controller: 'urls', status: :unprocessable_entity
    end
  end
end
