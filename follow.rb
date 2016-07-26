require 'sqlite3'
require_relative 'question_database.rb'


class Follow < Model
  attr_accessor :question_id, :user_id
  def initialize(options)
    @id = options['id']
    @question_id = options['question_id']
    @user_id = options['user_id']
  end

  def self.find_by_id(id)
    question_follows = database.execute(<<-SQL, id)
      SELECT
        *
      FROM
        question_follows
      WHERE
        id = ?
    SQL

    question_follows.map{|datum| Follow.new(datum)}
  end

  def self.find_by_question_id(question_id)
    question_follows = database.execute(<<-SQL, question_id)
      SELECT
        *
      FROM
        question_follows
      WHERE
        question_id = ?
    SQL

    question_follows.map{|datum| Follow.new(datum)}
  end

  def self.find_by_user_id(user_id)
    question_follows = database.execute(<<-SQL, user_id)
      SELECT
        *
      FROM
        question_follows
      WHERE
        user_id = ?
    SQL

    question_follows.map{|datum| Follow.new(datum)}
  end

  def self.all
    question_follows = database.execute("SELECT * FROM question_follows")
    question_follows.map{|datum| Follow.new(datum)}
  end

end
