require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  def setup
    @category = Category.new(name: 'Test Category')
  end

  test 'category should be valid' do
    assert @category.valid?
  end

  test "name shouldn't be empty" do
    @category.name = ''
    assert_not @category.valid?
  end

  test 'name should be unique' do
    @category.save
    another_category = Category.new(name: 'Test Category')
    assert_not another_category.valid?
  end

  test 'name should not be too long' do
    @category.name = '1' * 51
    assert_not @category.valid?
  end

  test 'name should not be too short' do
    @category.name = '12'
    assert_not @category.valid?
  end
end