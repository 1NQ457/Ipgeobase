# frozen_string_literal: true

require_relative 'ipgeobase/version'
require_relative 'ipgeobase/query'
require_relative 'ipgeobase/status_check'
require 'uri'
require 'net/http'

module Ipgeobase
  class Error < StandardError; end
  class << self
    def lookup(ip)
      uri = URI("http://ip-api.com/xml/#{ip}")

      response = Net::HTTP.get_response(uri)

      check_fail(response)
      Query.parse(response.body, single: true)
    end

    private

    def check_fail(response)
      data = StatusCheck.parse(response.body, single: true)
      raise data.message if data.status == 'fail'
    end
  end
end
