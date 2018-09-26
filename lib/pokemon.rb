require 'pry'

class Pokemon
  attr_reader :id, :name, :type, :db, :hp

  def initialize(params)
    @id = params[:id]
    @name = params[:name]
    @type = params[:type]
    @hp = params[:hp]
    @db = params[:db]
  end

  def self.save(name, type, database_connection)
    database_connection.execute("INSERT INTO pokemon(name, type) VALUES(?, ?)",name, type)
  end

  def self.find(id, database_connection)
    db_result = database_connection.execute("SELECT * FROM pokemon WHERE id=#{id}")
    db_result = db_result[0]
    Pokemon.new(id: db_result[0], name: db_result[1], type: db_result[2], hp: db_result[3])
  end

  def alter_hp(new_hp, database_connection)
    database_connection.execute(
      "UPDATE pokemon
        SET hp = #{new_hp}
        WHERE id=#{self.id};")
  end
end
