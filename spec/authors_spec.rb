require('spec_helper')

describe('Authors') do
  describe('#name') do
    it('will show the name of the author') do
      new_author = Authors.new({:name => "Homer"})
      expect(new_author.name()).to(eq("Homer"))
    end
  end

  describe('.all') do
    it('will return an empty array which will hold all authors') do
      expect(Authors.all()).to(eq([]))
    end
  end

  describe('#save') do
    it('will save the author into all authors database') do
      new_author = Authors.new({:name => "Homer"})
      new_author.save()
      expect(Authors.all()).to(eq([new_author]))
    end
  end

  describe('.find') do
    it('will find the author using the id') do
      new_author = Authors.new({:name => "Homer"})
      new_author.save()
      new_author2 = Authors.new({:name => "Rowling"})
      new_author2.save()
      expect(Authors.find(new_author2.id())).to(eq(new_author2))
    end
  end

  describe('#update') do
    it('will update the name of the author') do
      new_author = Authors.new({:name => "Homer"})
      new_author.save()
      new_author.update({:name => "Pratt"})
      expect(new_author.name()).to(eq("Pratt"))
    end
  end

  describe('#delete') do
    it('will delete the author') do
      new_author = Authors.new({:name => "Homer"})
      new_author.save()
      new_author2 = Authors.new({:name => "Pratt"})
      new_author2.save()
      new_author.delete()
      expect(Authors.all()).to(eq([new_author2]))
    end
  end

  describe('#books') do
    it('will show the books the author has written') do
      new_author = Authors.new({:name => "Jim Johnson"})
      new_author.save()
      new_book = Books.new({:name => "The days of new"})
      new_book.save()
      new_book2 = Books.new({:name => "The lion king"})
      new_book2.save()
      new_author.update({:books_id => [new_book.id(), new_book2.id()]})
      expect(new_author.books()).to(eq([new_book, new_book2]))
    end
  end
  
end
