require 'rails_helper'

RSpec.describe User, type: :model do
  subject do
    described_class.new email: 'default@users.com', password: 'newpassword'
  end

  it 'should be able to save a new user' do
    expect(subject.save).to be true
  end
end
