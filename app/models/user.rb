# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  unconfirmed_email      :string
#  username               :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # after_create :send_welcome_email
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_many :watchlist_items, dependent: :destroy
  has_many :movies, through: :watchlist_items
  has_many :lists, dependent: :destroy
  
  has_many :reviews, dependent: :destroy
  has_one_attached :avatar, dependent: :destroy

  validates :username,
            presence: true,
            uniqueness: true,
            length: { minimum: 3 },
            format: { with: /\A[a-zA-Z]+\z/, message: :wrong_username }

  private

  def send_welcome_email
    UserMailer.with(user: self).welcome.deliver_now
  end
end
