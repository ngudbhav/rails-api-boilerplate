module Users
  class ImagesController < ApplicationController
    def index
      @images = current_user.images_blobs

      ok(images: @images)
    end

    def create
      # Add validation to limit the file upload
      if current_user.images.attach(params[:file])
        ok
      else
        bad_request
      end
    end

    def destroy
      image = current_user.images.find(params[:id])
      image.purge_later

      ok
    end
  end
end
