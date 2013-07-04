require 'spec_helper'

describe ImportLead do
  let(:file) { File.open(File.join(File.dirname(File.realpath(__FILE__)), "../factories/sampleLeads.csv").to_s) }
  subject { ImportLead.new(file) }

  it "creates all the leads in the file" do
    expect { subject.import }.to change(Lead.count).by(file.readlines)
  end
end
