require 'rails_helper'

RSpec.describe User, type: :model do
  subject do
    described_class.new email: 'default@users.com', password: 'newpassword'
  end

  context 'when creating a new user' do
    it 'should be able to save a new user with only email/password' do
      expect(subject.save).to be true
    end

    it 'should be able to save new user with region' do
      subject.region = 'eu'
      expect(subject.save).to be true
    end
  end
end
