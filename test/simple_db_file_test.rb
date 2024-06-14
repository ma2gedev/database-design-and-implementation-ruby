require 'minitest/autorun'
require_relative '../lib/simple_db'

class SimpleDBFileTest < Minitest::Test
  def test_case
    database = SimpleDB.create_database('filetest', 400, 8)
    file_manager = database.file_manager

    block = SimpleDB::File::BlockId.new('testfile', 2)
    page1 = SimpleDB::File::Page.new(file_manager.block_size)
    pos1 = 88
    page1.set_string(pos1, 'abcdefghijklm')
    size = SimpleDB::File::Page.max_length('abcdefghijklm'.length)
    pos2 = pos1 + size
    page1.set_int(pos2, 345)
    file_manager.write(block, page1)

    page2 = SimpleDB::File::Page.new(file_manager.block_size)
    file_manager.read(block, page2)

    puts "offset #{pos2} contains #{page2.get_int(pos2)}"
    puts "offset #{pos1} contains #{page2.get_string(pos1)}"
  end
end
