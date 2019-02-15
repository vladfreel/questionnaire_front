class AnswersController < ApplicationController
  before_action :url_with_object, only: %i[edit update_answer destroy]

  def create
    params = { answer: {content: answer_params['content'], question_id: answer_params['question_id'] } }
    url = "http://#{set_host}/api/v1/answers.json"
    question = rest_client_send_request('post', params, url)
    parsed_question = JSON.parse(question)
    redirect_to question_path(parsed_question['id'])
  end

  def edit
    answer = rest_client_send_request('get', '', url_with_object)
    @answer = JSON.parse(answer)
  end

  def update_answer
    params = { answer: {content: answer_params['content']} }
    question = rest_client_send_request('put', params, url_with_object)
    @question = JSON.parse(question)
    redirect_to question_path(@question['id'])
  end

  def destroy
    rest_client_send_request('delete', '', url_with_object)
    redirect_to request.referrer
  end

  private
  def answer_params
    # whitelist params
    params.require(:answer).permit(:content, :question_id)
  end

  def rest_client_send_request action, params, url
    if action == 'get' || 'delete'
      RestClientService.new({action: action, params: params, url: url}).send_request.body
    else
      RestClientService.new({action: action, params: params, url: url}).send_request
    end
  end

  def url_with_object
    "http://#{set_host}/api/v1/answers/#{params[:id]}.json"
  end
end
