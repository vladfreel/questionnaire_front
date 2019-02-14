class QuestionsController < ApplicationController
  before_action :find_question, only: %i[show edit]

  def create
    question = RestClient.post "http://#{set_host}/api/v1/questions.json",
                               { question: {content: question_params['content']} },
                               {content_type: :json,
                                accept: :json}
    parsed_question = JSON.parse(question)
    redirect_to question_path(parsed_question['id'])
  end

  def index
    questions = RestClient.get("http://#{set_host}/api/v1/questions.json", { accept: :json }).body
    @questions = JSON.parse(questions)
  end

  def show;end

  def edit;end

  def update
    p '*'*100
    question = RestClient.put "http://#{set_host}/api/v1/questions/#{params[:id]}.json",
                              { question: {content: question_params['content']} },
                              {content_type: :json,
                               accept: :json}
    @question = JSON.parse(question)
    redirect_to question_path(question['id'])
  end

  def destroy
    RestClient.delete("http://#{set_host}/api/v1/questions/#{params[:id]}.json", { accept: :json }).body
    redirect_to questions_path
  end

  private

  def question_params
    # whitelist params
    params.require(:question).permit('content')
  end

  def find_question
    question = RestClient.get("http://#{set_host}/api/v1/questions/#{params[:id]}.json", { accept: :json }).body
    @question = JSON.parse(question)
  end
end
