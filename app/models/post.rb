class Post < ApplicationRecord
	belongs_to :user
	validates_presence_of :content 
	validates_presence_of :scheduled_at
	validates_length_of :content, maximum: 140, message: "less than 140 please"
end
