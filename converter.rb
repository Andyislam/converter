require "minitest/autorun"
require "pry"

class Converter

  def self.from_roman_to_numeric roman_value
    romans = {"M"=>1000, "D"=>500,"C"=>100,"L"=>50,"X"=>10,"IX"=>9, "V"=>5,"IV"=>4, "I"=>1}
    array = roman_value.split("")
    total = 0
    skip = false
    array.each_with_index do |i, index|
      unless skip == true
        current_num = romans["#{i}"]
        unless (index + 1) == array.size
          next_num = romans[array[index + 1]]
          if next_num > current_num 
            total = total + (next_num - current_num)
            skip = true 
          else
            total = total + current_num
            skip = false 
          end
        else
          total = total + current_num
          skip = false 
        end
      else 
        skip = false
      end
    end
    total
  end

  def self.from_numeric_to_roman numeric_value
    romans = {"M"=>1000, "D"=>500,"C"=>100,"L"=>50,"X"=>10,"IX"=>9, "V"=>5,"IV"=>4, "I"=>1}
    str = ""
    remaining = numeric_value
    romans.each do |k, v|
      n = return_int_and_remaining(remaining, v)
      if n["int"] > 0
        n['int'].times do 
          str << k
        end
        unless n["remaining"].to_i == 0
          remaining = n["remaining"]
        else
          remaining = 0
        end
      end
    end
    str
  end

  def self.return_int_and_remaining(number, divider)
    n = number.to_f / divider.to_i
    res = {}
    res['int'] = n.to_i
    decimals = n.to_s.split(".")[1]
    res['remaining'] = ("0.#{decimals}").to_f * divider
    res
  end
end

class ConverterTest < Minitest::Test
  def test_III_is_3
    assert_equal 3, Converter.from_roman_to_numeric("III")
  end

  def test_CM_is_900
    assert_equal 900, Converter.from_roman_to_numeric("CM")
  end

  def test_CCXCI_is_291
    assert_equal 291, Converter.from_roman_to_numeric("CCXCI")
  end

  def test_XXIX_is_29
    assert_equal 29, Converter.from_roman_to_numeric("XXIX")
  end

  def test_MCMXCIX_is_1999
    assert_equal 1999, Converter.from_roman_to_numeric("MCMXCIX")
  end

  def test_29_is_XXIX
    assert_equal "XXIX", Converter.from_numeric_to_roman(29)
  end

  def test_38_is_XXXVIII
    assert_equal "XXXVIII", Converter.from_numeric_to_roman(38)
  end
end
