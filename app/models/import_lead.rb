require 'csv'

class ImportLead
  def initialize(file)
    @file = file
  end

  def import_assigned_to(assigned)
    @assigned = assigned

    import
  end

  # Sample Format
  # "Source","First Name","Last Name","Gender","Company Name","Phone Number","Address","City",
  # "State","ZIP code","ZIP+4","database name","File Date","id","Production Date"
  def import
    CSV.foreach(@file.path, :converters => :all, :return_headers => false, :headers => :first_row) do |row|
      source, first_name, last_name, _, company, phone, *address = *row.to_hash.values

      street, city, state, zip, _ = *address
      address = Address.new(:street1 => street, :city => city, :state => state, :zipcode => zip)

      lead = Lead.new(:source => source, :first_name => first_name, :last_name => last_name,
                      :company => company, :phone => phone)

      lead.first_name = "FILL ME" if lead.first_name.blank?
      lead.last_name = "FILL ME" if lead.last_name.blank?
      lead.access = "Private"
      lead.addresses << address

      lead.assignee = @assigned if @assigned.present?

      lead.save!
    end
  end
end
