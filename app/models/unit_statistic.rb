class UnitStatistic < ActiveRecord::Base
  validates :user_id, :unit_id, :language_id, presence: true
  validates :date, uniqueness: { scope: [:user_id, :unit_id, :language_id] }

  belongs_to :user
  belongs_to :unit

  def language
    Language.find(language_id)
  end

  def step_passed!
    self.steps_passed += 1
    save!
  end

  def word_helped!
    self.words_helped += 1
    save!
  end

  def step_helped!
    self.steps_helped += 1
    save!
  end

  def right_answer!
    self.right_answers += 1
    save!
  end

  def wrong_answer!
    self.wrong_answers += 1
    save!
  end
end
