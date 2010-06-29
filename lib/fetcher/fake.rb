module Fetcher
  class Fake
    attr_reader :uri
    
    URI_VALIDATOR = /^\s*(http:\/\/|git:\/\/)?github.com\/[^\/]+\/[^\/]+\/?\s*$/i

    def initialize(uri)
      @uri = uri.strip.downcase
    end

    def commits(reload = false)
      [
        { "parents"=>[{"id"=>"6c24c0e7c16c4477fcc8a18703fe1cf7b902e184"}],
          "author"=>{"name"=>"Maxim Chernyak", "login"=>"maxim", "email"=>"max@bitsonnet.com"},
          "url"=>"http://github.com/maxim/changelogg/commit/6566e62a119137d7bbebe7e0d2ca8b31c6d6f1e6",
          "id"=>"6566e62a119137d7bbebe7e0d2ca8b31c6d6f1e6",
          "committed_date"=>Time.parse("2010-06-18 14:15:39 -0400"),
          "authored_date"=>Time.parse("2010-06-18 14:15:39 -0400"),
          "message"=>"Embed Commits into Repository and teach Repository to populate its own commits.",
          "tree"=>"b4ed90aea9846cd5857508b4353cf4daeee59eb2",
          "committer"=>{"name"=>"Maxim Chernyak", "login"=>"maxim", "email"=>"max@bitsonnet.com"}},

        { "parents"=>[{"id"=>"a1dd38ef9dcfd9d1b0ddcc51d5c255f334b5d2c3"}],
          "author"=>{"name"=>"Maxim Chernyak", "login"=>"maxim", "email"=>"max@bitsonnet.com"},
          "url"=>"http://github.com/maxim/changelogg/commit/6c24c0e7c16c4477fcc8a18703fe1cf7b902e184",
          "id"=>"6c24c0e7c16c4477fcc8a18703fe1cf7b902e184",
          "committed_date"=>Time.parse("2010-06-18 14:06:51 -0400"),
          "authored_date"=>Time.parse("2010-06-18 14:06:51 -0400"),
          "message"=>"Parse time values in commits.",
          "tree"=>"23c480ee1b11c1b3aecca3b0510c84afe8c3f19b",
          "committer"=>{"name"=>"Maxim Chernyak", "login"=>"maxim", "email"=>"max@bitsonnet.com"}},

        { "parents"=>[{"id"=>"ca9efaa4a0a26188dadca5c94c1cae61a3ede1d3"}],
          "author"=>{"name"=>"Maxim Chernyak", "login"=>"maxim", "email"=>"max@bitsonnet.com"},
          "url"=>"http://github.com/maxim/changelogg/commit/a1dd38ef9dcfd9d1b0ddcc51d5c255f334b5d2c3",
          "id"=>"a1dd38ef9dcfd9d1b0ddcc51d5c255f334b5d2c3",
          "committed_date"=>Time.parse("2010-06-17 17:08:48 -0400"),
          "authored_date"=>Time.parse("2010-06-17 17:08:48 -0400"),
          "message"=>"Extract commits key from github response and handle more erroneous cases.",
          "tree"=>"440335465f1d010cff9faf12c37da45668637f93",
          "committer"=>{"name"=>"Maxim Chernyak", "login"=>"maxim", "email"=>"max@bitsonnet.com"}}
      ]
    end
    
    def tags
      { "1.1.0" => "6566e62a119137d7bbebe7e0d2ca8b31c6d6f1e6", 
        "0.9.0" => "440335465f1d010cff9faf12c37da45668637f93"}
    end
  end
end