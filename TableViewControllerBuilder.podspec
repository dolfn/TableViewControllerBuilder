Pod::Spec.new do |s|
  s.name         = "TableViewControllerBuilder"
  s.version      = "0.1.1"
  s.summary      = "A framework that will make you to write only the custom code you need for building a generic table view controller."
  s.homepage     = "https://github.com/dolfn/TableViewControllerBuilder"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Dolfn" => "tap@dolfn.com" }
  s.social_media_url   = "https://twitter.com/dolfn_apps"
  s.ios.deployment_target = "8.0"
  s.source       = { :git => "https://github.com/dolfn/TableViewControllerBuilder.git", :tag => s.version }
  s.source_files  = "Sources/**/*"
  s.frameworks  = "Foundation", "UIKit"
  s.requires_arc = true
  s.module_name = "TableViewControllerBuilder"
end
