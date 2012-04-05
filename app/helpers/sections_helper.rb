module SectionsHelper
  def dots(length)
    str = "."
    (68-length).times do
      str += " ."
    end
    str
  end
  def divide(n1, n2)
    unless n2.zero?
      (n1.to_f / n2.to_f).round(2)
    else
      0
    end
  end
  def format_percentage(number)
    if number
      "#{number*100}%"
    end
  end
end
