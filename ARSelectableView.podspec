
Pod::Spec.new do |spec|

  spec.name         = "ARSelectableView"
  spec.version      = "1.0.0"
  spec.summary      = "ARSelectableView is provide selection type"

  spec.description  = <<-DESC
  ARSelectableView is provide selection type like : Radio, Checkbox, Tags
                   DESC

  spec.platform     = :ios, '13.0'
  spec.homepage     = "https://github.com/MakwanaRohit/ARSelectableView"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "Rohit Makwana" => "makwana.r.022@gmail.com" }

  spec.ios.deployment_target = "13.0"
  spec.swift_version = "5.0"
  s.module_name      = 'ARSelectableView'

  spec.source       = { :git => "https://github.com/MakwanaRohit/ARSelectableView.git", :tag => spec.version }

  spec.source_files = "ARSelectableView/Classes/**/*.swift"
  spec.resources    = "ARSelectableView/Images/*"

end
