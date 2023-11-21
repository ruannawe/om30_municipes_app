module CnsGenerator
  def valid_cns_number?(number)
    return false unless number.match?(/\A[1-9]\d{14}\z/)

    sum = 0
    number.each_char.with_index do |char, index|
      sum += char.to_i * (15 - index)
    end

    sum % 11 == 0
  end

  def generate_cns(definitive: true)
    loop do
      prefix = definitive ? rand(1..2).to_s : rand(7..9).to_s
      cns_number = prefix + ('%014d' % rand(10**14))
      return cns_number if valid_cns_number?(cns_number)
    end
  end
end
