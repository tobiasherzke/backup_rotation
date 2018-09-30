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
  it 'can tell the difference in months' do
      expect(@diff.get_num_months_back(StrDate.new("20180929"))).to eq 0
      expect(@diff.get_num_months_back(StrDate.new("20170929"))).to eq 12
      expect(@diff.get_num_months_back(StrDate.new("20170930"))).to eq 11
  end
  it 'can tell the difference in days' do
      expect(@diff.get_num_days_back(StrDate.new("20180929"))).to eq 0
      expect(@diff.get_num_days_back(StrDate.new("20170929"))).to eq 365
      expect(@diff.get_num_days_back(StrDate.new("20170930"))).to eq 364
      expect(@diff.get_num_days_back(StrDate.new("20171001"))).to eq 363
  end
end

RSpec.describe StrDateCollection do
  it 'holds available dates in a sorted list' do
    s = StrDateCollection.new("20180929","20170929","20170930")
    expect(s.available).to eq([StrDate.new("20170929"),
                               StrDate.new("20170930"),
                               StrDate.new("20180929")])
  end

  it 'ignores initializer parameters that do not translate to StrDates' do
    s = StrDateCollection.new("20180929","20170929","latest",
                              "lost+found","20170930")
    expect(s.available).to eq([StrDate.new("20170929"),
                               StrDate.new("20170930"),
                               StrDate.new("20180929")])
  end

  def testcollection
    StrDateCollection.new(*%w(20151218 20161231 20170929 20171124 20171125 20171126 20171127 20171128 20171129 20171201 20171203 20171204 20171205 20171206 20171208 20171211 20171212 20171213 20171214 20171215 20171218 20171219 20171220 20171221 20171222 20171223 20171224 20171225 20171226 20171227 20180103 20180104 20180105 20180108 20180110 20180112 20180115 20180116 20180117 20180118 20180119 20180120 20180121 20180122 20180123 20180124 20180125 20180126 20180127 20180128 20180129 20180130 20180131 20180201 20180202 20180203 20180204 20180205 20180206 20180207 20180208 20180209 20180210 20180211 20180212 20180213 20180214 20180215 20180216 20180217 20180218 20180219 20180220 20180221 20180222 20180223 20180224 20180225 20180226 20180227 20180228 20180301 20180302 20180303 20180304 20180305 20180312 20180313 20180314 20180316 20180331 20180403 20180404 20180405 20180409 20180410 20180411 20180416 20180417 20180418 20180419 20180420 20180421 20180422 20180423 20180424 20180425 20180430 20180502 20180507 20180508 20180509 20180510 20180511 20180512 20180513 20180514 20180515 20180516 20180517 20180518 20180519 20180520 20180521 20180522 20180523 20180524 20180525 20180526 20180527 20180528 20180529 20180530 20180531 20180601 20180602 20180603 20180604 20180605 20180606 20180607 20180608 20180609 20180610 20180611 20180612 20180613 20180614 latest lost+found))
  end
  it 'can produce another collection of all elements newer than some pivot' do
    expect(testcollection.newer_than(StrDate.new("20180614")).available).
    to eq([StrDate.new("20180614")])
    expect(testcollection.newer_than(StrDate.new("20180613")).available).
    to eq([StrDate.new("20180613"), StrDate.new("20180614")])
    expect(testcollection.newer_than(StrDate.new("20151218")).available).
    to eq(testcollection.available)
  end
  it 'can produce another collection with only a single element for each month' do
    expect(testcollection.latest_each_month).
    to eq(StrDateCollection.new(*%w(20151218 20161231 20170929 20171129 20171227 20180131 20180228 20180331 20180430 20180531 20180614)))
  end
  it 'can produce a list of contained years/months' do
    expect(testcollection.all_months).
    to eq([[2015,12],[2016,12],[2017,9],[2017,11],[2017,12],[2018,1],[2018,2],[2018,3],[2018,4],[2018,5],[2018,6]])
  end
  it 'can return the latest contained date in the given year and month' do
    expect(testcollection.latest_in(2015,12)).to eq(StrDate.new("20151218"))
    expect(testcollection.latest_in(2018,2)).to eq(StrDate.new("20180228"))
    expect(testcollection.latest_in(2018,6)).to eq(StrDate.new("20180614"))
    expect(testcollection.latest_in(2018,7)).to eq(nil)
  end
  it 'supports set subtraction' do
    s = StrDateCollection.new("20180929","20170929","20170930")
    latest = s.newer_than(StrDate.new("20180830"))
    expect(s - latest).to eq(StrDateCollection.new("20170929","20170930"))
    expect((s - latest) - latest).to eq(StrDateCollection.new("20170929","20170930"))
  end
end
