require 'spec_helper'

describe SpotifAye::Artist do

	describe 'find' do

		before :each do
			stub_request(:get, "http://ws.spotify.com/search/1/artist.json?q=stone").to_return(
				:status => 200, 
				:body => File.new('spec/mock_responses/single_result.txt'),
				:headers => {})
		end

		it 'should return a result set' do
			SpotifAye::Artist.find('stone').class.should == SpotifAye::ResultSet
		end

		describe 'ResultSet' do

			it 'should have the correct num_results' do
				SpotifAye::Artist.find('stone').num_results.should == 1
			end

			it 'should have the correct limit' do
				SpotifAye::Artist.find('stone').limit.should == 100
			end

			it 'should have the correct off_set' do
				SpotifAye::Artist.find('stone').offset.should == 0
			end

			it 'should have the correct type' do
				SpotifAye::Artist.find('stone').type.should == 'artist'
			end

			it 'should have the correct page' do
				SpotifAye::Artist.find('stone').page.should == 1
			end

			describe 'results' do

				it 'should be the correct size' do
					SpotifAye::Artist.find('stone').results.count.should == 1
				end

				it 'should contain artists objects' do
					SpotifAye::Artist.find('stone').results.first.class.should == SpotifAye::Artist
				end
			end
		end
	end

end