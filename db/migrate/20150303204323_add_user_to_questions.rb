class AddUserToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :user_id, :foreign_key
  end
end
