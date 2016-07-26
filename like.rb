require 'sqlite3'
require_relative 'question_database.rb'


class Like < Model
  attr_accessor :question_id, :user_id
  def initialize(options)
    @id = options['id']
    @question_id = options['question_id']
    @user_id = options['user_id']
  end

  def self.find_by_id(id)
    question_likes = database.execute(<<-SQL, id)
      SELECT
        *
      FROM
        question_likes
      WHERE
        id = ?
    SQL

    question_likes.map{|datum| Like.new(datum)}
  end

  def self.find_by_question_id(question_id)
    question_likes = database.execute(<<-SQL, question_id)
      SELECT
        *
      FROM
        question_likes
      WHERE
        question_id = ?
    SQL

    question_likes.map{|datum| Like.new(datum)}
  end

  def self.find_by_user_id(user_id)
    question_likes = database.execute(<<-SQL, user_id)
      SELECT
        *
      FROM
        question_likes
      WHERE
        user_id = ?
    SQL

    question_likes.map{|datum| Like.new(datum)}
  end

  def self.count(question_id)
    question_likes = database.execute(<<-SQL, question_id)
      SELECT
        COUNT(*)
      FROM
        question_likes
      WHERE
        question_id = ?
    SQL

    question_likes.first.values.first
  end

  def self.all
    question_likes = database.execute("SELECT * FROM question_likes")
    question_likes.map{|datum| Like.new(datum)}
  end

end
