# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'no-reply@mavideotheque.fr'
  layout 'mailer'
end
