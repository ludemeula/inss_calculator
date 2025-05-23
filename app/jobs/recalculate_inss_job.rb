class RecalculateInssJob < ApplicationJob
  queue_as :default

  def perform
    Rails.logger.info 'Iniciando o cálculo e atualização de INSS para os proponentes.'

    Proponent.find_each(batch_size: 100) do |proponent|
      begin
        new_discount = InssCalculator.calculate(proponent.salary)
        proponent.update(inss_discount: new_discount)

        Rails.logger.info "Desconto INSS atualizado para o proponente #{proponent.id}: R$ #{new_discount}"

      rescue => e
        Rails.logger.error "Erro ao atualizar o desconto INSS para o proponente #{proponent.id}: #{e.message}"
      end
    end

    Rails.logger.info 'Cálculo e atualização de INSS concluídos para todos os proponentes.'
  end
end
