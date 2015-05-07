require('spec_helper')

describe('Books') do
  describe('#name') do
    it('will show the name of the book') do
      new_book = Books.new({:name => "Enders Game"})
      expect(new_book.name()).to(eq("Enders Game"))
    end
  end
end
