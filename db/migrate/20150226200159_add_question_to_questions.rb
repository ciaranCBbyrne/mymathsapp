class AddQuestionToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :askedquestion, :string
    add_column :questions, :useranswer, :integer
    add_column :questions, :rightanswer, :integer
  end
end
