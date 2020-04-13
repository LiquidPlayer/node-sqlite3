require "json"

lcpackage = JSON.parse(File.read(File.join(__dir__, "package.json")))
version = lcpackage['version']

Pod::Spec.new do |s|
  s.name         = "node-sqlite3"
  s.version      = version
  s.summary      = "Asynchronous, non-blocking SQLite3 bindings for LiqudCore"

  s.description  = <<-DESC
    Asynchronous, non-blocking SQLite3 bindings for Node.js and LiquidCore.
  DESC

  s.homepage     = "https://github.com/LiquidPlayer/node-sqlite3"
  s.license = {:type => "BSD-3", :file => "LICENSE"}
  s.author             = { "Eric Lange" => "eric@flicket.tv" }
  s.platform = :ios, '11.0'
  s.source = { :git => "https://github.com/LiquidPlayer/node-sqlite3.git", :tag => "#{s.version}" }
  s.prepare_command = <<-CMD
    npm install
  CMD
  s.source_files  =
    "src/*.{cc,h}",
    "liquidcore/ios/*.{h,m,mm}",
    "node_modules/nan/*.h"
  s.private_header_files = [
    "src/*.{h}",
    "liquidcore/ios/*.{h}",
    "node_modules/nan/*.h"
  ]
  s.libraries = [ 'sqlite3' ]
  s.xcconfig = {
    :CLANG_WARN_DOCUMENTATION_COMMENTS => 'NO',
    :GCC_WARN_ABOUT_DEPRECATED_FUNCTIONS => 'NO',
    :GCC_WARN_64_TO_32_BIT_CONVERSION => 'NO',
    :CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES => 'YES',
    :SYSTEM_HEADER_SEARCH_PATHS => [
      "${PODS_CONFIGURATION_BUILD_DIR}/LiquidCore-headers/LiquidCore_headers.framework/PrivateHeaders/v8",
      "${PODS_CONFIGURATION_BUILD_DIR}/LiquidCore-headers/LiquidCore_headers.framework/PrivateHeaders/node",
      "${PODS_CONFIGURATION_BUILD_DIR}/LiquidCore-headers/LiquidCore_headers.framework/PrivateHeaders/uv",
      "${PODS_CONFIGURATION_BUILD_DIR}/LiquidCore-headers/LiquidCore_headers.framework/PrivateHeaders",
    ].join(' '),
    :OTHER_CFLAGS => [
      '-Wno-nullability-completeness'
    ].join(' '),
    :OTHER_CPLUSPLUSFLAGS => [
      '-DNODE_WANT_INTERNALS=1',
      '-Wno-nullability-completeness'
    ].join(' '),
  }
  s.dependency "LiquidCore"
  s.dependency "LiquidCore-headers"
end
