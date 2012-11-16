Pod::Spec.new do |s|
  s.name         = 'APUbiquitousUserDefaultsEngine'
  s.version      = '0.0.1'
  s.license      = 'BSD'
  s.summary      = 'APUbiquitousUserDefaultsEngine is a single class that syncs some keys of `NSUserDefaults` with iCloud, using `NSUbiquitousKeyValueStore` to store the values.'
  s.homepage     = 'https://github.com/monospacecollective/APUbiquitousUserDefaultsEngine'
  s.author       = { 'Axel Péju' => 'pejuaxel@me.com' }
  s.source       = { :git => 'https://github.com/monospacecollective/APUbiquitousUserDefaultsEngine.git', :tag => '0.0.1' }
  s.source_files = 'APUbiquitousUserDefaultsEngine.{h,m}'
  s.requires_arc = true
  s.platform     = :ios, '5.0'
end
