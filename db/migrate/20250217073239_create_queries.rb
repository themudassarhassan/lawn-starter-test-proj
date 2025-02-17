class CreateQueries < ActiveRecord::Migration[8.0]
  def change
    create_table :queries do |t|
      t.string :query_text
      t.string :resource_type
      t.float :response_time

      t.timestamps
    end
  end
end
