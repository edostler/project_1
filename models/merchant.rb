require_relative("../db/sql_runner")

class Merchant

  attr_reader :id
  attr_accessor :name

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @name = options['name']
  end

  def save()
    sql = "INSERT INTO merchants (name) VALUES ($1) RETURNING id"
    values = [@name]
    merchant = SqlRunner.run(sql, values)[0]
    @id = merchant["id"].to_i
  end

  def update()
    sql = "UPDATE merchants SET name = $1 WHERE id = $2"
    values = [@name, @id]
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

  def self.merchants()
    merchants = Merchant.all()
    return merchants.map{|merchant| merchant.name}
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
