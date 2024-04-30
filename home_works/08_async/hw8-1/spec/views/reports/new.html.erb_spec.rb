require 'rails_helper'

RSpec.describe "reports/new", type: :view do
  before(:each) do
    assign(:report, Report.new(
      name: "MyString",
      body: "MyString",
      status: 1,
      report_type: 1
    ))
  end

  it "renders new report form" do
    render

    assert_select "form[action=?][method=?]", reports_path, "post" do

      assert_select "input[name=?]", "report[name]"

      assert_select "input[name=?]", "report[body]"

      assert_select "input[name=?]", "report[status]"

      assert_select "input[name=?]", "report[report_type]"
    end
  end
end
