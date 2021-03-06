class QuestionsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_question, only: [:show, :edit, :update, :destroy]

  # GET /questions
  # GET /questions.json
  def index
    @questions = Question.all
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
  end

  # GET /questions/new
  def new
    @question = Question.new
  end

  # GET /questions/1/edit
  def edit
  end

  # POST /questions
  # POST /questions.json
  def create
    @question = Question.new(question_params)

    respond_to do |format|
      if @question.save
        format.html { redirect_to @question, notice: 'Question was successfully created.' }
        format.json { render :show, status: :created, location: @question }
      else
        format.html { render :new }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to @question, notice: 'Question was successfully updated.' }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to questions_url, notice: 'Question was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params[:question]
      params.require(:question).permit(:level, :difficulty,:question_number, :askedquestion, :useranswer, :rightanswer, :correct)
    end

  public

    # when user goes to /exam this will call the maths gem to generate questions
    def exam
      #query db for level reached by user logged in
      @user_level = Question.where(:user_id => current_user).maximum(:level)
      #query db for difficulty reached in level by user
      @user_difficulty = Question.where(:user_id => current_user, :level => @user_level).maximum(:difficulty)
      #query db for amount of questions asked at this level and difficulty
      @level_questions = Question.where(:user_id => current_user, :level => @user_level,
              :difficulty => @user_difficulty).count
      #query db for amount of questions answered correctly from questions asked
      @level_correct = Question.where(:user_id => current_user, :level => @user_level, 
              :difficulty => @user_difficulty, :correct => 'correct').count

      #call levelgem gem to work out user level and difficulty
      #pass in current level, current difficulty, questions asked per level/difficulty, and correct 
      #answers per level/difficulty
      @hold_level,@hold_difficulty = Levelfinder.getLevel(@user_level.to_i,@user_difficulty.to_i,
              @level_questions.to_i,@level_correct.to_i, 5)
      @result = Generate.makeQuestion(@hold_level, @hold_difficulty)
      @question_number = Question.where(:user_id => current_user, :level => @hold_level).count + 1

      #call congrats gem on completion of the previous level
      if @user_level != @hold_level and @hold_level.to_i != 0
        @total_level_correct = Question.where(:user_id => current_user, :level => @user_level,
              :correct => 'correct').count
        @total_level_incorrect = Question.where(:user_id => current_user, :level => @user_level,
              :correct => 'incorrect').count
        @congrats, @correct, @incorrect = Congratulations.response(@user_level.to_i, @total_level_correct.to_i,
              @total_level_incorrect.to_i, current_user.email)
      end

      #get help from the mathshelper gem if user hasn't passed the level by question 7 of current level and difficulty
      if Question.where(:user_id => current_user, :level => @hold_level, :difficulty => @hold_difficulty).count >= 7
        #get tips for current question
        @tip_line_one, @tip_line_two, @tip_line_three = Helper.giveHelp(@result)
      end 
    end

    # when user commits answer of question in /exam this will call the maths gem to compare answers
    # and save details in the questions db
    def compare
      @input1 = params[:search_string].to_i
      # check answer in maths gem
      @result1 = Generate.answerCheck(@input1)

      # get full question, level, and difficulty from maths gem to put in db
      @hold_question, @hold_answer, @ques_level, @ques_difficulty = Generate.getQuestion
      # get the number of the previously asked question and increment by one to pass to db
      @question_num = Question.where(:user_id => current_user, :level => @ques_level).count
      @question_num += 1

      # add information to questions db
      @question = Question.create(user_id: current_user, level: @ques_level, difficulty: @ques_difficulty,
            askedquestion: @hold_question, useranswer: @input1, rightanswer: @hold_answer, correct: @result1,
            question_number: @question_num)

      #loop back to next question
      redirect_to :exam

    end
end
