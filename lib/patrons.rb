class Patrons
  attr_reader(:name,:id)

  define_method(:initialize) do |attributes|
    @name = attributes[:name]
    @id = attributes[:id]
  end

  define_singleton_method(:all) do
    all_patrons = DB.exec("SELECT * FROM patrons;")
    patrons_list = []
    all_patrons.each() do |patron|
      name = patron.fetch('name')
      id = patron.fetch('id').to_i()
      patrons_list.push(Patrons.new({:name => name, :id => id}))
    end
    patrons_list
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO patrons (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_method(:==) do |another_patron|
    self.name().==(another_patron.name())
  end

  define_singleton_method(:find) do |identification|
    found_patron = nil
    Patrons.all().each() do |patron|
      if patron.id() == identification
        found_patron = patron
      end
    end
    found_patron
  end

  define_method(:update) do |attributes|
    @name = attributes.fetch(:name, @name)
    @id = self.id()
    DB.exec("UPDATE patrons SET name = ('#{@name}') WHERE id = #{self.id()};")

  end

  define_method(:delete) do
    DB.exec("DELETE FROM patrons WHERE id = #{self.id()};")
  end

  define_method(:checkout) do |attributes|
    attributes.fetch(:books_borrowed, []).each() do |book|
    DB.exec("INSERT INTO checkouts (patrons_id, books_borrowed_id) VALUES (#{self.id()}, #{book});")
    end
  end

  define_method(:checked_out_books) do
    book_lists = []
    books = DB.exec("SELECT books_borrowed_id FROM checkouts WHERE patrons_id = #{self.id};")
    books.each do |book|
      books_id = book.fetch('books_borrowed_id').to_i()
      book = DB.exec("SELECT * FROM books WHERE id = #{books_id};")
      name = book.first().fetch('name')
      book_lists.push(Books.new({:name => name}))
      end
    book_lists
  end





    # attributes.fetch(:books_borrowed, []).each() do books
    # list_books_borrowed = []
    # results = DB.exec("SELECT books_borrowed_id FROM checkouts WHERE books_borrowed_id = ('#{books_id}');")
    # results.each() do |result|
    #   books_id = result.fetch('books_borrowed_id').to_i()
    #   book = DB.exec("SELECT * from books WHERE id = #{books_id};")
    #   name = book.first().fetch('name')
    #   list_books_borrowed.push(Books.new({:name => name}))
    #   end
    # list_books_borrowed
    # end


end
