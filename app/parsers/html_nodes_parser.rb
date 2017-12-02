class HtmlNodesParser < Parser
  SOURCE_URL = 'http://time.com/'

  def price
    content.enum_for(:traverse).count.to_f / 100
  end

  private

    def parse
      Nokogiri::HTML(request)
    end
end
