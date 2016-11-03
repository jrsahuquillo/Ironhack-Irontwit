require 'spec_helper'
require 'date'

RSpec.describe Twit do
  describe ".usernames" do
     it "is a reply" do
       msg = "@hey hey"
       tweet = Twit.new(msg)
       expect(tweet.reply?).to eq(true)
     end
   end
  
  describe ".special_hashtags" do
   it "show special message" do
     msg = "We are learning in #ironhack hack"
     twit = Twit.new(msg)
     twit.special_hashtags
     expect(twit.hashtags).to include("#Hackyface")
   end
  end
 
  
  describe '.load_img' do
    before(:each) do
      msg = "chicos y chicas no es chiques #feminism"
      @twit = Twit.new(msg)
    end

    it 'push the image to the image property' do
      @twit.load_img("foton.jpeg")
      expect(@twit.img).to eq("foton.jpeg")
    end

    it 'allows only .jpeg .png .jpg extensions' do
      @twit.load_img("foton.pdf")
      expect(@twit.img).to be_nil
    end
  
    it 'returns alert msg on other extensions' do
      expect(@twit.load_img("foton.pdf")).to eq("Unsuported format")
    end
  end
  
  describe ".status" do
    it "is visible when date is between start and end" do
      start_date = Date.today - 1
      end_date = Date.today + 1
      twit = Twit.new("message", start_date, end_date)
      expect(twit.status).to eq("visible")
    end
    
    it "is invisible when date is not between start and end" do
      start_date = Date.today + 1
      end_date = Date.today + 10
      twit = Twit.new("message", start_date, end_date)
      expect(twit.status).to eq("invisible")
    end
  end
  
  describe "tweet message length" do
    it "is invalid over 140 characters" do
      str = "*" * 141
      twit = Twit.new(str)
      
      expect(twit.valid?).to eq(false)
      #expect { Twit.new(str) }.to raise_error
    end
    
    it "is valid under 140" do
      str = "*" * 139
      twit = Twit.new(str)
      
      expect(twit.valid?).to eq(true)
    end
  end
  
  describe ".hashtags" do
    it "extracts the correct amount of hashtags" do
      msg = "chicos y chicas no es chiques #feminism, #machirulo"
      twit = Twit.new(msg)
      expect(twit.hashtags.size).to eql(2)
    end
  
    it "works for zero hashtags" do
      msg = "chicos y chicas no es chiques"
      twit = Twit.new(msg)
      expect(twit.hashtags.size).to eql(0)
    end
    
    it "returns the correct hashtgas" do
      msg = "chicos y chicas no es chiques #feminism"
      twit = Twit.new(msg)
      expect(twit.hashtags).to include("#feminism")
    end
  end
end


