module ReportPresenter

  def self.print(report, arg, hdd_type = nil)
    puts "ID, #{arg}" + (hdd_type ? ", HDD type" : "")
    report.each do |line|
      puts "#{line[:id]}, #{line[:arg]}" + (hdd_type ? ", #{line[:hdd_type]}" : "")
    end
  end
  
end