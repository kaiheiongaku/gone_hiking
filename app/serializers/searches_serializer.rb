class SearchesSerializer
  include FastJsonapi::ObjectSerializer
  attributes :text, :user_id
end
