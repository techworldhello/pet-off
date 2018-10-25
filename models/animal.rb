class Animal < ActiveRecord::Base
	# one animal to many media
	# when animal is deleted delete children
	has_many :media, dependent: :destroy
end 

