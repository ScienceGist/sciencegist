require 'grape'
require_relative 'api_v1'
require_relative 'api_v2'

module Sg
  class Api < Grape::API
    mount ApiV1
    mount ApiV2
  end
end
