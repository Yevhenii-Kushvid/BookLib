module ApplicationHelper

  def errors(object)
    #if object.errors.any?
    #  "<div id='error_explanation'><h2>#{pluralize(@object.errors.count, "error")}prohibited this quote from being saved:</h2><ul>#{</ul></div>".html_safe
    #else
    #  "no errors"
    #end
    if object.errors.any?
      messages = ""

      object.errors.full_messages.each do |message|
        messages += "<li>".html_safe + message + "</li>".html_safe
      end
      result = "<div id='error_explanation'><h2>".html_safe + pluralize(object.errors.count, "error").to_s + " prohibited this quote from being saved:</h2><ul>".html_safe + messages.html_safe + "</ul></div>".html_safe
    else
      result = ""
    end


  end

end
