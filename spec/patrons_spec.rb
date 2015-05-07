require('spec_helper')

describe('Patrons') do
  describe('#name') do
    it('will show the name of the patron') do
      new_patron = Patrons.new({:name => "Kha Le"})
      expect(new_patron.name()).to(eq("Kha Le"))
    end
  end

  describe('.all') do
    it('will return an empty array where all the patrons will be held') do
      expect(Patrons.all()).to(eq([]))
    end
  end

  describe('#save') do
    it('will save the name of the patron to the list') do
      new_patron = Patrons.new({:name => "Andrew Lee"})
      new_patron.save()
      expect(Patrons.all()).to(eq([new_patron]))
    end
  end

  describe('.find') do
    it('will find the patron using the id') do
      new_patron = Patrons.new({:name => "Andrew Lee"})
      new_patron.save()
      new_patron2 = Patrons.new({:name => "Kha Le"})
      new_patron2.save()
      expect(Patrons.find(new_patron.id())).to(eq(new_patron))
    end
  end

  describe('#update') do
    it('will update the patron list in the database') do
      new_patron = Patrons.new({:name => "Andrew Lee"})
      new_patron.save()
      new_patron.update({:name => "James Bond"})
      expect(new_patron.name()).to(eq("James Bond"))
    end
  end

  describe('#delete') do
    it('will delete the information from the data base') do
      new_patron = Patrons.new({:name => "kha le"})
      new_patron.save()
      new_patron2 = Patrons.new({:name => "Cookie Monster"})
      new_patron2.save()
      new_patron.delete()
      expect(Patrons.all()).to(eq([new_patron2]))
    end
  end

  describe('#checked_out_books') do
    it('will allow patrons to check out books') do
      new_patron = Patrons.new({:name => "Obama"})
      new_patron.save()
      new_book = Books.new({:name => "The Life of Pie"})
      new_book.save()
      new_book2 = Books.new({:name => "Ice Cream is my religion"})
      new_book2.save()
      new_patron.checkout({:books_borrowed => [new_book.id(), new_book2.id()]})
      expect(new_patron.checked_out_books()).to(eq([new_book, new_book2]))
    end
  end

end
