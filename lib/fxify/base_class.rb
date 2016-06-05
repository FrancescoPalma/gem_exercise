require 'open-uri'
require 'nokogiri'

module Fxify
  class ECBData
    ECB_90_DAYS_URL = "http://www.ecb.europa.eu/stats/eurofxref/eurofxref-hist-90d.xml"
    def initialize  
        @days = []
        fetch_data("data.xml") 
        @data_file = Nokogiri::XML File.open("data.xml") 
        parse_xml
    end 

    def currencies
        @days.first.currencies.map { |c| c.name } 
    end 

    def dates
        @days.map { |d| d.day } 
    end
    
    private

    def rate(date, currency)
        @days.detect { |d| d.day == date }.currencies.detect { |c| c.name == currency }.value
    end 

    def parse_xml
      @data_file.xpath("//xmlns:Cube").each do |day| 
          if day.attribute("time")

           @days << ExchangeDate.new(day.attribute("time").value, day.children.map do |currency|
              Currency.new(name: currency.attribute("currency").value, value: currency.attribute("rate").value)
           end)

          end   
      end 
    end    
 
    def fetch_data(file_name)
        begin
         remote_data = open(ECB_90_DAYS_URL).read
        rescue OpenURI::HTTPError => e
          puts "Error #{e}"
        end 

        File.open(file_name, 'w') { |file| file.write(remote_data) } if e.nil?
    end

  end
end