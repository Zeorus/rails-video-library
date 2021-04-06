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
require "test_helper"

class ViewTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
