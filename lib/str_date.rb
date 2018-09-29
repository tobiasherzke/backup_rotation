class StrDate
  def initialize(string)
    if string =~ /^\d{8}$/
      @string = string
    else
      raise "constructor parameter string needs exactly 8 digits"
    end
  end
end
