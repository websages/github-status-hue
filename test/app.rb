#!/usr/bin/env ruby
# only for testing

require 'rubygems'
require 'bundler/setup'
require './config/boot'
require './config/environment'

g = GitHub::Status.execute

