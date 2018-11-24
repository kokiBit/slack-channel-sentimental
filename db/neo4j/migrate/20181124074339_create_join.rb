class CreateJoin < Neo4j::Migrations::Base
  def up
    add_constraint :Join, :uuid
  end

  def down
    drop_constraint :Join, :uuid
  end
end
