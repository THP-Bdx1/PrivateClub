require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest



   test "login with valid information" do #test validité du login avec bonnes infos
    @user=User.create!(first_name:  "Example",
                                            last_name: "User",
                                            email: "user@example.com",
                                            password:              "password",
                                            password_confirmation: "password" )
    get login_path
    post login_path, params: { session: { email:    'user@example.com',
                                            password: 'password' } }
    get root_path
  end
  
    test "login with invalid information" do  #test validité du login avec mauvaises infos
    @user=User.create!(first_name:  "Example",
                        last_name: "User",
                        email: "user@example.com",
                        password:              "password",
                        password_confirmation: "password" )
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email: "", password: "" } }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

end

