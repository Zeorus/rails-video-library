# == Schema Information
#
# Table name: views
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  movie_id   :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_views_on_movie_id  (movie_id)
#  index_views_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (movie_id => movies.id)
#  fk_rails_...  (user_id => users.id)
#
class View < ApplicationRecord
  belongs_to :user
  belongs_to :movie

  validates :movie_id, uniqueness: { scope: :user_id }
end
