Fabricator :admin_user, from: :user do
  user_type fabricator: :admin, from: :user_type
  user_name 'admin'
  mail { Faker::Email::email }
  nombre { Faker::Name::name }
  pass '12345'
end