# frozen_string_literal: true

require 'happymapper'

class StatusCheck
  include HappyMapper

  tag 'query'
  element :status, String
  element :message, String
end
