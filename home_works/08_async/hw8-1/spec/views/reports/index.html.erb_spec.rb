require 'rails_helper'

RSpec.describe "reports/index", type: :view do
  before(:each) do
    assign(:reports, [
      Report.create!(
        name: "Name",
        body: "Body",
        status: 2,
        report_type: 3
      ),
      Report.create!(
        name: "Name",
        body: "Body",
        status: 2,
        report_type: 3
      )
    ])
  end

  it "renders a list of reports" do
    render
    assert_select "tr>td", text: "Name".to_s, count: 2
    assert_select "tr>td", text: "Body".to_s, count: 2
    assert_select "tr>td", text: 2.to_s, count: 2
    assert_select "tr>td", text: 3.to_s, count: 2
  end
end
