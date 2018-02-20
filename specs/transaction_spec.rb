require('minitest/autorun')
require('minitest/rg')

require_relative('../models/transaction')

class TransactionTest < MiniTest::Test

  def setup
    @transaction = Transaction.new({
      "description" => "Weekly shop",
      "value" => 72.59,
      "spend_date" => "01/1/2018",
      "merchant_id" => 1,
      "tag_id" => 1
    })
  end

  # test get/sets
  def test_get_transaction_description
    result = @transaction.description
    assert_equal("Weekly shop", result)
  end

  def test_get_transaction_value
    result = @transaction.value
    assert_equal(72.59, result)
  end

  def test_get_transaction_spend_date
    result = @transaction.spend_date
    assert_equal("01/1/2018", result)
  end

  def test_get_transaction_merchant_id
    result = @transaction.merchant_id
    assert_equal(1, result)
  end

  def test_get_transaction_tag_id
    result = @transaction.tag_id
    assert_equal(1, result)
  end

  def test_set_transaction_description
    @transaction.description = "Beers with the lads"
    result = @transaction.description
    assert_equal("Beers with the lads", result)
  end

  def test_set_transaction_value
    @transaction.value = 50.55
    result = @transaction.value
    assert_equal(50.55, result)
  end

  def test_set_transaction_spend_date
    @transaction.spend_date = "2/8/2018"
    result = @transaction.spend_date
    assert_equal("2/8/2018", result)
  end

  def test_set_transaction_merchant_id
    @transaction.merchant_id = 2
    result = @transaction.merchant_id
    assert_equal(2, result)
  end

  def test_set_transaction_tag_id
    @transaction.tag_id = 2
    result = @transaction.tag_id
    assert_equal(2, result)
  end

  # test functions

  def test_format_date
    date = "2018-05-15"
    result = Transaction.format_date(date)
    assert_equal("15-05-2018", result)
  end

end
