
Pod::Spec.new do |spec|

  spec.name         = "ARSelectableView"
  spec.version      = "0.1.1"
  spec.summary      = "ARSelectableView is provide selection type"

  spec.description  = <<-DESC
  ARSelectableView is provide selection type like : Radio, Checkbox, Tags
                   DESC

  spec.homepage     = "https://github.com/MakwanaRohit/ARSelectableView"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "Rohit Makwana" => "makwana.r.022@gmail.com" }

  spec.ios.deployment_target = "11.0"
  spec.swift_version = "4.2"

  spec.source       = { :git => "https://github.com/MakwanaRohit/ARSelectableView.git", :tag => spec.version }
  spec.source_files  = "ARSelectableView/**/*.swift"

end
