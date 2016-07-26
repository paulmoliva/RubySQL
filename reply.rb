require 'sqlite3'
require_relative 'question_database.rb'


class Reply < Model
  attr_accessor :question_id, :parent_id, :user_id, :body
  def initialize(options)
    @id = options['id']
    @question_id = options['question_id']
    @parent_id = options['parent_id']
    @user_id = options['user_id']
    @body = options['body']
  end

  def self.find_by_id(id)
    replies = database.execute(<<-SQL, id)
      SELECT
        *
      FROM
        replies
      WHERE
        id = ?
    SQL

    replies.map{|datum| Reply.new(datum)}
  end

  def self.find_by_question_id(question_id)
    replies = database.execute(<<-SQL, question_id)
      SELECT
        *
      FROM
        replies
      WHERE
        question_id = ?
    SQL

    replies.map{|datum| Reply.new(datum)}
  end

  def self.find_by_parent_id(parent_id)
    replies = database.execute(<<-SQL, parent_id)
      SELECT
        *
      FROM
        replies
      WHERE
        parent_id = ?
    SQL

    replies.map{|datum| Reply.new(datum)}
  end

  def self.find_by_user_id(user_id)
    replies = database.execute(<<-SQL, user_id)
      SELECT
        *
      FROM
        replies
      WHERE
        user_id = ?
    SQL

    replies.map{|datum| Reply.new(datum)}
  end

  def self.all
    replies = database.execute("SELECT * FROM replies")
    replies.map{|datum| Reply.new(datum)}
  end

end
