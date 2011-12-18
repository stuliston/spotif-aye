require "spotif-aye/version"
require 'httparty'

module SpotifAye

	class Artist
		include HTTParty

		base_uri 'ws.spotify.com/search/1'

		attr_accessor :name, :href, :popularity

		def initialize(result)
			self.name = result['name']
			self.href = result['href']
			self.popularity = result['popularity'].to_f
		end

		def self.find(name)
	    response = get("/artist.json?q=#{name}")
	    if response.success?
	    	return parse_results(JSON.parse(response)['artists'])
	    else
	      raise response.response
	    end
	  end

	  private

    def self.parse_results(results)
    	artists = []
    	results.each { |r| artists << self.new(r) }
	  end

	end

end