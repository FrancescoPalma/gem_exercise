require 'spec_helper'

module Fxify
  describe ExchangeRate do
    context "AUD to INR conversion" do
      let(:exchange_rate) {ExchangeRate.new}
      it "returns a valid number" do
        expect(exchange_rate.at(exchange_rate.dates.max, "AUD", "INR")).to be > 0
      end
      it "returns a decimal number" do
        expect(exchange_rate.at(exchange_rate.dates.max, "JPY", 'USD').to_s).to be =~ /.(.*)/
      end
    end

    context "JPY to USD conversion" do
      let(:exchange_rate) { ExchangeRate.new }
      it "returns a valid number" do
        expect(exchange_rate.at(exchange_rate.dates.sample, "JPY", "USD")).to be > 0
      end 
      it "returns a decimal number" do
        expect(exchange_rate.at(exchange_rate.dates.sample, "JPY", "USD").to_s).to be =~ /.(.*)/
      end 
    end

    context "To fetch currency list" do
      let(:exchange_rate) {ExchangeRate.new}
      it "returns an array of currencies" do
        expect(exchange_rate.currencies).to be_a(Array)
      end
      it "returns an array with at least one element" do
        expect(exchange_rate.currencies.size).to be > 0
      end
    end

    context "To fetch valid days" do
      let(:exchange_rate) { ExchangeRate.new }
      it "returns an array of currencies" do
        expect(exchange_rate.dates).to be_a(Array)
      end
      it "returns an array with at least one element" do
        expect(exchange_rate.dates.size).to be > 0
      end
    end
  end
end
