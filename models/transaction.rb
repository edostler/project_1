require_relative("../db/sql_runner")

class Transaction

  attr_reader :id
  attr_accessor :description, :value, :spend_date, :merchant_id, :tag_id

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @description = options["description"]
    @value = options["value"].to_f
    @spend_date = options["spend_date"]
    @merchant_id = options['merchant_id'].to_i
    @tag_id = options['tag_id'].to_i
  end

  def save()
    sql = "INSERT INTO transactions (description, value, spend_date, merchant_id, tag_id) VALUES ($1, $2, $3, $4, $5) RETURNING id"
    values = [@description, @value, @spend_date, @merchant_id, @tag_id]
    transaction = SqlRunner.run(sql, values)[0]
    @id = transaction["id"].to_i
  end

  def tag()
    sql = "SELECT * FROM tags WHERE id = $1"
    values = [@tag_id]
    tag = SqlRunner.run(sql, values)
    return Tag.new(tag.first)
  end

  def merchant()
    sql = "SELECT * FROM merchants WHERE id = $1"
    values = [@merchant_id]
    merchant = SqlRunner.run(sql, values)
    return Merchant.new(merchant.first)
  end

  def self.sum_values()
    sql = "SELECT SUM(value) FROM transactions"
    values = []
    return SqlRunner.run(sql, values).first[:sum.to_s].to_f
  end

  def self.delete_all()
    sql = "DELETE FROM transactions"
    values = []
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM transactions"
    values = []
    transaction = SqlRunner.run(sql, values)
    return transaction.map{|transaction| Transaction.new(transaction)}
  end

  def self.find(id)
    sql = "SELECT * FROM transactions WHERE id = $1"
    values = [id]
    transaction = SqlRunner.run(sql, values)
    return Transaction.new(transaction.first)
  end

  def self.delete(id)
    sql = "DELETE FROM transactions WHERE id = $1"
    values = [id]
    SqlRunner.run(sql, values)
  end

end
