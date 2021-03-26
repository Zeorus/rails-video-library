# frozen_string_literal: true

# == Schema Information
#
# Table name: library_items
#
#  id            :bigint           not null, primary key
#  in_library    :boolean          default(FALSE)
#  to_watch      :boolean          default(FALSE)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  movie_id      :bigint           not null
#  movie_tmdb_id :integer
#  user_id       :bigint           not null
#
# Indexes
#
#  index_library_items_on_movie_id  (movie_id)
#  index_library_items_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (movie_id => movies.id)
#  fk_rails_...  (user_id => users.id)
#
class LibraryItem < ApplicationRecord
  belongs_to :user
  belongs_to :movie
end
