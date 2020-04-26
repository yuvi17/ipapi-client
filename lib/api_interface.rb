# frozen_string_literal: true

require 'rest-client'

class ApiInterface
  API_HOST = 'api.ipstack.com/'

  def initialize(ip_address, api_key, https_enabled)
    @api_key = api_key
    @ip_address = ip_address
    @scheme = https_enabled ? 'https://' : 'http://'
  end

  def geoip_data
    response = RestClient.get("#{@scheme}#{API_HOST}#{@ip_address}?access_key=#{@api_key}")
    body = JSON.parse(response.body)
    if response.code == 200
      { success: true, data: body }
    else
      body
    end
  end

end