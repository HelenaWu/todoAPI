class User < ActiveRecord::Base
has_secure_password

validates_uniqueness_of :email
validates_presence_of :email
has_many :lists, dependent: :destroy



end
