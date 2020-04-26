#frozen_string_literal: true

require 'json'

module IpstackClient
  class Cacher
    def initialize(redis, enable_caching, cache_period)
      @redis_client = redis
      @enable_caching = enable_caching
      @cache_period = cache_period
    end

    def find(ip)
      yield unless @enable_caching

      geoip_data =  @redis_client.get(ip)
      return JSON.parse(geoip_data) if geoip_data

      geoip_data = yield
      @redis_client.set(ip, geoip_data.to_json, ex: @cache_period) if geoip_data[:success]
        
      geoip_data
    end
  end
end