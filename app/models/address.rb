class Address < ApplicationRecord
  belongs_to :proponent

  enum :address_type, { principal: 'principal', secundario: 'secundario' }

  validates :street, :number, :neighborhood, :city, :state, :zip_code, presence: true, if: :principal?

  def principal?
    address_type == Address.address_types[:principal]
  end
end
