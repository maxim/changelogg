require 'typhoeus'
require 'fetcher/github'

module Fetcher
  ApiError = Class.new(StandardError)
end