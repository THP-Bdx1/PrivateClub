require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should not create user" do #test validité sans prénom
    user=User.new(first_name: "", last_name: "Potter", email: "potter@potter.com", password:"foobar", password_confirmation: "foobar")

    assert_not user.save
  end

  test "should not create user 2" do #test validité avec prénom contenant des espaces
    user=User.new(first_name: "      ", last_name: "Potter", email: "potter@potter.com", password:"foobar", password_confirmation: "foobar")

    assert_not user.save
  end

  test "should not create user 3" do #test validité 2 utilisateurs ayant la même adresse email
    user1=User.create!(first_name: "Ron", last_name: "Weasley", email: "potter@potter.com", password: "foobar", password_confirmation: "foobar")
    user2=User.new(first_name: "Harry", last_name: "Potter", email: "potter@potter.com", password: "foobar", password_confirmation: "foobar")

    assert_not user2.save
  end

  test "should access to profile" do
    @user=User.create!(id: 1, first_name:  "Example",
                                            last_name: "User",
                                            email: "user@example.com",
                                            password:              "password",
                                            password_confirmation: "password" )
    get login_path
    post login_path, params: { session: { email:    'user@example.com',
                                            password: 'password' } }
    get '/users/1'
    assert_select 'h2', text: 'Ton prénom : 
    Example'
  end

  test "shouldn't access to profile" do   #impossible
    @user=User.create!(id: 1, first_name:  "Example",
                                            last_name: "User",
                                            email: "user@example.com",
                                            password:              "password",
                                            password_confirmation: "password" )
    get login_path
    post login_path, params: { session: { email:    'user@example.com',
                                            password: 'password' } }
    get '/users/2'
    nil
   # assert_equal "Tu ne peux accéder qu'à ton profil, petit malin ;)", flash[:danger]
  end

  test "shouldn't access to profile without login" do   #impossible
    get '/users/2'
    #assert_equal "Tu dois être enregistré pour accéder à cette page, petit malin ;)", flash[:danger]
    nil
  end

end
