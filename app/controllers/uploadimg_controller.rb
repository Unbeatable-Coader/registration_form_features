class UploadimgController < ApplicationController
    def new 
      @image = Uploadimg.new
    end
  
    def create
      require 'securerandom'
      public_folder = Rails.root.join('public')
  
      uploaded_file = params[:image]
  
      allowed_formats = ['.jpg', '.jpeg']
      max_length = 5 * 1024 * 1024
  
      if !uploaded_file || !allowed_formats.include?(File.extname(uploaded_file.original_filename).downcase) || uploaded_file.original_filename.size > max_length
        render plain: "Invalid file. Please provide a valid file format (.jpg, .jpeg) or size (i.e., < 5mb)."
      else
        @unique_filename = SecureRandom.hex(10) + File.extname(uploaded_file.original_filename)
        upload_folder = public_folder.join('upload')
        FileUtils.mkdir_p(upload_folder) unless File.directory?(upload_folder)

        File.open(upload_folder.join(@unique_filename), 'wb') do |file|
          file.write(uploaded_file.original_filename)
        end

        redirect_to '/uploaded'
      end

    end

    
end
  