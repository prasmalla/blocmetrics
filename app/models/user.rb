class User < ActiveRecord::Base
  # Other available devise modules are:
  # :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable

  has_many :registered_applications, dependent: :destroy

  def admin?
    role == 'admin'
  end
end
