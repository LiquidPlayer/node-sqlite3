Pod::Spec.new do |s|
  s.name         = "node-sqlite3"
  s.version      = "0.1.0"
  s.summary      = "Asynchronous, non-blocking SQLite3 bindings for LiqudCore"

  s.description  = <<-DESC
    Asynchronous, non-blocking SQLite3 bindings for Node.js and LiquidCore.
  DESC

  s.homepage     = "https://github.com/LiquidPlayer/node-sqlite3"
  s.license = {:type => "BSD-3", :file => "LICENSE"}

  s.author             = { "Eric Lange" => "eric@flicket.tv" }

  s.platform = :ios, '10.0'

  s.source = { :git => "https://github.com/LiquidPlayer/node-sqlit3.git", :tag => "#{s.version}" }

  s.source_files  =
    "src/*.{cc,h}",
    "liquidcore/ios/*.{h,m,mm}",
    "node_modules/nan/*.h"

  s.libraries = [
    'sqlite3', # libsqlite3.tbd
  ]

  s.xcconfig = {
    :CLANG_WARN_DOCUMENTATION_COMMENTS => 'NO',
    :GCC_WARN_ABOUT_DEPRECATED_FUNCTIONS => 'NO',
    :GCC_WARN_64_TO_32_BIT_CONVERSION => 'NO',
    :SYSTEM_HEADER_SEARCH_PATHS => [
      "${PODS_CONFIGURATION_BUILD_DIR}/LiquidCore/LiquidCore.framework/PrivateHeaders"
    ].join(' '),

    :OTHER_CPLUSPLUSFLAGS => [
      '-DNODE_WANT_INTERNALS=1'
    ].join(' '),

  }

  s.swift_version = '3.0'

  s.dependency "LiquidCore"
end