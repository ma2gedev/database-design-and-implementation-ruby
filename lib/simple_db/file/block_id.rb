module SimpleDB
  module File
    class BlockId
      attr_reader :filename, :block_num

      def initialize(filename, block_num)
        @filename = filename
        @block_num = block_num
      end

      def to_s
        "[file #{filename}, block #{block_num}]"
      end

      def ==(block_id)
        filename == block_id.filename && block_num == block_id.block_num
      end

      alias_method :eql?, :==

      def hash
        [filename, block_num].hash
      end
    end
  end
end