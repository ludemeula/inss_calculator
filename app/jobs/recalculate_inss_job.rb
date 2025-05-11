class RecalculateInssJob < ApplicationJob
  queue_as :default

  def perform
    Rails.logger.info 'Iniciando o cálculo e atualização de INSS para os proponentes.'

    Proponent.find_each(batch_size: 100) do |proponent|
      begin
        new_discount = InssCalculator.calculate(proponent.salary)
        proponent.update_columns(inss_discount: new_discount) # Atualiza diretamente no banco

        Rails.logger.info "Desconto INSS atualizado para o proponente #{proponent.id}: R$ #{new_discount}"

      rescue => e
        # Log de erro para o caso de falhas na atualização
        Rails.logger.error "Erro ao atualizar o desconto INSS para o proponente #{proponent.id}: #{e.message}"
      end
    end

    Rails.logger.info 'Cálculo e atualização de INSS concluídos para todos os proponentes.'
  end
end
