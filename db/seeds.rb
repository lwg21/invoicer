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

puts "Creating invoices…"
invoice1 = Invoice.create(
  number: next_invoice_num += 1,
  date: Date.today,
  client: client1
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
  client: client1
)
