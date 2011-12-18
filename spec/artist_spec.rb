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

		describe 'single result response' do

			before :each do
				stub_request(:get, "http://ws.spotify.com/search/1/artist.json?q=stone").to_return(
					:status => 200, 
					:body => File.new('spec/mock_responses/single_result.txt'), 
					:headers => {})
			end

			it 'should exist' do
				lambda { SpotifAye::Artist.find('stone') }.should_not raise_error(NoMethodError)
			end

			it 'should return an array' do
	      SpotifAye::Artist.find('stone').class.should == Array
			end

		end

	end

end