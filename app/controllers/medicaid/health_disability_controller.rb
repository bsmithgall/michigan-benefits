# frozen_string_literal: true

module Medicaid
  class HealthDisabilityController < StandardStepsController
    include MedicaidFlow
  end
end