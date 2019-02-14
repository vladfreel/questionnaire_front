class AnswersController < ApplicationController

  def create
    question = RestClient.post "http://#{set_host}/api/v1/answers.json", answer_params.to_json
    redirect_to question_path(question['id'])
  end

  def update
    RestClient.put("http://#{set_host}/api/v1/answers/#{params[:id]}.json", { accept: :json }).body
    redirect_to request.referrer
  end

  def destroy
    RestClient.delete("http://#{set_host}/api/v1/answers/#{params[:id]}.json", { accept: :json }).body
    redirect_to request.referrer
  end

  private

  def answer_params
    # whitelist params
    params.require(:answer).permit(:content, :question_id)
  end
end
