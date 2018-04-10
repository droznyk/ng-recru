class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :movie

  scope :top_10_commenters_last_week, lambda {
                                              includes(:users)
                                               .where('created_at >= ?', Time.now - 7.days)
                                               .group(:user_id)
                                               .count
                                               .sort_by { |k, v| v }
                                               .reverse
                                               .first(10)
                                             } 

  validates :content, presence: true
end
