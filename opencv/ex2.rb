  require "opencv"

  image = OpenCV::IplImage.load("boot.jpg")
  window = OpenCV::GUI::Window.new("preview")
  window.show(image)
  OpenCV::GUI::wait_key
