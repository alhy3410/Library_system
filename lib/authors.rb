class Authors
  attr_reader(:name,:id)

  define_method(:initialize) do |attributes|
    @name = attributes[:name]
    @id = attributes[:id]
  end

  define_singleton_method(:all) do
    author_list = []
    all_authors = DB.exec("SELECT * FROM authors;")
    all_authors.each() do |author|
      name = author.fetch('name')
      id = author.fetch('id').to_i()
      author_list.push(Authors.new({:name => name, :id => id}))
    end
    author_list
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO authors (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_method(:==) do |another_author|
    self.name().==(another_author.name())
  end

  define_singleton_method(:find) do |identification|
    found_author = nil
    Authors.all().each() do |author|
      if author.id() == identification
        found_author = author
      end
    end
    found_author
  end

  define_method(:update) do |attributes|
    @name = attributes.fetch(:name, @name)
    @id = self.id()
    DB.exec("UPDATE authors SET name = ('#{@name}') WHERE id = #{@id};")
  end

  define_method(:delete) do
    @id = self.id()
    DB.exec("DELETE FROM authors WHERE id = #{@id};")
  end

end
