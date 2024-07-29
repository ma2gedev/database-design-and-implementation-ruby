require 'minitest/autorun'
require_relative '../../../lib/simple_db'

class SimpleDBFileBlockIdTest < Minitest::Test
  def test_case
    block1 = SimpleDB::File::BlockId.new('testfile', 2)
    block2 = SimpleDB::File::BlockId.new('testfile', 2)
    assert_equal block1, block2
  end

  def test_case2
    block1 = SimpleDB::File::BlockId.new('testfile', 2)
    block2 = SimpleDB::File::BlockId.new('testfile', 2)
    assert_equal block1.filename, block2.filename
  end

  def test_case3
    block1 = SimpleDB::File::BlockId.new('testfile', 2)
    block2 = SimpleDB::File::BlockId.new('testfile', 2)
    assert block1.eql?(block2)
  end
end
