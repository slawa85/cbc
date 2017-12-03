class LettersParser < Parser
  SOURCE_URL = 'http://time.com/'

  def price
    (content.scan(/[a]/m).size.to_f / 100).round(2)
  end

  private

    def parse
      Sanitize.clean(request, remove_contents: ['script', 'style'])
    end
end
