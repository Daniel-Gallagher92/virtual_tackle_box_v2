class LureSerializer
  include JSONAPI::Serializer
  attributes :brand, :variety, :color, :weight
end
