class Question < ActiveRecord::Base
  default_scope { where(private: false) }

  has_many :answers
  belongs_to :user

  def as_json
    {
      id: id,
      title: title,
      user: user,
      answers: answers
    }
  end
end
