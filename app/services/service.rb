# frozen_string_literal: true

class Service < Mutations::Command
  # Force ActiveRecord to rollback every update of creation made inside the service
  # in case of failure
  def run
    outcome = nil
    ApplicationRecord.transaction do
      outcome = super
      raise ActiveRecord::Rollback unless outcome.success?
    end
    outcome
  end
end
