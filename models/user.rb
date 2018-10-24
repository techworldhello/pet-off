class User < ActiveRecord::Base
   has_secure_password
   has_many :animals
   has_many :likes
end 