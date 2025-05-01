10.times do
    proponent = Proponent.create!(
      name: Faker::Name.name,
      documents: Faker::IDNumber.brazilian_citizen_number,
      birth_date: Faker::Date.birthday(min_age: 18, max_age: 65),
      salary: rand(1000.0..8000.0).round(2)
    )
    proponent.update(inss_discount: InssCalculator.calculate(proponent.salary))

    proponent.addresses.create!(
      street: Faker::Address.street_name,
      number: Faker::Address.building_number,
      neighborhood: Faker::Address.community,
      city: Faker::Address.city,
      state: Faker::Address.state_abbr,
      zip_code: Faker::Address.zip_code
    )

    rand(1..2).times do
      proponent.contacts.create!(
        contact_type: Contact.contact_types.keys.sample,
        value: Faker::PhoneNumber.cell_phone_in_e164
      )
    end
  end
