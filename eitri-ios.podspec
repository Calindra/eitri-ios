#
# Be sure to run `pod lib lint eitri-ios.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'eitri-ios'
  s.version          = '2.1.0'
  s.summary          = 'eitri-ios'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
eitri-ios cocoapods distribution
                       DESC

  s.homepage         = 'https://github.com/Calindra/eitri-ios'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Calindra' => 'contato@calindra.com.br' }
  s.source           = { :git => 'https://github.com/Calindra/eitri-ios.git', :tag => s.version.to_s }

  s.ios.deployment_target = '13'
  s.vendored_frameworks = 'Eitri.xcframework'
  
end
