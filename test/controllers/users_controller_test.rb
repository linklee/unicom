require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, user: { agree_rules: @user.agree_rules, desired_amount: @user.desired_amount, email: @user.email, fact_flat: @user.fact_flat, fact_locality_name: @user.fact_locality_name, fact_street: @user.fact_street, mobile_phone: @user.mobile_phone, name: @user.name, patronymic: @user.patronymic, reg_flat: @user.reg_flat, reg_house: @user.reg_house, reg_house: @user.reg_house, reg_locality_name: @user.reg_locality_name, reg_street: @user.reg_street, same_address: @user.same_address, surname: @user.surname }
    end

    assert_redirected_to user_path(assigns(:user))
  end

  test "should show user" do
    get :show, id: @user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user
    assert_response :success
  end

  test "should update user" do
    patch :update, id: @user, user: { agree_rules: @user.agree_rules, desired_amount: @user.desired_amount, email: @user.email, fact_flat: @user.fact_flat, fact_locality_name: @user.fact_locality_name, fact_street: @user.fact_street, mobile_phone: @user.mobile_phone, name: @user.name, patronymic: @user.patronymic, reg_flat: @user.reg_flat, reg_house: @user.reg_house, reg_house: @user.reg_house, reg_locality_name: @user.reg_locality_name, reg_street: @user.reg_street, same_address: @user.same_address, surname: @user.surname }
    assert_redirected_to user_path(assigns(:user))
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end

    assert_redirected_to users_path
  end
end
