module V1
  class JobsSerializer < ActiveModel::Serializer
    attributes :id, :classification, :remote, :title, :amount, :description, :user_id
  end
end
