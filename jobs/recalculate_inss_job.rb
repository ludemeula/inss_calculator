class RecalculateInssJob < ApplicationJob
    queue_as :default

    def perform
      Proponent.find_each do |proponent|
        new_discount = InssCalculator.calculate(proponent.salary)
        proponent.update(inss_discount: new_discount)
      end
    end
end
