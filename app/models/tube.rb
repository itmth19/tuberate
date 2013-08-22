class Tube < ActiveRecord::Base
  validates_presence_of :title
  validates_presence_of :link

  before_create :set_rank

	has_many :comments

  private
    def set_rank
      self.rank = 1
    end 
end
