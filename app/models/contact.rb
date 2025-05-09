class Contact < ApplicationRecord
  belongs_to :proponent

  enum :contact_type,
       { telefone_residencial: 0, celular: 1, whatsapp: 2, email: 3 }

  validates :contact_type, :value, presence: true

  def valid_phone_format
    unless valid_phone?(value)
      errors.add(:value, 'deve ser um telefone válido (ex: (11) 91234-5678)')
    end
  end

  def phone_type?
    contact_type.in?(%w[telefone_residencial celular whatsapp])
  end

  def valid_phone?(phone)
    phone.match?(/\A\(?\d{2}\)? \d{4,5}-\d{4}\z/)
  end
end
