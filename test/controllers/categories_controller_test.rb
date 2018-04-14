require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  test 'should get a categories index' do
    get categories_path
    assert_response :success
  end

  test 'should get a new category' do
    get new_category_path
    assert_response :success
  end

  test 'should get a show category' do
    category = Category.create(name: 'Test category')
    get category_path(category.id)
    assert_response :success
  end
end