class QuestionsController < ApplicationController

  def index
    questions = RestClient.get("http://#{set_host}/api/v1/questions.json", { accept: :json }).body
    @questions = JSON.parse(questions)
    p @questions
  end

end
