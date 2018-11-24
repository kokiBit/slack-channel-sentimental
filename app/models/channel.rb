class Channel
  include Neo4j::ActiveNode


  property :channel_id, type: String
  property :name, type: String

  has_many :in, :users, model_class: :User, rel_class: :Join
end
