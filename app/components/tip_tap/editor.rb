class Components::TipTap::Editor < Components::Base
  attr_reader :path, :method, :content, :entity_name, :resource_id, :attribute

  def initialize(resource:, attribute:, path:, method:)
    @entity_name = resource.class.name.underscore
    @resource_id = resource.id
    @attribute = attribute
    @path = path
    @method = method
    @content = resource.public_send(String(attribute).underscore)
  end

  def view_template
    div(
      class: "mt-4",
      data: {
        controller: :tiptap,
        tiptap_path_value: path,
        tiptap_method_value: method,
        tiptap_content_value: content,
        tiptap_entity_name_value: entity_name,
        tiptap_attribute_value: attribute,
        tiptap_resource_id_value: resource_id
      }
    ) do
      render Toolbar.new
      div(data: { tiptap_target: :editor }, class: "hidden mt-4 outline")
    end
  end
end
