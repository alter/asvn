#!/usr/bin/env ruby
require '../asvn.rb'
svn = ASVN::Asvn.new('LOGIN','PASSWORD')
trunk_list = svn.list('svn://REPO/PATH/trunk')
trunk_list.each { |item| puts item }

