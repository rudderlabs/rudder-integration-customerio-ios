require 'json'

package = JSON.parse(File.read(File.join(__dir__, 'package.json')))

rudder_sdk_version = '~> 1.26'
deployment_target = '13.0'

customerio_sdk_name = 'CustomerIO/DataPipelines'
customerio_sdk_version = '~> 3.5.1'

Pod::Spec.new do |s|
  s.name             = 'Rudder-CustomerIO'
  s.version          = package['version']
  s.summary          = 'Privacy and Security focused Segment-alternative. CustomerIO Native SDK integration support.'

  s.description      = <<-DESC
  Rudder is a platform for collecting, storing and routing customer event data to dozens of tools. Rudder is open-source, can run in your cloud environment (AWS, GCP, Azure or even your data-centre) and provides a powerful transformation framework to process your event data on the fly.
                       DESC
  s.homepage         = 'https://github.com/rudderlabs/rudder-integration-customerio-ios'
  s.license          = { :type => "Apache", :file => "LICENSE.md" }
  s.author           = { 'RudderStack' => 'arnab@rudderlabs.com' }
  s.source           = { :git => 'https://github.com/rudderlabs/rudder-integration-customerio-ios.git' , :tag => "v#{s.version}" }
  
  s.requires_arc = true
  s.source_files = 'Rudder-CustomerIO/Classes/**/*'
  s.static_framework = true
  s.ios.deployment_target = deployment_target
  
  if defined?($CustomerIOSDKVersion)
    Pod::UI.puts "#{s.name}: Using user specified CustomerIO SDK version '#{$CustomerIOSDKVersion}'"
    customerio_sdk_version = $CustomerIOSDKVersion
  else
    Pod::UI.puts "#{s.name}: Using default CustomerIO SDK version '#{customerio_sdk_version}'"
  end
  
  if defined?($RudderSDKVersion)
    Pod::UI.puts "#{s.name}: Using user specified Rudder SDK version '#{$RudderSDKVersion}'"
    rudder_sdk_version = $RudderSDKVersion
  else
    Pod::UI.puts "#{s.name}: Using default Rudder SDK version '#{rudder_sdk_version}'"
  end
  
  s.dependency 'Rudder', rudder_sdk_version
  s.dependency customerio_sdk_name, customerio_sdk_version
  
end
