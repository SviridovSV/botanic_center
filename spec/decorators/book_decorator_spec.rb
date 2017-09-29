require 'rails_helper'

describe BookDecorator do
  let :book do
    author = build(:author, first_name: 'Ivan', last_name: 'Lopis')
    author2 = build(:author, first_name: 'Vasiliy', last_name: 'Lipa')
    build(:book, :long_description, authors: [author, author2]).decorate
  end

  describe '#authors_list' do
    it 'return authors with coma' do
      expect(book.authors_list).to eq('Ivan Lopis, Vasiliy Lipa')
    end
  end

  describe '#short_description' do
    context 'when description longer than 350' do
      it 'return cut description with link' do
        expect(book.short_description).to eq(book.description.slice(0, 347) +
        "...<a class=\"in-gold-500 ml-10\" id=\"read_link\" href=\"#\">Read More</a>")
      end
    end

    context 'when description less than 350' do
      it 'return description' do
        book.description = 'test'
        expect(book.short_description).to eq(book.description)
      end
    end
  end

  describe '#dimensions_list' do
    it "return dimensions in H: n” x W: n” x D: n”" do
      expect(book.dimensions_list).to eq("H: 2.4” x W: 1.3” x D: 0.6”")
    end
  end

  describe 'in_current_order?' do
    context 'when book is in current order' do
      it 'return true' do
        order = Order.new(order_items: [OrderItem.new(book: book)])
        allow(book.h).to receive(:current_order).and_return(order)
        expect(book.in_current_order?).to eq(true)
      end
    end

    context 'when book is not in current order' do
      it 'return false' do
        allow(book.h).to receive(:current_order).and_return(Order.new)
        expect(book.in_current_order?).to eq(false)
      end
    end
  end
end
