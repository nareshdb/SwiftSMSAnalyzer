Pod::Spec.new do |s|
  s.name             = 'SwiftSMSAnalyzer'
  s.version          = '0.1.7'
  s.summary          = 'A small helper class which analyzes the SMS text.'
  s.description      = <<-DESC
It analyzes text for details as Encoding - UTF16, GSM 7 bit, Number of messages, Characters per message.
                       DESC
 
  s.homepage         = 'https://github.com/nareshdb/SwiftSMSAnalyzer'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Naresh Bhadresha' => 'nareshjangid84@gmail.com' }
  s.source           = { :git => 'https://github.com/nareshdb/SwiftSMSAnalyzer.git', :tag => s.version.to_s }
 
  s.ios.deployment_target = '10.0'
  s.source_files = 'Resources/SwiftSMSAnalyzer.swift'
 
end
