# -*- encoding: utf-8 -*-
$:.unshift File.dirname(__FILE__)

require 'bundler'
Bundler.require(:default, (ENV["RACK_ENV"]|| 'development').to_sym)

Sidekiq.configure_server do |config|
  config.redis = { :url => ENV['REDISTOGO_URL'], :size => 10}
end

Sidekiq.configure_client do |config|
  config.redis = { :url => ENV['REDISTOGO_URL'] , :size => 10}
end

NEO4J_POOL = ConnectionPool.new(:size => 10, :timeout => 3) { Neography::Rest.new }

require 'active_support/core_ext/numeric/time'
require 'digest/sha1'

require 'neonews/jobs/get_news'
require 'neonews/jobs/get_article'
require 'neonews/jobs/get_description'