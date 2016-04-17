# -*- encoding: utf-8 -*-
# Meteoprog specification file
Sur::Specification.new do |s|
  # Sublet information
  s.name        = 'Meteoprog'
  s.version     = '0.4'
  s.tags        = ['weather']
  s.files       = ['meteoprog.rb']
  s.icons       = []

  # Sublet description
  s.description = 'Very simple weather sublet, which takes info from meteoprog.ua'
  s.notes       = <<NOTES
  Visit meteoprog.ua, enter your location and take it from address line.
  For example, url - http://www.meteoprog.ua/en/weather/Kyiv/
  You need to extract "Kyiv" and set variable "location" as "Kyiv" in your config.
  Click on sublet to refresh data and show detailed info through notify-osd
NOTES

  # Sublet authors
  s.authors     = ['Artur Plysyuk']
  s.contact     = 'ifuelen@gmail.com'
  s.date        = 'Sat Oct 11 11:21 EEST 2014'

  # Sublet config
  s.config = [
    {
      name: 'interval',
      type: 'integer',
      description: 'interval',
      def_value: '1800'
    },
    {
      name: 'location',
      type: 'string',
      description: 'Enter your location. For details - sur notes meteoprog',
      def_value: 'Lviv'
    },
    {
      name: 'lang',
      type: 'string',
      description: 'Language for city indicator (en, ua, ru, pl)',
      def_value: 'en'
    }
  ]
end
