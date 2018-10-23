class Animal < ActiveRecord::Base
	# one animal to many media
	has_many :media
end 

