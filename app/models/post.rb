class Post < ApplicationRecord
	belongs_to :user
	validates_presence_of :content 
	validates_presence_of :scheduled_at
	validates_length_of :content, maximum: 140, message: "less than 140 please"
	validates_datetime :scheduled_at, :on => :create, :on_or_after => Time.zone.now 

	def to_twitter
		client = Twitter::REST::Client.new do |config|
			config.consumer_key        = ENV['TWITTER_KEY']
			config.consumer_secret     = ENV['TWITTER_SECRET']
			config.access_token        = self.user.twitter.oauth_token
			config.access_token_secret = self.user.twitter.secret
		end
		client.update(self.content)
	end

	def to_facebook
		graph = Koala::Facebook::API.new(self.user.facebook.oauth_access_token)
		graph.put_connections("me", "feed", message: self.content)
	end
end
