class Components::Entries::PrependTaskForm < Phlex::HTML
  include Phlex::Rails::Helpers::TurboStream

  attr_reader :task

  def initialize(task:)
    @task = task
  end

  def view_template
    turbo_stream.prepend(:tasks_frame) do
      div(class: "mt-4") do
        render Components::Entries::Task.new(task:)
      end
    end
  end
end
