module ApplicationHelper
  def template_name_css_class
    return unless content_for?(:template_name)

    "template--#{content_for(:template_name)}"
  end

  def debug?
    ENV["DEBUG"] == "true"
  end

  def full_office_name(application)
    if application.receiving_office_name == "Clio"
      "Clio Road"
    elsif application.receiving_office_name == "Union"
      "Union Street"
    else
      application.receiving_office_name
    end
  end
end
