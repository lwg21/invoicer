def random_date(min)
  rand(Date.new(2022)..Date.new(2026))
end

def random_date_same_month(date)
  rand(date.beginning_of_month..date.end_of_month)
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
  details: "Julia Julia\nTeststr. 99, 1. Aufgang, 1. Stock\n20000 Hamburg\nGermany",
  vat_number: "12 345 67899",
  phone_number: "+49 123456789",
  email_address: "julia@julia.com",
  iban: "DE00 0000 0000 0000 0000 00",
  bic: "XXXXXXXXXXX",
  jurisdiction: "Hamburg"
)

user2.company.update(
  details: "Lucas Lucas\nRue du test 99, Cour droite\n10000 Paris\nFrance",
  vat_number: "12 345 67899",
  phone_number: "+33 123456789",
  email_address: "l@l.com",
  iban: "FR00 0000 0000 0000 0000 00",
  bic: "XXXXXXXXXXX",
  jurisdiction: "Paris"
)

puts "Creating clients…"
client1 = Client.create(
  name: "Lucas",
  details: "Lucas\n18, rue de la Forêt\n00000 Ville, France",
  vat_number: "FR00000000000",
  phone_number: "+33600000000",
  email_address: "lucas@lucas.com"
)

client2 = Client.create(
  name: "Josh",
  details: "Josh\n14, , rue de la Piscine\n00000 Ville, France",
  vat_number: "FR00000000000",
  phone_number: "+33600000000",
  email_address: "josh@josh.com"
)

client3 = Client.create(
  name: "Beatrice",
  details: "Josh\n45 Townstreet\n00000 London, Great-Britain",
  vat_number: "GB00000000000",
  phone_number: "+41600000000",
  email_address: "bea@trice.com"
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
