  #!/usr/bin/env ruby
  require "opencv"

  #~ if ARGV.length < 2
    #~ puts "Usage: your_app_name source dest"
    #~ exit
  #~ end

  data = "C:\OpenCV-2.2.0\build/data/haarcascades/haarcascade_frontalface_alt.xml"
  data = 'C:\OpenCV-2.2.0\build\data\haarcascades\haarcascade_frontalface_alt.xml'
  detector = OpenCV::CvHaarClassifierCascade::load(data)
  image = OpenCV::IplImage.load('boot.jpg')
  detector.detect_objects(image) do |region|
    color = OpenCV::CvColor::Blue
    image.rectangle! region.top_left, region.bottom_right, :color => color
  end
  image.save_image('boot2.jpg')
