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


end
