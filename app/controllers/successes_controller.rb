class SuccessesController < ApplicationController
  def index
    @successes = Task.where.not(successes: nil).pluck(:successes)
  end
end
