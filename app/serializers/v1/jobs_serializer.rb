module V1
  class JobsSerializer < ActiveModel::Serializer
    attributes :id, :classification, :remote, :duration, :description, :user_id
  end
end
