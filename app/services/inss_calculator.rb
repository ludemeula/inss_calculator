class InssCalculator
  BRACKETS = [
    { limit: 1518.00, rate: 0.075 },
    { limit: 2793.88, rate: 0.09 },
    { limit: 4190.83, rate: 0.12 },
    { limit: 8157.41, rate: 0.14 }
  ].freeze

  def self.calculate(salary)
    return 0.0 if salary.nil? || salary <= 0

    salary = salary.to_f
    total_contribution = 0.0
    previous_limit = 0.0

    BRACKETS.each do |bracket|
      if salary > bracket[:limit]
        taxable_amount = bracket[:limit] - previous_limit
        total_contribution += taxable_amount * bracket[:rate]
        previous_limit = bracket[:limit]
      else
        taxable_amount = salary - previous_limit
        total_contribution += taxable_amount * bracket[:rate]
        break
      end
    end

    total_contribution.round(2)
  end
end
