require "str_date"

RSpec.describe StrDate  do

  context 'constructor' do
    it 'can be created from a string containing 8 digits' do
      expect{StrDate.new("20180929")}.to_not raise_exception
    end

    it 'rejects a constructor without parameter' do
      expect{StrDate.new}.to raise_exception(ArgumentError)
    end

    it 'rejects a constructor with non-digit characters' do
      expect{StrDate.new("helloworld")}.to raise_exception(RuntimeError)
    end

    it 'rejects a constructor with other than 8 digits' do
      [0,1,2,3,4,5,6,7,9,10,11].each{|num_digits|
        expect{StrDate.new("20180929000"[0,num_digits])}.
        to raise_exception(RuntimeError)
      }
    end
  end

end
