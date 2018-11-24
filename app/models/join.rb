class Join
  include Neo4j::ActiveRel

  from_class :User
  to_class :Channel
  type 'JOIN'

  property :total_message_count, type: Integer
  property :sentimental_score, type: BigDecimal
end
