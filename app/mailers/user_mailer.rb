require "sitemplate_core/action_mailer/localized"

class UserMailer < Devise::Mailer
  include SitemplateCore::ExtendedMailer
  include SitemplateCore::LocalizedMailer

  layout 'email'

  def confirmation_instructions(record, token, opts={})
    @locale = record.locale
    I18n.locale = @locale
    @host = ActionMailer::Base.default_url_options[:host]
    @email = record.email
    @name = record.title
    @resource = record
    @token = record.confirmation_token

    subj = t('mailer.confirmation_instructions.subject', app_name: @host)
    mail(to: @email, subject: subj, template_name: localized_template(__method__))
  end

  def reset_password_instructions(record, token, opts={})
    @locale = record.locale
    I18n.locale = @locale
    @host = ActionMailer::Base.default_url_options[:host]
    @email = record.email
    @name = record.title
    @resource = record
    @token = record.reset_password_token

    subj = t('mailer.reset_password_instructions.subject', app_name: @host)
    mail(to: @email, subject: subj, template_name: localized_template(__method__))
  end
end
