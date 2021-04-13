# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'sschwob@mavideotheque.fr'
  layout 'mailer'
end
