require "mysql"

SQL = DB.open(ENV["MYSQL_URL"])
at_exit { SQL }

class Base
  def self.all
    where
  end

  def self.where(conditions = "1=1")
    results = Array(Hash(String, String | Nil)).new
    query = "select email, name_first, name_last, country, address from #{@@table_name} where #{conditions}"
    SQL.query(query) do |rs|
      rs.each do
        results << {
          "email"      => rs.read(String),
          "first_name" => rs.read(String),
          "last_name"  => rs.read(String),
          "country"    => rs.read((String | Nil)),
          "address"    => rs.read((String | Nil)),
        }
      end
    end
    results
  end

  def self.find_by(attr, value)
    SQL.query_one(
      "select count(*), name_first, name_last
       from #{@@table_name} where #{attr} = ?",
      value,
      as: {Int64, (String | Nil), (String | Nil)}
    )
  end

  def self.schema
    table_schema = Hash(String, String).new
    SQL.query "SELECT COLUMN_NAME, DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'#{@@table_name}';" do |rs|
      rs.each do
        table_schema[rs.read(String)] = rs.read(String).capitalize
      end
    end
    table_schema
  end
end
