require 'test_helper'

class CreateCategoriesTest < ActionDispatch::IntegrationTest
  test 'create_category' do
    get new_category_path
    assert_template 'categories/new'

    assert_difference 'Category.count', 1 do
      post categories_path, params: {category: {name: 'Test category'}}
      follow_redirect!
    end
    assert_template 'categories/index'
    assert_match 'Test category', response.body
  end

  test 'create_invalid_category' do
    get new_category_path
    assert_template 'categories/new'

    assert_no_difference 'Category.count' do
      post categories_path, params: {category: {name: '11'}}
    end
    assert_template 'categories/new'
  end
end