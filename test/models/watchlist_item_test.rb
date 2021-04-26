# == Schema Information
#
# Table name: watchlist_items
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  list_id    :bigint           not null
#  movie_id   :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_watchlist_items_on_list_id   (list_id)
#  index_watchlist_items_on_movie_id  (movie_id)
#  index_watchlist_items_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (list_id => lists.id)
#  fk_rails_...  (movie_id => movies.id)
#  fk_rails_...  (user_id => users.id)
#
require "test_helper"

class WatchlistItemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
