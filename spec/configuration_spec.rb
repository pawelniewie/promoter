require 'spec_helper'

describe 'configuration' do

  describe 'api_key' do
    it 'returns default key' do
      expect(promoter.api_key).to eq('ribeyeeulorem')
    end

    it 'cannot be changed' do
      expect {
        promoter.api_key = 'test'
      }.to raise_error NoMethodError
    end

    it 'is not global' do
      expect {
        Promoter::api_key
      }.to raise_error NoMethodError
    end
  end

end