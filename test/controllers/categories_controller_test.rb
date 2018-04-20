require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.create(username: 'Test', email: 'test@email.com', password: '12345', admin: true)
  end

  test 'should get a categories index' do
    get categories_path
    assert_response :success
  end

  test 'should get a new category' do
    sign_in_as(@user, '12345')
    get new_category_path
    assert_response :success
  end

  test 'should get a show category' do
    category = Category.create(name: 'Test category')
    get category_path(category.id)
    assert_response :success
  end

  test 'should redirect to the login page without admin access' do
    sign_in_as(@user, '12345')
    @user.admin = false
    @user.save
    assert_no_difference 'Category.count' do
      post categories_path, params: {category: {name: 'Test category'}}
    end
    assert_redirected_to log_in_path
  end
end