class Proponent < ApplicationRecord
  has_many :addresses, dependent: :destroy
  has_many :contacts, dependent: :destroy

  accepts_nested_attributes_for :addresses, allow_destroy: true
  accepts_nested_attributes_for :contacts, allow_destroy: true

  validates :name, :cpf, :salary, presence: true
  validates :cpf, uniqueness: true

  before_validation :normalize_salary

  def normalize_salary
    self.salary = salary.to_s.tr(',', '.').to_f if salary.is_a?(String)
  end
end
