# def create_factory_creature
#   type = FactoryGirl.create(:type)
#   creature = FactoryGirl.create(:creature, type_id: type.id)
# end
#
# def create_creature
#   type = Type.create(name: "Land")
#   type.creatures.create(
#     name: "Unicorn",
#     description: "Pretty and pink",
#     price: 200.00
#   )
# end
#
# def admin_login
#   admin = User.create!(
#     username: "admin",
#     password: "adminpw",
#     email: "admin@gmail.com",
#     admin: true
#   )
#
#   visit root_path
#   click_on "Login"
#   fill_in "session_username", with: "admin"
#   fill_in "session_password", with: "adminpw"
#   click_button "Login"
# end

# 
# def user_login
#   create_user
# 
#   visit root_path
#   click_link "Login"
# 
#   fill_in "session_username", with: "Casey"
#   fill_in "session_password", with: "password"
#   click_button "Login"
# end
#
# def create_user
#   user = User.create!(
#     username: "Casey",
#     password: "password",
#     email: "casey@gmail.com"
#   )
# end
#
# def create_user_2
#   user = User.create!(
#     username: "Andrew",
#     password: "password",
#     email: "andrew@gmail.com"
#   )
# end
#
# def create_orders
#   create_creature
#   create_user
#   create_user_2
#
#   
#   user1_order2.creatures_orders.create!(
#     creature_id: Creature.first.id,
#     quantity: 1

#   user1_order3.creatures_orders.create!(
#     creature_id: Creature.first.id,
#     quantity: 1
#   )

#   user2_order1.creatures_orders.create!(
#     creature_id: Creature.first.id,
#     quantity: 1
#   )
#     
#   user2_order2.creatures_orders.create!(
#     creature_id: Creature.first.id,
#     quantity: 1
#   )    
# end
# 
