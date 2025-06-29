# frozen_string_literal: true

class Follower < ApplicationRecord
  self.table_name = 'Followers'

  establish_connection(
    adapter: 'postgresql',
    host: ENV['DB_HOST'],
    database: ENV['FOLLOW_DB_NAME'],
    username: ENV['DB_USER'],
    password: ENV['DB_PASSWORD'],
    port: ENV['DB_PORT'],
    encoding: 'unicode'
  )
end
