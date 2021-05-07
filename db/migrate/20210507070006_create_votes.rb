class CreateVotes < ActiveRecord::Migration[6.0]
  def change
    create_table :votes do |t|
      t.string :job_id
      t.belongs_to :user,
                    null: false,
                    index: :true,
                    foreign_key: { on_delete: :cascade }
      t.boolean :upvote
      t.boolean :downvote      
    end

    add_index :votes, [:job_id, :user_id], unique: true
  end
end
