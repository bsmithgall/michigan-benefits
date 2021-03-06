module Medicaid
  class IntroName < Step
    step_attributes(
      :first_name,
      :last_name,
      :sex,
    )

    validates :first_name,
      presence: { message: "Make sure to provide a first name" }

    validates :last_name,
      presence: { message: "Make sure to provide a last name" }

    validates :sex, inclusion: {
      in: %w(male female),
      message: "Make sure to answer this question",
    }
  end
end
