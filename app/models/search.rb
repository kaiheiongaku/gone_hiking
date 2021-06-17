class Search < ApplicationRecord
  belongs_to :user

  validates_presence_of :user, :text, required: true
  validates_uniqueness_of :text, scope: :user_id
end
