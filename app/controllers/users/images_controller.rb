module Users
  class ImagesController < ApplicationController
    def index
      @images = current_user.images_blobs

      ok(images: @images)
    end

    def create
      # Add validation to limit the file upload
      current_user.images.attach(params[:file])

      ok
    rescue ActiveSupport::MessageVerifier::InvalidSignature
      bad_request
    end

    def destroy
      image = current_user.images.find(params[:id])
      image.purge_later

      ok
    end
  end
end
