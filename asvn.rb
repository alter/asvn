require 'svn/core'
require 'svn/client'
require 'svn/wc'
require 'svn/repos'

module ASVN
  class Asvn

    attr_accessor :login
    attr_accessor :password
    attr_accessor :scc
    @VERSION = 0.0.1

    def initialize(login,password)
      @login = login
      @password = password
      @scc = Svn::Client::Context.new()
      @scc.add_simple_provider
      @scc.auth_baton[Svn::Core::AUTH_PARAM_DEFAULT_USERNAME] = @login
      @scc.auth_baton[Svn::Core::AUTH_PARAM_DEFAULT_PASSWORD] = @password
    end

    def version
      @VERSION
    end

    #svn list svn://uri
    def list(repos_uri, revision='HEAD')
      revision == 'HEAD' ? revision : revision.to_i!
      list = []
      @scc.list(repos_uri, revision) { |path, dirent, lock, abs_path|
      if !path.empty?
        list << path
      end
      }
      return list
    end

    #svn export svn://uri
    def export(repos_uri, output_dir, revision='HEAD')
      revision == 'HEAD' ? revision : revision.to_i
      begin
        @scc.export(repos_uri, output_dir, revision)
      rescue Svn::Error::CLIENT_UNRELATED_RESOURCES => e
        raise "No such revision #{revision} at #{repos_uri}"
      end
    end

    #svn info svn://uri
    #puts("Url: #{info.url}")
    #puts("Last changed rev: #{info.last_changed_rev}")
    #puts("Last changed author: #{info.last_changed_author}")
    #puts("Last changed date: #{info.last_changed_date}")
    #puts("Kind: #{info.kind}")
    def info(repos_uri, revision='HEAD')
      revision == 'HEAD' ? revision : revision.to_i
      begin
        @scc.info(repos_uri, revision) { |path, info|
          return info
        }
      rescue Svn::Error => e
        raise "Failed to retrieve SVN info at revision #{revision}"
      end
    end

    def checkout(repos_uri, output_dir, revision='HEAD')
      revision == 'HEAD' ? revision : revision.to_i
      begin
        @scc.checkout(repos_uri, output_dir, revision, nil)
      rescue Svn::Error::CLIENT_UNRELATED_RESOURCES => e # revision doesn't exist
        raise "No such revision #{revision} at #{repos_uri}"
      end
    end

    def log(repos_uri, revision='HEAD')
      revision == 'HEAD' ? revision : revision.to_i
      list = {}
      @scc.log(repos_uri, 0, revision, 0, true, nil) { |changed_paths, rev, author, date, message|
        list[:revision] = rev
        list[:author] = author
        list[:date] = date
        list[:message] = message
        return list
      }
    end
  end
end
