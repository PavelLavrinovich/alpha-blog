require 'test_helper'

class ListCategoriesTest < ActionDispatch::IntegrationTest
  def setup
    @category = Category.create(name: 'Test category')
    @another_category = Category.create(name: 'Another test category')
  end

  test 'should list categories' do
    get categories_path
    assert_template 'categories/index'

    assert_match 'Test category', response.body
    assert_match 'Another test category', response.body
  end
end