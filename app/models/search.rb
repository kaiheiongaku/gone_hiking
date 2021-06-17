class Search < ApplicationRecord
  belongs_to :user

  validates_presence_of :user, :text, required: true
end
