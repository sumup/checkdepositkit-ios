Pod::Spec.new do |s|
  s.name             = '{{NAME}}'
  s.version          = '0.0.1'
  s.summary          = '{{SUMMARY}}'

  s.homepage         = 'https://github.com/{{GIT_PATH}}'
  s.license          = { :type => 'Proprietary', :text => 'Copyright {{YEAR}} SumUp' }
  s.author           = 'SumUp'
  s.source           = { :git => 'git@github.com:{{GIT_PATH}}', :tag => s.version.to_s }

  s.swift_versions   = ['5.3']

  s.platform = :ios
  s.ios.deployment_target = '12.0'

  s.dependency 'SMPCrashReporting', '~> 1.2.0'
  s.dependency 'SMPLogging', '~> 1.0.2'

  s.source_files = ['{{NAME}}/**/*.{swift}']
  s.exclude_files = ['{{NAME}}/Tests/**/*']

  s.resource_bundle = { "{{NAME}}Resources" => ["{{NAME}}/**/*.{lproj,xcassets,strings}"] }
end
