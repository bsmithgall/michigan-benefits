class SignAndSubmit < Step
  include Rails.application.routes.url_helpers

  self.title = "Legal"
  self.subhead = "Enter your full legal name here to sign this application."

  self.questions = {
    signature: "Your signature"
  }

  self.placeholders = {
    signature: "Your full legal name"
  }

  self.overviews = {
    signature: "By entering your name you agree that you want to apply for "\
      "FAB and Medicaid, that you have been honest on this application, and "\
      "that you have read and agreed to the terms on the previous page."
  }

  attr_accessor :signature

  validates :signature,
    presence: { message: "Make sure you enter your signature" }

  def previous
    IntroductionComplete.new(@app)
  end

  def next
    clear_sessions_path(redirect_to: confirmations_path)
  end

  def assign_from_app
    self.signature = @app.signature
  end

  def update_app!
    @app.update!(signature: signature)
    FormMailer.submission(form: @app.form).deliver_now
  end

  def submit_label
    "Sign and submit application"
  end
end
