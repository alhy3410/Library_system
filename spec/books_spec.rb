require('spec_helper')

describe('Books') do
  describe('#name') do
    it('will show the name of the book') do
      new_book = Books.new({:name => "Enders Game"})
      expect(new_book.name()).to(eq("Enders Game"))
    end
  end

  describe('.all') do
    it('will return an empty array which will hold all books') do
      expect(Books.all()).to(eq([]))
    end
  end

  describe('#save') do
    it('will save the book into all books database') do
      new_book = Books.new({:name => "Great Gatsby"})
      new_book.save()
      expect(Books.all()).to(eq([new_book]))
    end
  end

  describe('.find') do
    it('will find the book using the id') do
      new_book = Books.new({:name => "The World"})
      new_book.save()
      new_book2 = Books.new({:name => "Great Gatsby"})
      new_book2.save()
      expect(Books.find(new_book2.id())).to(eq(new_book2))
    end
  end

  describe('#update') do
    it('will update the name of the book') do
      new_book = Books.new({:name => "Enders Game"})
      new_book.save()
      new_book.update({:name => "The Game"})
      expect(new_book.name()).to(eq("The Game"))
    end
  end

  describe('#delete') do
    it('will delete the book') do
      new_book = Books.new({:name => "Enders Game"})
      new_book.save()
      new_book2 = Books.new({:name => "The Time"})
      new_book2.save()
      new_book.delete()
      expect(Books.all()).to(eq([new_book2]))
    end

    
  end

end
