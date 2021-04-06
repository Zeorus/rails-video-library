# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  username               :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :views
  has_many :seen_movies, through: :views, source: :movie

  has_many :watchlist_items
  has_many :towatch_movies, through: :watchlist_items, source: :movie
  
  has_many :review
  has_one_attached :avatar

  validates :username, 
            presence: true, 
            uniqueness: true, 
            length: { minimum: 3, too_short: "Doit contenir minimum %{count} caractères" },
            format: { with: /\A[a-zA-Z]+\z/, message: "Doit contenir uniquement des lettres" }
end
