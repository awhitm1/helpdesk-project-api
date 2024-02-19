require 'rails_helper'

RSpec.describe Ticket, type: :model do
  context 'ticket is created' do
    it 'creates a valid ticket' do 
      ticket = create(:ticket)
      expect(ticket).to be_valid
    end
  end
end
