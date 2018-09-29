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

    it 'rejects a constructor with a year before 2000' do
      expect{StrDate.new("19991231")}.
      to raise_exception(RuntimeError)
    end

    it 'rejects a constructor with a month outside 1-12' do
      ["20180001","20181301"].each{|invalid_month_str|
        expect{StrDate.new(invalid_month_str)}.
        to raise_exception(RuntimeError)
      }
    end

    it 'rejects a constructor with a day outside 1-31' do
      ["20180900","20180932"].each{|invalid_day_str|
        expect{StrDate.new(invalid_day_str)}.
        to raise_exception(RuntimeError)
      }
    end
  end

  context "Date field accessors" do
    it 'returns the first 4 digits as year' do
        expect(StrDate.new("20180929").year).to eq(2018)
    end
    it 'returns digits 5 and 6 as month' do
      expect(StrDate.new("20180929").month).to eq(9)
    end
    it 'returns digits 7 and 8 as month' do
      expect(StrDate.new("20180929").day).to eq(29)
    end
  end

  context "comparison" do
    it 'recognizes date equality' do
      expect(StrDate.new("20180929")).
      to eq(StrDate.new("20180929"))
    end
    it 'recognizes inequality' do
      expect(StrDate.new("20180929") != StrDate.new("20180930")).
      to be true
    end
    it 'recognizes greater / lesser' do
      expect(StrDate.new("20180929")).
      to be < (StrDate.new("20180930"))
      expect(StrDate.new("20180929")).
      to be > (StrDate.new("20180928"))
    end
  end
end

RSpec.describe StrDateDifference do
  before{@diff = StrDateDifference.new(StrDate.new("20180929"))}
  it 'can tell the difference in years' do
      expect(@diff.get_num_years_back(StrDate.new("20180929"))).to eq 0
      expect(@diff.get_num_years_back(StrDate.new("20170929"))).to eq 1
      expect(@diff.get_num_years_back(StrDate.new("20170930"))).to eq 0
  end
end
