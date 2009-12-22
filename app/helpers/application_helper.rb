# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  # form helper
  def set_form_focus
    javascript_tag("$(document).ready( function() { $('form:first input:first').focus(); });")
  end
  
end
