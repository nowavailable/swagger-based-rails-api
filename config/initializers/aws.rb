ActionMailer::Base.add_delivery_method :ses,
  AWS::SES::Base,
  access_key_id: Rails.application.credentials.production[:aws_smtp_access_key_id],
  secret_access_key: Rails.application.credentials.production[:aws_smtp_secret_acess_key],
  server: 'email-smtp.us-east-1.amazonaws.com'
