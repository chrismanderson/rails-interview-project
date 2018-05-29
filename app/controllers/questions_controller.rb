class QuestionsController < ApplicationController
  def index
    @questions = Question.all.includes(:answers)

    respond_to do |format|
      format.html
      format.json { render json: @questions}
    end
  end

  def show
    question = Question.where(id: params[:id]).first

    respond_to do |format|
      format.html
      format.json {render json: @question}
    end
  end
end
