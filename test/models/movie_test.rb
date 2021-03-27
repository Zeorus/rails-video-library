# == Schema Information
#
# Table name: movies
#
#  id          :bigint           not null, primary key
#  poster_path :string
#  runtime     :string
#  sinopsis    :text
#  tagline     :string
#  title       :string
#  year        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  tmdb_id     :integer
#
require "test_helper"

class MovieTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
