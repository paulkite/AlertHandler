Pod::Spec.new do |s|
  s.name         = "AlertHandler"
  s.version      = "1.1.3"
  s.summary      = "Simple UIAlertController wrapper."
  s.description  = <<-DESC
  Simple UIAlertController wrapper. Allows for one line alert view / action sheet dispatch with customizable options.
                   DESC
  s.homepage     = "https://github.com/paulkite/AlertHandler"
  s.license      = "MIT"
  s.author    = "Voodoo77 Studios, Inc."
  s.platform     = :ios, "9.0"
  s.source       = { :git => "https://github.com/paulkite/AlertHandler.git", :tag => "v#{s.version}" }
  s.source_files  = "AlertHandler", "AlertHandler/**/*.{h,m,swift}"
  s.requires_arc = true
end
