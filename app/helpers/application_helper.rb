module ApplicationHelper
  def format_cpf(cpf)
    digits = cpf.to_s.gsub(/\D/, '') # Remove todos os caracteres não numéricos

    if digits.length == 11
      "#{digits[0..2]}.#{digits[3..5]}.#{digits[6..8]}-#{digits[9..10]}"
    else
      cpf # Retorna o CPF como está se não tiver 11 dígitos
    end
  end

  def format_phone(number)
    digits = number.to_s.gsub(/\D/, '')

    case digits.length
    when 11
      "(#{digits[0..1]}) #{digits[2..6]}-#{digits[7..10]}"
    when 10
      "(#{digits[0..1]}) #{digits[2..5]}-#{digits[6..9]}"
    else
      number # retorna como está se não for 10 ou 11 dígitos
    end
  end
end
