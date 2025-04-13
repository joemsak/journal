class Components::Entries::PrependTaskForm < Phlex::HTML
  include Phlex::Rails::Helpers::TurboStream

  attr_reader :entry, :task

  def initialize(entry:, task:)
    @entry = entry
    @task = task
  end

  def view_template
    turbo_stream.prepend(:tasks_frame) do
      div(class: "mt-4") do
        render Components::Entries::Task.new(entry:, task:)
      end
    end
  end
end
