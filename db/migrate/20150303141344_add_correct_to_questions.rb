class AddCorrectToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :correct, :string
  end
end
