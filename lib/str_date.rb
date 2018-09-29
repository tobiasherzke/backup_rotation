require "date"

class StrDate
  def initialize(string)
    if string =~ /^\d{8}$/
      @string = string
    else
      raise "constructor parameter string needs exactly 8 digits"
    end
    [[:year, 2000, 3000], [:month, 1, 12], [:day, 1, 31]].each{
      |datefield,min,max|
      if send(datefield) < min || send(datefield) > max
        raise "#{datefield} must be between #{min} and #{max}"
      end
    }
  end

  def year()
    @string[0,4].to_i
  end
  def month()
    @string[4,2].to_i
  end
  def day()
    @string[6,2].to_i
  end

  def <=>(other)
    [year,month,day] <=> [other.year, other.month, other.day]
  end
  include Comparable
end

class StrDateDifference
  def initialize(strdate_reference)
    @ref = strdate_reference
  end
  def get_num_years_back(strdate)
    yearsdiff = @ref.year - strdate.year
    if (@ref.month < strdate.month) ||
      (@ref.month == strdate.month && @ref.day < strdate.day)
      yearsdiff -= 1
    end
    return yearsdiff
  end
  def get_num_months_back(strdate)
    monthsdiff = @ref.month - strdate.month +
      (@ref.year - strdate.year) * 12;
    if @ref.day < strdate.day
      monthsdiff -= 1
    end
    return monthsdiff
  end
  def get_num_days_back(strdate)
    (Date.new(@ref.year,@ref.month,@ref.day) -
     Date.new(strdate.year,strdate.month,strdate.day)).round()
  end
end
