class Category < ApplicationRecord
  has_many :books

  validates :title, presence: true, uniqueness: true

  MAIN_GATEGORY = "Mobile development".freeze

  def self.current_category(params)
    return Category.find(params[:category]) if params.include?(:category)
    Category.find_by_title(Category::MAIN_GATEGORY)
  end
end
