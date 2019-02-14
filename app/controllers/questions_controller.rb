class QuestionsController < ApplicationController

  def create
    question = RestClient.post "http://#{set_host}/api/v1/questions.json", question_params.to_json
    redirect_to question_path(question['id'])
  end

  def index
    questions = RestClient.get("http://#{set_host}/api/v1/questions.json", { accept: :json }).body
    @questions = JSON.parse(questions)
  end

  def show
    question = RestClient.get("http://#{set_host}/api/v1/questions/#{params[:id]}.json", { accept: :json }).body
    @question = JSON.parse(question)
  end

  def update
    question = RestClient.put("http://#{set_host}/api/v1/questions/#{params[:id]}.json", { accept: :json }).body
    @question = JSON.parse(question)
    redirect_to question_path(question['id'])
  end

  def destroy
    question = RestClient.delete("http://#{set_host}/api/v1/questions/#{params[:id]}.json", { accept: :json }).body
    @question = JSON.parse(question)
    redirect_to questions_path
  end

  private

  def question_params
    # whitelist params
    params.require(:question).permit(:content)
  end
end
