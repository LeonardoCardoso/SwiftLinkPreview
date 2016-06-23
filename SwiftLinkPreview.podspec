Pod::Spec.new do |s|

	s.platform = :ios
	s.ios.deployment_target = '8.0'
	s.name = "SwiftLinkPreview"
	s.summary = "It makes a preview from an url, grabbing all the information such as title, relevant texts and images."
	s.requires_arc = true
	s.version = "0.0.2"
	s.license = { :type => "MIT", :file => "LICENSE" }
	s.author = { "Leonardo Cardoso" => "contact@leocardz.com" }
	s.homepage = "https://github.com/LeonardoCardoso/Swift-Link-Preview"
	s.source = { :git => "https://github.com/LeonardoCardoso/Swift-Link-Preview.git", :tag => "#{s.version}"}
	s.framework = "UIKit"
	s.dependency 'Alamofire', '~> 3.4'
	s.source_files = "SwiftLinkPreview/**/*.{swift}"
	s.resources = "SwiftLinkPreview/**/*.{swift}"

end