platform :ios, '12.0'

project '{{NAME}}SampleApp/{{NAME}}SampleApp.xcproj'

source "git@github.com:sumup/cocoapods-specs.git"
source 'https://cdn.cocoapods.org'

load "submodules/ios-tooling/cocoapods/Podfile-Helper.rb"

target '{{NAME}}SampleApp' do

  inhibit_all_warnings!
  use_frameworks!

  pod '{{NAME}}', :path => '.', :inhibit_warnings => false
  pod 'SMPIdentity', '~> 0.2.22', :subspecs => ['SampleAppIntegration']

  target '{{NAME}}UnitTests' do
    inherit! :search_paths
  end

  target '{{NAME}}SnapshotTests' do
    inherit! :search_paths
    pod 'SumUpSnapshotTesting'
  end
end

post_install do |installer|
  remove_mac_catalyst_support(installer)
  fix_deployment_target(installer)
  fix_last_upgrade_check(installer)
end

def remove_mac_catalyst_support(installer)
  apply_settings_to_generated_projects(installer, {
    'SUPPORTS_MACCATALYST' => 'NO',
    'SUPPORTS_MAC_DESIGNED_FOR_IPHONE_IPAD' => 'NO'
  })
end

def apply_settings_to_generated_projects(installer, build_settings)
  installer.generated_projects.each do |project|
    project.build_configurations.each do |config|
      build_settings.each do |key, value|
        config.build_settings[key] = value
      end
    end
  end
end
