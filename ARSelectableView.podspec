Pod::Spec.new do |spec|

  spec.name         = "ARSelectableView"
  spec.version      = "0.0.1"
  spec.summary      = "ARSelectableView is provide multiple selection type"

  spec.description  = <<-DESC
This CocoaPods library helps you perform selection.
                   DESC

  spec.homepage     = "https://github.com/MakwanaRohit/ARSelectableView"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "Rohit Makwana" => "makwana.r.022@gmail.com" }

  spec.ios.deployment_target = "11.0"
  spec.swift_version = "4.2"

  spec.source        = { :git => "https://github.com/jeantimex/SwiftyLib.git", :tag => "#{spec.version}" }
  spec.source_files  = "ARSelectableView"

end