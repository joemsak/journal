class Views::Sessions::New < Views::Base
  include Phlex::Rails::Helpers::FormWith
  include Phlex::Rails::Helpers::Routes

  def view_template
    render Layout.new(title: "Login") do
      div(class: "flex items-center justify-center h-screen") do
        form_with url: sessions_path do |f|
          f.label :password, class: "block font-bold cursor-pointer"
          f.password_field :password, class: "mt-2 py-2 px-4"

          f.submit "Log in",
            class: "block cursor-pointer mt-4 w-full bg-blue-300 outline-blue-200 shadow py-2 font-bold"
        end
      end
    end
  end
end
