require 'test_helper'

class CreateCategoriesTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create(username: 'Test', email: 'test@email.com', password: '12345', admin: true)
  end

  test 'create_category' do
    sign_in_as(@user, '12345')
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
    sign_in_as(@user, '12345')
    get new_category_path
    assert_template 'categories/new'

    assert_no_difference 'Category.count' do
      post categories_path, params: {category: {name: '11'}}
    end
    assert_template 'categories/new'
  end
end