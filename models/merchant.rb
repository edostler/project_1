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

end
