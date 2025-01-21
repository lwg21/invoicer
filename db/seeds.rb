def random_date(min)
  rand(Date.new(2022)..Date.new(2026))
end

def random_date_same_month(date)
  rand(date.beginning_of_month..date.end_of_month)
end

def set_realistic_invoice_date(invoice)
end

puts "Destroying all records…"
InvoiceItem.destroy_all
Invoice.destroy_all
Client.destroy_all
User.destroy_all

puts "Creating users…"
user1 = User.create(
  email_address: "julia@julia.com",
  password: "123456"
)

user2 = User.create(
  email_address: "lucas@lucas.com",
  password: "123456"
)

puts "Updating copany details…"
user1.company.update(
  designation: "Julia Julia",
  address_line1: "Teststr. 99",
  address_line2: "1. Aufgang, 1. Stock",
  city: "Hamburg",
  postal_code: "20000",
  country: "Germany",
  vat_number: "12 345 67899",
  phone_number: "+49 123456789",
  email_address: "julia@julia.com",
  iban: "DE00 0000 0000 0000 0000 00",
  bic: "XXXXXXXXXXX",
  jurisdiction: "Hamburg"
)

user2.company.update(
  designation: "Lucas Lucas",
  address_line1: "Rue du test 99",
  address_line2: "Cour droite",
  city: "Paris",
  postal_code: "10000",
  country: "France",
  vat_number: "12 345 67899",
  phone_number: "+33 123456789",
  email_address: "l@l.com",
  iban: "FR00 0000 0000 0000 0000 00",
  bic: "XXXXXXXXXXX",
  jurisdiction: "Paris"
)

puts "Creating clients…"
client1 = Client.create(
  designation: "Lucas",
  address_line1: "18, rue de la Forêt",
  postal_code: "00000",
  city: "Ville",
  country: "France",
  vat_number: "FR00000000000",
  phone_number: "+33600000000",
  email_address: "lucas@lucas.com"
  )

client2 = Client.create(
  designation: "Josh",
  address_line1: "14, rue de la Piscine",
  postal_code: "00000",
  city: "Ville",
  country: "France",
  vat_number: "FR00000000000",
  phone_number: "+33600000000",
  email_address: "josh@josh.com"
)

client3 = Client.create(
  designation: "Beatrice",
  address_line1: "45 Townstreet",
  postal_code: "00000",
  city: "London",
  country: "Great-Britain",
  vat_number: "GB00000000000",
  phone_number: "+41600000000",
  email_address: "b@b.com"
)

client4 = Client.create(
  designation: "Anna",
  address_line1: "17, rue de du Trèfle",
  postal_code: "00000",
  city: "Ville",
  country: "France",
  vat_number: "FR00000000000",
  phone_number: "+33600000000",
  email_address: "an@na.com"
)

client5 = Client.create(
  designation: "George",
  address_line1: "17, rue de du Trèfle",
  postal_code: "00000",
  city: "Ville",
  country: "France",
  vat_number: "FR00000000000",
  phone_number: "+33600000000",
  email_address: "g@g.com"
)
client6 = Client.create(
  designation: "Hannah",
  address_line1: "17, rue de du Trèfle",
  postal_code: "00000",
  city: "Ville",
  country: "France",
  vat_number: "FR00000000000",
  phone_number: "+33600000000",
  email_address: "an@na.com"
)
client7 = Client.create(
  designation: "Sam",
  address_line1: "17, rue de du Trèfle",
  postal_code: "00000",
  city: "Ville",
  country: "France",
  vat_number: "FR00000000000",
  phone_number: "+33600000000",
  email_address: "an@na.com"
)

puts "Creating invoices…"
20.times do
  Invoice.create(
    client: Client.all.sample,
    company: User.all.sample.company
  )
end

puts "Adding invoice items…"
items = [
  {
  name: "Einzeluntericht 30 Minuten",
  description: "Gesangsuntericht",
  unit_price: 30
  },
  {
  name: "Einzeluntericht 60 Minuten",
  description: "Gesangsuntericht",
  unit_price: 55
  },
  {
  name: "Einzeluntericht 120 Minuten",
  description: "Gesangsuntericht",
  unit_price: 100
  }
]

Invoice.all.each do |invoice|
  random_date = rand(Date.new(2022)..Date.new(2026))
  noizy_dates = (0..10).map { random_date + rand(0..10).ceil }
  rand(1..10).times do
    invoice.invoice_items.create(
      **(items.sample),
      quantity: rand(1..12),
      date: noizy_dates.sample
      )
  end
end

puts "Issue and pay some invoices…"
Invoice.includes(:invoice_items)
       .sort_by { |invoice| invoice.invoice_items.maximum(:date) || Date.new(0) }
       .each do |invoice|
         if rand() > 0.3
           invoice.issue!
           invoice.update(date: invoice.invoice_items.maximum(:date) + rand(0..10).ceil)
           invoice.update(paid: true) if rand() > 0.5
         end
       end
