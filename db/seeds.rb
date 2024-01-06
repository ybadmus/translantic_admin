# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

incoterms = [{ abbr: 'EXW', description: 'Ex Works, named where the shipment is available to the buyer, not loaded. The seller will not contract for any transportation.' }, { abbr: 'FCA', description: 'Free Carrier, unloaded at the sellers dock OR a named place where the shipment is available to the international carrier or agent, not loaded. This term can be used for any mode of transport.' }, { abbr: 'FAS', description: 'Free Alongside Ship, named ocean port of shipment. Ocean shipments that are NOT containerized.' }, { abbr: 'FOB', description: 'Free Onboard vessel named ocean port of shipment. This term is used for ocean shipments only where it is important that the goods pass the ship rail.'}, { abbr: 'CFR', description: 'Cost and Freight, Named ocean port of destination. This term is used for ocean shipments that are not containerized.' }, { abbr: 'CIF', description: 'Cost, Insurance, and Freight, named ocean port of destination. This term is used for ocean shipments that are not containerized.' }, { abbr: 'CPT', description: 'Carriage Paid To, named place or port of destination. This term is used for air or ocean containerized and roll-on roll-off shipments.' }, { abbr: 'CIP', description: 'Carriage and Insurance Paid To, named place or port of destination. This term is used for air or ocean containerized and roll-on roll-off shipments.' }, { abbr: 'DAF', description: 'Delivered At Frontier, named place of destination, by land, not unloaded. This term is used for any mode of transportation but must be delivered by land.' }, { abbr: 'DES', description: 'Delivered Ex-Ship, named port of destination, not unloaded. This term is used for ocean shipments only.' }, { abbr: 'DEQ', description: 'Delivered Ex-Quay, named port of destination, unloaded, not cleared. This term is used for ocean shipments only.' }, { abbr: 'DDU', description: 'Delivered Duty Unpaid, named place of destination, not unloaded, not cleared. This term is used for any mode of transportation.' }, { abbr: 'DDP', description: 'Delivered Duty Paid, named place of destination, not unloaded, cleared. This term is used for any mode of transportation.' }]

locations = [{ city: 'Accra', country: 'Ghana' }, { city: 'Lagos', country: 'Nigeria' }, { city: 'Lome', country: 'Togo' }, { city: 'Cotonou', country: 'Benin' }, { city: 'Kuala Lumpur',country: 'Malaysia' }, { city: 'Casablanca', country: 'Morocco' }]

Incoterm.create!(incoterms)
Location.create!(locations)

Shipper.create({ name: 'Shipper 1', email: "#{Faker::Name.first_name}.#{Faker::Name.last_name}@gmail.com", phone: Faker::PhoneNumber.phone_number })

Shipper.create({ name: 'Shipper 2', email: "#{Faker::Name.first_name}.#{Faker::Name.last_name}@gmail.com", phone: Faker::PhoneNumber.phone_number })

Shipper.create({ name: 'Shipper 3', email: "#{Faker::Name.first_name}.#{Faker::Name.last_name}@gmail.com", phone: Faker::PhoneNumber.phone_number })

Receiver.create({ name: 'Receiver 1', email: "#{Faker::Name.first_name}.#{Faker::Name.last_name}@gmail.com", phone: Faker::PhoneNumber.phone_number })

Receiver.create({ name: 'Receiver 2', email: "#{Faker::Name.first_name}.#{Faker::Name.last_name}@gmail.com", phone: Faker::PhoneNumber.phone_number })

Receiver.create({ name: 'Receiver 3', email: "#{Faker::Name.first_name}.#{Faker::Name.last_name}@gmail.com", phone: Faker::PhoneNumber.phone_number })

Quoter.create({ name: 'Quoter 1', email: "#{Faker::Name.first_name.downcase}.#{Faker::Name.last_name.downcase}@gmail.com", phone: Faker::PhoneNumber.phone_number })

Quoter.create({ name: 'Quoter 2', email: "#{Faker::Name.first_name.downcase}.#{Faker::Name.last_name.downcase}@gmail.com", phone: Faker::PhoneNumber.phone_number })

Quoter.create({ name: 'Quoter 3', email: "#{Faker::Name.first_name.downcase}.#{Faker::Name.last_name.downcase}@gmail.com", phone: Faker::PhoneNumber.phone_number })

ShippingInformation.create({ address_line1: Faker::Address.full_address, company_name: Faker::Company.name, receiver_id: Receiver.first.id, location_id: Location.second.id })

ShippingInformation.create({ address_line1: Faker::Address.full_address, company_name: Faker::Company.name, receiver_id: Receiver.second.id, location_id: Location.second.id })

ShippingInformation.create({ address_line1: Faker::Address.full_address, company_name: Faker::Company.name, receiver_id: Receiver.last.id, location_id: Location.third.id  })

Quote.create({ frieght_type: :air, status: :submitted, height: 15.00, width: 35.00, length: 90.00, message: Faker::Lorem.paragraphs, total_gross_weight: 13.00, departure_id: Location.first.id, destination_id: Location.last.id, incoterm_id: Incoterm.first.id })

Quote.create({ frieght_type: :sea, status: :reviewed, height: 20.00, width: 34.00, length: 75.00, message: Faker::Lorem.paragraphs, total_gross_weight: 35.00, departure_id: Location.second.id, destination_id: Location.third.id, incoterm_id: Incoterm.second.id })

Quote.create({ frieght_type: :land, status: :responded, height: 10.00, width: 32.00, length: 50.00, message: Faker::Lorem.paragraphs, total_gross_weight: 58.00, departure_id: Location.last.id, destination_id: Location.fourth.id, incoterm_id: Incoterm.last.id })

ShippingDetail.create({ declared_value: 10000.00, description: Faker::Lorem.paragraphs, dutiable: true, frieght_type: :sea, height: 15.00, width: 35.00, length: 90.00, quantity: 5, current_location_id: Location.first.id, shipper_id: Shipper.first.id, departure_id: Location.third.id, incoterm_id: Incoterm.first.id, shipping_information_id: ShippingInformation.first.id })

ShippingDetail.create({ declared_value: 7000.00, description: Faker::Lorem.paragraphs, dutiable: false, frieght_type: :air, height: 15.00, width: 35.00, length: 90.00, quantity: 5, current_location_id: Location.fourth.id, shipper_id: Shipper.second.id, departure_id: Location.second.id, incoterm_id: Incoterm.first.id, shipping_information_id: ShippingInformation.second.id })

ShippingDetail.create({ declared_value: 210000.00, description: Faker::Lorem.paragraphs, dutiable: true, frieght_type: :rails, height: 15.00, width: 35.00, length: 90.00, quantity: 5, current_location_id: Location.third.id, shipper_id: Shipper.third.id, departure_id: Location.last.id, incoterm_id: Incoterm.first.id, shipping_information_id: ShippingInformation.third.id })
