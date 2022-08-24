class Student
    attr_accessor :name, :age, :id

    def initialize(name:, age:, id: nil)
        @id=id
        @name=name
        @age=age
    end

# TODO: CREATE TABLE-class method
def self.create_table
    sql = <<-SQL
    CREATE TABLE if NOT EXISTS students(
        id INTEGER PRIMARY KEY,
        name TEXT,
        age INTEGER
    )
    SQL
    DB[:conn].execute(sql)
end

# TODO: INSERT RECORD - instance method
def add_to_db
    sql = <<-SQL
    INSERT INTO students (name,age)
    VALUES(?,?)
    SQL
    DB[:conn].execute(sql,self.name,self.age)
    set_id
end

# TODO: SHOW ALL RECORDS-class method
def self.all
    sql = <<-SQL
    SELECT * FROM students
    SQL
    DB[:conn].execute(sql).map do |row|
     object_from_db(row)
    end
end
# SHOW PREVIOUSLY ADDED

# def show_most_recent
#     sql = <<-SQL
#     SELECT * FROM students ORDER BY id DESC LIMIT 1 
#     SQL
#     DB[:conn].execute(query)map do |row|
#         Student.object_from_db(row)
#     end.first
# end
# TODO: UPDATE RECORD
def update
    sql = <<-SQL
    UPDATE students
    SET name = ?,age = ?
    WHERE id = ?
    SQL
    DB[:conn].execute(sql,self.name,self.age,self.id)
    
end
# TODO: DELETE RECORD

def delete
    sql = <<-SQL
    DELETE FROM students WHERE id = ?
    SQL
    DB[:conn].execute(sql,self.id)
end
# TODO: CONVERT TABLE RECORD TO RUBY OBJECT-class
def self.object_from_db(row)
    self.new(id:row[0],name:row[1],age:row[2])
end

# TODO: SEARCH FOR RECORD THAT MEETS CERTAIN CONDITIONS -OLDEST
def self.find_oldest
    sql = <<-SQL
    SELECT * FROM students ORDER BY age DESC LIMIT 1
    SQL
    DB[:conn].execute(sql).map do |row|
        self.object_from_db(row)
    end.first
end

private

def set_id
    query = "SELECT last_insert_rowid() FROM students"
    @id = DB[:conn].execute(query)[0][0]
  end

end