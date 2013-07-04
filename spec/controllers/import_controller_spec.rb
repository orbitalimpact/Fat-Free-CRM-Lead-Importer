require 'spec_helper'

describe Admin::ImportController do
  context "with valid csv file" do
    before do
      visit admin_import_path

      page.attach_file :file, Rails.root.join("spec/factories/sampleLeads.csv").to_s

      click_button "Import"
    end

    it "redirects to admin root and displays success message" do
      expect(current_path).to eq(admin_path)

      expect(page).to have_content("Successfully imported Leads")
    end
  end
end
