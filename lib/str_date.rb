class StrDate
  def initialize(string)
    if string =~ /^\d{8}$/
      @string = string
    else
      raise "constructor parameter string needs exactly 8 digits"
    end
    if year < 2000
      raise "year may not be before 2000"
    end
    if month < 1 || month > 12
      raise "month must be between 01 and 12"
    end
    if day < 1 || day > 31
      raise "day must be between 01 and 31"
    end
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
end
