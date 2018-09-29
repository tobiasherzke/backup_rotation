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
    0
  end
end
