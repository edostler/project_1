require_relative("../db/sql_runner")

class Tag

  attr_reader :id
  attr_accessor :name

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @name = options['name']
  end

  def save()
    sql = "INSERT INTO tags (name) VALUES ($1) RETURNING id"
    values = [@name]
    tag = SqlRunner.run(sql, values)[0]
    @id = tag["id"].to_i
  end

  def update()
    sql = "UPDATE tags SET name = $1 WHERE id = $2"
    values = [@name, @id]
    SqlRunner.run( sql, values )
  end

  def merchants()
    sql = "SELECT merchants.* FROM merchants INNER JOIN transactions ON transactions.merchant_id = merchants.id WHERE transactions.merchant_id = $1;"
    values = [@id]
    merchants = SqlRunner.run(sql, values)
    return merchants.map {|merchant| Merchant.new(merchant)}
  end

  def self.sum_tag_values(id)
    sql = "SELECT SUM(value) FROM transactions WHERE tag_id = $1"
    values = [id]
    return SqlRunner.run(sql, values).first["sum"].to_f
  end

  def self.delete_all()
    sql = "DELETE FROM tags"
    values = []
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM tags"
    values = []
    tag = SqlRunner.run(sql, values)
    return tag.map{|tag| Tag.new(tag)}
  end

  def self.find(id)
    sql = "SELECT * FROM tags WHERE id = $1"
    values = [id]
    tag = SqlRunner.run(sql, values)
    return Tag.new(tag.first)
  end

  def self.find_by_name(name)
    sql = "SELECT * FROM tags WHERE name = $1"
    values = [name]
    tag = SqlRunner.run(sql, values)
    return Tag.new(tag.first)
  end

  def self.filter_value(operator, value)
    if operator == "less"
      sql = "SELECT tags.* FROM tags INNER JOIN transactions ON transactions.tag_id = tags.id WHERE transactions.value < $1"
      values = [value]
      tag = SqlRunner.run(sql, values)
      return tag.map{|tag| Tag.new(tag)}
    else
      sql = "SELECT tags.* FROM tags INNER JOIN transactions ON transactions.tag_id = tags.id WHERE transactions.value > $1"
      values = [value]
      tag = SqlRunner.run(sql, values)
      return tag.map{|tag| Tag.new(tag)}
    end
  end

  def self.delete(id)
    sql = "DELETE FROM tags WHERE id = $1"
    values = [id]
    SqlRunner.run(sql, values)
  end

end
