class InssCalculator
    BRACKETS = [
      { limit: 1412.00, rate: 0.075 },
      { limit: 2666.68, rate: 0.09 },
      { limit: 4000.03, rate: 0.12 },
      { limit: 7786.02, rate: 0.14 }
    ]
  
    def self.calculate(salary)
      return 0 if salary <= 0
  
      total = 0
      previous_limit = 0
  
      BRACKETS.each do |bracket|
        if salary > bracket[:limit]
          total += (bracket[:limit] - previous_limit) * bracket[:rate]
        else
          total += (salary - previous_limit) * bracket[:rate]
          break
        end
        previous_limit = bracket[:limit]
      end
  
      total
    end
  end
  