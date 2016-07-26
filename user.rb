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

  def self.find_by_name(fname, lname)
    users = database.execute(<<-SQL, lname, fname)
      SELECT
        *
      FROM
        users
      WHERE
        lname = ? AND fname = ?
    SQL

    users.map{|datum| User.new(datum)}
  end

  def self.all
    users = database.execute("SELECT * FROM users")
    users.map{|datum| User.new(datum)}
  end

  def authored_questions
    Question.find_by_author_id(@id)
  end

  def authored_replies
    Reply.find_by_user_id(@id)
  end

  def followed_questions
    Follow.followed_questions_for_user_id(@id)
  end

  def liked_questions
    Like.liked_questions_for_user_id(@id)
  end

  def average_karma
    avg = Model.database.execute(<<-SQL,@id)
      SELECT
        CAST(
          COUNT(DISTINCT(likes.question_id))
        AS FLOAT)
      FROM
        (SELECT
          *
        FROM
          questions
        LEFT OUTER JOIN
          question_likes
        ON
          questions.id = question_likes.question_id
        WHERE
          questions.author_id = ?) likes

    SQL

  end

end
