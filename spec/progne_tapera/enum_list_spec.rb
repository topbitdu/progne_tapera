require 'spec_helper'

describe ProgneTapera::EnumList do

  let :subject do
    class GenderEnum
      include ProgneTapera::EnumList
      module ItemMethods
        def hello(name)
          case code
          when '1' then "#{name}先生"
          when '2' then "#{name}女士"
          else name.to_s
          end
        end
      end
    end
    GenderEnum
  end

  let :male          do ProgneTapera::EnumItem.new '1', :male,          localized_name: '男'    end
  let :female        do ProgneTapera::EnumItem.new '2', :female,        localized_name: '女'    end
  let :not_specified do ProgneTapera::EnumItem.new '9', :not_specified, localized_name: '未指定' end

  before :each do
    subject.add_item male          unless subject.item_defined? male
    subject.add_item female        unless subject.item_defined? female
    subject.add_item not_specified unless subject.item_defined? not_specified
  end

  after :each do
  end

  it 'should have enum name' do
    expect(subject.enum_name).to eq(:gender_enum)
  end

  it 'should respond to each' do
    expect(subject).to respond_to(:each)
  end

  it 'should respond to map' do
    expect(subject).to respond_to(:map)
  end

  it 'should be able to count' do
    expect(subject).to       respond_to(:count)
    expect(subject.count).to eq(3)
  end

  it 'should reject duplicate item' do
    expect { subject.add_item male }.to raise_error(ArgumentError)
  end

  it 'should reject wrong type' do
    expect { subject.add_item 'MALE' }.to raise_error(ArgumentError)
  end

  it 'should be able to add item safely' do
    expect(subject.count).to eq(3)
    subject.safe_add_item    male
    expect(subject.count).to eq(3)
  end

  it 'should have all' do
    gender_enums = GenderEnum.all

    expect(gender_enums).to       be_present
    expect(gender_enums.count).to eq(3)
  end

  it 'should have selected' do
    gender_enums = GenderEnum.selected

    expect(gender_enums).to       be_present
    expect(gender_enums.count).to eq(3)
  end

  it 'should have customized selected' do
    gender_enums = GenderEnum.selected do |items| items.select { |item| ['1', '2'].include? item.code } end

    expect(gender_enums).to       be_present
    expect(gender_enums.count).to eq(2)
  end

  it 'should have form options' do
    options = GenderEnum.form_options

    expect(options).to      be_present
    expect(options.size).to eq(3)
  end

  it 'should have customized form options' do
    options = GenderEnum.form_options do |items| items.select { |item| ['1', '2'].include? item.code } end

    expect(options).to      be_present
    expect(options.size).to eq(2)
  end

  it 'should hello to male' do
    expect(GenderEnum::MALE.hello 'Wu').to eq('Wu先生')
  end

  it 'should hello to female' do
    expect(GenderEnum::FEMALE.hello 'Wu').to eq('Wu女士')
  end

  it 'should hello to not specified' do
    expect(GenderEnum::NOT_SPECIFIED.hello 'Wu').to eq('Wu')
  end

end
