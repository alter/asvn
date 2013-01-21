ASVN
====

tiny svn library(wrapper)

REQUIREMENTS
------------

####Linux####
  Redhat and Fedora: **yum install subversion-ruby**
  
  Ubuntu and Debian: **apt-get install libsvn-ruby**
####OS X####
  sudo port install subversion-rubybindings

**AND**
####  On both:####
  **gem install svn**


### EXAMPLE ###
    #!/usr/bin/env ruby
    require '../asvn.rb'
    svn = ASVN::Asvn.new('LOGIN','PASSWORD')
    trunk_list = svn.list('svn://REPO/PATH/trunk')
    trunk_list.each { |item| puts item }

#### Methods ####
- list
- info
- log
- checkout
- export

