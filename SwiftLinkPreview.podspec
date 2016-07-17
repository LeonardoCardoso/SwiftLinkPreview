Pod::Spec.new do |s|

	s.ios.deployment_target = '8.0'
	s.osx.deployment_target     = "10.9"
    s.watchos.deployment_target = '2.0'
    s.tvos.deployment_target    = '9.0'
	s.name = "SwiftLinkPreview"
	s.summary = "It makes a preview from an url, grabbing all the information such as title, relevant texts and images."
	s.requires_arc = true
	s.version = "0.1.3"
	s.license = { :type => "MIT", :file => "LICENSE" }
	s.author = { "Leonardo Cardoso" => "contact@leocardz.com" }
	s.homepage = "https://github.com/LeonardoCardoso/SwiftLinkPreview"
	s.source = { :git => "https://github.com/LeonardoCardoso/SwiftLinkPreview.git", :tag => "#{s.version}"}
	s.source_files = "Sources/**/*.{swift}"
	s.resources = "Sources/**/*.{swift}"

end