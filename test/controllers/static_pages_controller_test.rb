require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
    test "login with valid information has good links" do   #valable pour la page d'accueil + la navbar
    @user=User.create!(first_name:  "Example",
                                            last_name: "User",
                                            email: "user@example.com",
                                            password:              "password",
                                            password_confirmation: "password" )
    get login_path
    post login_path, params: { session: { email:    'user@example.com',
                                            password: 'password' } }
    assert_redirected_to root_path
    follow_redirect!
    assert_template root_path
    assert_select 'a[href=?]', login_path, count: 0
    assert_select 'a[href=?]', logout_path, count: 1
    assert_select 'a[href=?]', signup_path, count: 0
    assert_select 'a[href=?]', '/home', count: 2
  end

  test "Private Pages with login" do   #liens présents pour page private
    @user=User.create!(first_name:  "Example",
                                            last_name: "User",
                                            email: "user@example.com",
                                            password:              "password",
                                            password_confirmation: "password" )
    get login_path
    post login_path, params: { session: { email:    'user@example.com',
                                            password: 'password' } }
    assert_redirected_to root_path
    follow_redirect!
    assert_template root_path
    get '/home'
    assert_select 'td', text: 'Example'
  end


end
