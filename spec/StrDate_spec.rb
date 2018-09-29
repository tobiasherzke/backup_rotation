require "str_date"

RSpec.describe StrDate  do

  context 'constructor' do
    it 'can be created from a string containing 8 digits' do
      expect{StrDate.new("20180929")}.to_not raise_exception
    end

    it 'rejects a constructor without parameter' do
      expect{StrDate.new}.to raise_exception(ArgumentError)
    end
  end

end
