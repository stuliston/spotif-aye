require 'spec_helper'

describe SpotifAye::Artist do

	describe 'constructor' do

		before :all do
			@artist = SpotifAye::Artist.new({ "href" => "spotify:artist:4gzpq5DPGxSnKTe4SA8HAU", "name" => "Coldplay", "popularity" => "0.75453" })
		end

		it 'should assign the name' do
			@artist.name.should == 'Coldplay'
		end

		it 'should assign the href' do
			@artist.href.should == 'spotify:artist:4gzpq5DPGxSnKTe4SA8HAU'
		end

		it 'should assign the popularity' do
			@artist.popularity.should == 0.75453
		end
	end

	describe 'find' do

		before :all do
			body = 
			<<-EOV
			{
				"artists" => {
					"xmlns:opensearch" => "http://a9.com/-/spec/opensearch/1.1/", 
					"xmlns" => "http://www.spotify.com/ns/music/1", 
					"Query" => { 
						"role" => "request", 
						"startPage" => "1", 
						"searchTerms" => "the stone roses" }, 
					"totalResults" => "3", 
					"startIndex" => "0", 
					"itemsPerPage" => "100", 
					"artist" => [
						{ "href" => "spotify:artist:1lYT0A0LV5DUfxr6doRP3d", 
							"name" => "The Stone Roses", 
							"popularity" => "0.53524" }
					]
				}
			}
			EOV

			FakeWeb.register_uri(:get, "http://ws.spotify.com/search/1/artist.json?q=foo", :body => body)
		end

		it 'should exist' do
			lambda { SpotifAye::Artist.find('The Stone Roses') }.should_not raise_error(NoMethodError)
		end

		it 'should turn a single result into a single Artist array ' do
      SpotifAye::Artist.find('foo').should == 'foo'
		end

	end

end