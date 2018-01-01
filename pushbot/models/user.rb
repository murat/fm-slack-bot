class User
  include Mongoid::Document

  field :id, :type => Integer
  field :slack_id, :type => String
  field :email, :type => String
  field :token, :type => String
end