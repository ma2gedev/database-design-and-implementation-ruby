require 'simple_db/server/database'
require 'simple_db/file/file_manager'
require 'simple_db/file/block_id'
require 'simple_db/file/page'

module SimpleDB
  class << self
    def create_database(directory_name, block_size, third_param)
      Server::Database.new(directory_name, block_size, third_param)
    end
  end
end
