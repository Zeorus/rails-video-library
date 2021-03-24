# == Schema Information
#
# Table name: movies
#
#  id          :bigint           not null, primary key
#  poster_path :string
#  sinopsis    :text
#  title       :string
#  year        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Movie < ApplicationRecord
end
