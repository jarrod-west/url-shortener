class UrlsController < ApplicationController
  SHORT_SIZE = 8 # Result will be ~4/3 this size, see SecureRandom.urlsafe_base64 doco for details.

  def index
    @urls = Url.all
  end

  def new
    @url = Url.new
  end

  def show
    @url = Url.find_by(short: params[:short])
    if !params["created"]
      redirect_to @url.original, allow_other_host: true
    end
    @url
  end

  def create
    # Add the shorted URL to the parameters
    params = url_parameters
    params[:short] = create_short # TODO: Handle conflicts, duplicates, etc

    # Create and save the new URL
    @url = Url.new(params)
    if @url.save
      # Redirect to the created object, but pass a query param so we can choose not to redirect
      redirect_to action: "show", controller: "urls", short: @url.short, created: true
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
    def url_parameters
      params.require(:url).permit(:original)
    end

    def create_short
      SecureRandom.urlsafe_base64(SHORT_SIZE)
    end
end
