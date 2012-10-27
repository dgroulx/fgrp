class Fact < ActiveRecord::Base
  attr_accessible :answer, :question

  validates :answer, :question, :presence => true
end
