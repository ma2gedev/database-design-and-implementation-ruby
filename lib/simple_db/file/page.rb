module SimpleDB
  module File
    class Page
      INT32_SIZE = 4
      UTF16_SIZE = 2

      attr_reader :bb

      def initialize(block_size)
        @bb = StringIO.new("\0" * block_size)
      end

      def get_int(offset)
        bb.seek(offset)
        bb.read(INT32_SIZE).unpack('N').first
      end

      def set_int(offset, n)
        bb.seek(offset)
        bb.write([n].pack('N'))
      end

      def get_bytes(offset)
        bb.seek(offset)
        length = bb.read(INT32_SIZE).unpack('N').first
        bb.read(length).unpack('C*')
      end

      def set_bytes(offset, bytes)
        bb.seek(offset)
        bb.write([bytes.length].pack('N'))
        bb.write(bytes.pack('C*'))
      end

      def get_string(offset)
        get_bytes(offset).pack('C*')
      end

      def set_string(offset, string)
        set_bytes(offset, string.unpack('C*'))
      end

      def self.max_length(string_length)
        INT32_SIZE + (string_length * UTF16_SIZE)
      end

      def contents
        bb.rewind
        bb.string
      end
    end
  end
end
