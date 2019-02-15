class QuestionsController < ApplicationController
  before_action :find_question, only: %i[show edit]
  before_action :url_with_object, only: %i[update_question destroy]
  before_action :url_without_object, only: %i[create index]
  before_action :get_question_params, only: %i[create update_question]

  def create
    question = rest_client_send_request('post', get_question_params, url_without_object)
    parsed_question = JSON.parse(question)
    redirect_to question_path(parsed_question['id'])
  end

  def index
    questions = rest_client_send_request('get', nil, url_without_object)
    @questions = JSON.parse(questions)
  end

  def show;end

  def edit;end

  def update_question
    rest_client_send_request('put', get_question_params, url_with_object)
    redirect_to question_path(params[:id])
  end

  def destroy
    rest_client_send_request('delete', nil, url_with_object)
    redirect_to questions_path
  end

  private

  def question_params
    # whitelist params
    params.require(:question).permit('content')
  end

  def get_question_params
    { question: {content: question_params['content']} }
  end

  def url_with_object
    "http://#{set_host}/api/v1/questions/#{params[:id]}.json"
  end

  def url_without_object
    "http://#{set_host}/api/v1/questions.json"
  end

  def find_question
    question = rest_client_send_request('get', '', url_with_object)
    @question = JSON.parse(question)
  end

  def rest_client_send_request action, params, url
    if action == 'get' || 'delete'
      RestClientService.new({action: action, params: params, url: url}).send_request.body
    else
      RestClientService.new({action: action, params: params, url: url}).send_request
    end
  end
end
