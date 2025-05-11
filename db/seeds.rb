User.create!(name: 'Admin', email: 'admin@example.com', password: 'senha123')

User.create!(name: 'Maria Oliveira', email: 'maria.oliveira@example.com', password: 'senha456')

User.create!(name: 'Carlos Pereira', email: 'carlos.pereira@example.com', password: 'senha789')

puts 'Usuários criados com sucesso!'

def gerar_cpf
  n = 9.times.map { rand(10) }
  soma1 = n.each_with_index.map { |num, i| num * (10 - i) }.sum
  d1 = soma1 % 11 < 2 ? 0 : 11 - soma1 % 11

  soma2 = (n + [ d1 ]).each_with_index.map { |num, i| num * (11 - i) }.sum
  d2 = soma2 % 11 < 2 ? 0 : 11 - soma2 % 11

  (n + [ d1, d2 ]).join
end

10.times do
  proponent =
    Proponent.create!(
      name: Faker::Name.name,
      cpf: gerar_cpf,
      rg: Faker::Number.number(digits: 8),
      birth_date: Faker::Date.birthday(min_age: 18, max_age: 65),
      salary: rand(1000.0..8000.0).round(2),
    )
  proponent.update(inss_discount: InssCalculator.calculate(proponent.salary))

  proponent.addresses.create!(
    street: Faker::Address.street_name,
    number: Faker::Address.building_number,
    neighborhood: Faker::Address.community,
    city: Faker::Address.city,
    state: Faker::Address.state_abbr,
    zip_code: Faker::Address.zip_code,
    address_type: 'principal',
  )

  rand(1..2).times do
    contact_type = Contact.contact_types.keys.sample # Isto retorna um tipo de contato como string (e.g. "celular")
    proponent.contacts.create!(
      contact_type: contact_type,
      value: Faker::PhoneNumber.unique.phone_number.gsub(/\d{2}(\d{4,5})(\d{4})/, '(\\1) \\2-\\3'),
    )
  end
end

puts 'Proponentes criados com sucesso!'
