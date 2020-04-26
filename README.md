## RUBY CLIENT FOR ACCESSING IPStack GEO-LOCATION DATABASES

## IPSTACK CLIENT

### Ruby Client for accessing the IPStack APIs for GeoLocation Servies

## DESCRIPTION

This is a Ruby Client for accessing the IPSTACK GeoLocation APIs.
It provides an option to cache the frequently accessed URLs for a configurable period using `redis` as a cache store.

It is a wrapper on the REST APIs provided by IPSTACK. More documentation can be found on
https://ipstack.com/documentation

------
## Installation

Add this line to your application's Gemfile:

```ruby
gem 'transaction'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install transaction


## CONFIGURATION

### OPTIONS


<table>
  <tr>
    <th> Option </th>
    <th> Description </th>
    <th> Default </th>
    <th> Required </th>
  </tr>

  <tr>
    <td> api_key </td>
    <td> Access Key for the IPSTACK ACCOUNT. An error is raised if this value is not provided. </td>
    <td> - </td>
    <td> YES </td>
  </tr>

  <tr>
    <td> enable_caching </td>
    <td>To cache the result for an IP. If true, requests are cached for a period of 6 hours by default in Redis. Redis client configuration needs tor be provided.</td>
    <td> false </td>
    <td> NO </td>
  </tr>

  <tr>
    <td> redis </td>
    <td>Redis Client object where the frequent requests will be cached. If `enable_caching` is set to `true` and `redis` is not defined, this will result in an error. </td>
    <td> redis://127.0.0.1:6379/0 </td>
    <td> NO </td>
  </tr>

  <tr>
    <td> cache_period </td>
    <td>TTL for which an IP String will be cached in redis. </td>
    <td> 6 hours </td>
    <td> NO </td>
  </tr>
  <tr>
    <td> enable_https </td>
    <td>To request IPStack APIs over HTTPS protocol. Only commercial accounts have access to use HTTPS. </td>
    <td> false </td>
    <td> NO </td>
  </tr>
</table>

### RAILS
In a file named `config/initializers/ipstack_client.rb`
```ruby

  IpstackClient.configure do |config|
    config.enable_caching = true
    config.redis = Redis.new(url: ENV['REDIS_HOST']) # redis host
    config.enable_https = false # only commercial accounts have HTTPS
    config.cache_period = 24.hours # caching period
    config.api_key = 'abcdefghtijjaj1212' # your IPStack API Key
  end

```
### RUBY
For plain Ruby, you can configure directly as well
```ruby
  require 'ipstack_client'

  # configuration options for ipstack_client
  IpstackClient.redis = Redis.new(url: ENV['REDIS_HOST'])
  IpstackClient.enable_https = false
  IpstackClient.cache_period = 24.hours
  IpstackClient.api_key = '44adbdb6a221064ae58c389f64f5f348'
```

## USAGE

### Find GeoIP details about an IP

```ruby
  ipstack_client = IpstackClient::Lookup.new()
  geoip_data = ipstack_client.geoip_data(request.remote_ip)

````
### RESPONSE FORMAT

#### Successful Response

```json
{
  "success": true,
  "data": {
    "ip": "134.201.250.155",
    "hostname": "134.201.250.155",
    "type": "ipv4",
    "continent_code": "NA",
    "continent_name": "North America",
    "country_code": "US",
    "country_name": "United States",
    "region_code": "CA",
    "region_name": "California",
    "city": "Los Angeles",
    "zip": "90013",
    "latitude": 34.0453,
    "longitude": -118.2413,
    "location": {
      "geoname_id": 5368361,
      "capital": "Washington D.C.",
      "languages": [
          {
            "code": "en",
            "name": "English",
            "native": "English"
          }
      ],
      "country_flag": "https://assets.ipstack.com/images/assets/flags_svg/us.svg",
      "country_flag_emoji": "🇺🇸",
      "country_flag_emoji_unicode": "U+1F1FA U+1F1F8",
      "calling_code": "1",
      "is_eu": false
    },
    "time_zone": {
      "id": "America/Los_Angeles",
      "current_time": "2018-03-29T07:35:08-07:00",
      "gmt_offset": -25200,
      "code": "PDT",
      "is_daylight_saving": true
    },
    "currency": {
      "code": "USD",
      "name": "US Dollar",
      "plural": "US dollars",
      "symbol": "$",
      "symbol_native": "$"
    },
    "connection": {
      "asn": 25876,
      "isp": "Los Angeles Department of Water & Power"
    },
    "security": {
      "is_proxy": false,
      "proxy_type": null,
      "is_crawler": false,
      "crawler_name": null,
      "crawler_type": null,
      "is_tor": false,
      "threat_level": "low",
      "threat_types": null
    }
  }
}
```
#### Errors

Detailed list of errors can be found here: https://ipstack.com/documentation (in the `Error Codes` Section)

Whenever a requested resource is not available or an API call fails for another reason, a JSON error is returned. Errors always come with an error code and a description.

**Example Error**: The following error is returned if your monthly API request volume has been exceeded.

```json
{
  "success": false,
  "error": {
    "code": 104,
    "type": "monthly_limit_reached",
    "info": "Your monthly API request volume has been reached. Please upgrade your plan."    
  }
}

```
