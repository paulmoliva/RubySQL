require 'sqlite3'
require_relative 'question_database.rb'


class User < Model
  attr_accessor :fname, :lname
  def initialize(options)
    @id = options['id']
    @fname = options['fname']
    @lname = options['lname']
  end

  def self.find_by_id(id)
    users = database.execute(<<-SQL, id)
      SELECT
        *
      FROM
        users
      WHERE
        id = ?
    SQL

    users.map{|datum| User.new(datum)}
  end

  def self.find_by_fname(fname)
    users = database.execute(<<-SQL, fname)
      SELECT
        *
      FROM
        users
      WHERE
        fname = ?
    SQL

    users.map{|datum| User.new(datum)}
  end

  def self.find_by_lname(lname)
    users = database.execute(<<-SQL, lname)
      SELECT
        *
      FROM
        users
      WHERE
        lname = ?
    SQL

    users.map{|datum| User.new(datum)}
  end

  def self.all
    users = database.execute("SELECT * FROM users")
    users.map{|datum| User.new(datum)}
  end

end
