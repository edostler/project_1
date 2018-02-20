require('minitest/autorun')
require('minitest/rg')

require_relative('../models/tag')

class TagTest < MiniTest::Test

  def setup
    @tag = Tag.new({
      "name" => "Food Shop"
    })  end

  # test get/sets
  def test_get_tag_name
    result = @tag.name
    assert_equal("Food Shop", result)
  end

  def test_set_tag_name
    @tag.name = "Bar"
    result = @tag.name
    assert_equal("Bar", result)
  end

end
