require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
    
      test "valid signup information" do  #test validité de l'inscription avec bonnes infos
    get signup_path
    assert_difference 'User.count', 1 do
        post users_path, params: { user: { first_name:  "Example",
                                            last_name: "User",
                                            email: "user@example.com",
                                            password:              "password",
                                            password_confirmation: "password" } }
    end
    follow_redirect!
    assert_template 'users/show'
  end
  
    test "invalid signup information" do  #test validité de l'inscription avec mauvaises infos
    get signup_path
        post users_path, params: { user: { first_name:  "Example",
                                            last_name: "User",
                                            email: "",
                                            password:              "password",
                                            password_confirmation: "password" } }
  flash[:danger] = "Tu dois être enregistré pour accéder à cette page, petit malin ;)"
  end

end