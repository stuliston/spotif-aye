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
	    	return ResultSet.new(response)
	    else
	      raise response.response
	    end
	  end

	end

	class ResultSet

		attr_accessor :num_results, :limit, :offset, :query, :type, :page, :results

		def initialize(response)
			results = JSON.parse(response)
			populate_info(results['info'])
			populate_results(results['artists'])
		end

		private 

		def populate_info(info)
			self.num_results = info['num_results']
			self.limit = info['limit']
			self.offset = info['offset']
			self.query = info['query']
			self.type = info['type']
			self.page = info['page']
		end

		def populate_results(artists)
			self.results = []
			artists.each { |a| self.results << Artist.new(a) }
		end

	end

end