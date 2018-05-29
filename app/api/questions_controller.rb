class Api::QuestionsController < Api::BaseController
  before_action :protect_endpoint

  def index
    @questions = Question.all.includes(:answers)

    if params[:search_term].present?
      @questions = @questions.where(title: params[:search_term])
    end
    
    render json: questions_json(@questions)
  end

  def show
    question = Question.where(id: params[:id]).first

    render json: question.to_json
  end

  def questions_json(questions)
    questions.map do |question|
      {
        id: question.id,
        title: question.title,
        user: question.user,
        answers: question.answers.map { |foo| { answer: foo.body, id: foo.id, user_id: foo.user_id }}
      }
    end.to_json
  end

  def protect_endpoint
    unless Tenant.where(api_key: params[:api_key]).count == 1
      render json: { error: "Unauthorized" }, status: 404
    else
      tenant = Tenant.where(api_key: params[:api_key]).first
      tenant.request_count += 1
      tenant.last_accessed_at = Time.current
      tenant.save
    end
  end
end
