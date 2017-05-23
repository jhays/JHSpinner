Pod::Spec.new do |s|
  s.name             = "JHSpinner"
  s.version          = "0.2.1"
  s.summary          = "A unique animated loading spinner / activity indicator for iOS"
  s.description      = <<-DESC
  A unique animated loading spinner / activity indicator UIView subclass for iOS. Includes several customization options to change the overlay, colors, text, and animation speed. Also includes a determinate spinner for progress-bar style loading or file upload.
                       DESC

  s.homepage         = "https://github.com/jhays/JHSpinner"
  s.screenshots     = "https://raw.githubusercontent.com/jhays/JHSpinner/master/RoundedSquare.gif", "https://raw.githubusercontent.com/jhays/JHSpinner/master/Determinite.gif"
  s.license          = 'MIT'
  s.author           = { "JHays" => "orbosphere@gmail.com" }
  s.source           = { :git => "https://github.com/jhays/JHSpinner.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/orbosphere'
  s.platform     = :ios, '8.0'
  s.requires_arc = true
  s.source_files = 'Pod/Classes/**/*'
  s.frameworks = 'UIKit'
end
