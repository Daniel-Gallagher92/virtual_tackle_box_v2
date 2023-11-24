class UserSerializer
  include JSONAPI::Serializer
  attributes :email, :catches, :lures
end
