module Mathable
  
  def sum_values(key_value_arr)
    sum = Hash.new(0)
    key_value_arr.each { |key, value| sum[key] += value }
    sum
  end

  def get_percentage(numerator, denominator, round_to = 2)
    (numerator.to_f / denominator).round(round_to)
  end
end
