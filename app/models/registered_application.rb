class RegisteredApplication < ActiveRecord::Base
  belongs_to :user
  has_many :events, dependent: :destroy

  validates :name, presence: true
  validates :url, presence: true, uniqueness: true
  validates_format_of :url, with: URI::regexp(%w(http https))
end
