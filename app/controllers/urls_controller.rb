class UrlsController < ApplicationController
  def index
    @urls = Url.all
  end

  def new
    @url = Url.new
  end

  def show
    @url = Url.find(params[:id])
    if !params["created"]
      redirect_to @url.original, allow_other_host: true
    end
    @url
  end

  def create
    # Add the shorted URL to the parameters
    params = url_parameters
    params[:short] = Random.rand(1000).to_s

    # Create and save the new URL
    @url = Url.new(params)
    if @url.save
      # Redirect to the created object, but pass a query param so we can choose not to redirect
      redirect_to action: "show", controller: "urls", id: @url.id, created: true
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
    def url_parameters
      params.require(:url).permit(:original)
    end
end
