class ContentsController < ApplicationController
  def create
    content = Content.first || Content.new
    content.update!(body: params.expect(:content))
    head :ok
  end
end
