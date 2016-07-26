require_relative 'question_database.rb'
require_relative 'question.rb'
require_relative 'user.rb'
require_relative 'reply.rb'
require_relative 'follow.rb'
require_relative 'like.rb'

class Model
  def self.database
    QuestionsDatabase.instance
  end
end
