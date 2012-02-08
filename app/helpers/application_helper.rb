module ApplicationHelper
  def link_to_add_fields(name, f, association, form)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(form, {:f => builder, :no_select => true})
    end
    link_to_function(name, raw("AGan.add_fields(this, '#{association}', '#{escape_javascript(fields)}')"), :id => "add_mov")
  end

  def link_to_remove_fields(name, f)
    f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)")
  end
end
