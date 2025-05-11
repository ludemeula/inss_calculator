require 'rails_helper'

RSpec.describe InssCalculator, type: :model do
  describe '.calculate' do
    it 'Salary de R$ 1.000,00 - primeira faixa' do
      salary = 1000.00
      expect(InssCalculator.calculate(salary)).to eq(75.00)
    end

    it 'Salario de R$ 1.045,00 - primeira faixa' do
      salary = 1045.00
      expect(InssCalculator.calculate(salary)).to eq(78.38)
    end

    it 'Salario de R$ 1.412,00 - primeira faixa' do
      salary = 1412.00
      expect(InssCalculator.calculate(salary)).to eq(105.90)
    end

    it 'Salario de R$ 1.500,00 - primeira faixa' do
      salary = 1500.00
      expect(InssCalculator.calculate(salary)).to eq(112.5)
    end

    it 'Salario de R$ 1.518,00 - primeira faixa' do
      salary = 1518.00
      expect(InssCalculator.calculate(salary)).to eq(113.85)
    end

    it 'Salario de R$ 2.000,00 - segunda faixa' do
      salary = 2000.00
      expect(InssCalculator.calculate(salary)).to eq(157.23)
    end

    it 'Salario de R$ 2.793,88 - segunda faixa' do
      salary = 2793.88
      expect(InssCalculator.calculate(salary)).to eq(228.68)
    end

    it 'Salario de R$ 3.000 - terceira faixa' do
      salary = 3000
      expect(InssCalculator.calculate(salary)).to eq(253.41)
    end

    it 'Salario de R$ 4.190.83 - terceira faixa' do
      salary = 4190.83
      expect(InssCalculator.calculate(salary)).to eq(396.31)
    end

    it 'Salario de R$ 5.000 - quarta faixa' do
      salary = 5000.00
      expect(InssCalculator.calculate(salary)).to eq(509.6)
    end

    it 'Salario de R$ 6.000 - quarta faixa' do
      salary = 6000.00
      expect(InssCalculator.calculate(salary)).to eq(649.6)
    end

    it 'Salario de R$ 7.500 - quarta faixa' do
      salary = 7500.00
      expect(InssCalculator.calculate(salary)).to eq(859.6)
    end

    it 'Salario de R$ 8.157,41 - quarta faixa' do
      salary = 8157.41
      expect(InssCalculator.calculate(salary)).to eq(951.63)
    end

    it 'Salario de R$ 9.000 - quarta faixa' do
      salary = 9000
      expect(InssCalculator.calculate(salary)).to eq(951.63)
    end

    it 'Salario de R$ 9.500 - quarta faixa' do
      salary = 9500
      expect(InssCalculator.calculate(salary)).to eq(951.63)
    end

    it 'returns 0 for salary of R$ 0' do
      salary = 0.00
      expect(InssCalculator.calculate(salary)).to eq(0.00)
    end

    it 'returns 0 for nil salary' do
      salary = nil
      expect(InssCalculator.calculate(salary)).to eq(0.00)
    end
  end
end
