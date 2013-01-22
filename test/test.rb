#!/usr/bin/env ruby
# -*- encoding: utf-8 -*-

#lib = File.expand_path('../lib', File.dirname(__FILE__))
#$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'asvn'


options = {user: 'asvn_user', password: 'asvn_password', uri: 'https://subversion.assembla.com/svn/asvn_example'}

svn = Asvn::Asvn.new(options[:user], options[:password])

puts "svn list: "
trunk_list = svn.list(options[:uri])
trunk_list.each { |item| puts item }
puts "="*20

puts "svn info: "
trunk_info = svn.info(options[:uri])
kind = trunk_info.kind == 1 ? "file" : "folder"
puts "url = #{trunk_info.url}\nrev = #{trunk_info.last_changed_rev}\nauthor = #{trunk_info.last_changed_author}\ndate = #{trunk_info.last_changed_date}\nKind = #{kind}"
puts "="*20

puts "svn log: "
trunk_log = svn.log(options[:uri])
trunk_log.each { |key,value| puts "#{key}: #{value}" }
puts "="*20
