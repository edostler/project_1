require_relative("../db/sql_runner")

class Merchant

  attr_reader :id
  attr_accessor :name, :total_spend

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @name = options['name']
    @total_spend = options['total_spend'].to_f
  end

  def save()
    sql = "INSERT INTO merchants (name, total_spend) VALUES ($1, $2) RETURNING id"
    values = [@name, @total_spend]
    merchant = SqlRunner.run(sql, values)[0]
    @id = merchant["id"].to_i
  end

  def update()
    sql = "UPDATE merchants SET (name, total_spend) = ($1, $2) WHERE id = $3"
    values = [@name, @total_spend, @id]
    SqlRunner.run( sql, values )
  end

  def tags()
    sql = "SELECT tags.* FROM tags INNER JOIN transactions ON transactions.tag_id = tags.id WHERE transactions.tag_id = $1;"
    values = [@id]
    tags = SqlRunner.run(sql, values)
    return tags.map {|tag| Tag.new(tag)}
  end

  def self.sum_merchant_values(id)
    sql = "SELECT SUM(value) FROM transactions WHERE merchant_id = $1"
    values = [id]
    return SqlRunner.run(sql, values).first["sum"].to_f
  end

  def self.delete_all()
    sql = "DELETE FROM merchants"
    values = []
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM merchants"
    values = []
    merchant = SqlRunner.run(sql, values)
    return merchant.map{|merchant| Merchant.new(merchant)}
  end

  def self.find(id)
    sql = "SELECT * FROM merchants WHERE id = $1"
    values = [id]
    merchant = SqlRunner.run(sql, values)
    return Merchant.new(merchant.first)
  end

  def self.find_by_name(name)
    sql = "SELECT * FROM merchants WHERE name = $1"
    values = [name]
    merchant = SqlRunner.run(sql, values)
    return Merchant.new(merchant.first)
  end

  def self.delete(id)
    sql = "DELETE FROM merchants WHERE id = $1"
    values = [id]
    SqlRunner.run(sql, values)
  end

end
