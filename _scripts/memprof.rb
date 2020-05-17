#!/usr/bin/env ruby
# frozen_string_literal: true

require 'memory_profiler'
require 'jekyll'

MemoryProfiler.report do
  Jekyll::Commands::Build.process(
    'source'      => File.expand_path('..', __dir__),
    'destination' => File.expand_path('../_site', __dir__),
    'verbose'     => false,
  )
  puts ''
end.pretty_print(scale_bytes: true, normalize_paths: true)
