Pod::Spec.new do |s|
  s.name         = 'AcknowledgementsPlist'
  s.version      = '0.0.7'
  s.summary      = 'AcknowledgementsPlist manages the licenses of libraries that depend on your iOS app.'
  s.homepage     = 'https://github.com/cats-oss/AcknowledgementsPlist'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author             = { 'Takuma Horiuchi' => 'horitaku46@gmail.com' }
  s.source       = { http: "#{s.homepage}/releases/download/#{s.version}/portable_acknowledgementsplist.zip" }
  s.preserve_paths = '*'
  s.exclude_files = "**/file.zip"
end
