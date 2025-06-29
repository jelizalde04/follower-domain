class Pet < ActiveRecord::Base
  self.table_name = 'Pets'
  self.primary_key = 'id'

  establish_connection(
    adapter: 'postgresql',
    database: ENV['PET_DB_NAME'],
    host: ENV['DB_HOST'],
    username: ENV['DB_USER'],
    password: ENV['DB_PASSWORD'],
    port: ENV['DB_PORT']
  )
end
