class ItemSerializer < ActiveModel::Serializer
  attributes :id, :description, :status
end
