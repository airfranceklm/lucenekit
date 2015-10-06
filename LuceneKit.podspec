#
# Be sure to run `pod lib lint LuceneKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "LuceneKit"
  s.version          = "0.1.0"
  s.summary          = "A short description of LuceneKit."
  s.description  = <<-DESC
# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!  
 
                       DESC

  s.homepage         = "https://github.com/afklm/lucenekit.git"
  s.license          = 'MIT'
  s.author           = { "Laurent Gaches" => "laurent@binimo.com" }
  s.source           = { :git => "https://github.com/afklm/lucenekit.git", :tag => s.version.to_s }
	
  s.platform     = :ios, '7.0'
  s.requires_arc = false

  s.resource_bundles = {
    'LuceneKit' => ['Pod/Assets/*.png']
  }

  s.source_files = 'Pod/Libraries/Header/**/*.h'
  s.vendored_library = ['Pod/Libraries/liblucene++.3.0.7.a']
  
end
