require 'rails_helper'

RSpec.describe InssCalculator, type: :model do
  describe '.calculate' do
    it 'calculates the correct INSS for salary of R$ 1.000,00' do
      salary = 1000.00
      expect(InssCalculator.calculate(salary)).to eq(75.00)
    end

    it 'calculates the correct INSS for salary of R$ 1.045,00' do
      salary = 1045.00
      expect(InssCalculator.calculate(salary)).to eq(78.37)
    end

    it 'calculates the correct INSS for salary of R$ 1.500,00' do
      salary = 1500.00
      expect(InssCalculator.calculate(salary)).to eq(112.08)
    end

    it 'calculates the correct INSS for salary of R$ 2.000,00' do
      salary = 2000.00
      expect(InssCalculator.calculate(salary)).to eq(150.88)
    end

    it 'calculates the correct INSS for salary of R$ 2.500,00' do
      salary = 2500.00
      expect(InssCalculator.calculate(salary)).to eq(197.78)
    end

    it 'calculates the correct INSS for salary of R$ 3.000,00' do
      salary = 3000.00
      expect(InssCalculator.calculate(salary)).to eq(281.62)
    end

    it 'calculates the correct INSS for salary of R$ 4.000,00' do
      salary = 4000.00
      expect(InssCalculator.calculate(salary)).to eq(400.00)
    end

    it 'calculates the correct INSS for salary of R$ 5.000,00' do
      salary = 5000.00
      expect(InssCalculator.calculate(salary)).to eq(580.00)
    end

    it 'calculates the correct INSS for salary of R$ 7.500,00' do
      salary = 7500.00
      expect(InssCalculator.calculate(salary)).to eq(940.68)
    end

    it 'calculates the correct INSS for salary of R$ 7.786,02' do
      salary = 7786.02
      expect(InssCalculator.calculate(salary)).to eq(1046.78)
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
