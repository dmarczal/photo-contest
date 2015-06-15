class Page < ActiveRecord::Base
  validates :permalink, uniqueness: true
end
