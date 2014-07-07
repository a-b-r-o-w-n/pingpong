class StaticInput < SimpleForm::Inputs::StringInput

  def input
    value = object.send(attribute_name) if object.respond_to? attribute_name

    input = template.content_tag :p, class: 'form-control-static' do
      value.to_s
    end
    input
  end

end