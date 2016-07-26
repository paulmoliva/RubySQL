require_relative 'question_database.rb'

class Model
  def self.database
    QuestionsDatabase.instance
  end
end
