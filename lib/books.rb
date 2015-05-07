class Books
  attr_reader(:name,:id)

  define_method(:initialize) do |attributes|
    @name = attributes[:name]
    @id = attributes[:id]
  end

  define_singleton_method(:all) do
    books_list = []
    all_books = DB.exec("SELECT * FROM books;")
    all_books.each() do |book|
      name = book.fetch('name')
      id = book.fetch('id').to_i()
      books_list.push(Books.new({:name => name, :id => id}))
    end
    books_list
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO books (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_method(:==) do |another_book|
   self.name().==(another_book.name())
  end

  define_singleton_method(:find) do |identification|
    found_book = nil
    Books.all().each() do |book|
      if book.id() == identification
        found_book = book
      end
    end
    found_book
  end

  define_method(:update) do |attributes|
    @name = attributes.fetch(:name, @name)
    @id = self.id()
    DB.exec("UPDATE books SET name = ('#{@name}') WHERE id = #{@id};")
  end

  define_method(:delete) do
    @id = self.id()
    DB.exec("DELETE FROM books WHERE id = #{@id};")
  end

end
