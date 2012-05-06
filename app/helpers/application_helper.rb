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

  def nav_sel(page)
    case page
    when "home"
      if params[:controller] == "home" 
        return raw(" class=\"active\"") 
      end
    when "in_eg_new"
      if params[:controller] == "movimientos" and params[:action] == "new" and params[:type] == "in_eg"
        return raw(" class=\"active\"")
      end
    when "mov_new"
      if params[:controller] == "movimientos" and params[:action] == "new" and params[:type] == "mov"
        return raw(" class=\"active\"")
      end
    when "rec_new"
      if params[:controller] == "movimientos" and params[:action] == "new" and params[:type] == "rec"
        return raw(" class=\"active\"")
      end
    when "in_eg_list"
      if params[:controller] == "movimientos" and params[:action] == "index" and params[:type] == "in_eg"
        return raw(" class=\"active\"")
      end
    when "mov_list"
      if params[:controller] == "movimientos" and params[:action] == "index" and params[:type] == "mov"
        return raw(" class=\"active\"")
      end
    when "rec_list"
      if params[:controller] == "movimientos" and params[:action] == "index" and params[:type] == "rec"
        return raw(" class=\"active\"")
      end
    end

  end
end
