Rails.application.configure do
  config.lograge.enabled = true


  config.lograge.custom_payload do |controller|
    {
      application_id: controller.current_application.try(:id),
      application_type: controller.current_application.try(:class),
    }
  end
end
