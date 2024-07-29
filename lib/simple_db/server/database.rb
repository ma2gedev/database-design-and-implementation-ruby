module SimpleDB
  module Server
    class Database
      attr_reader :file_manager

      # TODO: Third parameter is `8` but I could not find any explanations about it
      def initialize(directory_name, block_size, what_is_this)
        @file_manager = File::FileManager.new(directory_name, block_size)
      end
    end
  end
end
