class RemoveUserFromQuestions < ActiveRecord::Migration
  def change
    remove_column :questions, :user_id, :string
  end
end
