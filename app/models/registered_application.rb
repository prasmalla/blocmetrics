class RegisteredApplication < ActiveRecord::Base
  belongs_to :user

  validates :name, presence: true
  validates :url, presence: true, uniqueness: true
end
