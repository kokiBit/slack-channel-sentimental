class User
  include Neo4j::ActiveNode


  property :user_id, type: String
  property :name, type: String

  has_one :out, :channel, model_class: :Channel, rel_class: :Join
end
