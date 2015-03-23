class AddNumberToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :question_number, :int
  end
end
