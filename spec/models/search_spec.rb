require 'rails_helper'

describe Search do
  describe 'relationships' do
    it { should belong_to(:user) }
  end
end
