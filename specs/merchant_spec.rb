require('minitest/autorun')
require('minitest/rg')

require_relative('../models/merchant')

class MerchantTest < MiniTest::Test

  def setup
    @merchant = Merchant.new({
      "name" => "Sainsburys"
    })
  end

  # test get/sets
  def test_get_merchant_name
    result = @merchant.name
    assert_equal("Sainsburys", result)
  end

  def test_set_merchant_name
    @merchant.name = "Tesco"
    result = @merchant.name
    assert_equal("Tesco", result)
  end

end
