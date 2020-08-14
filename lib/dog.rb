require "pry"

class Dog

  attr_accessor :name , :breed,:id
  #attr_reader :id

  def initialize(id:nil,name:,breed:)

    @id =id
    @name = name
    @breed = breed

  end

  def self.create_table
    sql = "CREATE TABLE  IF NOT EXISTS dogs(
    id INTEGER PRIMARY KEY,
    name TEXT,
    breed TEXT)"
    DB[:conn].execute(sql)
  end

  def self.drop_table

    sql = "DROP TABLE dogs"
    DB[:conn].execute(sql)
  end

  def save
    sql = "INSERT INTO dogs(name, breed)
           VALUES(?,?)"

    DB[:conn].execute(sql, self.name, self.breed)
    @id = DB[:conn].execute("SELECT last_insert_rowid()FROM dogs")[0][0]
  self
end

def update

  sql = "UPDATE dogs
          SET name = ?, breed = ?  WHERE id = ?"
  DB[:conn].execute(sql,self.name,self.breed, self.id)

end
def self.new_from_db(row)
  new_dog = Dog.new
  new_dog.id = row[0]
  new_dog.name = row[1]
  new_dog.breed = row[2]
  new_dog
end
def self.create(name:,breed:)
  dog = self.new(name,breed)
  dog.save
  dog
end
end
