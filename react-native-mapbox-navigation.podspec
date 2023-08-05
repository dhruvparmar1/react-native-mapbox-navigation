require "json"

package = JSON.parse(File.read(File.join(__dir__, "package.json")))
folly_compiler_flags = '-DFOLLY_NO_CONFIG -DFOLLY_MOBILE=1 -DFOLLY_USE_LIBCPP=1 -Wno-comma -Wno-shorten-64-to-32'

TargetsToChangeToDynamic = []

$RNMBNAV = Object.new

def $RNMBNAV.post_install(installer)
  installer.pod_targets.each do |pod|
    if TargetsToChangeToDynamic.include?(pod.name)
      if pod.send(:build_type) != Pod::BuildType.dynamic_framework
        pod.instance_variable_set(:@build_type,Pod::BuildType.dynamic_framework)
        puts "* Changed #{pod.name} to `#{pod.send(:build_type)}`"
        fail "Unable to change build_type" unless mobile_events_target.send(:build_type) == Pod::BuildType.dynamic_framework
      end
    end
  end
end

def $RNMBNAV.pre_install(installer)
  installer.aggregate_targets.each do |target|
    target.pod_targets.select { |p| TargetsToChangeToDynamic.include?(p.name) }.each do |mobile_events_target|
      mobile_events_target.instance_variable_set(:@build_type,Pod::BuildType.dynamic_framework)
      puts "* Changed #{mobile_events_target.name} to #{mobile_events_target.send(:build_type)}"
      fail "Unable to change build_type" unless mobile_events_target.send(:build_type) == Pod::BuildType.dynamic_framework
    end
  end
end

Pod::Spec.new do |s|
  s.name         = "react-native-mapbox-navigation"
  s.version      = package["version"]
  s.summary      = package["description"]
  s.homepage     = package["homepage"]
  s.license      = package["license"]
  s.authors      = package["author"]

  s.platforms    = { :ios => "12.0" }
  s.source       = { :git => "https://github.com/dhruvparmar1/react-native-mapbox-navigation.git", :tag => "#{s.version}" }

  s.source_files = "ios/**/*.{h,m,mm,swift}"

  s.dependency "React-Core"
  s.dependency "MapboxCoreNavigation", "~> 2.11.0"
  s.dependency "MapboxNavigation", "~> 2.11.0"

  # Don't install the dependencies when we run `pod install` in the old architecture.
  if ENV['RCT_NEW_ARCH_ENABLED'] == '1' then
    s.compiler_flags = folly_compiler_flags + " -DRCT_NEW_ARCH_ENABLED=1"
    s.pod_target_xcconfig    = {
        "HEADER_SEARCH_PATHS" => "\"$(PODS_ROOT)/boost\"",
        "OTHER_CPLUSPLUSFLAGS" => "-DFOLLY_NO_CONFIG -DFOLLY_MOBILE=1 -DFOLLY_USE_LIBCPP=1",
        "CLANG_CXX_LANGUAGE_STANDARD" => "c++17"
    }
    s.dependency "React-RCTFabric"
    s.dependency "React-Codegen"
    s.dependency "RCT-Folly"
    s.dependency "RCTRequired"
    s.dependency "RCTTypeSafety"
    s.dependency "ReactCommon/turbomodule/core"
  end
end
