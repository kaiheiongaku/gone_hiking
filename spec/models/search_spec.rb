require 'rails_helper'

describe Search do
  describe 'relationships' do
    it { should belong_to(:user) }
  end

  describe 'validations' do
    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:text) }
    it { should validate_uniqueness_of(:text).scoped_to(:user_id) }
  end
end
