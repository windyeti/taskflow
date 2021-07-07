module ProjectsHelper
  def delimetr(value)
    arr_value = value.to_s.split('')
    offset = arr_value.size % 3
    result = []
    arr_value.each.with_index do |item, index|
      result << item
      result << " " if ((index == offset - 1) && (offset != 0)) || (((index + 1 - offset) % 3 == 0) && ((index + 1) != arr_value.size))
    end
    result.join()
  end
end
