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

end
