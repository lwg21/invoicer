# Consolidate all company information in a single column `details`

Company.all.each do |company|
  details = [
    company.designation,
    [company.address_line1, company.address_line2].join(", "),
    [company.postal_code, company.city].join(", ")
  ]
  company.update(details: details.join("\n"))
end

Invoice.where(issued: true).each do |invoice|
  details = [
    invoice.company_designation,
    [invoice.company_address_line1, invoice.company_address_line2].join(", "),
    [invoice.company_postal_code, invoice.company_city].join(", ")
  ]
  invoice.update(company_details: details.join("\n"))
end
