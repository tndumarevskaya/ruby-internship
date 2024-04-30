require_relative './report/report'
require_relative './report/report_presenter'

n = ENV.fetch('N', 10).to_i
hdd_type = ENV.fetch('HDD_TYPE', nil)

report = Report.new()
report1 = report.expensive_vm(n)
ReportPresenter.print(report1, "Price")

report2 = report.cheap_vm(n)
ReportPresenter.print(report2, "Price")

report3 = report.big_volume(n, hdd_type)
ReportPresenter.print(report3, "HDD capacity", hdd_type)

report4 = report.additional_volume_number(n, hdd_type)
ReportPresenter.print(report4, "Additional HDD num", hdd_type)

report5 = report.additional_volume_capacity(n, hdd_type)
ReportPresenter.print(report5, "Additional HDD capacity", hdd_type)
