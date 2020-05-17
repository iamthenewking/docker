# frozen_string_literal: true

require "jekyll"
require "method_profiler"

module Hirb::Helpers::Table::Filters
  def to_milliseconds(seconds)
    # override original definition: `"%.3f ms" % (seconds * 1000)`
    "%.3fs" % (seconds)
  end
end

def log(topic, message="")
  puts "#{topic} ".rjust(20) + message
end

klass   = Object.const_get(ARGV[0] || "Jekyll::Site", false)
profiler = MethodProfiler.observe(klass)
log "-" * 80
log "Profiling:", klass.name.cyan
log "-" * 80

Jekyll::Commands::Build.process(
  "source"      => File.expand_path('..', __dir__),
  "destination" => File.expand_path('../_site', __dir__),
  "verbose"     => false,
  "incremental" => false
)

log ""
log profiler.report.sort_by(:method).order(:descending)
