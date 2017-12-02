require 'net/http'

class Parser
  class Error < ::StandardError; end

  attr_reader :content

  def self.call
    new.price
  end

  def initialize
    @content = parse
  end

  def price
    fail 'Not implemented'
  end

  private

    def parse
      fail 'Not implemented'
    end

    def request
      uri = URI(self.class::SOURCE_URL)
      res = Net::HTTP.get_response(uri)
      fail Parser::Error unless res.is_a?(Net::HTTPSuccess)
      res.body
    end
end
