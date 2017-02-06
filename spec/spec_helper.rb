$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "stock_history"

RSpec.configure do |c|
  c.expect_with(:rspec) { |cc| cc.syntax = [:should, :expect] }
end