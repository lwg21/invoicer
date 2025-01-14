puts "Destroying all records…"
InvoiceItem.destroy_all
Invoice.destroy_all
Client.destroy_all
User.destroy_all

puts "Creating clients…"
user1 = User.create(
  email_address: "julia@julia.com",
  password: "123456"
)

company_details = {
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
}

user1.company.update(company_details)

next_invoice_num = 0

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

client2 = Client.create(
  designation: "Beatrice",
  address_line1: "45 Townstreet",
  postal_code: "00000",
  city: "London",
  country: "Great-Britain",
  vat_number: "GB00000000000",
  phone_number: "+41600000000",
  email_address: "b@b.com"
)

client2 = Client.create(
  designation: "Anna",
  address_line1: "17, rue de du Trèfle",
  postal_code: "00000",
  city: "Ville",
  country: "France",
  vat_number: "FR00000000000",
  phone_number: "+33600000000",
  email_address: "an@na.com"
)

puts "Creating invoices…"
invoice1 = Invoice.create(
  number: next_invoice_num += 1,
  date: Date.today,
  client: client1,
  company: User.last.company
)

item1 = InvoiceItem.create(
  name: "Einzeluntericht 30 Minuten",
  description: "",
  quantity: 9,
  unit_price: 13.5
)

item1 = InvoiceItem.create(
  invoice: invoice1,
  name: "Einzeluntericht 30 Minuten",
  description: "",
  date: "03.12.2024",
  quantity: 9,
  unit_price: 13.5
)

item2 = InvoiceItem.create(
  invoice: invoice1,
  name: "Probestunde",
  description: "",
  date: "03.12.2024",
  quantity: 2,
  unit_price: 8
)

item3 = InvoiceItem.create(
  invoice: invoice1,
  name: "Einzeluntericht 45 Minuten",
  description: "",
  date: "03.12.2024",
  quantity: 3,
  unit_price: 20.25
)

invoice2 = Invoice.create(
  number: next_invoice_num += 1,
  date: Date.today,
  client: client1,
  company: User.last.company
)
