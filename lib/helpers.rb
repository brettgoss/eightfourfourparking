#!/usr/bin/ruby
require 'dotenv'
require 'http'
require 'awesome_print'
require 'base64'
Dotenv.load

module Helpers
  def build_url(endpoint)
    @base_url = "https://#{ENV['ACCOUNT_URL']}/api/3.0"
    @endpoint = endpoint
    @built_url = "#{@base_url}/#{@endpoint}"

    puts "built url: " + @built_url
    return @built_url
  end

  def get(endpoint)
    puts "Getting: " + endpoint
    res = HTTP.basic_auth(:user => ENV['CLIENT_ID'], :pass => ENV['CLIENT_SECRET'])
      .get(build_url(endpoint)).to_s
  end

  def post(endpoint, body)
    puts "Posting to: " + endpoint
    res = HTTP.basic_auth(:user => ENV['CLIENT_ID'], :pass => ENV['CLIENT_SECRET'])
      .headers("Content-Type" => "application/json")
      .post(build_url(endpoint), :body => body).to_s
  end
end