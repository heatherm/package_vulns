require "rails_helper"

describe "Static Pages" do
  it "/ should include the application name in its title" do
    visit root_path

    expect(page).to have_title "VulnFindr"
  end
end
