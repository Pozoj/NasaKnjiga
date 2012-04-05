module BooksHelper
  def cover_style(book, style = nil)
    cover = style ? book.cover.url(style) : book.cover.url
    { :style => "background: url(#{cover}) no-repeat" }
  end
end
