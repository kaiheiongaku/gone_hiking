class UsersSerializer
  include FastJsonapi::ObjectSerializer
  attributes :email, :api_key
end
