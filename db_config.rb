require 'active_record'

options = {
    adapter: 'postgresql',
    database: 'pet_project'
}

ActiveRecord::Base.establish_connection( ENV['DATABASE_URL'] || options)