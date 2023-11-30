class UserSerializer
  include JSONAPI::Serializer
  attributes :id, :email, :catches, :lures, :created_at
end
