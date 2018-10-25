class Medium < ActiveRecord::Base
	# one medium to many likes
    has_many :likes
    belongs_to :animals
    # one medium to users who liked it
    has_many :users, :through => :likes
end 

