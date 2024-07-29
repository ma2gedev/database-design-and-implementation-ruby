module SimpleDB
  module File
    class FileManager
      attr_reader :block_size

      def initialize(db_directory, block_size)
        @db_directory = db_directory
        @block_size = block_size
        @open_files = {}
        @mutex = Mutex.new

        @new = !::File.exist?(@db_directory)
        if @new
          Dir.mkdir(@db_directory)
        end

        Dir.foreach(@db_directory) do |filename|
          if filename.start_with?('temp')
            ::File.delete(@db_directory + '/' + filename)
          end
        end
      end

      def read(block, page)
        @mutex.synchronize do
          file = open_file(block.filename)
          file.seek(block.block_num * @block_size)
          # TODO: StringIO を渡して書いてもらうことができないので、読み込んでから書き込んでいるが IF が汚い
          outbuf = "X" * page.bb.length
          file.read(page.bb.length, outbuf)
          page.bb.write(outbuf)
        end
      end

      def write(block, page)
        @mutex.synchronize do
          file = open_file(block.filename)
          file.seek(block.block_num * @block_size)
          file.write(page.contents)
        end
      end

      def append(filename)
        @mutex.synchronize do
          new_block_num = length(filename)
          block = SimpleDB::File::BlockId.new(filename, new_block_num)
          b = StringIO.new("\0" * block_size)
          file = open_file(filename)
          file.seek(block.block_num * @block_size)
          file.write(b)
          block
        end
      end

      def length(filename)
        file = open_file(filename)
        file.size / @block_size
      end

      def new?()
        @new
      end

      private
      
      def open_file(filename)
        file = @open_files[filename]
        if file == nil
          file = ::File.open(@db_directory + '/' + filename, 'w+')
          @open_files[filename] = file
        end
        file
      end
    end
  end
end
