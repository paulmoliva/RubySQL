require 'sqlite3'
require_relative 'question_database.rb'


class Question < Model
  attr_accessor :title, :body, :author_id
  def initialize(options)
    @id = options['id']
    @title = options['title']
    @body = options['body']
    @author_id  =options['author_id']
  end

  def self.find_by_id(id)
    questions = database.execute(<<-SQL, id)
      SELECT
        *
      FROM
        questions
      WHERE
        id = ?
    SQL

    questions.map{|datum| Question.new(datum)}
  end

  def self.find_by_user(author_id)
    questions = database.execute(<<-SQL, author_id)
      SELECT
        *
      FROM
        questions
      WHERE
        author_id = ?
    SQL

    questions.map{|datum| Question.new(datum)}
  end

  def self.find_by_title(title)
    questions = database.execute(<<-SQL, title)
      SELECT
        *
      FROM
        questions
      WHERE
        title = ?
    SQL

    questions.map{|datum| Question.new(datum)}
  end

  def self.all
    questions = database.execute("SELECT * FROM questions")
    questions.map{|datum| Question.new(datum)}
  end

end
