Pod::Spec.new do |s|
  s.name = 'ARSelectableView'
  s.version = '1.1'
  s.license = 'MIT'
  s.description  = <<-DESC
  ARSelectableView is provide selection type like : Radio, Checkbox, Tags
                   DESC

  s.summary = 'Selection type in Swift'
  s.homepage = 'https://github.com/MakwanaRohit/ARSelectableView'
  s.authors = { 'Rohit Makwana' => 'makwana.r.022@gmail.com' }
  s.source = { :git => "https://github.com/MakwanaRohit/ARSelectableView.git", :tag => s.version }
  s.source_files = "ARSelectableView/Classes/**/*.swift"
  s.resources    = "ARSelectableView/Images/*"

  s.ios.deployment_target = '13.0'

  s.swift_versions = ['5']

end