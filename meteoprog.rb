# Meteoprog sublet file
require 'net/http';
require 'cgi'
require 'json'

configure :meteoprog do |s|
  s.interval    = s.config[:interval] || 1800
  s.location    = s.config[:location] || 'Lviv'
  s.lang        = s.config[:lang]     || 'en'
  s.result      = {}
end

helper do
  def refresh_data
    uri = URI("http://www.meteoprog.ua/data/weather/informer/#{URI.escape(self.location)}.js" \
              "?dt=#{Date.today}")
    http = Net::HTTP.new(uri.host, 80)
    http.read_timeout = 500
    request = Net::HTTP::Get.new(uri.request_uri)
    self.result  = JSON.parse(http.request(request).body)
    self.data = "#{self.result[self.lang] || self.location}: #{self.result['now_temp']}°C"
  rescue Exception
    self.data = 'Weather n/a'
  end
end

on :run do |s|
  refresh_data
end

on :mouse_down do |s, x, y, button|
  refresh_data
  summary = "Weather in #{s.result['en']}"
  body = <<-BODY.strip
    Now:            #{s.result['now_temp']}°C
    Today:          #{s.result['today_temp_min']}...#{s.result['today_temp_max']}°C
    Tomorrow:       #{s.result['tomorrow_temp_min']}...#{s.result['tomorrow_temp_max']}°C
    After tomorrow: #{s.result['after_tomorrow_temp_min']}...#{s.result['after_tomorrow_temp_max']}°C
  BODY
  `notify-send "#{summary}" "#{body}" --expire-time=5000`
end
