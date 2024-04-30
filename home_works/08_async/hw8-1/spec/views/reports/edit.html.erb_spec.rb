require 'rails_helper'

RSpec.describe "reports/edit", type: :view do
  before(:each) do
    @report = assign(:report, Report.create!(
      name: "MyString",
      body: "MyString",
      status: 1,
      report_type: 1
    ))
  end

  it "renders the edit report form" do
    render

    assert_select "form[action=?][method=?]", report_path(@report), "post" do

      assert_select "input[name=?]", "report[name]"

      assert_select "input[name=?]", "report[body]"

      assert_select "input[name=?]", "report[status]"

      assert_select "input[name=?]", "report[report_type]"
    end
  end
end
