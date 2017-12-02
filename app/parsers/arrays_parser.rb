class ArraysParser < Parser
  SOURCE_URL = 'http://openlibrary.org/search.json?q=the+lord+of+the+rings'

  def price
    count_array_elements(content['docs'])
  end

  private

  def count_array_elements(array)
    knt = array.is_a?(Array) && array.length > 10 ? 1 : 0
    array.inject(knt) do |sum, element|
      sum += count_sub_array_elements(element)
      sum
    end
  end

  def count_sub_array_elements(array)
    array.count do |_x, v|
      v.is_a?(Array) && v.length > 10
    end
  end

  def parse
    JSON.parse(request)
  end
end
