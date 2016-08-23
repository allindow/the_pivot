class Seed
  def self.start
    new.generate
  end

  def generate
    generate_organizations
    generate_countries
    generate_recipients
    generate_users
  end

  def generate_organizations
    org_1 = Organization.create(name: "Women International", description: "An organization aimed toward helping women around the world in all endeavors. Whether it's education, career improvement, or starting a business, Women International is here to help, and you can help too!", status: 1, image_path: "../assets/women.jpg")
    org_2 = Organization.create(name: "It Takes A Village", description: "Raising a child is difficult enough, but doing it alone is almost impossible. It Takes A Village offers help to single parents around the world, giving them the resources they need in order to give their children a better, happier life.", status: 1, image_path: "../assets/village.jpg")
    org_3 = Organization.create(name: "Green for Green Agriculture", description: "Supporting farms and ranches worldwide, Green for Green gives you a way to ensure locally raised crops and livestock remain available to communities and businesses.", status: 1, image_path: "../assets/green.jpg")
    org_4 = Organization.create(name: "Educare", description: "Dedicated to supporting and furthering education for all, Educare offers a way for to help a field that directly helps us all. From pencils and paper, to textbooks, to computers and even building new facilities, your contribution can mean a better world now, and in the future.", status: 1, image_path: "../assets/education.jpg")
    org_5 = Organization.create(name: "Health Now!", description: "Health Now! receives help from people just like you in order to fund and improve emergency healthcare in communities. One donation can save a life.", status: 1, image_path: "../assets/health.jpg")
    org_6 = Organization.create(name: "Veteran’s Hope", description: "At Veteran’s Hope, we strive to make the transition from military life to civilian life as smooth as possible. We help veterans from militaries across the world discover their passions and achieve their dreams by providing resources for them to receive funding for their new life ventures.", status: 1, image_path: "../assets/veterans.jpg")
    org_7 = Organization.create(name: "Disabilities Council International", description: "People with disabilities always have a place to turn for help with funding for their brilliant ideas with Disabilities Council International. We seek to support our recipients with their desires for disability accommodations in their community as well as new business ideas.", status: 1, image_path: "../assets/disability.jpg")
    org_8 = Organization.create(name: "Green Ventures", description: "We want to make the world a better place for future generations by supporting those who find ways to preserve our natural resources and drive down the carbon footprint of the people in their community. Our recipients are the change we want to see in the world!", status: 1, image_path: "../assets/venture.jpg")
    org_9 = Organization.create(name: "The Nonprofit Spring", description: "The Nonprofit Spring is a place for people who want to make the biggest impact with their fresh ideas. Our recipients will put every penny to good use, focusing on funding the implementation and expansion of their cause rather than a net profit.", status: 1, image_path: "../assets/nonprofit.jpg")
    org_10 = Organization.create(name: "Local Spa Society", description: "Our motto is “Selfcare for everyone, everywhere.” We believe people are most successful when they make time to pamper themselves occasionally, and we support those who are passionate about being able to provide this to their community.", status: 1, image_path: "../assets/spa.jpg")
    org_11 = Organization.create(name: "Dream Kitchen Inc.", description: "There are no pies in the sky at Dream Kitchen Inc! We help international chefs bring their culinary dreams to fruition by having world renown food experts collaborate with them on their ideas and connect them with investments that help them piece together their dream restaurant.", status: 1, image_path: "../assets/kitchen.jpg")
    org_12 = Organization.create(name: "Animal Conservation Worldwide", description: "Support wildlife conservation and the protection of domesticated animals around the world by sponsoring families taking a stand for the voiceless. Animals are in desperate need of help in the face of habitat loss, overhunting, poaching, and abuse. These individuals are working to change their communities to have compassion for animals in all of the ways that animals interact with human societies around the world. Funds are used to support animal care and rehabilitation and community outreach.", status: 1, image_path: "../assets/animal.jpg")
    org_13 = Organization.create(name: "Local Leadership Initiative", description: "Help aspiring leaders create campaigns, attend trainings and educational seminars, and advocate for change in their own communities. Supporting these local leaders keeps leadership positions filled by those who know best supplying them with the tools they need to guide their communities into the future.", status: 1, image_path: "../assets/local.jpg")
    org_14 = Organization.create(name: "Indigenous Rights International", description: "Indigenous populations around the world are threatened by the spread of homogenized Western culture. Individuals from these communities are asking for global support in protecting their native lands and culture. Resources can go to help communities buy back historical land from developers, establish cultural centers, host cultural events, and spread awareness to mainstream culture about the importance of maintaining indigenous heritage.", status: 1, image_path: "../assets/indigenous.jpg")
    org_15 = Organization.create(name: "Democracy Today!", description: "Take a stand for democracy worldwide as these individuals work to preserve the right to vote in their communities. Funds provided will help these vetted individuals protect voting locations, provide transportation for the elderly and disenfranchised, and maintain relationships with international voting observers.", status: 1, image_path: "../assets/democracy.jpg")
    org_16 = Organization.create(name: "Physical Safety Network", description: "Protect victims of physical abuse around the world by helping them leave abusive situations. Funding will help these individuals find housing, employment, education and childcare. Additionally, support other ambassadors who are working to start education programs to advocate for physical safety at home. (Some of these individual’s personal information has been randomized to protect their identity.)", status: 1, image_path: "../assets/physical.jpg")
    org_17 = Organization.create(name: "Homes for Humanity", description: "Homes for Humanity provides housing loans and technical assistance for local institutions that cater to low-income families.", status: 1, image_path: "../assets/home.jpg")
    org_18 = Organization.create(name: "Global Retail Opportunities", description: "Support a retail business in a village and contribute to the growth of a community by creating jobs, generating revenue, and promoting locally made goods.", status: 1, image_path: "../assets/retail.jpg")
    org_19 = Organization.create(name: "Feeding Families Farm Fresh", description: "Our mission is to feed families fresh produce to support and promote healthy living. Support local farmers make deliveries to families in need with seasonal crops straight from the ground.", status: 1, image_path: "../assets/freshfood.jpg")
    org_20 = Organization.create(name: "Childcare Everywhere", description: "We believe childcare should be affordable for everyone. Help provide funding for a childcare facility that so families can continue to work.", status: 1, image_path: "../assets/childcare.jpg")
  end
  
  def gender
    ["women", "men"].sample
  end

  def org_without_women
    Organization.where('name != ?', "Women International").sample
  end

  def women_int
    Organization.find_by(name: "Women International")
  end

  def generate_recipients
    Country.all.each do |country|
      48.times do |n|
        name = Faker::Name.name
        country.recipients << Recipient.create(name: name,
        description: " is a #{Faker::Company.buzzword} individual in need of a #{Faker::Commerce.product_name}! Help make their dreams come true with your contribution.",
        amount_received: rand(0..800),
        image_path:"https://randomuser.me/api/portraits/#{gender}/#{rand(0..99)}.jpg",
        organization: org_without_women)
      end
      2.times do |n|
        name = Faker::Name.name
        country.recipients << Recipient.create(name: name,
        description: " is a #{Faker::Company.buzzword} individual in need of a #{Faker::Commerce.product_name}! Help make their dreams come true with your contribution.",
        amount_received: rand(0..800), image_path:"https://randomuser.me/api/portraits/women/#{rand(0..99)}.jpg",
        organization: women_int)
      end
    end
  end

  def generate_countries
    Country.create(name:"Ghana")
    Country.create(name:"Japan")
    Country.create(name:"Brazil")
    Country.create(name:"Italy")
    Country.create(name:"Jamaica")
    Country.create(name:"Australia")
    Country.create(name:"Ireland")
    Country.create(name:"Mexico")
    Country.create(name:"India")
    Country.create(name:"Kenya")
  end

  def generate_users
    registered = Role.create(name: "registered_user")
    org_admin = Role.create(name: "org_admin")
    platform_admin = Role.create(name: "platform_admin")
    women = Organization.find_by(name: "Women International")
    village = Organization.find_by(name: "It Takes A Village")
    green = Organization.find_by(name: "Green for Green Agriculture")
    educare = Organization.find_by(name: "Educare")
    health = Organization.find_by(name: "Health Now!")

    angela = women.users.create!(username: "angela@example.com", password: "password")
    caleb = village.users.create!(username: "caleb@example.com", password: "password")
    lin = green.users.create!(username: "lin@example.com", password: "password")
    tommasina = educare.users.create!(username: "tommasina@example.com", password: "password")
    sally = health.users.create!(username: "sally@example.com", password: "password")
    angela.roles << [registered, org_admin]
    lin.roles << [registered, org_admin]
    caleb.roles << [registered, org_admin]
    tommasina.roles << [registered, org_admin]
    sally.roles << [registered, org_admin]
  end
end

Seed.start
