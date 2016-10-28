require 'spec_helper'

describe ProgneTapera::EnumItem do

  before :each do
    @ethnicity_item = described_class.new 'HA',   :han,     localized_name: '汉',      numeric_code: '01'
    @gender_item    = described_class.new '1',    :male,    localized_name: '男'
    @algorithm_item = described_class.new 'AES8', :aes_256, localized_name: 'AES-256', digits: 256
  end

  after :each do
  end

  it 'should have constant name' do
    expect(@ethnicity_item.constant_name).to eq('HAN')
    expect(@gender_item.constant_name).to    eq('MALE')
    expect(@algorithm_item.constant_name).to eq('AES_256')
  end

  it 'should have localized name' do
    expect(@ethnicity_item.localized_name).to eq('汉')
    expect(@gender_item.localized_name).to    eq('男')
    expect(@algorithm_item.localized_name).to eq('AES-256')
  end

  it 'should have digits' do
    expect(@algorithm_item.digits).to eq(256)
  end

  it 'should have numeric code' do
    expect(@ethnicity_item.numeric_code).to eq('01')
  end

end
