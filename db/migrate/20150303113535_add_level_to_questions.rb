class AddLevelToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :level, :integer
    add_column :questions, :difficulty, :integer
  end
end
