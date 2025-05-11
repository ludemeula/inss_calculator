class InssCalculator
  BRACKETS = [
    { limit: 1412.00, rate: 0.075 },   # Faixa 1: até 1.412,00, alíquota 7,5%
    { limit: 2666.68, rate: 0.09 },    # Faixa 2: até 2.666,68, alíquota 9%
    { limit: 4000.03, rate: 0.12 },    # Faixa 3: até 4.000,03, alíquota 12%
    { limit: 7786.02, rate: 0.14 }     # Faixa 4: até 7.786,02, alíquota 14%
  ].freeze

  def self.calculate(salary)
    return 0.0 if salary.nil? || salary <= 0

    remaining_salary = salary.to_f
    total_contribution = 0.0
    previous_limit = 0.0

    BRACKETS.each do |bracket|
      # Se o salário é maior que o limite da faixa, aplica-se a contribuição dessa faixa.
      if remaining_salary > bracket[:limit]
        taxable_amount = bracket[:limit] - previous_limit
        total_contribution += taxable_amount * bracket[:rate]
        remaining_salary -= taxable_amount
        previous_limit = bracket[:limit]
      else
        # Se o salário é menor que o limite da faixa, calcula a contribuição com o restante do salário.
        taxable_amount = remaining_salary
        total_contribution += taxable_amount * bracket[:rate]
        break
      end
    end

    # Retorna o valor total com 2 casas decimais
    total_contribution.round(2)
  end
end