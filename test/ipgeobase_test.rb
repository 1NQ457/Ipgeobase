# frozen_string_literal: true

require 'test_helper'

class IpgeobaseTest < Minitest::Test
  def setup # rubocop:disable Metrics/MethodLength
    stub_request(:get, 'http://ip-api.com/xml/83.169.216.199')
      .to_return(body: File.read('test/fixtures/succes.xml'))

    stub_request(:get, 'http://ip-api.com/xml/8.8.8.8.8')
      .to_return(body: File.read('test/fixtures/fail.xml'))

    @correct_ip = '83.169.216.199'
    @incorrect_ip = '8.8.8.8.8'

    @sample_object = {
      country: 'Russia',
      countryCode: 'RU',
      city: 'Yekaterinburg',
      lat: 56.8333,
      lon: 60.6
    }
  end

  def teardown; end

  def test_correct_case
    actual = Ipgeobase.lookup(@correct_ip)

    assert_equal @sample_object[:country], actual.country
    assert_equal @sample_object[:countryCode], actual.countryCode
    assert_equal @sample_object[:city], actual.city
    assert_equal @sample_object[:lat], actual.lat
    assert_equal @sample_object[:lon], actual.lon
  end

  def test_incorrect_case
    assert_raises RuntimeError do
      Ipgeobase.lookup(@incorrect_ip)
    end
  end
end
