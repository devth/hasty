# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  # form helper
  def set_form_focus
    javascript_tag("$(\"input[type='text']:first\", document.forms[0]).focus();")
  end
  
end
