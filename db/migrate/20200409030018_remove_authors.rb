class RemoveAuthors < ActiveRecord::Migration[6.1]
  def change
    drop_table :authors

    remove_column :posts, :author_id, :bigint
  end
end
