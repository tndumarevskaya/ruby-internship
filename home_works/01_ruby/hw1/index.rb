require_relative './report/report'
require_relative './report/report_presenter'

report = Report.new()
report1 = report.expensive_vm(10)
ReportPresenter.print(report1, "Price")

report2 = report.cheap_vm(5)
ReportPresenter.print(report2, "Price")

hdd_type = "ssd"
report3 = report.big_volume(3, hdd_type)
ReportPresenter.print(report3, "HDD capacity", hdd_type)

report4 = report.additional_volume_number(10, hdd_type)
ReportPresenter.print(report4, "Additional HDD num", hdd_type)

report5 = report.additional_volume_capacity(10, hdd_type)
ReportPresenter.print(report5, "Additional HDD capacity", hdd_type)