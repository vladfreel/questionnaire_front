class AnswersController < ApplicationController

  def create
    question = RestClient.post "http://#{set_host}/api/v1/answers.json",
                               { answer: {content: answer_params['content'],
                                          question_id: answer_params['question_id'] } },
                               {content_type: :json,
                                accept: :json}
    parsed_question = JSON.parse(question)
    redirect_to question_path(parsed_question['id'])
  end

  def edit
    answer = RestClient.get("http://#{set_host}/api/v1/answers/#{params[:id]}.json", { accept: :json }).body
    @answer = JSON.parse(answer)
  end

  def update_answer
    question = RestClient.put "http://#{set_host}/api/v1/answers/#{params[:id]}.json",
                              { answer: {content: answer_params['content']} },
                              {content_type: :json,
                               accept: :json}
    @question = JSON.parse(question)

    redirect_to question_path(@question['id'])
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
