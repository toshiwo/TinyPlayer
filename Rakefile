# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/osx'

begin
  require 'bundler'
  Bundler.require
rescue LoadError
end

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'TinyPlayer'

  # via https://github.com/HipByte/RubyMotion/commit/a6de0f4021cf9dc155151cdc22887728ddddd6ca
  app.codesign_for_release = false
end
