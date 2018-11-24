class CreateChannel < Neo4j::Migrations::Base
  def up
    add_constraint :Channel, :uuid
  end

  def down
    drop_constraint :Channel, :uuid
  end
end
